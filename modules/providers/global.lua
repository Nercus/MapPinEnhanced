---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local PinManager = MapPinEnhanced:GetModule("PinManager")

---------------------------------------------------------------------------

---Add a global table for other addons to use AddPin and AddWaypoint -> more coming in the future
local globalMapPinEnhanced = {}
globalMapPinEnhanced.AddPin = function(_, pinData)
    PinManager:AddPin(pinData)
end
globalMapPinEnhanced.AddWaypoint = function(_, pinData)
    PinManager:AddPin(pinData)
end
---@type table
_G[MapPinEnhanced.addonName] = globalMapPinEnhanced
