---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinSections = MapPinEnhanced:GetModule("PinSections")

local CONSTANTS = MapPinEnhanced.CONSTANTS

---@class PinObject
---@field SetColor fun(_, color: PinColors)
---@field IsColorSelected fun(_, color: PinColors): boolean

---@param pin PinObject
function PinFactory:HandleColor(pin)
    function pin:SetColor(color)
        self.worldmapPin:SetPinColor(color)
        self.minimapPin:SetPinColor(color)
        self.trackerPinEntry:SetPinColor(color)
        self.superTrackedPin:SetPinColor(color)
        if (self:IsTracked()) then
            self.worldmapPin:SetTrackedTexture()
            self.minimapPin:SetTrackedTexture()
            self.trackerPinEntry:SetTrackedTexture()
        else
            self.worldmapPin:SetUntrackedTexture()
            self.minimapPin:SetUntrackedTexture()
            self.trackerPinEntry:SetUntrackedTexture()
        end
        self.pinData.color = color
        PinSections:PersistSections(self.section.name, self.pinID)
    end

    function pin:IsColorSelected(color)
        local colorByIndex = CONSTANTS.PIN_COLORS[color]
        if not colorByIndex then
            return false
        end
        local colorName = colorByIndex.colorName
        return self.pinData.color == colorName
    end
end
