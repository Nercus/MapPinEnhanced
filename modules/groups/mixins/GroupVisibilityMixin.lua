---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupVisibilityMixin = {}

---Drain live resources before publishing hidden/empty state or releasing the group.
---Conflicting commands are rejected; only owner teardown may interrupt this work.
---@param archiveState "hidden"|"cleared"|false
---@param onComplete fun()?
function MapPinEnhancedGroupVisibilityMixin:ReleasePins(archiveState, onComplete)
    local groupID, lifetimeChangeNumber = self:GetGroupID(), self.lifetimeChangeNumber
    local deleting = self.isDeleting
    local finished, hadTrackedPin = false, false
    ---@type fun()?
    local cancelExecution
    ---@type fun()
    local cancelBatch

    local function isCurrent()
        return self:GetGroupID() == groupID and self.lifetimeChangeNumber == lifetimeChangeNumber and
            self.isDeleting == deleting
    end

    local function finish(status)
        if finished then return end
        finished = true
        if cancelExecution then cancelExecution() end
        cancelExecution = nil
        if self.cancelBatch == cancelBatch then self.cancelBatch = nil end
        if not isCurrent() then return end
        self.pinsUpdating, self.batchLocked = nil, nil
        if status == "complete" and archiveState == "hidden" then self.hidden = true end
        if not deleting then
            self:PersistPinChanges(true, status == "complete")
            MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
            if hadTrackedPin then Groups:TrackNextPinAfterGroup(self) end
        end
        if status == "complete" and onComplete then onComplete() end
    end

    cancelBatch = function() finish("stopped") end
    self.cancelBatch = cancelBatch
    self.batchLocked = true
    self:BeginPinChanges()
    if finished then return end
    cancelExecution = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint()
        -- Deleting the current key is safe during next/pairs; no insertions are admitted.
        for pinID, pin in pairs(self.pinState.pins) do
            if not isCurrent() then return false end
            hadTrackedPin = hadTrackedPin or pin:IsTracked()
            if archiveState == "hidden" or archiveState == "cleared" and self:IsRestorable() then
                local changed, data = self.pinState:ArchiveActive(pinID, archiveState)
                if changed and archiveState == "cleared" then
                    MapPinEnhanced:FireCallback("PIN_CLEARED", nil, self, pinID, data)
                end
            else
                local data = archiveState == "cleared" and CopyTable(pin:GetSaveableData()) or nil
                self.pinState:Remove(pinID)
                self.pinState:ReleaseDetachedPin(pin)
                if data then MapPinEnhanced:FireCallback("PIN_CLEARED", nil, self, pinID, data) end
            end
            if finished then return false end
            checkpoint()
        end
        -- Hiding and clearing active pins preserve all previously retained state.
        -- Only permanent group deletion/emptying discards the archive.
        if archiveState == false then
            for pinID in pairs(self.pinState.archive) do
                self.pinState:Remove(pinID)
                checkpoint()
            end
        end
        self.pinState.changeNumber = self.pinState.changeNumber + 1
        self.pinState:CheckPinState(checkpoint)
    end }, nil, finish, 1, function(message)
        finish("stopped")
        geterrorhandler()(message)
    end)
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:HideGroup()
    if not self:CancelBatch() then return false end
    if self.protected or self.hidden then return false end
    self:ReleasePins("hidden")
    return true
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:ShowGroup()
    if not self:CancelBatch() then return false end
    if not self.hidden then return false end
    return self:RestoreArchivedPins(nil, "hidden")
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:ClearGroup()
    if not self:CancelBatch() then return false end
    self:ReleasePins(false)
    return true
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:ClearAllPins()
    if not self:CancelBatch() then return false end
    if self.hidden or self:GetPinCount() == 0 then return true end
    self:ReleasePins("cleared")
    return true
end
