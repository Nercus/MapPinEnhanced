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
---@param touchOrder boolean?
local function Commit(group, touchOrder)
    group.pinState:AssertInvariants()
    if touchOrder then group:TouchOrder() end
    Groups:PersistGroup(group)
end

---@param group MapPinEnhancedGroupMixin
---@param pinData pinData|SaveablePinData
---@param overridePinID UUID?
---@param order number?
---@return MapPinEnhancedPinMixin?, UUID, boolean replacedWayBackPin, boolean shouldTrack
local function AddWithoutCommit(group, pinData, overridePinID, order)
    local replacedWayBackPin = false
    if group.groupType == "way-back" and group:GetTotalPinCount() > 0 then
        group.pinState:Reset()
        replacedWayBackPin = true
    end

    if group.hidden then
        local pinID = group.pinState:AddArchived(pinData, ARCHIVE_STATE_HIDDEN, order, overridePinID)
        return nil, pinID, replacedWayBackPin, false
    end

    local pin, shouldTrack = group.pinState:AddActive(pinData, overridePinID, order)
    return pin, pin.pinID, replacedWayBackPin, shouldTrack
end

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

---@param pinData pinData
---@param overridePinID UUID?
---@return MapPinEnhancedPinMixin?, UUID?
function MapPinEnhancedGroupPinOperationsMixin:AddPin(pinData, overridePinID)
    assert(pinData, "MapPinEnhancedGroupMixin:AddPin: pinData is nil")

    local pin, pinID, replacedWayBackPin, shouldTrack = AddWithoutCommit(self, pinData, overridePinID)
    self:PruneOldestReachedPins()
    Commit(self, true)
    if shouldTrack and pin then pin:TrackAfterGroupCommit() end
    if pin then
        MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin)
    else
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    if replacedWayBackPin and pin then
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    return pin, pinID
end

---@param pinsData pinData[]|SaveablePinData[]
---@param preserveGroupOrder boolean?
---@param pinOrders table<UUID, number>?
function MapPinEnhancedGroupPinOperationsMixin:AddMultiplePins(pinsData, preserveGroupOrder, pinOrders)
    assert(pinsData, "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData is nil")
    assert(type(pinsData) == "table", "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData must be a table")
    if #pinsData == 0 then return end

    ---@type MapPinEnhancedPinMixin?
    local trackedPin
    ---@param pinData pinData|SaveablePinData
    local function addPin(pinData)
        local pinID = pinData.pinID
        local pin, _, _, shouldTrack = AddWithoutCommit(self, pinData, pinID,
            pinID and pinOrders and pinOrders[pinID] or nil)
        if shouldTrack then trackedPin = pin end
    end

    local function finish()
        self:PruneOldestReachedPins()
        Commit(self, not preserveGroupOrder)
        if trackedPin then trackedPin:TrackAfterGroupCommit() end
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end

    if #pinsData < 50 then
        for _, pinData in ipairs(pinsData) do addPin(pinData) end
        finish()
        return
    end

    ---@type function[]
    local tasks = {}
    for _, pinData in ipairs(pinsData) do
        local data = pinData
        tasks[#tasks + 1] = function() addPin(data) end
    end
    local batchSize = math.min(math.max(math.ceil(#pinsData / 60), 10), 100)
    MapPinEnhanced:BatchExecution(tasks, nil, finish, batchSize)
end

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:RemovePin(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:RemovePin: pinID is nil")

    local pin = self:GetPinByID(pinID)
    local wasTracked = pin and pin:IsTracked() or false
    local order = self.pinState:GetOrder(pinID)
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(order) or nil
    local removedPin, archivedPin = self.pinState:Remove(pinID)
    if not removedPin and not archivedPin then return false end

    ResetLimitWarningIfBelowTarget(self)
    Commit(self, true)
    if removedPin then
        self.pinState:ReleaseDetachedPin(pinID)
        MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pinID)
    else
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end

    if wasTracked then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackAfterGroupCommit()
        else
            Groups:TrackNextPinAfterGroup(self, order)
        end
    end
    return true
end

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:MarkPinReached(pinID)
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
    Commit(self, true)
    MapPinEnhanced:FireCallback("PIN_REACHED", nil, self, pinID, data)
    if wasTracked then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackAfterGroupCommit()
        else
            Groups:TrackNextPinAfterGroup(self, order)
        end
    end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:RestoreReachedPins()
    if self.hidden then return false end
    if self.pinState:RestoreArchived(ARCHIVE_STATE_REACHED) == 0 then return false end
    Commit(self, true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:HideGroup()
    if self.protected or self.hidden then return false end
    local hadTrackedPin = self.pinState:ArchiveAll(ARCHIVE_STATE_HIDDEN)
    self.hidden = true
    Commit(self, true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    if hadTrackedPin then Groups:TrackNextPinAfterGroup(self) end
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:ShowGroup()
    if not self.hidden then return false end
    self.hidden = false
    self.pinState:RestoreArchived()
    Commit(self, true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:ClearGroup()
    if not self.protected then return false end
    self.pinState:Reset()
    self.limitWarningShown = false
    Commit(self, true)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param pinIDs UUID[]
function MapPinEnhancedGroupPinOperationsMixin:RemoveMultiplePins(pinIDs)
    assert(pinIDs, "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs is nil")
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs must be a table")
    if #pinIDs == 0 then return end

    ---@type UUID[]
    local detachedPinIDs = {}
    ---@param pinID UUID
    local function removePin(pinID)
        local pin = self.pinState:Remove(pinID)
        if pin then detachedPinIDs[#detachedPinIDs + 1] = pinID end
    end
    local function finish()
        ResetLimitWarningIfBelowTarget(self)
        Commit(self, true)
        for _, pinID in ipairs(detachedPinIDs) do self.pinState:ReleaseDetachedPin(pinID) end
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    if #pinIDs < 50 then
        for _, pinID in ipairs(pinIDs) do removePin(pinID) end
        finish()
        return
    end

    ---@type function[]
    local tasks = {}
    for _, pinID in ipairs(pinIDs) do
        local id = pinID
        tasks[#tasks + 1] = function() removePin(id) end
    end
    local batchSize = math.min(math.max(math.ceil(#pinIDs / 60), 10), 100)
    MapPinEnhanced:BatchExecution(tasks, nil, finish, batchSize)
end

---@param pinID UUID
---@return UUID?
function MapPinEnhancedGroupPinOperationsMixin:DuplicatePin(pinID)
    local entries = self:GetPinEntries()
    ---@type SaveablePinData?
    local sourceData
    for _, entry in ipairs(entries) do
        if entry.pinID == pinID then sourceData = entry.data end
    end
    if not sourceData then return nil end

    sourceData.pinID = nil
    local pin, duplicatePinID, replacedWayBackPin, shouldTrack = AddWithoutCommit(self, sourceData)
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
    Commit(self, true)
    if shouldTrack and pin then pin:TrackAfterGroupCommit() end
    if pin then MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin) end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return duplicatePinID
end

---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return boolean
function MapPinEnhancedGroupPinOperationsMixin:MovePinToGroup(pinID, targetGroup)
    if self == targetGroup then return false end
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
    Commit(self, true)
    if sourcePin then
        self.pinState:ReleaseDetachedPin(pinID)
        MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pinID)
    end

    local targetEntries = targetGroup:GetPinEntries()
    local targetPin, _, replacedWayBackPin, shouldTrack =
        AddWithoutCommit(targetGroup, sourceEntry.data, pinID)
    ---@type UUID[]
    local targetOrder = {}
    if not replacedWayBackPin then
        for _, entry in ipairs(targetEntries) do targetOrder[#targetOrder + 1] = entry.pinID end
    end
    targetOrder[#targetOrder + 1] = pinID
    assert(targetGroup.pinState:Reorder(targetOrder),
        "MapPinEnhancedGroupMixin:MovePinToGroup: could not apply target pin order")

    Commit(targetGroup, true)
    if shouldTrack and targetPin then targetPin:TrackAfterGroupCommit() end
    if targetPin then MapPinEnhanced:FireCallback("PIN_ADDED", nil, targetGroup, targetPin) end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)

    if wasTracked and not targetPin then
        if nextOrderedPin and self:GetPinByID(nextOrderedPin.pinID) then
            nextOrderedPin:TrackAfterGroupCommit()
        else
            Groups:TrackNextPinAfterGroup(self, cursorOrder)
        end
    end
    return true
end
