-- Template: file://./slider.xml
---@class MapPinEnhancedSliderMixin : Slider,PropagateMouseMotion
---@field onChangeCallback function
---@field valueText FontString
---@field Back Button
---@field Forward Button
MapPinEnhancedSliderMixin = {}


---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

function MapPinEnhancedSliderMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
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


---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedSliderMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetValueStep(optionData.step or 1)
    self:SetMinMaxValues(optionData.min or 0, optionData.max or 100)
    local init = optionData.init --[[@as number | nil]]
    self:SetValue(init or 0)
    self.valueText:SetText(roundValueToPrecision(init or 0, optionData.step))
    self:SetScript("OnValueChanged", function(_, value)
        self.onChangeCallback(value)
        self.valueText:SetText(roundValueToPrecision(self:GetValue(), optionData.step))
    end)
    self.Back:SetScript("OnClick", function()
        self:SetValue(self:GetValue() - optionData.step)
    end)
    self.Forward:SetScript("OnClick", function()
        self:SetValue(self:GetValue() + optionData.step)
    end)
    self:SetCallback(optionData.onChange)
end
