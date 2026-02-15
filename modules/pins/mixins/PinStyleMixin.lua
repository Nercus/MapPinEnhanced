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

    self.worldmapPin:SetIconTexture(nil, nil)
    self.minimapPin:SetIconTexture(nil, nil)

    self.pinData.color = color
    self.pinData.texture = nil
    self.pinData.usesAtlas = nil
    self:PersistPin()

    MapPinEnhanced:FireCallback("PIN_UPDATED_COLOR", self.pinID, color)
end

function MapPinEnhancedPinStyleMixin:HasColor(color)
    if not self.pinData.color then
        return false
    end

    return self.pinData.color == color
end

local PIN_ICONS = Pins.PIN_ICONS

---@param icon string the icon to set, if usesAtlas is true, this is the atlas name, otherwise it is a file path
---@param usesAtlas boolean if true, the path is an atlas, otherwise it is a file path
function MapPinEnhancedPinStyleMixin:SetIcon(icon, usesAtlas)
    if icon then
        self.pinData.texture = icon
        self.pinData.usesAtlas = usesAtlas
        self.pinData.color = nil
    else
        self.pinData.texture = nil
        self.pinData.usesAtlas = nil
        self.pinData.color = self.pinData.color
    end

    self.worldmapPin:SetIconTexture(icon, usesAtlas)
    self.minimapPin:SetIconTexture(icon, usesAtlas)
    MapPinEnhanced:FireCallback("PIN_UPDATED_ICON", self.pinID, icon, usesAtlas)
end
