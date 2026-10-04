---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field groupsPool ObjectPool<MapPinEnhancedGroupMixin>
---@field debouncedPersist table<string, { schedule: fun(), cancel: fun() }> pending saves by groupID
---@field SYSTEM_GROUP_IDS table<string, string>
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

Groups.SYSTEM_GROUP_IDS = {
    UNGROUPED = "system-ungrouped",
    WAY_BACK = "system-way-back",
}

local SYSTEM_GROUP_TYPES = {
    [Groups.SYSTEM_GROUP_IDS.UNGROUPED] = "ungrouped",
    [Groups.SYSTEM_GROUP_IDS.WAY_BACK] = "way-back",
}

---@param groupID UUID?
---@return "ungrouped"|"way-back"?
function Groups:GetSystemGroupType(groupID)
    return groupID and SYSTEM_GROUP_TYPES[groupID] or nil
end

local function CreateGroupObject()
    return CreateAndInitFromMixin(MapPinEnhancedGroupMixin)
end

---@param group MapPinEnhancedGroupMixin
local function ResetGroupObject(_, group)
    group:Reset()
end

function Groups:GetObjectPool()
    if not self.objectPool then
        self.objectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
        self.objectPool.capacity = 100
    end

    return self.objectPool
end

---@param name string
---@return string
function Groups:CleanGroupName(name)
    assert(name, "Groups:CleanGroupName: name is nil")
    assert(type(name) == "string", "Groups:CleanGroupName: name must be a string")
    return (name:gsub("^%s*(.-)%s*$", "%1"))
end

---@param name string
---@return string
function Groups:GetNameKey(name)
    return string.lower(self:CleanGroupName(name))
end

---@param name string
---@return boolean
function Groups:IsValidGroupName(name)
    if type(name) ~= "string" then return false end
    return self:CleanGroupName(name) ~= ""
end

local DEFAULT_GROUPS = {
    {
        groupID = Groups.SYSTEM_GROUP_IDS.UNGROUPED,
        name = L["Ungrouped Pins"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\inv_ability_skyriding_glyph",
        order = -1,
        groupType = "ungrouped",
    },
    {
        groupID = Groups.SYSTEM_GROUP_IDS.WAY_BACK,
        name = L["My Way Back"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\rogue_burstofspeed",
        order = math.huge,
        groupType = "way-back",
    }
}

function Groups:GetAllGroups()
    local groups = {}
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        if not group.isDeleting then table.insert(groups, group) end
    end
    return groups
end

---@param group1 MapPinEnhancedGroupMixin
---@param group2 MapPinEnhancedGroupMixin
---@return boolean
function Groups:IsGroupBefore(group1, group2)
    local order1 = group1:GetOrder() or 0
    local order2 = group2:GetOrder() or 0
    if order1 ~= order2 then
        return order1 > order2
    end
    return (group1:GetName() or "") < (group2:GetName() or "")
end

---@param groupInfo GroupInfo
---@return MapPinEnhancedGroupMixin?
---@return string? failureReason
function Groups:RegisterGroup(groupInfo)
    assert(groupInfo, "Groups:RegisterGroup: groupInfo is nil")
    assert(groupInfo.name, "Groups:RegisterGroup: groupInfo.name is nil")
    assert(type(groupInfo.name) == "string", "Groups:RegisterGroup: groupInfo.name must be a string")
    assert(self:IsValidGroupName(groupInfo.name), "Groups:RegisterGroup: groupInfo.name is empty")
    assert(groupInfo.source, "Groups:RegisterGroup: groupInfo.source is nil")
    assert(type(groupInfo.source) == "string", "Groups:RegisterGroup: groupInfo.source must be a string")
    assert(groupInfo.source ~= "", "Groups:RegisterGroup: groupInfo.source is empty")
    assert(C_AddOns.IsAddOnLoaded(groupInfo.source), "Groups:RegisterGroup: groupInfo.source is not a loaded addon")
    assert(groupInfo.groupID == nil or type(groupInfo.groupID) == "string",
        "Groups:RegisterGroup: groupInfo.groupID must be a string")
    assert(groupInfo.groupID == nil or groupInfo.groupID ~= "",
        "Groups:RegisterGroup: groupInfo.groupID must not be empty")

    local groupID = groupInfo.groupID or MapPinEnhanced:GenerateUUID("group")
    if groupInfo.groupID then
        local deferredSource = self:GetDeferredGroupSource(groupID)
        if deferredSource and deferredSource ~= groupInfo.source then
            return nil, "a saved group with this ID belongs to another source addon"
        end
        if deferredSource then
            self:RestoreDeferredExternalGroups(deferredSource)
            if not self:GetGroupByID(groupID) then
                return nil, "the saved group could not be restored"
            end
        end
    end

    ---@param pendingGroup MapPinEnhancedGroupMixin
    for pendingGroup in self:GetObjectPool():EnumerateActive() do
        if pendingGroup.isDeleting and (pendingGroup:GetGroupID() == groupID or
            self:GetNameKey(pendingGroup:GetName()) == self:GetNameKey(groupInfo.name)) then
            return nil, "the group is being deleted"
        end
    end

    local existingGroup = self:GetGroupByID(groupID)
    if existingGroup then
        if existingGroup:GetSource() == groupInfo.source then return existingGroup end
        return nil, "a group with this ID belongs to another source addon"
    end

    if self:GetGroupByName(groupInfo.name) then
        return nil, "a group with this name already exists"
    end

    local groupsPool = Groups:GetObjectPool()
    local group = groupsPool:Acquire()
    if not group then return nil, "the group limit was reached" end
    groupInfo.groupID = groupID
    group:ApplyGroupInfo(groupInfo)
    self:PersistGroup(group)

    return group
end

function Groups:UnregisterGroup(group)
    assert(group, "Groups:UnregisterGroup: group is nil")
    assert(type(group) == "table", "Groups:UnregisterGroup: group must be a table")
    assert(group.Reset, "Groups:UnregisterGroup: group must be a MapPinEnhancedGroupMixin object")

    local groupsPool = Groups:GetObjectPool()
    groupsPool:Release(group)
end

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Groups:DeleteGroup(group)
    assert(group, "Groups:DeleteGroup: group is nil")
    if group:IsProtected() then return false end

    if group.isDeleting then return false end
    local groupID = group:GetGroupID()
    group.isDeleting = true
    group:CancelBatch(true)
    self:CancelGroupPersist(groupID)
    MapPinEnhanced:DeleteVar("groups", groupID)
    group:ReleasePins(false, function()
        self:UnregisterGroup(group)
        MapPinEnhanced:FireCallback("GROUP_DELETED", nil, groupID)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil)
    end)
    return true
end

function Groups:GetGroupByName(name)
    assert(name, "Groups:GetGroupByName: name is nil")
    assert(type(name) == "string", "Groups:GetGroupByName: name must be a string")
    local nameKey = self:GetNameKey(name)
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        if not group.isDeleting and self:GetNameKey(group:GetName()) == nameKey then
            return group
        end
    end

    return nil
end

function Groups:GetGroupByID(groupID)
    if not groupID then return nil end
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        if not group.isDeleting and group:GetGroupID() == groupID then
            return group
        end
    end

    return nil
end

---@return boolean accepted
function Groups:MarkAllPinsReached()
    local accepted = true
    for group in self:EnumerateGroups() do
        if not group:IsHidden() and not group:MarkAllPinsReached() then
            accepted = false
        end
    end
    return accepted
end

function Groups:GetUngroupedGroup()
    return self:GetGroupByID(self.SYSTEM_GROUP_IDS.UNGROUPED)
end

function Groups:GetWayBackGroup()
    return self:GetGroupByID(self.SYSTEM_GROUP_IDS.WAY_BACK)
end

---@param pinData pinData
---@return UUID?
function Groups:SetWayBackPin(pinData)
    assert(pinData, "Groups:SetWayBackPin: pinData is nil")
    local group = self:GetWayBackGroup()
    if not group then return nil end

    local _, pinID = group:AddPin(pinData)
    return pinID
end

---@param pinID UUID
---@return boolean
function Groups:IsPinIDInUse(pinID)
    if not pinID then return false end

    ---@param group MapPinEnhancedGroupMixin
    for group in self:GetObjectPool():EnumerateActive() do
        if group.pinState:GetOrder(pinID) ~= nil then return true end
        -- Intake/conversion owns IDs even before their first archive copy exists.
        local input = group.restoreData
        if input then
            if type(input.pinArchive) == "table" and input.pinArchive[pinID] then return true end
            if type(input.pins) == "table" then
                for _, pin in ipairs(input.pins) do
                    if type(pin) == "table" and pin.pinID == pinID then return true end
                end
            end
        end
    end

    return false
end

---@param excludedGroup MapPinEnhancedGroupMixin?
---@return MapPinEnhancedGroupMixin?, MapPinEnhancedPinMixin?
function Groups:GetNextTrackableGroup(excludedGroup)
    ---@type MapPinEnhancedGroupMixin?
    local bestGroup

    for group in self:EnumerateGroups() do
        if group ~= excludedGroup and not group.pinsUpdating and not group:IsHidden() and group:GetPinCount() > 0 then
            if not bestGroup or self:IsGroupBefore(group, bestGroup) then
                bestGroup = group
            end
        end
    end

    if not bestGroup then return nil, nil end
    return bestGroup, bestGroup:GetNextTrackablePin()
end

---@param group MapPinEnhancedGroupMixin
---@param cursorOrder number?
---@return MapPinEnhancedPinMixin?
function Groups:TrackNextPinAfterGroup(group, cursorOrder)
    assert(group, "Groups:TrackNextPinAfterGroup: group is nil")

    local nextPin = group:GetNextTrackablePin(cursorOrder)
    if nextPin then
        -- The group was already saved, so tracking this pin must not save it again.
        nextPin:TrackWithoutPersisting()
        return nextPin
    end

    local _, crossGroupPin = self:GetNextTrackableGroup(group)
    if crossGroupPin then
        crossGroupPin:Track()
    end
    return crossGroupPin
end

---@param completed integer
---@param total integer
function Groups:ReportStoppedPinOperation(completed, total)
    MapPinEnhanced:Print(string.format(
        MapPinEnhanced.L["Pin operation stopped after %d of %d pins. Completed changes were kept."], completed, total))
end

---@return fun(): MapPinEnhancedGroupMixin
---@return any
function Groups:EnumerateGroups()
    local groupsPool = Groups:GetObjectPool()
    local iterator, state = groupsPool:EnumerateActive()
    ---@cast iterator fun(state: any, key: MapPinEnhancedGroupMixin?): MapPinEnhancedGroupMixin?
    ---@type MapPinEnhancedGroupMixin?
    local key
    return function()
        repeat
            key = iterator(state, key)
        until not key or not key.isDeleting
        return key
    end
end

---@return string
function Groups:GetAvailableImportGroupName()
    local index = 1
    while self:GetGroupByName(string.format(L["Import %d"], index)) do
        index = index + 1
    end
    return string.format(L["Import %d"], index)
end

function Groups:CreateDefaultGroups()
    for _, groupInfo in ipairs(DEFAULT_GROUPS) do
        local existingGroup = groupInfo.groupID and self:GetGroupByID(groupInfo.groupID) or
            self:GetGroupByName(groupInfo.name)
        if existingGroup then
            existingGroup:ApplyGroupInfo(groupInfo)
            self:PersistGroup(existingGroup)
        else
            self:RegisterGroup(groupInfo)
        end
    end
end

MapPinEnhanced:OnLoad(function()
    Groups:MigrateLegacyData()
    Groups:RestoreAllGroups()
    Groups:CreateDefaultGroups()
end)
