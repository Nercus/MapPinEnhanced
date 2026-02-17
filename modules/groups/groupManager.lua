---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field groupsPool ObjectPool<MapPinEnhancedGroupMixin>
---@field debouncedPersist table<string, function> a table to store the debounced persist functions for each group by group name
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

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


function Groups:GetAllGroups()
    local groups = {}
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        table.insert(groups, group)
    end
    return groups
end

---@param groupInfo GroupInfo
---@return MapPinEnhancedGroupMixin?
function Groups:RegisterGroup(groupInfo)
    assert(groupInfo, "Groups:RegisterGroup: groupInfo is nil")
    assert(groupInfo.name, "Groups:RegisterGroup: groupInfo.name is nil")
    assert(type(groupInfo.name) == "string", "Groups:RegisterGroup: groupInfo.name must be a string")
    assert(groupInfo.source, "Groups:RegisterGroup: groupInfo.source is nil")
    assert(type(groupInfo.source) == "string", "Groups:RegisterGroup: groupInfo.source must be a string")
    assert(C_AddOns.IsAddOnLoaded(groupInfo.source), "Groups:RegisterGroup: groupInfo.source is not a loaded addon")

    local existingGroup = self:GetGroupByName(groupInfo.name)
    if existingGroup then
        MapPinEnhanced:Debug("Groups:RegisterGroup: Group with name '%s' already exists, returning existing group",
            groupInfo.name)
        return existingGroup
    end

    local groupsPool = Groups:GetObjectPool()
    local group = groupsPool:Acquire()
    group:SetName(groupInfo.name)
    group:SetIcon(groupInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark") -- Default icon if not provided
    group:SetSource(groupInfo.source)

    return group
end

function Groups:UnregisterGroup(group)
    assert(group, "Groups:UnregisterGroup: group is nil")
    assert(type(group) == "table", "Groups:UnregisterGroup: group must be a table")
    assert(group.Reset, "Groups:UnregisterGroup: group must be a MapPinEnhancedGroupMixin object")

    local groupsPool = Groups:GetObjectPool()
    groupsPool:Release(group)
end

function Groups:GetGroupByName(name)
    assert(name, "Groups:GetGroupByName: name is nil")
    assert(type(name) == "string", "Groups:GetGroupByName: name must be a string")
    local groupsPool = Groups:GetObjectPool()
    ---@param group MapPinEnhancedGroupMixin
    for group in groupsPool:EnumerateActive() do
        if group:GetName() == name then
            return group
        end
    end

    return nil
end

Groups.debouncedPersist = {}
---@param group MapPinEnhancedGroupMixin
function Groups:PersistGroup(group)
    assert(group, "Groups:PersistGroup: group is nil")
    local groupName = group:GetName()
    assert(groupName, "Groups:PersistGroup: group name is nil")

    if not self.debouncedPersist[groupName] then
        self.debouncedPersist[groupName] = MapPinEnhanced:DebounceChange(function()
            local data = group:GetSaveableData()
            assert(data, "Groups:PersistGroup: data is nil")
            if not data or not data.name then return end
            MapPinEnhanced:SetVar("groups", data.name, data)
        end, 0.5)
    end

    self.debouncedPersist[groupName]()
end

---@param groupData SaveableGroupData
function Groups:RestoreGroup(groupData)
    assert(groupData, "Groups:RestoreGroup: groupInfo is nil")
    if #groupData.pins == 0 then
        -- If there are no pins in the group, we don't need to restore it
        return
    end
    local group = self:GetGroupByName(groupData.name)
    if not group then
        group = self:RegisterGroup(groupData)
    end
    assert(group, "Groups:RestoreGroup: group is nil after registration")
    group:AddMultiplePins(groupData.pins)
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
        -- Check if this default group already exists (from restoration)
        local existingGroup = self:GetGroupByName(groupInfo.name)
        if existingGroup then
            -- Ensure it has the correct source and icon
            if existingGroup:GetSource() ~= groupInfo.source then
                existingGroup:SetSource(groupInfo.source)
            end
            if existingGroup:GetIcon() ~= groupInfo.icon then
                existingGroup:SetIcon(groupInfo.icon)
            end
        else
            -- Only acquire a new one if it doesn't exist
            local group = groupsPool:Acquire()
            group:SetName(groupInfo.name)
            group:SetIcon(groupInfo.icon)
            group:SetSource(groupInfo.source)
        end
    end
end

MapPinEnhanced:OnLoad(function()
    -- the order here is important! The restore process purges all empty groups, so we need to restore the default groups first and then create the default groups
    Groups:RestoreAllGroups()
    Groups:InitializeDefaultGroups()
end)
