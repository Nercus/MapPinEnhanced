---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

Groups.debouncedPersist = {}

---@param groupID UUID?
function Groups:CancelGroupPersist(groupID)
    if not groupID then return end
    local pending = self.debouncedPersist[groupID]
    if not pending then return end
    pending.cancel()
    self.debouncedPersist[groupID] = nil
end

---@param group MapPinEnhancedGroupMixin
function Groups:PersistGroup(group)
    assert(group, "Groups:PersistGroup: group is nil")
    if group.isDeleting or group.pinsUpdating then return end
    local groupID = assert(group:GetGroupID(), "Groups:PersistGroup: groupID is nil")

    if not self.debouncedPersist[groupID] then
        local lifetimeChangeNumber = group.lifetimeChangeNumber
        ---@type fun()?
        local cancelExecution
        ---@type { schedule: fun(), cancel: fun() }
        local pending
        local function isCurrent()
            return self.debouncedPersist[groupID] == pending and not group.isDeleting and
                not group.pinsUpdating and group:GetGroupID() == groupID and
                group.lifetimeChangeNumber == lifetimeChangeNumber and self:GetGroupByID(groupID) == group
        end
        local schedule, cancelTimer = MapPinEnhanced:DebounceChange(function()
            if not isCurrent() then
                self:CancelGroupPersist(groupID)
                return
            end
            ---@type SaveableGroupData?
            local data
            cancelExecution = MapPinEnhanced:BatchExecution({ function()
                local checkpoint = MapPinEnhanced:CreateBatchCheckpoint()
                data = group:GetSaveableData(checkpoint)
            end }, nil, function()
                cancelExecution = nil
                if isCurrent() then
                    self.debouncedPersist[groupID] = nil
                    MapPinEnhanced:SetVar("groups", groupID, data)
                end
            end, 1, function(message)
                self:CancelGroupPersist(groupID)
                geterrorhandler()(message)
            end)
        end, 0.5)
        pending = {
            schedule = function()
                -- A mutation cannot leave a suspended copy of the old state alive.
                if cancelExecution then cancelExecution() end
                cancelExecution = nil
                schedule()
            end,
            cancel = function()
                cancelTimer()
                if cancelExecution then cancelExecution() end
                cancelExecution = nil
            end,
        }
        self.debouncedPersist[groupID] = pending
    end
    self.debouncedPersist[groupID].schedule()
end
