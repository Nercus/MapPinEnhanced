---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSliderTemplate : Frame
---@field valueText FontString
---@field back Button
---@field forward Button
---@field ticks table<number, MapPinEnhancedSliderTickTemplate>
---@field slider MinimalSliderTemplate
MapPinEnhancedSliderMixin = {}

---@class MapPinEnhancedSliderTickTemplate : Texture

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

local MAX_NUM_TICKS = 15

function MapPinEnhancedSliderMixin:UpdateTicks()
    local slider = self.slider
    self.tickPool:ReleaseAll()
    self.ticks = {}
    local currentValue = slider:GetValue()
    local minValue, maxValue = slider:GetMinMaxValues()
    local step = slider:GetValueStep()
    local numTicks = math.ceil((maxValue - minValue) / step)

    if numTicks > MAX_NUM_TICKS then
        return
    end
    local tickSpacing = (self:GetWidth() - 20) / numTicks -- 20 is for the two buttons
    for i = 0, numTicks do
        local tickValue = minValue + i * step
        if tickValue <= maxValue then
            local tick = self.tickPool:Acquire()
            tick:SetPoint("TOPLEFT", self, "BOTTOMLEFT", i * tickSpacing + 5, 5)
            tick:SetWidth(10)
            tick:Show()
            self.ticks[tickValue] = tick
            if tickValue == currentValue then
                tick:SetHeight(15)
            else
                tick:SetHeight(10)
            end
            if tickValue <= currentValue then
                tick:SetDesaturated(false)
            else
                tick:SetDesaturated(true)
            end
        end
    end
end

function MapPinEnhancedSliderMixin:OnSizeChanged()
    self:UpdateTicks()
    local height = self:GetHeight()
    self.slider:SetHeight(height)
end

function MapPinEnhancedSliderMixin:OnLoad()
    self.tickPool = CreateTexturePool(self, "ARTWORK", 1, "MapPinEnhancedSliderTickTemplate")
    self:UpdateTicks()
    self.slider:SetScript("OnValueChanged", function(_, value)
        self:OnValueChanged(value)
    end)
end

function MapPinEnhancedSliderMixin:OnValueChanged(value)
    if value then
        local slider = self.slider
        self.valueText:SetText(roundValueToPrecision(value, slider:GetValueStep()))
        for tickValue, tick in pairs(self.ticks) do
            if tickValue == value then
                tick:SetHeight(15)
            else
                tick:SetHeight(10)
            end
            if tickValue <= value then
                tick:SetDesaturated(false)
            else
                tick:SetDesaturated(true)
            end
        end
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
    slider:SetMinMaxValues(formData.min, formData.max)
    slider:SetValueStep(formData.step or 1)
    self:UpdateTicks()
    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            slider:SetValue(initialValue)
        end
    end


    self:SetCallback(formData.onChange)
end
