---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")

local ARCHIVE_STATE_REACHED = "reached"
local ARCHIVE_STATE_HIDDEN = "hidden"

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinRestorationMixin = {}

---@param pinData SaveablePinData
---@return SaveablePinData, UUID?
local function CleanRestoredPinData(pinData)
    if type(pinData.pinID) == "string" then return pinData, pinData.pinID end
    ---@type SaveablePinData
    local normalized = CopyTable(pinData)
    normalized.pinID = nil
    return normalized, nil
end

---@param groupData SaveableGroupData
function MapPinEnhancedGroupPinRestorationMixin:RestorePinState(groupData)
    self:CancelBatch()
    self.pinState:Reset()

    local pinArchive = type(groupData.pinArchive) == "table" and groupData.pinArchive or {}
    for pinID, archivedPin in pairs(pinArchive) do
        if type(pinID) == "string" and type(archivedPin) == "table" and
            type(archivedPin.data) == "table" and
            (archivedPin.state == ARCHIVE_STATE_REACHED or archivedPin.state == ARCHIVE_STATE_HIDDEN) then
            local state = self.hidden and ARCHIVE_STATE_HIDDEN or archivedPin.state
            self.pinState:AddArchived(archivedPin.data, state,
                type(archivedPin.order) == "number" and archivedPin.order or nil, pinID)
        end
    end

    local pins = type(groupData.pins) == "table" and groupData.pins or {}
    local pinOrders = type(groupData.pinOrder) == "table" and groupData.pinOrder or nil
    ---@type table<UUID, boolean>
    local retainedIDs = {}
    for _, entry in ipairs(self:GetPinEntries()) do retainedIDs[entry.pinID] = true end

    ---@type UUID[]
    local activePins = {}
    ---@type UUID?
    local trackedPinID
    if not self.hidden then
        for pinID, archivedPin in pairs(self.pinState.archive) do
            if archivedPin.state == ARCHIVE_STATE_HIDDEN then activePins[#activePins + 1] = pinID end
        end
    end
    for _, rawPinData in ipairs(pins) do
        if type(rawPinData) == "table" then
            ---@cast rawPinData SaveablePinData
            local pinData, pinID = CleanRestoredPinData(rawPinData)
            if pinID and retainedIDs[pinID] then
                ---@type SaveablePinData
                pinData = CopyTable(pinData)
                pinData.pinID = nil
                pinID = nil
            end
            local restoredID = self.pinState:AddArchived(pinData, ARCHIVE_STATE_HIDDEN,
                pinID and pinOrders and pinOrders[pinID] or nil, pinID)
            retainedIDs[restoredID] = true
            if not self.hidden then
                activePins[#activePins + 1] = restoredID
                if pinData.setTracked then trackedPinID = restoredID end
            end
        end
    end

    if self.hidden or #activePins == 0 then
        self:PersistPinChanges()
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        return
    end

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
        self:PruneOldestReachedPins()
        self:PersistPinChanges()
        local trackedPin = trackedPinID and self:GetPinByID(trackedPinID)
        if trackedPin then trackedPin:TrackWithoutPersisting() end
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        if status ~= "complete" then Groups:ReportStoppedPinOperation(completed, #activePins) end
    end

    local function onError(message)
        finish("stopped")
        geterrorhandler()(message)
    end

    cancelBatch = function() finish("stopped") end
    self.cancelBatch = cancelBatch

    local function restorePin(pinID)
        if finished or not self:IsSameGroup(groupID, lifetimeChangeNumber) then return false end
        if not self.pinState:RestoreArchivedPin(pinID) then return false end
        completed = completed + 1
        return not finished and self:IsSameGroup(groupID, lifetimeChangeNumber)
    end

    if #activePins < 50 then
        for _, pinID in ipairs(activePins) do
            local success, restored = pcall(restorePin, pinID)
            if not success then
                onError(tostring(restored))
                return
            end
            if not restored then
                finish("stopped")
                return
            end
        end
        finish("complete")
        return
    end

    ---@type (fun(): boolean?)[]
    local tasks = {}
    for _, pinID in ipairs(activePins) do
        local id = pinID
        tasks[#tasks + 1] = function() return restorePin(id) end
    end
    local batchSize = math.min(math.max(math.ceil(#activePins / 60), 10), 100)
    cancelExecution = MapPinEnhanced:BatchExecution(tasks, nil, finish, batchSize, onError)
end
