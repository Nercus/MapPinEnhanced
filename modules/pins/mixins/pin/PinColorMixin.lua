---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinColorMixin = {}

local DEFAULT_PIN_COLOR = "Yellow"

---@enum (key) PinColors
local PIN_COLORS_BY_NAME = {
    ["Red"] = CreateColor(0.867, 0.200, 0.200, 1),
    ["Orange"] = CreateColor(0.859, 0.529, 0.129, 1),
    ["Pale"] = CreateColor(0.898, 0.659, 0.369, 1),
    ["Yellow"] = CreateColor(0.949, 0.788, 0.149, 1),
    ["Green"] = CreateColor(0.404, 0.788, 0.263, 1),
    ["LightBlue"] = CreateColor(0.318, 0.757, 0.878, 1),
    ["DarkBlue"] = CreateColor(0.239, 0.239, 0.976, 1),
    ["Purple"] = CreateColor(0.549, 0.314, 0.886, 1),
    ["Pink"] = CreateColor(0.886, 0.427, 0.843, 1),
}

---@param color PinColors | "Custom"
function MapPinEnhancedPinColorMixin:SetPinColor(color)
    if not color then
        color = DEFAULT_PIN_COLOR
    end
    local colorValue = PIN_COLORS_BY_NAME[color] or DEFAULT_PIN_COLOR
    self.worldmapPin:SetPinColor(colorValue)
    self.minimapPin:SetPinColor(colorValue)
    self.supertrackedPin:SetPinColor(colorValue)
    self.trackerEntry:SetPinColor(colorValue)

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
