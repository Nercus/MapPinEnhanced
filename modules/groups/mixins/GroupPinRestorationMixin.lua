---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinRestorationMixin = {}

---Saved input is retained by this operation until intake finishes. Only deletion
---may discard it; other commands are rejected while intake is copying archives.
---@param groupData SaveableGroupData?
---@param state "reached"|"hidden"?
---@return boolean accepted
function MapPinEnhancedGroupPinRestorationMixin:RestoreArchivedPins(groupData, state)
    if not self:CancelBatch() then return false end
    local groupID, lifetimeChangeNumber = self:GetGroupID(), self.lifetimeChangeNumber
    local completed, total, finished = 0, 0, false
    local intakeComplete = not groupData
    local wasHidden = self.hidden
    ---@type UUID?
    local trackedPinID
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
        self.pinsUpdating, self.batchLocked = nil, nil
        -- An intake error must not overwrite the original saved input with a prefix.
        if not intakeComplete then
            self.restoreData = groupData
            Groups:PersistGroup(self)
        else
            self.restoreData = nil
            self:PruneOldestReachedPins()
            self:PersistPinChanges(not groupData, status == "complete")
        end
        local trackedPin = trackedPinID and self:GetPinByID(trackedPinID)
        if trackedPin then trackedPin:TrackWithoutPersisting() end
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        if status ~= "complete" then Groups:ReportStoppedPinOperation(completed, total) end
    end

    cancelBatch = function() finish("stopped") end
    self.cancelBatch = cancelBatch
    self.batchLocked = groupData ~= nil
    self.restoreData = groupData
    self:BeginPinChanges()
    if finished then return false end
    cancelExecution = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint()
        if groupData then
            self.pinState:Reset(checkpoint)
            if finished then return false end
            local archive = type(groupData.pinArchive) == "table" and groupData.pinArchive or {}
            for pinID, archivedPin in pairs(archive) do
                if finished then return false end
                if type(pinID) == "string" and type(archivedPin) == "table" and
                    type(archivedPin.data) == "table" and
                    (archivedPin.state == "reached" or archivedPin.state == "hidden") then
                    self.pinState:AddArchived(archivedPin.data, wasHidden and "hidden" or archivedPin.state,
                        type(archivedPin.order) == "number" and archivedPin.order or nil, pinID)
                end
                checkpoint()
            end
            local pins = type(groupData.pins) == "table" and groupData.pins or {}
            local orders = type(groupData.pinOrder) == "table" and groupData.pinOrder or {}
            for _, rawData in ipairs(pins) do
                if finished then return false end
                if type(rawData) == "table" then
                    local data = CopyTable(rawData)
                    local pinID = type(data.pinID) == "string" and data.pinID or nil
                    if pinID and self.pinState.archive[pinID] then pinID = nil end
                    data.pinID = pinID
                    local restoredID = self.pinState:AddArchived(data, "hidden", pinID and orders[pinID], pinID)
                    if data.setTracked then trackedPinID = restoredID end
                end
                checkpoint()
            end
            intakeComplete = true
            self.restoreData = nil
            self.batchLocked = nil
        end
        -- A hidden saved group stays archived; ShowGroup activates its archives.
        if not groupData or not wasHidden then
            self.hidden = false
            for _, archivedPin in pairs(self.pinState.archive) do
                if not state or archivedPin.state == state then total = total + 1 end
                checkpoint()
            end
            for pinID, archivedPin in pairs(self.pinState.archive) do
                if not state or archivedPin.state == state then
                    if not self:IsSameGroup(groupID, lifetimeChangeNumber) then return false end
                    if not self.pinState:RestoreArchivedPin(pinID) then return false end
                    completed = completed + 1
                end
                checkpoint()
            end
        end
        self.pinState:CheckPinState(checkpoint)
    end }, nil, finish, 1, function(message)
        finish("stopped")
        geterrorhandler()(message)
    end)
    return true
end

---@param groupData SaveableGroupData
---@return boolean accepted
function MapPinEnhancedGroupPinRestorationMixin:RestorePinState(groupData)
    -- Visible saved groups retry hidden archives, but preserve reached history.
    return self:RestoreArchivedPins(groupData, "hidden")
end

---@return boolean accepted
function MapPinEnhancedGroupPinRestorationMixin:RestoreReachedPins()
    if self.hidden or self:GetReachedPinCount() == 0 then return false end
    return self:RestoreArchivedPins(nil, "reached")
end
