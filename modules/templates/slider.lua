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

function MapPinEnhancedSliderMixin:OnLoad()
    self.tickPool = CreateTexturePool(self, "ARTWORK", 1, "MapPinEnhancedSliderTickTemplate")
    -- hook into setscript and every time a script is set hook it and also hook the textformatting
    hooksecurefunc(self, "SetScript", function(_, scriptName, func)
        if scriptName == "OnValueChanged" then
            self:HookScript(scriptName, function(_, ...)
                local value = select(1, ...)
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
            end)
        end
    end)

    hooksecurefunc(self, "SetValueStep", function(_, step)
        self:UpdateTicks()
    end)
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
