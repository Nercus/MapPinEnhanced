---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

---@type table<string, table<UUID, SaveableGroupData>>
Groups.deferredExternalGroups = {}

---@param groupData SaveableGroupData
---@return MapPinEnhancedGroupMixin?
function Groups:RestoreGroup(groupData)
    if type(groupData) ~= "table" then return nil end
    if type(groupData.groupID) ~= "string" or groupData.groupID == "" then return nil end
    if not self:IsValidGroupName(groupData.name) then return nil end
    if type(groupData.source) ~= "string" or groupData.source == "" then return nil end
    if self:GetSystemGroupType(groupData.groupID) and groupData.source ~= MapPinEnhanced.name then return nil end

    local group = self:GetGroupByID(groupData.groupID)
    if group and group:GetSource() ~= groupData.source then return nil end

    local nameOwner = self:GetGroupByName(groupData.name)
    if nameOwner and nameOwner ~= group then return nil end

    group = group or self:GetObjectPool():Acquire()
    group:ApplyGroupInfo(groupData)

    for pinID, archivedPin in pairs(groupData.pinArchive or {}) do
        group.pinArchive[pinID] = CopyTable(archivedPin)
    end

    if not group:IsHidden() then
        for pinID, order in pairs(groupData.pinOrder or {}) do
            group:SetPinOrder(pinID, order, true)
        end
        group:AddMultiplePins(groupData.pins or {}, true)
    end

    return group
end

function Groups:RestoreAllGroups()
    local groupsData = MapPinEnhanced:GetVar("groups")
    if type(groupsData) ~= "table" then return end

    for _, groupData in pairs(groupsData) do
        if type(groupData) == "table" then
            local source = groupData.source
            if source == MapPinEnhanced.name or
                (type(source) == "string" and C_AddOns.IsAddOnLoaded(source)) then
                self:RestoreGroup(groupData)
            elseif type(source) == "string" and source ~= "" and groupData.groupID and
                not self:GetSystemGroupType(groupData.groupID) then
                self.deferredExternalGroups[source] = self.deferredExternalGroups[source] or {}
                self.deferredExternalGroups[source][groupData.groupID] = groupData
            end
        end
    end
end

---@param source string
function Groups:RestoreDeferredExternalGroups(source)
    if not C_AddOns.IsAddOnLoaded(source) then return end

    local groupsData = self.deferredExternalGroups[source]
    if not groupsData then return end
    self.deferredExternalGroups[source] = nil

    for _, groupData in pairs(groupsData) do
        local group = self:RestoreGroup(groupData)
        if group then
            MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
        end
    end
end

---@param groupID UUID
---@return string? source
function Groups:GetDeferredGroupSource(groupID)
    for source, groupsData in pairs(self.deferredExternalGroups) do
        if groupsData[groupID] then
            return source
        end
    end
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(addonName)
    if addonName and addonName ~= MapPinEnhanced.name then
        Groups:RestoreDeferredExternalGroups(addonName)
    end
end)
