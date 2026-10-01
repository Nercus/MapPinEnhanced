---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

local ARCHIVE_STATE_REACHED = "reached"
local ARCHIVE_STATE_HIDDEN = "hidden"
local UNGROUPED_PIN_LIMIT = 100
local UNGROUPED_PIN_CLEANUP_TARGET = 90

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinOperationsMixin = {}

---@param group MapPinEnhancedGroupMixin
local function ResetLimitWarningIfBelowTarget(group)
    if group.groupType == "ungrouped" and group:GetTotalPinCount() <= UNGROUPED_PIN_CLEANUP_TARGET then
        group.limitWarningShown = false
    end
end

---@return number
function MapPinEnhancedGroupPinOperationsMixin:PruneOldestReachedPins()
    if self.groupType ~= "ungrouped" then return 0 end

    local totalPinCount = self:GetTotalPinCount()
    if totalPinCount <= UNGROUPED_PIN_CLEANUP_TARGET then
        self.limitWarningShown = false
        return 0
    end
    if totalPinCount < UNGROUPED_PIN_LIMIT then return 0 end

    local removed = self.pinState:PruneOldestReached(UNGROUPED_PIN_CLEANUP_TARGET)
    local remainingPinCount = totalPinCount - removed
    if remainingPinCount <= UNGROUPED_PIN_CLEANUP_TARGET then
        self.limitWarningShown = false
    elseif remainingPinCount > UNGROUPED_PIN_LIMIT and not self.limitWarningShown then
        self.limitWarningShown = true
        MapPinEnhanced:Print(string.format(
            MapPinEnhanced.L
            ["To maintain performance, Ungrouped Pins normally keeps up to 100 pins. " ..
            "It currently has %d; older pins will be removed automatically as more pins are reached."],
            remainingPinCount))
    end
    return removed
end

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:RemovePin(pinID)
    self:CancelBatch()
    assert(pinID, "MapPinEnhancedGroupMixin:RemovePin: pinID is nil")

    local pin = self:GetPinByID(pinID)
    local wasTracked = pin and pin:IsTracked() or false
    local order = self.pinState:GetOrder(pinID)
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(order) or nil
    local removedPin, archivedPin = self.pinState:Remove(pinID)
    if not removedPin and not archivedPin then return false end

    ResetLimitWarningIfBelowTarget(self)
    self:PersistPinChanges(true)
    if removedPin then
        self.pinState:ReleaseDetachedPin(pinID)
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
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:MarkPinReached(pinID)
    self:CancelBatch()
    assert(pinID, "MapPinEnhancedGroupMixin:MarkPinReached: pinID is nil")

    local archivedPin = self:GetArchivedPinByID(pinID)
    if archivedPin then return archivedPin.state == ARCHIVE_STATE_REACHED end

    local pin = self:GetPinByID(pinID)
    if not pin then return false end
    local order = self.pinState:GetOrder(pinID)
    local nextOrderedPin = pin:IsTracked() and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(order) or nil
    local changed, data, wasTracked = self.pinState:ArchiveActive(pinID, ARCHIVE_STATE_REACHED)
    if not changed then return false end

    self:PruneOldestReachedPins()
    self:PersistPinChanges(true)
    MapPinEnhanced:FireCallback("PIN_REACHED", nil, self, pinID, data)
    if wasTracked then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackWithoutPersisting()
        else
            Groups:TrackNextPinAfterGroup(self, order)
        end
    end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:RestoreReachedPins()
    self:CancelBatch()
    if self.hidden then return false end
    local restored, total, message = self.pinState:RestoreArchived(ARCHIVE_STATE_REACHED)
    if restored < total then Groups:ReportStoppedPinOperation(restored, total) end
    if restored > 0 then
        self:PersistPinChanges(true)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    if message then geterrorhandler()(message) end
    return restored > 0
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:HideGroup()
    self:CancelBatch()
    if self.protected or self.hidden then return false end
    local hadTrackedPin = self.pinState:ArchiveAll(ARCHIVE_STATE_HIDDEN)
    self.hidden = true
    self:PersistPinChanges(true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    if hadTrackedPin then Groups:TrackNextPinAfterGroup(self) end
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:ShowGroup()
    self:CancelBatch()
    if not self.hidden then return false end
    self.hidden = false
    local restored, total, message = self.pinState:RestoreArchived()
    if restored < total then Groups:ReportStoppedPinOperation(restored, total) end
    self:PersistPinChanges(true)
    if message then geterrorhandler()(message) end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:ClearGroup()
    self:CancelBatch()
    if not self.protected then return false end
    self.pinState:Reset()
    self.limitWarningShown = false
    self:PersistPinChanges(true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param pinIDs UUID[]
function MapPinEnhancedGroupPinOperationsMixin:RemoveMultiplePins(pinIDs)
    self:CancelBatch()
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs must be a table")
    if #pinIDs == 0 then return end

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
        ResetLimitWarningIfBelowTarget(self)
        self:PersistPinChanges(true)
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
        if pin then self.pinState:ReleaseDetachedPin(pinID) end
        return not finished and self:IsSameGroup(groupID, lifetimeChangeNumber)
    end

    if #pinIDs < 50 then
        for _, pinID in ipairs(pinIDs) do
            local success, removed = pcall(removePin, pinID)
            if not success then
                onError(tostring(removed))
                return
            end
            if not removed then
                finish("stopped")
                return
            end
        end
        finish("complete")
        return
    end

    ---@type (fun(): boolean?)[]
    local tasks = {}
    for _, pinID in ipairs(pinIDs) do
        local id = pinID
        tasks[#tasks + 1] = function() return removePin(id) end
    end
    local batchSize = math.min(math.max(math.ceil(#pinIDs / 60), 10), 100)
    cancelExecution = MapPinEnhanced:BatchExecution(tasks, nil, finish, batchSize, onError)
end

---@param pinID UUID
---@return UUID?
function MapPinEnhancedGroupPinOperationsMixin:DuplicatePin(pinID)
    self:CancelBatch()
    local entries = self:GetPinEntries()
    ---@type SaveablePinData?
    local sourceData
    for _, entry in ipairs(entries) do
        if entry.pinID == pinID then sourceData = entry.data end
    end
    if not sourceData then return nil end

    -- GetPinEntries is unordered; preserve the editor's order before inserting the copy.
    table.sort(entries, function(a, b)
        if a.order ~= b.order then return a.order > b.order end
        return (a.data.title or "") < (b.data.title or "")
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
    self:CancelBatch()
    if self == targetGroup then return false end
    targetGroup:CancelBatch()
    local entries = self:GetPinEntries()
    ---@type MapPinEnhancedGroupPinEntry?
    local sourceEntry
    for _, entry in ipairs(entries) do
        if entry.pinID == pinID then sourceEntry = entry end
    end
    if not sourceEntry then return false end

    local sourcePin = self:GetPinByID(pinID)
    local wasTracked = sourcePin and sourcePin:IsTracked() or false
    local cursorOrder = sourceEntry.order
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(cursorOrder) or nil
    self.pinState:Remove(pinID)
    ResetLimitWarningIfBelowTarget(self)
    self:PersistPinChanges(true)
    if sourcePin then
        self.pinState:ReleaseDetachedPin(pinID)
        MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pinID)
    end

    local targetEntries = targetGroup:GetPinEntries()
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
