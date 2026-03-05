---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
local MapPinEnhancedWayfinderArrow = {}


function MapPinEnhancedWayfinderArrow:SetWayfinderPin(pinData)
end

function MapPinEnhancedWayfinderArrow:Enable()
end

function MapPinEnhancedWayfinderArrow:Disable()
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_ARROW"] = MapPinEnhancedWayfinderArrow
