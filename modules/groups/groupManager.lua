---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field groupsPool ObjectPool<MapPinEnhancedGroupMixin>
---@field debouncedPersist table<string, function> a table to store debounced persist functions by groupID
---@field SYSTEM_GROUP_IDS table<string, string>
---@field RESERVED_GROUP_NAMES table<string, string>
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

Groups.SYSTEM_GROUP_IDS = {
    UNGROUPED = "system-ungrouped",
}

Groups.RESERVED_GROUP_NAMES = {
    WAY_BACK = L["My Way Back"],
}

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
        name = Groups.RESERVED_GROUP_NAMES.WAY_BACK,
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\rogue_burstofspeed",
        order = math.huge,
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
    assert(self:IsValidGroupName(groupInfo.name), "Groups:RegisterGroup: groupInfo.name is empty")
    assert(groupInfo.source, "Groups:RegisterGroup: groupInfo.source is nil")
    assert(type(groupInfo.source) == "string", "Groups:RegisterGroup: groupInfo.source must be a string")
    assert(C_AddOns.IsAddOnLoaded(groupInfo.source), "Groups:RegisterGroup: groupInfo.source is not a loaded addon")

    if self:GetGroupByName(groupInfo.name) then
        return nil
    end

    local groupID = groupInfo.groupID or MapPinEnhanced:GenerateUUID("group")
    if self:GetGroupByID(groupID) then
        return nil
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
    return self:GetGroupByName(self.RESERVED_GROUP_NAMES.WAY_BACK)
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
    ---@type number?
    local bestOrder

    for group in self:EnumerateGroups() do
        if group ~= excludedGroup and not group:IsHidden() and group:GetPinCount() > 0 then
            local order = group:GetOrder() or 0
            if not bestGroup or order > bestOrder then
                bestGroup = group
                bestOrder = order
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

    local nextPin = group:TrackNextTrackablePin(cursorOrder)
    if nextPin then return nextPin end

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

    for pinID, order in pairs(ungroupedData.pinOrder or {}) do
        targetGroup:SetPinOrder(pinID, order, true)
    end

    for pinID, archivedPin in pairs(ungroupedData.pinArchive or {}) do
        targetGroup.pinArchive[pinID] = CopyTable(archivedPin)
    end

    ungroupedGroup:ClearGroup()

    if #(ungroupedData.pins or {}) > 0 then
        targetGroup:AddMultiplePins(ungroupedData.pins)
    else
        self:PersistGroup(targetGroup)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)
    end

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

---@param groupData SaveableGroupData
function Groups:RestoreGroup(groupData)
    assert(groupData, "Groups:RestoreGroup: groupInfo is nil")
    if not groupData.groupID then
        return
    end

    local group = self:GetGroupByID(groupData.groupID)
    if not group then
        group = self:RegisterGroup(groupData)
    end
    if not group then return end

    group:ApplyGroupInfo(groupData)
    group:SetOrder(groupData.order or GetTime())

    for pinID, archivedPin in pairs(groupData.pinArchive or {}) do
        group.pinArchive[pinID] = CopyTable(archivedPin)
    end

    if not group:IsHidden() then
        for pinID, order in pairs(groupData.pinOrder or {}) do
            group:SetPinOrder(pinID, order, true)
        end

        group:AddMultiplePins(groupData.pins or {})
    end
end

function Groups:RestoreAllGroups()
    ---@type table<string, SaveableGroupData> | nil
    local groupsData = MapPinEnhanced:GetVar("groups")
    if not groupsData then
        return
    end

    for _, groupData in pairs(groupsData) do
        self:RestoreGroup(groupData)
    end
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
