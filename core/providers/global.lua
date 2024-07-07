---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")

---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")

local globalMapPinEnhanced = {}
globalMapPinEnhanced.AddPin = function(_, pinData)
    PinManager:AddPin(pinData)
end
globalMapPinEnhanced.AddWaypoint = function(_, pinData)
    PinManager:AddPin(pinData)
end

---@type table
_G[MapPinEnhanced.addonName] = globalMapPinEnhanced
