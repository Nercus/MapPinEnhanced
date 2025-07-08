---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinColorMixin = {}

local DEFAULT_PIN_COLOR = "Yellow"

---@param color PinColors | 'Custom'
function MapPinEnhancedPinColorMixin:SetPinColor(color)
    self.worldmapPin:SetPinColor(color)
    self.minimapPin:SetPinColor(color)

    if self:IsTracked() then
        self.worldmapPin:SetTracked()
        self.minimapPin:SetTracked()
    else
        self.worldmapPin:SetUntracked()
        self.minimapPin:SetUntracked()
    end

    self.pinData.color = color or DEFAULT_PIN_COLOR
end

function MapPinEnhancedPinColorMixin:PinHasColor(color)
    if not self.pinData.color then
        return false
    end

    return self.pinData.color == color
end

function MapPinEnhancedPinColorMixin:SetPinIcon(icon, usesAtlas)
    self.worldmapPin:SetPinIcon(icon, usesAtlas)
    self.minimapPin:SetPinIcon(icon, usesAtlas)

    if icon then
        self.pinData.texture = icon
        self.pinData.usesAtlas = usesAtlas
    else
        self.pinData.texture = nil
        self.pinData.usesAtlas = nil
    end
    self:SetPinColor("Custom")
end
