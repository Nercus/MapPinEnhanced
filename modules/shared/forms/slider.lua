-- LINK ./slider.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedSliderMixin : Slider,PropagateMouseMotion
---@field onChangeCallback function
---@field valueText FontString
---@field Back Button
---@field Forward Button
MapPinEnhancedSliderMixin = {}

---@class SliderOptions
---@field onChange fun(value: number)
---@field init? number -- initial value can be nil if option has never been set before
---@field default number
---@field min number
---@field max number
---@field step number

function MapPinEnhancedSliderMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param value number
---@param step number
---@return string
local function roundValueToPrecision(value, step)
    if not step or step == 1 then
        return tostring(math.floor(value))
    end
    local precision = string.len(tostring(step):match('%.%d+')) - 1
    return string.format("%." .. precision .. "f", value)
end


---@param disabled boolean
function MapPinEnhancedSliderMixin:SetDisabled(disabled)
    if disabled then
        self:Disable()
        self:SetAlpha(0.5)
        self.Back:Disable()
        self.Back:SetAlpha(0.5)
        self.Forward:Disable()
        self.Forward:SetAlpha(0.5)
    else
        self:Enable()
        self:SetAlpha(1)
        self.Back:Enable()
        self.Back:SetAlpha(1)
        self.Forward:Enable()
        self.Forward:SetAlpha(1)
    end
end

---@param optionData OptionSliderTyped | SliderOptions
function MapPinEnhancedSliderMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetValueStep(optionData.step or 1)
    self:SetMinMaxValues(optionData.min or 0, optionData.max or 100)
    local init = optionData.init --[[@as number | nil]]
    self:SetValue(init or 0)
    self.valueText:SetText(roundValueToPrecision(init or 0, optionData.step))
    self:SetDisabled(optionData.disabledState)
    self:SetScript("OnValueChanged", function(_, value)
        self.valueText:SetText(roundValueToPrecision(self:GetValue(), optionData.step))
        if not self.onChangeCallback then return end
        self.onChangeCallback(value)
    end)
    self.Back:SetScript("OnClick", function()
        self:SetValue(self:GetValue() - optionData.step)
    end)
    self.Forward:SetScript("OnClick", function()
        self:SetValue(self:GetValue() + optionData.step)
    end)
    self:SetCallback(optionData.onChange)
end
