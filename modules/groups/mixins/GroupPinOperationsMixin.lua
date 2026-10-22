---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Navigation = MapPinEnhanced:GetModule("Navigation")

local ARCHIVE_STATE_CLEARED = "cleared"
local ARCHIVE_STATE_HIDDEN = "hidden"

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinOperationsMixin = {}

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:RemovePin(pinID)
    if not self:CancelBatch() then return false end
    assert(pinID, "MapPinEnhancedGroupMixin:RemovePin: pinID is nil")

    local pin = self:GetPinByID(pinID)
    local wasTracked = pin and pin:IsTracked() or false
    local order = self.pinState:GetOrder(pinID)
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(order) or nil
    local removedPin, archivedPin = self.pinState:Remove(pinID)
    if not removedPin and not archivedPin then return false end

    self:PersistPinChanges(true)
    if removedPin then
        self.pinState:ReleaseDetachedPin(removedPin)
        MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pinID)
    else
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end

    if wasTracked then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackWithoutPersisting()
        else
            Groups:TrackNextPinAfterGroup(self, order)
        end
    end
    return true
end

---@param pinID UUID
---@param reached boolean? only the arrival owner supplies this
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:ClearPin(pinID, reached)
    if not self:CancelBatch() then return false end
    assert(pinID, "MapPinEnhancedGroupMixin:ClearPin: pinID is nil")

    local archivedPin = self:GetArchivedPinByID(pinID)
    if archivedPin then return archivedPin.state == ARCHIVE_STATE_CLEARED end

    local pin = self:GetPinByID(pinID)
    if not pin then return false end
    local order = self.pinState:GetOrder(pinID)
    local ordered = self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED
    -- Manual clearing also advances an ordered group when another pin is tracked.
    local nextOrderedPin = ordered and self:GetOrderedTrackablePin(order, pinID) or nil
    local wasTracked = pin:IsTracked()
    local prediction = reached and wasTracked and Groups:TakeNextPinPrediction(self, pinID) or nil
    local predictionChangeNumber = self.predictionChangeNumber or 0
    local groupID, lifetimeChangeNumber = self:GetGroupID(), self.lifetimeChangeNumber
    local data = CopyTable(pin:GetSaveableData())
    if self:IsRestorable() then
        if not self.pinState:ArchiveActive(pinID, ARCHIVE_STATE_CLEARED) then return false end
    else
        self.pinState:Remove(pinID)
        self.pinState:ReleaseDetachedPin(pin)
    end

    self:PersistPinChanges(true)
    MapPinEnhanced:FireCallback("PIN_CLEARED", nil, self, pinID, data)
    -- Arrival releases its origin once. Reentrant mutation or selection during
    -- release must not apply the old group's speculative winner.
    if reached and wasTracked then
        local owner = Navigation:GetActiveDestinationState()
        if not self:IsSameGroup(groupID, lifetimeChangeNumber) or Pins:GetTrackedPin() or owner then return true end
        if self.predictionChangeNumber ~= predictionChangeNumber + 1 or
            prediction and not Navigation:IsDestinationPredictionFresh(prediction) then
            prediction = nil
        end
    end
    if wasTracked or ordered then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackWithoutPersisting()
        else
            Groups:TrackNextPinAfterGroup(self, order, prediction)
        end
    end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param pinIDs UUID[]
---@return boolean accepted
function MapPinEnhancedGroupPinOperationsMixin:RemoveMultiplePins(pinIDs)
    if not self:CancelBatch() then return false end
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs must be a table")
    if #pinIDs == 0 then return true end

    local groupID, lifetimeChangeNumber = self:GetGroupID(), self.lifetimeChangeNumber
    local completed, finished = 0, false
    ---@type fun()?
    local cancelExecution
    ---@type fun()
    local cancelBatch

    local function finish(status)
        if finished then return end
        finished = true
        if cancelExecution then cancelExecution() end
        cancelExecution = nil
        if self.cancelBatch == cancelBatch then self.cancelBatch = nil end
        if not self:IsSameGroup(groupID, lifetimeChangeNumber) then return end
        self.pinsUpdating = nil
        self:PersistPinChanges(true, status == "complete")
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        if status ~= "complete" then Groups:ReportStoppedPinOperation(completed, #pinIDs) end
    end

    local function onError(message)
        finish("stopped")
        geterrorhandler()(message)
    end

    cancelBatch = function() finish("stopped") end
    self.cancelBatch = cancelBatch

    ---@param pinID UUID
    ---@return boolean
    local function removePin(pinID)
        if finished or not self:IsSameGroup(groupID, lifetimeChangeNumber) then return false end
        local pin = self.pinState:Remove(pinID)
        completed = completed + 1
        if pin then self.pinState:ReleaseDetachedPin(pin) end
        return not finished and self:IsSameGroup(groupID, lifetimeChangeNumber)
    end

    self:BeginPinChanges()
    if finished then return false end
    cancelExecution = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint()
        for _, pinID in ipairs(pinIDs) do
            if not removePin(pinID) then return false end
            checkpoint()
        end
        self.pinState:CheckPinState(checkpoint)
    end }, nil, finish, 1, onError)
    return true
end

---@param pinID UUID
---@return UUID?
function MapPinEnhancedGroupPinOperationsMixin:DuplicatePin(pinID)
    if not self:CancelBatch() then return nil end
    local sourceEntry = self.pinState:GetEntryCopy(pinID)
    if not sourceEntry then return nil end
    local sourceData = sourceEntry.data
    local entries = self:GetPinDisplayEntries()

    -- Display entries are unordered; preserve the editor's order before inserting the copy.
    table.sort(entries, function(a, b)
        if a.order ~= b.order then return a.order > b.order end
        return (a.title or "") < (b.title or "")
    end)
    sourceData.pinID = nil
    sourceData.title = string.format(MapPinEnhanced.L["copy of %s"], sourceData.title)
    local pin, duplicatePinID, replacedWayBackPin, shouldTrack = self:AddBeforePersist(sourceData)
    if not duplicatePinID then return nil end
    ---@type UUID[]
    local pinIDs = {}
    if not replacedWayBackPin then
        for _, entry in ipairs(entries) do
            pinIDs[#pinIDs + 1] = entry.pinID
            if entry.pinID == pinID then pinIDs[#pinIDs + 1] = duplicatePinID end
        end
    else
        pinIDs[1] = duplicatePinID
    end
    assert(self.pinState:Reorder(pinIDs),
        "MapPinEnhancedGroupMixin:DuplicatePin: could not apply complete pin order")
    self:PersistPinChanges(true)
    if shouldTrack and pin then pin:TrackWithoutPersisting() end
    if pin then MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin) end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return duplicatePinID
end

---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:MovePinToGroup(pinID, targetGroup)
    if not self:CancelBatch() then return false end
    if self == targetGroup then return false end
    if not targetGroup:CancelBatch() then return false end
    local sourceEntry = self.pinState:GetEntryCopy(pinID)
    if not sourceEntry then return false end

    local sourcePin = self:GetPinByID(pinID)
    local wasTracked = sourcePin and sourcePin:IsTracked() or false
    local cursorOrder = sourceEntry.order
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(cursorOrder) or nil
    self.pinState:Remove(pinID)
    self:PersistPinChanges(true)
    if sourcePin then
        self.pinState:ReleaseDetachedPin(sourcePin)
        MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pinID)
    end

    local targetEntries = targetGroup:GetPinDisplayEntries()
    local success, targetPin, targetPinID, replacedWayBackPin, shouldTrack =
        pcall(targetGroup.AddBeforePersist, targetGroup, sourceEntry.data, pinID)
    local message = not success and tostring(targetPin) or nil
    if not success then
        targetPin, targetPinID = nil, nil
        replacedWayBackPin = targetGroup.groupType == "way-back"
    end
    if not targetPinID then
        targetGroup.pinState:AddArchived(sourceEntry.data, ARCHIVE_STATE_HIDDEN, nil, pinID)
        Groups:ReportStoppedPinOperation(0, 1)
    end
    ---@type UUID[]
    local targetOrder = {}
    if not replacedWayBackPin then
        for _, entry in ipairs(targetEntries) do targetOrder[#targetOrder + 1] = entry.pinID end
    end
    targetOrder[#targetOrder + 1] = pinID
    assert(targetGroup.pinState:Reorder(targetOrder),
        "MapPinEnhancedGroupMixin:MovePinToGroup: could not apply target pin order")

    targetGroup:PersistPinChanges(true)
    if message then geterrorhandler()(message) end
    if shouldTrack and targetPin then targetPin:TrackWithoutPersisting() end
    if targetPin then MapPinEnhanced:FireCallback("PIN_ADDED", nil, targetGroup, targetPin) end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)

    if wasTracked and not targetPin then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackWithoutPersisting()
        else
            Groups:TrackNextPinAfterGroup(self, cursorOrder)
        end
    end
    return true
end
