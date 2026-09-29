---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

MapPinEnhanced:RegisterGlobalAPI("AddPin", function(pinData)
    local uncategorizedSection = Groups:GetUngroupedGroup()
    if not uncategorizedSection then return end
    local _, pinID = uncategorizedSection:AddPin(pinData)
    return pinID
end)

MapPinEnhanced:RegisterGlobalAPI("AddWaypoint", function(pinData)
    local uncategorizedSection = Groups:GetUngroupedGroup()
    if not uncategorizedSection then return end
    local _, pinID = uncategorizedSection:AddPin(pinData)
    return pinID
end)
