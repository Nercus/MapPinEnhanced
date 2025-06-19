---@class MapPinEnhancedColorpickerTemplate : Button
---@field r number
---@field g number
---@field b number
---@field a number
---@field color Texture
---@field hasOpacity boolean?
MapPinEnhancedColorpickerMixin = {}

---@class ColorPickerInfo
---@field swatchFunc fun()
---@field hasOpacity boolean
---@field opacityFunc fun()
---@field opacity number
---@field cancelFunc fun()
---@field r number
---@field g number
---@field b number
---@field a number



---@class MapPinEnhanced : NercUtilsAddon
local MapPinEnhanced = LibStub("NercUtils"):GetAddon(...)


local ColorPickerFrame = ColorPickerFrame

function MapPinEnhancedColorpickerMixin:OnClick()
    ---@type ColorPickerInfo
    local info = {
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = ColorPickerFrame:GetColorAlpha()
            self:SetColor(r, g, b, a)
        end,
        hasOpacity = self.hasOpacity,
        opacityFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = ColorPickerFrame:GetColorAlpha()
            self:SetColor(r, g, b, a)
        end,
        opacity = (self.a or 1),
        cancelFunc = function()
            self:SetColor(self.r, self.g, self.b, self.a)
        end,
        r = self.r or 255,
        g = self.g or 255,
        b = self.b or 255,
        a = self.a or 1,
    }
    ColorPickerFrame:SetupColorPickerAndShow(info)
end

---@param r number
---@param g number
---@param b number
---@param a number
function MapPinEnhancedColorpickerMixin:SetColor(r, g, b, a)
    self.r, self.g, self.b, self.a = r, g, b, a
    self.color:SetVertexColor(r, g, b, a)
end
