-- Template: file://./colorpicker.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedColorpickerMixin : Button, PropagateMouseMotion
---@field onChangeCallback function
---@field r number
---@field g number
---@field b number
---@field a number
---@field color Texture
MapPinEnhancedColorpickerMixin = {}

---@class Color
---@field r number
---@field g number
---@field b number
---@field a number?



---@class ColorPickerOptions
---@field onChange fun(value: Color)
---@field init? fun(): Color -- initial value can be nil if option has never been set before
---@field default Color


local ColorPickerFrame = ColorPickerFrame

local function showColorPicker(colorFrame)
    ---@type number, number, number, number
    local r2, g2, b2, a2 = colorFrame.r, colorFrame.g, colorFrame.b, colorFrame.a
    ---@type ColorPickerInfo
    local info = {
        swatchFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = ColorPickerFrame:GetColorAlpha()
            colorFrame.setColor(r, g, b, a)
        end,

        hasOpacity = a2 ~= nil,
        opacityFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = ColorPickerFrame:GetColorAlpha()
            colorFrame.setColor(r, g, b, a)
        end,
        opacity = (a2 or 1),
        cancelFunc = function()
            colorFrame.setColor(r2, g2, b2, a2)
        end,
        r = r2,
        g = g2,
        b = b2,
        a = a2
    }
    ColorPickerFrame:SetupColorPickerAndShow(info)
end


---@param disabled boolean
function MapPinEnhancedColorpickerMixin:SetDisabled(disabled)
    if disabled then
        self:SetScript("OnMouseDown", nil)
        self:SetAlpha(0.5)
    else
        self:SetScript("OnMouseDown", function()
            showColorPicker(self)
        end)
        self:SetAlpha(1)
    end
end

function MapPinEnhancedColorpickerMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param optionData OptionColorpickerTyped | ColorPickerOptions
function MapPinEnhancedColorpickerMixin:Setup(optionData)
    self.onChangeCallback = nil
    self.r = nil
    self.g = nil
    self.b = nil
    self.a = nil

    self:SetScript("OnMouseDown", function()
        showColorPicker(self)
    end)
    self.setColor = function(r, g, b, a)
        self.r, self.g, self.b, self.a = r, g, b, a
        self.color:SetVertexColor(r, g, b, a)
        if not self.onChangeCallback then return end
        self.onChangeCallback({ r = r, g = g, b = b, a = a })
    end
    local initColor = optionData.init()
    self.setColor(initColor.r, initColor.g, initColor.b, initColor.a)
    self:SetDisabled(optionData.disabledState)
    self:SetCallback(optionData.onChange)
end
