---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

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
    if self.onChangeCallback then
        self.onChangeCallback(self.r, self.g, self.b, self.a or 1)
    end
end

---@param callback fun(r: number, g: number, b: number, a: number)
function MapPinEnhancedColorpickerMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class MapPinEnhancedColorpickerData
---@field onChange fun(r: number, g: number, b: number, a: number)
---@field init? fun(): {r: number, g: number, b: number, a: number}

---@param formData MapPinEnhancedColorpickerData
function MapPinEnhancedColorpickerMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue then
            self:SetColor(initialValue.r, initialValue.g, initialValue.b, initialValue.a)
        end
    else
        self:SetColor(255, 255, 255, 1) -- default to white color if no init function is provided
    end
    self:SetCallback(formData.onChange)
end
