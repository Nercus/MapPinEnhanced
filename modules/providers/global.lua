---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local PinSections = MapPinEnhanced:GetModule("PinSections")

local L = MapPinEnhanced.L



---Add a global table for other addons to use AddPin and AddWaypoint -> more coming in the future
local globalMapPinEnhanced = {}
globalMapPinEnhanced.AddPin = function(_, pinData)
    local uncategorizedSection = PinSections:GetSectionByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end
globalMapPinEnhanced.AddWaypoint = function(_, pinData)
    local uncategorizedSection = PinSections:GetSectionByName(L["Uncategorized Pins"])
    if not uncategorizedSection then return end
    uncategorizedSection:AddPin(pinData)
end
---@type table
_G[MapPinEnhanced.addonName] = globalMapPinEnhanced
