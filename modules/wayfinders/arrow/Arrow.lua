---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
---@field frame MapPinEnhancedFloatingArrowTemplate
---@field unsubscribeRotatePinOption fun() | nil
local MapPinEnhancedWayfinderArrow = {}

---@return MapPinEnhancedFloatingArrowTemplate
function MapPinEnhancedWayfinderArrow:GetFrame()
    if not self.frame then
        self.frame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingArrowTemplate")
    end
    return self.frame
end

---@param title string
function MapPinEnhancedWayfinderArrow:SetTitle(title)
    self:GetFrame():SetTitle(title)
end

---@param color PinColor
function MapPinEnhancedWayfinderArrow:SetColor(color)
    self:GetFrame():SetColor(color)
end

---@param texture string
---@param usesAtlas boolean
function MapPinEnhancedWayfinderArrow:SetTexture(texture, usesAtlas)
    self:GetFrame():SetTexture(texture, usesAtlas)
end

---@param lock boolean
function MapPinEnhancedWayfinderArrow:SetLock(lock)
    self:GetFrame().pin:SetLock(lock)
end

---@param rotatePin boolean
function MapPinEnhancedWayfinderArrow:SetRotatePin(rotatePin)
    if not self.frame then return end
    self.frame:SetRotatePin(rotatePin)
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
    if wayfinderData.texture then
        self:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        self:SetColor(wayfinderData.color)
    end
    self:SetTitle(wayfinderData.title)
    self:SetLock(wayfinderData.lock)
    frame.fadeOut:Stop()
    if not frame:IsShown() then
        frame.fadeIn:Play()
    end
end

function MapPinEnhancedWayfinderArrow:Enable()
    self:GetFrame()
    self.unsubscribeRotatePinOption = Options:SubscribeToOptionChanges("Wayfinder.Arrow.RotatePin", function(value)
        self:SetRotatePin(value)
    end)
end

function MapPinEnhancedWayfinderArrow:Disable()
    if self.frame then
        self.frame.fadeIn:Stop()
        self.frame.fadeOut:Play()
    end
    if self.unsubscribeRotatePinOption then
        self.unsubscribeRotatePinOption()
        self.unsubscribeRotatePinOption = nil
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
