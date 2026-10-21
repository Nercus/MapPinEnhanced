---@class MapPinEnhancedOptionColorpickerTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedColorpickerTemplate
---@field gradient boolean?
MapPinEnhancedOptionColorpickerMixin = {}

function MapPinEnhancedOptionColorpickerMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionColorpickerMixin:GetValue()
    return self.child:GetValue()
end

---@param value MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient
---@return boolean
function MapPinEnhancedOptionColorpickerMixin:IsValueEqual(value)
    return tCompare(self:GetValue(), value, 2)
end

---@param value MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient
function MapPinEnhancedOptionColorpickerMixin:SetValue(value)
    self.child:SetValue(value)
end

---@param initValue MapPinEnhancedColorpickerColor|MapPinEnhancedColorpickerGradient
function MapPinEnhancedOptionColorpickerMixin:Setup(initValue)
    self.child.gradient = self.gradient == true
    self.child:UpdateMode()
    self.child:SetCallback(function()
        self:NotifyChange(self:GetValue())
    end)
    self:SetValue(initValue)
end
