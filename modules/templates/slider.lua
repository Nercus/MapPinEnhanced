---@class MapPinEnhancedSliderTemplate : Slider
---@field valueText FontString
---@field Back Button
---@field Forward Button
MapPinEnhancedSliderMixin = {}

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


function MapPinEnhancedSliderMixin:OnLoad()
    -- hook into setscript and every time a script is set hook it and also hook the textformatting
    hooksecurefunc(self, "SetScript", function(_, scriptName, func)
        if scriptName == "OnValueChanged" then
            self:HookScript(scriptName, function(_, ...)
                local value = select(1, ...)
                if value then
                    self.valueText:SetText(roundValueToPrecision(value, self:GetValueStep()))
                end
            end)
        end
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
