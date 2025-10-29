---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSliderTemplate : Slider
---@field valueText FontString
---@field Back Button
---@field Forward Button
---@field ticks table<number, MapPinEnhancedSliderTickTemplate>
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

-- FIXME: ticks don't work properly when step size is small while min and max values are large

function MapPinEnhancedSliderMixin:UpdateTicks()
    self.tickPool:ReleaseAll()
    self.ticks = {}
    local currentValue = self:GetValue()
    -- calculate the number of ticks based on the slider's range and step, never draw more than 10 ticks
    local minValue, maxValue = self:GetMinMaxValues()
    local step = self:GetValueStep()
    local numTicks = math.min(10, math.ceil((maxValue - minValue) / step))
    local tickSpacing = (self:GetWidth() - 20) / numTicks -- 20 is for the left and right buttons
    for i = 0, numTicks do
        local tickValue = minValue + i * step
        if tickValue <= maxValue then
            local tick = self.tickPool:Acquire()
            tick:SetPoint("TOPLEFT", self, "BOTTOMLEFT", i * tickSpacing + 5, 0) -- 10 is for the left button
            tick:SetWidth(10)
            tick:Show()
            self.ticks[tickValue] = tick
            if tickValue == currentValue then
                tick:SetHeight(20)
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
end

function MapPinEnhancedSliderMixin:OnLoad()
    self.tickPool = CreateTexturePool(self, "ARTWORK", 1, "MapPinEnhancedSliderTickTemplate")
    self:UpdateTicks()
end

function MapPinEnhancedSliderMixin:OnValueChanged(value)
    if value then
        self.valueText:SetText(roundValueToPrecision(value, self:GetValueStep()))
        for tickValue, tick in pairs(self.ticks) do
            if tickValue == value then
                tick:SetHeight(20)
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

    self:SetMinMaxValues(formData.min, formData.max)
    self:SetValueStep(formData.step or 1)
    self:UpdateTicks()
    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self:SetValue(initialValue)
        end
    end


    self:SetCallback(formData.onChange)
end
