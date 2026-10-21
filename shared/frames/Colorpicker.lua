---@class MapPinEnhancedColorpickerColor
---@field r number
---@field g number
---@field b number
---@field a number

---@class MapPinEnhancedColorpickerGradient
---@field startColor MapPinEnhancedColorpickerColor
---@field endColor MapPinEnhancedColorpickerColor

---@class MapPinEnhancedColorpickerTemplate : Button
---@field r number
---@field g number
---@field b number
---@field a number
---@field endColor MapPinEnhancedColorpickerColor?
---@field color Texture
---@field colorStart Texture
---@field colorEnd Texture
---@field bg Texture
---@field highlight Texture
---@field left Button
---@field right Button
---@field gradient boolean?
---@field hasOpacity boolean?
---@field onChangeCallback fun(r: number, g: number, b: number, a: number, endColor: MapPinEnhancedColorpickerColor?)
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
---@field extraInfo any

local ColorPickerFrame = ColorPickerFrame

function MapPinEnhancedColorpickerMixin:UpdateMode()
    self.left:SetShown(self.gradient == true)
    self.right:SetShown(self.gradient == true)
    self.highlight:SetShown(not self.gradient)
end

function MapPinEnhancedColorpickerMixin:OnEnabledChanged()
    self.left:SetEnabled(self:IsEnabled())
    self.right:SetEnabled(self:IsEnabled())
    if not self:IsEnabled() then self:ClosePicker() end
end

function MapPinEnhancedColorpickerMixin:ClosePicker()
    -- The native picker is shared with other controls and addons.
    if ColorPickerFrame:GetExtraInfo() == self then
        ColorPickerFrame:Hide()
        ColorPickerFrame.swatchFunc = nil
        ColorPickerFrame.opacityFunc = nil
        ColorPickerFrame.cancelFunc = nil
        ColorPickerFrame.extraInfo = nil
    end
end

function MapPinEnhancedColorpickerMixin:OnClick()
    self:OpenPicker(false)
end

---@param editEnd boolean
function MapPinEnhancedColorpickerMixin:OpenPicker(editEnd)
    if not self:IsEnabled() then return end
    local color = editEnd and self.endColor or self
    local r, g, b, a = color.r or 1, color.g or 1, color.b or 1, color.a or 1
    local function ApplyColor(red, green, blue, alpha)
        if editEnd then
            self.endColor = { r = red, g = green, b = blue, a = alpha }
            self:SetColor(self.r, self.g, self.b, self.a, true)
        else
            self:SetColor(red, green, blue, alpha, true)
        end
    end
    local function UpdateColor()
        local red, green, blue = ColorPickerFrame:GetColorRGB()
        ApplyColor(red, green, blue, self.hasOpacity and ColorPickerFrame:GetColorAlpha() or a)
    end
    ---@type ColorPickerInfo
    local info = {
        swatchFunc = UpdateColor,
        hasOpacity = self.hasOpacity == true,
        opacityFunc = UpdateColor,
        opacity = a,
        cancelFunc = function()
            ApplyColor(r, g, b, a)
        end,
        r = r,
        g = g,
        b = b,
        a = a,
        extraInfo = self,
    }
    ColorPickerFrame:SetupColorPickerAndShow(info)
end

---@param r number
---@param g number
---@param b number
---@param a number
---@param triggerCallback boolean|nil
function MapPinEnhancedColorpickerMixin:SetColor(r, g, b, a, triggerCallback)
    self.r, self.g, self.b, self.a = r, g, b, a
    local startColor = CreateColor(r, g, b, a)
    local endColor = self.gradient and self.endColor
    local finishColor = endColor and CreateColor(endColor.r, endColor.g, endColor.b, endColor.a) or startColor
    -- The brush texture has translucent cutouts even when the chosen color is opaque.
    self.bg:SetShown(a < 1 or (endColor and endColor.a < 1) or false)
    self.colorStart:SetVertexColor(r, g, b, a)
    self.color:SetGradient("HORIZONTAL", startColor, finishColor)
    self.colorEnd:SetVertexColor(finishColor:GetRGBA())
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(r, g, b, a, endColor and CopyTable(endColor) or nil)
    end
end

---@param callback fun(r: number, g: number, b: number, a: number, endColor: MapPinEnhancedColorpickerColor?)
function MapPinEnhancedColorpickerMixin:SetCallback(callback)
    assert(type(callback) == "function", "Colorpicker:SetCallback: callback must be a function")
    self:ClosePicker()
    -- Publish live previews synchronously so hiding cannot leave a pending save.
    self.onChangeCallback = callback
end

---@class ColorPickerSetup
---@field onChange fun(r: number, g: number, b: number, a: number, endColor: MapPinEnhancedColorpickerColor?)
---@field init? fun(): MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient

---@param formData ColorPickerSetup
function MapPinEnhancedColorpickerMixin:Setup(formData)
    assert(type(formData) == "table", "Colorpicker:Setup: form data must be a table")
    local white = { r = 1, g = 1, b = 1, a = 1 }
    local default = self.gradient and { startColor = white, endColor = white } or white
    self:SetValue(formData.init and formData.init() or default)
    self:SetCallback(formData.onChange)
end

---@return MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient
function MapPinEnhancedColorpickerMixin:GetValue()
    local color = { r = self.r, g = self.g, b = self.b, a = self.a }
    if self.gradient then
        return { startColor = color, endColor = CopyTable(self.endColor) }
    end
    return color
end

---@param value MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient
---@param triggerCallback boolean|nil
function MapPinEnhancedColorpickerMixin:SetValue(value, triggerCallback)
    self:ClosePicker()
    if self.gradient then
        local gradient = value --[[@as MapPinEnhancedColorpickerGradient]]
        assert(gradient.startColor and gradient.endColor,
            "Colorpicker:SetValue: gradient requires startColor and endColor")
        self.endColor = CopyTable(gradient.endColor)
        value = gradient.startColor
    else
        self.endColor = nil
    end
    local color = value --[[@as MapPinEnhancedColorpickerColor]]
    assert(color.r and color.g and color.b and color.a,
        "Colorpicker:SetValue: color requires r, g, b and a")
    self:SetColor(color.r, color.g, color.b, color.a, triggerCallback)
end
