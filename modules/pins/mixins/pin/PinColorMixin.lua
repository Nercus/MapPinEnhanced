---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinColorMixin = {}

local DEFAULT_PIN_COLOR = "Yellow"

---@param color PinColors | "Custom"
function MapPinEnhancedPinColorMixin:SetPinColor(color)
    if not color then
        color = DEFAULT_PIN_COLOR
    end
    self.worldmapPin:SetPinColor(color)
    self.minimapPin:SetPinColor(color)
    self.supertrackedPin:SetPinColor(color)
    self.trackerEntry:SetPinColor(color)

    if self:IsTracked() then
        self.worldmapPin:SetTracked()
        self.minimapPin:SetTracked()
        self.trackerEntry:SetTracked()
        self.supertrackedPin:SetTracked()
    else
        self.worldmapPin:SetUntracked()
        self.minimapPin:SetUntracked()
        self.trackerEntry:SetUntracked()
        self.supertrackedPin:SetUntracked()
    end

    if color ~= "Custom" then
        self.worldmapPin:SetPinIcon(nil, nil)
        self.minimapPin:SetPinIcon(nil, nil)
        self.trackerEntry:SetPinIcon(nil, nil)
        self.supertrackedPin:SetPinIcon(nil, nil)
    end

    self.pinData.color = color or DEFAULT_PIN_COLOR
    self:PersistPin()
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
    self.trackerEntry:SetPinIcon(icon, usesAtlas)
    self.supertrackedPin:SetPinIcon(icon, usesAtlas)

    if icon then
        self.pinData.texture = icon
        self.pinData.usesAtlas = usesAtlas
        self:SetPinColor("Custom")
    else
        self.pinData.texture = nil
        self.pinData.usesAtlas = nil
        self:SetPinColor(self.pinData.color or DEFAULT_PIN_COLOR)
    end
    -- persist in here is not needed as we also set the pin color
end
