---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
---@field frame MapPinEnhancedFloatingArrowTemplate
local MapPinEnhancedWayfinderArrow = {}

function MapPinEnhancedWayfinderArrow:GetFrame()
    if not self.frame then
        self.frame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingArrowTemplate")
    end
    return self.frame
end

---@param data WayfinderData?
function MapPinEnhancedWayfinderArrow:Init(data)
    local frame = self:GetFrame()
    if not data or not data.mapID or not data.x or not data.y then
        frame:Hide()
        return
    end
    frame:SetLocation(data.mapID, data.x, data.y)
    frame:SetColor(data.color)
    frame:SetTitle(data.title)
    frame:Show()
end

function MapPinEnhancedWayfinderArrow:Enable()
    local frame = self:GetFrame()
end

function MapPinEnhancedWayfinderArrow:Disable()
    if self.frame then
        self.frame:Hide()
        self.frame:ClearAllPoints()
        self.frame:SetParent(nil)
        self.frame = nil
    end
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_ARROW"] = MapPinEnhancedWayfinderArrow
