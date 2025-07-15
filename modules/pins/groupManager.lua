---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field groupsPool ObjectPool<MapPinEnhancedPinGroupMixin>
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

---@class GroupInfo
---@field name string the name of the group
---@field source string the name of the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map

local function CreateGroupObject()
    return CreateAndInitFromMixin(MapPinEnhancedPinGroupMixin)
end

---@param group MapPinEnhancedPinGroupMixin
local function ResetGroupObject(_, group)
    group:Reset()
end

function Groups:GetObjectPool()
    if not self.objectPool then
        self.objectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
        self.objectPool.capacity = 100 -- only allow 100 groups at the same time
    end

    return self.objectPool
end

local DEFAULT_GROUPS = {
    {
        name = L["Uncategorized Pins"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\INV_Misc_QuestionMark",
    },
    {
        name = L["Temporary Import"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\INV_Misc_QuestionMark",
    }
}


---@param groupInfo GroupInfo
---@return MapPinEnhancedPinGroupMixin
function Groups:RegisterPinGroup(groupInfo)
    assert(groupInfo, "Groups:RegisterPinGroup: groupInfo is nil")
    assert(groupInfo.name, "Groups:RegisterPinGroup: groupInfo.name is nil")
    assert(type(groupInfo.name) == "string", "Groups:RegisterPinGroup: groupInfo.name must be a string")
    assert(groupInfo.source, "Groups:RegisterPinGroup: groupInfo.source is nil")
    assert(type(groupInfo.source) == "string", "Groups:RegisterPinGroup: groupInfo.source must be a string")
    assert(C_AddOns.IsAddOnLoaded(groupInfo.source), "Groups:RegisterPinGroup: groupInfo.source is not a loaded addon")
    -- Assert that the group name is not a default group name
    for _, defaultGroup in ipairs(DEFAULT_GROUPS) do
        assert(groupInfo.name ~= defaultGroup.name,
            "Groups:RegisterPinGroup: groupInfo.name cannot be a default group name")
    end

    local existingGroup = self:GetGroupByName(groupInfo.name)
    if existingGroup then
        return existingGroup
    end

    local groupsPool = Groups:GetObjectPool()
    local group = groupsPool:Acquire()
    group:SetName(groupInfo.name)
    group:SetIcon(groupInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark") -- Default icon if not provided
    group:SetSource(groupInfo.source)

    return group
end

function Groups:UnregisterPinGroup(group)
    assert(group, "Groups:UnregisterPinGroup: group is nil")
    assert(type(group) == "table", "Groups:UnregisterPinGroup: group must be a table")
    assert(group.Reset, "Groups:UnregisterPinGroup: group must be a MapPinEnhancedPinGroupMixin object")

    local groupsPool = Groups:GetObjectPool()
    groupsPool:Release(group)
end

function Groups:GetGroupByName(name)
    assert(name, "Groups:GetGroupByName: name is nil")
    assert(type(name) == "string", "Groups:GetGroupByName: name must be a string")
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedPinGroupMixin
    for group in groupsPool:EnumerateActive() do
        if group:GetName() == name then
            return group
        end
    end

    return nil
end

---@type table<string, function>
local debouncedPersist = {}

---@param group MapPinEnhancedPinGroupMixin
function Groups:PersistGroup(group)
    assert(group, "Groups:PersistGroup: group is nil")
    local groupName = group:GetName()
    assert(groupName, "Groups:PersistGroup: group name is nil")

    -- Persisting the data for a group is debounced to avoid excessive calls of the function on a half second delay
    if not debouncedPersist[groupName] then
        debouncedPersist[groupName] = MapPinEnhanced:DebounceChange(function()
            local data = group:GetSaveableData()
            assert(data, "Groups:PersistGroup: data is nil")
            if not data or not data.name then return end
            MapPinEnhanced:SetVar("groups", data.name, data)
        end, 0.5)
    end

    debouncedPersist[groupName]()
end

---@param groupData SaveableGroupData
function Groups:RestoreGroup(groupData)
    assert(groupData, "Groups:RestoreGroup: groupInfo is nil")
    local group = self:GetGroupByName(groupData.name)
    if not group then
        group = self:RegisterPinGroup(groupData)
    end
    assert(group, "Groups:RestoreGroup: group is nil after registration")

    ---@param pinData SaveablePinData
    for _, pinData in ipairs(groupData.pins) do
        assert(pinData, "Groups:RestoreGroup: pinData is nil")
        assert(type(pinData) == "table", "Groups:RestoreGroup: pinData must be a table")
        group:AddPin(pinData, pinData.pinID)
    end
end

function Groups:RestoreAllGroups()
    ---@type SaveableGroupData[] | nil
    local groupsData = MapPinEnhanced:GetVar("groups")
    if not groupsData then
        return
    end

    for _, groupData in pairs(groupsData) do
        self:RestoreGroup(groupData)
    end
end

function Groups:EnumerateGroups()
    local groupsPool = Groups:GetObjectPool()
    return groupsPool:EnumerateActive()
end

-- Initialize default groups
function Groups:InitializeDefaultGroups()
    local groupsPool = Groups:GetObjectPool()
    for _, groupInfo in ipairs(DEFAULT_GROUPS) do
        local group = groupsPool:Acquire()
        group:SetName(groupInfo.name)
        group:SetIcon(groupInfo.icon)
        group:SetSource(groupInfo.source)
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Groups:InitializeDefaultGroups()
    Groups:RestoreAllGroups()
end)
