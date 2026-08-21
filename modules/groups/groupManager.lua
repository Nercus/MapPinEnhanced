---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field groupsPool ObjectPool<MapPinEnhancedGroupMixin>
---@field debouncedPersist table<string, function> a table to store debounced persist functions by groupID
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
function Groups:NormalizeGroupName(name)
    assert(name, "Groups:NormalizeGroupName: name is nil")
    assert(type(name) == "string", "Groups:NormalizeGroupName: name must be a string")
    return (name:gsub("^%s*(.-)%s*$", "%1"))
end

---@param name string
---@return string
function Groups:GetNameKey(name)
    return string.lower(self:NormalizeGroupName(name))
end

---@param name string
---@return boolean
function Groups:IsValidGroupName(name)
    if type(name) ~= "string" then return false end
    return self:NormalizeGroupName(name) ~= ""
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
        table.insert(groups, group)
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

    local groupID = group:GetGroupID()
    group.isDeleting = true
    self.debouncedPersist[groupID] = nil
    MapPinEnhanced:DeleteVar("groups", groupID)
    self:UnregisterGroup(group)
    MapPinEnhanced:FireCallback("GROUP_DELETED", nil, groupID)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil)
    return true
end

function Groups:GetGroupByName(name)
    assert(name, "Groups:GetGroupByName: name is nil")
    assert(type(name) == "string", "Groups:GetGroupByName: name must be a string")
    local nameKey = self:GetNameKey(name)
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        if self:GetNameKey(group:GetName()) == nameKey then
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
        if group:GetGroupID() == groupID then
            return group
        end
    end

    return nil
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

    for group in self:EnumerateGroups() do
        if group:GetPinByID(pinID) or group:GetArchivedPinByID(pinID) then
            return true
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
        if group ~= excludedGroup and not group:IsHidden() and group:GetPinCount() > 0 then
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
        nextPin:TrackAfterGroupCommit()
        return nextPin
    end

    local _, crossGroupPin = self:GetNextTrackableGroup(group)
    if crossGroupPin then
        crossGroupPin:Track()
    end
    return crossGroupPin
end

---@param name string
---@return MapPinEnhancedGroupMixin?
function Groups:CreateGroupFromUngrouped(name)
    assert(name, "Groups:CreateGroupFromUngrouped: name is nil")
    assert(type(name) == "string", "Groups:CreateGroupFromUngrouped: name must be a string")
    if not self:IsValidGroupName(name) then return nil end

    local normalizedName = self:NormalizeGroupName(name)
    if self:GetGroupByName(normalizedName) then
        return nil
    end

    local ungroupedGroup = self:GetUngroupedGroup()
    if not ungroupedGroup then return nil end
    if ungroupedGroup:GetTotalPinCount() == 0 then return nil end

    local ungroupedData = ungroupedGroup:GetSaveableData()
    local targetGroup = self:RegisterGroup({
        name = normalizedName,
        source = MapPinEnhanced.name,
        icon = ungroupedGroup:GetIcon(),
        order = GetTime(),
        trackingMode = self:GetDefaultTrackingMode(),
    })
    if not targetGroup then return nil end

    ungroupedGroup:ClearGroup()
    targetGroup:RestorePinState(ungroupedData)

    return targetGroup
end

Groups.debouncedPersist = {}
---@param group MapPinEnhancedGroupMixin
function Groups:PersistGroup(group)
    assert(group, "Groups:PersistGroup: group is nil")
    if group.isDeleting then return end
    local groupID = group:GetGroupID()
    assert(groupID, "Groups:PersistGroup: groupID is nil")

    if not self.debouncedPersist[groupID] then
        self.debouncedPersist[groupID] = MapPinEnhanced:DebounceChange(function()
            local data = group:GetSaveableData()
            assert(data, "Groups:PersistGroup: data is nil")
            if not data or not data.groupID then return end
            MapPinEnhanced:SetVar("groups", data.groupID, data)
        end, 0.5)
    end

    self.debouncedPersist[groupID]()
end

---@return fun(): MapPinEnhancedGroupMixin
---@return any
function Groups:EnumerateGroups()
    local groupsPool = Groups:GetObjectPool()
    return groupsPool:EnumerateActive()
end

---@return string
function Groups:GetAvailableImportGroupName()
    local index = 1
    while self:GetGroupByName(string.format(L["Import %d"], index)) do
        index = index + 1
    end
    return string.format(L["Import %d"], index)
end

function Groups:InitializeDefaultGroups()
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
    Groups:RestoreAllGroups()
    Groups:InitializeDefaultGroups()
end)
