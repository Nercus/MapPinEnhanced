---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

local function ValidateGroupInfo(groupInfo, apiName)
    if type(groupInfo) ~= "table" then
        error(apiName .. ": groupInfo must be a table")
    end
    if not Groups:IsValidGroupName(groupInfo.name) then
        error(apiName .. ": groupInfo.name must be a non-empty string")
    end
    if type(groupInfo.source) ~= "string" or groupInfo.source == "" then
        error(apiName .. ": groupInfo.source must be a non-empty string")
    end
    if not C_AddOns.IsAddOnLoaded(groupInfo.source) then
        error(apiName .. ": source addon is not loaded")
    end
    if groupInfo.groupType ~= nil or Groups:GetSystemGroupType(groupInfo.groupID) ~= nil then
        error(apiName .. ": system groups cannot be registered through the public API")
    end
    if Groups:GetGroupByName(groupInfo.name) then
        error(apiName .. ": a group with this name already exists")
    end
end

MapPinEnhanced:RegisterGlobalAPI("RegisterGroup", function(groupInfo)
    ValidateGroupInfo(groupInfo, "MapPinEnhanced.RegisterGroup")

    local group = Groups:RegisterGroup(groupInfo)
    if not group then
        error("MapPinEnhanced.RegisterGroup: failed to register group")
    end

    if group:IsHidden() and group:GetSource() ~= MapPinEnhanced.name then
        MapPinEnhanced:Print(string.format(L["%s added hidden group \"%s\"."], group:GetSource(), group:GetName()))
    end

    return group:GetGroupID()
end)

MapPinEnhanced:RegisterGlobalAPI("AddPinToGroup", function(groupID, pinData)
    local group = Groups:GetGroupByID(groupID)
    if not group or group:IsProtected() then return nil end

    local _, pinID = group:AddPin(pinData)
    return pinID
end)

MapPinEnhanced:RegisterGlobalAPI("DeletePin", function(pinID)
    for group in Groups:EnumerateGroups() do
        if group:GetGroupID() ~= Groups.SYSTEM_GROUP_IDS.WAY_BACK and group:RemovePin(pinID) then
            return true
        end
    end
    return false
end)

MapPinEnhanced:RegisterGlobalAPI("MarkPinReached", function(pinID)
    for group in Groups:EnumerateGroups() do
        if group:GetGroupID() ~= Groups.SYSTEM_GROUP_IDS.WAY_BACK and group:MarkPinReached(pinID) then
            return true
        end
    end
    return false
end)

MapPinEnhanced:RegisterGlobalAPI("GetGroupTrackingMode", function(groupID)
    local group = Groups:GetGroupByID(groupID)
    if not group then return nil end
    return group:GetTrackingMode()
end)

MapPinEnhanced:RegisterGlobalAPI("SetGroupTrackingMode", function(groupID, mode)
    if not Groups:IsValidTrackingMode(mode) then
        error("MapPinEnhanced.SetGroupTrackingMode: invalid tracking mode")
    end

    local group = Groups:GetGroupByID(groupID)
    if not group then return false end
    return group:SetTrackingMode(mode)
end)
