---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

MapPinEnhanced:RegisterGlobalAPI("AddPin", function(pinData)
    local uncategorizedSection = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end)

MapPinEnhanced:RegisterGlobalAPI("AddWaypoint", function(pinData)
    local uncategorizedSection = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end)
