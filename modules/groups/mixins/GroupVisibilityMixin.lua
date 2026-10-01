---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupVisibilityMixin = {}

---Drain live resources before publishing hidden/empty state or releasing the group.
---Conflicting commands are rejected; only owner teardown may interrupt this work.
---@param archive boolean
---@param onComplete fun()?
function MapPinEnhancedGroupVisibilityMixin:ReleasePins(archive, onComplete)
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
        if status == "complete" then
            if archive then self.hidden = true end
            self.limitWarningShown = false
        end
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
            if archive then
                self.pinState:ArchiveActive(pinID, "hidden")
            else
                self.pinState:Remove(pinID)
                self.pinState:ReleaseDetachedPin(pin)
            end
            if finished then return false end
            checkpoint()
        end
        for pinID, archivedPin in pairs(self.pinState.archive) do
            if archive then
                archivedPin.state = "hidden"
            else
                self.pinState:Remove(pinID)
            end
            checkpoint()
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
    self:ReleasePins(true)
    return true
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:ShowGroup()
    if not self:CancelBatch() then return false end
    if not self.hidden then return false end
    return self:RestoreArchivedPins()
end

---@return boolean accepted
function MapPinEnhancedGroupVisibilityMixin:ClearGroup()
    if not self:CancelBatch() then return false end
    if not self.protected then return false end
    self:ReleasePins(false)
    return true
end
