---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
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


local groupsPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
groupsPool.capacity = 100 -- only allow 100 groups at the same time

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

    local group = groupsPool:Acquire()
    group:SetIcon(groupInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark") -- Default icon if not provided
    group:SetName(groupInfo.name)
    group:SetSource(groupInfo.source)

    return group
end

function Groups:UnregisterPinGroup(group)
    assert(group, "Groups:UnregisterPinGroup: group is nil")
    assert(type(group) == "table", "Groups:UnregisterPinGroup: group must be a table")
    assert(group.Reset, "Groups:UnregisterPinGroup: group must be a MapPinEnhancedPinGroupMixin object")

    groupsPool:Release(group)
end

function Groups:GetGroupByName(name)
    assert(name, "Groups:GetGroupByName: name is nil")
    assert(type(name) == "string", "Groups:GetGroupByName: name must be a string")

    ---@param group MapPinEnhancedPinGroupMixin
    for group in groupsPool:EnumerateActive() do
        if group:GetName() == name then
            return group
        end
    end

    return nil
end

-- Initialize default groups
function Groups:InitializeDefaultGroups()
    for _, groupInfo in ipairs(DEFAULT_GROUPS) do
        local group = groupsPool:Acquire()
        group:SetIcon(groupInfo.icon)
        group:SetName(groupInfo.name)
        group:SetSource(groupInfo.source)
    end
end

Groups:InitializeDefaultGroups()
