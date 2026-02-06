---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
local MapPinEnhancedWayfinderFloating = {}


function MapPinEnhancedWayfinderFloating:SetWayfinderData(pinData)
end

function MapPinEnhancedWayfinderFloating:Enable()
end

function MapPinEnhancedWayfinderFloating:Disable()
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating
