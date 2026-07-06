---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
---@field frame MapPinEnhancedFloatingArrowTemplate
local MapPinEnhancedWayfinderArrow = {}

---@return MapPinEnhancedFloatingArrowTemplate
function MapPinEnhancedWayfinderArrow:GetFrame()
    if not self.frame then
        self.frame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingArrowTemplate")
    end
    return self.frame
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderArrow:Init(wayfinderData)
    local frame = self:GetFrame()
    if not wayfinderData or not wayfinderData.mapID or not wayfinderData.x or not wayfinderData.y then
        self.frame.fadeIn:Stop()
        self.frame.fadeOut:Play()
        return
    end
    frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    frame:SetColor(wayfinderData.color)
    frame:SetTitle(wayfinderData.title)
    frame.fadeOut:Stop()
    frame.fadeIn:Play()
end

function MapPinEnhancedWayfinderArrow:Enable()
    self:GetFrame()
end

function MapPinEnhancedWayfinderArrow:Disable()
    if self.frame then
        self.frame.fadeIn:Stop()
        self.frame.fadeOut:Play()
    end
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_ARROW"] = MapPinEnhancedWayfinderArrow


Options:SubscribeToOptionChanges("Wayfinder.Arrow.Enable", function(value)
    if value then
        Wayfinders:EnableWayfinder("WAYFINDER_ARROW")
    else
        Wayfinders:DisableWayfinder("WAYFINDER_ARROW")
    end
end)
