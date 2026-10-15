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
globalMapPinEnhanced.TrackNearestPin = function()
    PinManager:TrackNearestPin()
end
globalMapPinEnhanced.SetClosestWaypoint = function()
    PinManager:TrackNearestPin()
end
globalMapPinEnhanced.GetNearestPin = function()
    return PinManager:GetNearestPin()
end
globalMapPinEnhanced.GetClosestWaypoint = function()
    return PinManager:GetNearestPin()
end
globalMapPinEnhanced.ClearAllPins = function()
    PinManager:ClearPins()
end
globalMapPinEnhanced.ClearAllWaypoints = function()
    PinManager:ClearPins()
end

---@type table
_G[MapPinEnhanced.addonName] = globalMapPinEnhanced
