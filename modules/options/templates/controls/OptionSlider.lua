---@class MapPinEnhancedOptionSliderTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedSliderTemplate
---@field minValue number Optional minimum value set through keyvalues, defaults to 1
---@field maxValue number Optional maximum value set through keyvalues, defaults to 10
---@field stepValue number Optional step value set through keyvalues, defaults to 1
MapPinEnhancedOptionSliderMixin = {}


function MapPinEnhancedOptionSliderMixin:GetValue()
    return self.child.slider:GetValue()
end

function MapPinEnhancedOptionSliderMixin:SetValue(value)
    self.child:SetValue(value, false)
end

---@param initValue number
function MapPinEnhancedOptionSliderMixin:Setup(initValue)
    self.child:Setup({
        onChange = function(value)
            self:NotifyChange(value)
        end,
        min = self.minValue or 1,
        max = self.maxValue or 10,
        step = self.stepValue or 1,
    })
    assert(type(initValue) == "number", "Initial value for slider must be a number")
    self:SetValue(initValue)
end
