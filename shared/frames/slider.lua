---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSliderValueText : FontString
---@field fadeOut AnimationGroup
---@field fadeIn AnimationGroup

---@class MapPinEnhancedSliderTemplate : Frame
---@field valueText MapPinEnhancedSliderValueText
---@field back Button
---@field forward Button
---@field slider MinimalSliderTemplate
MapPinEnhancedSliderMixin = {}

---@param value number
---@param step number
---@return string
local function roundValueToPrecision(value, step)
    if not step or step == 1 then
        return tostring(math.floor(value))
    end
    local precision = math.max(0, -math.floor(math.log10(step)))
    return string.format("%." .. precision .. "f", value)
end

function MapPinEnhancedSliderMixin:OnSizeChanged()
    local height = self:GetHeight()
    self.slider:SetHeight(height)
end

function MapPinEnhancedSliderMixin:OnLoad()
    self.valueText:Hide()
    self.valueText:SetAlpha(1)

    self.slider:SetScript("OnValueChanged", function(_, value)
        self:OnValueChanged(value)
    end)

    -- Hook into thumb drag events
    self.slider:HookScript("OnMouseDown", function()
        self:OnThumbDragStart()
    end)

    self.slider:HookScript("OnMouseUp", function()
        self:OnThumbDragStop()
    end)
end

function MapPinEnhancedSliderMixin:OnShow()
    self:OnSizeChanged()
end

function MapPinEnhancedSliderMixin:OnThumbDragStart()
    if self.valueText.fadeOut:IsPlaying() then
        self.valueText.fadeOut:Stop()
    end
    if self.valueText.fadeIn:IsPlaying() then
        self.valueText.fadeIn:Stop()
    end
    self.valueText.fadeIn:Play()
end

---@type FunctionContainer
local fadeOutDelay
function MapPinEnhancedSliderMixin:OnThumbDragStop()
    if self.valueText.fadeIn:IsPlaying() then
        self.valueText.fadeIn:Stop()
    end
    if fadeOutDelay and not fadeOutDelay:IsCancelled() then
        fadeOutDelay:Cancel()
    end
    fadeOutDelay = C_Timer.NewTimer(0.5, function()
        if self.valueText:IsShown() then
            self.valueText.fadeOut:Play()
        end
    end)
end

function MapPinEnhancedSliderMixin:OnValueChanged(value)
    if value then
        local slider = self.slider
        self.valueText:SetText(roundValueToPrecision(value, slider:GetValueStep()))
    end
    if self.suppressOnChange then
        return
    end
    if self.onChangeCallback then
        self.onChangeCallback(value)
    end
end

---@param disabled boolean
function MapPinEnhancedSliderMixin:SetDisabledState(disabled)
    if disabled then
        self.slider:Disable()
        self:SetAlpha(0.5)
        self.back:Disable()
        self.back:SetAlpha(0.5)
        self.forward:Disable()
        self.forward:SetAlpha(0.5)
    else
        self.slider:Enable()
        self:SetAlpha(1)
        self.back:Enable()
        self.back:SetAlpha(1)
        self.forward:Enable()
        self.forward:SetAlpha(1)
    end
end

function MapPinEnhancedSliderMixin:GetValue()
    return self.slider:GetValue()
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedSliderMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class SliderSetup
---@field onChange fun(value: number)
---@field init? fun(): number -- initial value can be nil if option has never been set before
---@field min number -- minimum value of the slider
---@field max number -- maximum value of the slider
---@field step number -- step value of the slider

---@param formData SliderSetup
function MapPinEnhancedSliderMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")
    local slider = self.slider
    self.valueText:ClearAllPoints()
    self.valueText:SetPoint("BOTTOM", slider.Thumb, "TOP", 0, 2)
    slider:SetMinMaxValues(formData.min, formData.max)
    slider:SetValueStep(formData.step or 1)
    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            slider:SetValue(initialValue)
        end
    end

    self:SetCallback(formData.onChange)
end

---@param value number
---@param triggerCallback boolean|nil
function MapPinEnhancedSliderMixin:SetValue(value, triggerCallback)
    self.suppressOnChange = not triggerCallback
    self.slider:SetValue(value)
    self.suppressOnChange = false
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
