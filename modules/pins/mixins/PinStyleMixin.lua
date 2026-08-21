---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinStyleMixin = {}

---@param color PinColor?
function MapPinEnhancedPinStyleMixin:SetColor(color)
    self.worldmapPin:SetColor(color)
    self.minimapPin:SetColor(color)

    if self:IsTracked() then
        self.worldmapPin:SetTracked()
        self.minimapPin:SetTracked()
    else
        self.worldmapPin:SetUntracked()
        self.minimapPin:SetUntracked()
    end

    self.pinData.color = color
    self.pinData.texture = nil
    self.pinData.usesAtlas = nil
    self:PersistPin()

    if not self.suppressChangePublication then
        MapPinEnhanced:FireCallback("PIN_UPDATED_COLOR", self.pinID, color)
    end
end

function MapPinEnhancedPinStyleMixin:HasColor(color)
    if not self.pinData.color then
        return false
    end

    return self.pinData.color == color
end

---@param icon string|number? the icon to set; atlas names must be strings
---@param usesAtlas boolean? if true, the path is an atlas, otherwise it is a file path
function MapPinEnhancedPinStyleMixin:SetIcon(icon, usesAtlas)
    if not icon then
        self:SetColor(Pins.DEFAULT_COLOR)
        return
    end

    self.pinData.texture = icon
    self.pinData.usesAtlas = usesAtlas
    self.pinData.color = nil

    self.worldmapPin:SetIconTexture(icon, usesAtlas)
    self.minimapPin:SetIconTexture(icon, usesAtlas)
    self:PersistPin()
    if not self.suppressChangePublication then
        MapPinEnhanced:FireCallback("PIN_UPDATED_ICON", self.pinID, icon, usesAtlas)
    end
end
