---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

---Add a global table for other addons to use AddPin and AddWaypoint -> more coming in the future
local globalMapPinEnhanced = {}
globalMapPinEnhanced.AddPin = function(_, pinData)
    local uncategorizedSection = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end
globalMapPinEnhanced.AddWaypoint = function(_, pinData)
    local uncategorizedSection = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end
---@type table
_G[MapPinEnhanced.name] = globalMapPinEnhanced
