---@class MapPinEnhancedOptionColorpickerTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedColorpickerTemplate
MapPinEnhancedOptionColorpickerMixin = {}

function MapPinEnhancedOptionColorpickerMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionColorpickerMixin:GetValue()
    return { r = self.child.r, g = self.child.g, b = self.child.b, a = self.child.a }
end

---@param value {r: number, g: number, b: number, a: number}
---@return boolean
function MapPinEnhancedOptionColorpickerMixin:IsValueEqual(value)
    return self.child.r == value.r
        and self.child.g == value.g
        and self.child.b == value.b
        and self.child.a == value.a
end

---@param value {r: number, g: number, b: number, a: number}
function MapPinEnhancedOptionColorpickerMixin:SetValue(value)
    self.child:SetColor(value.r, value.g, value.b, value.a, false)
end

---@param initValue {r: number, g: number, b: number, a: number}
function MapPinEnhancedOptionColorpickerMixin:Setup(initValue)
    self.child:SetCallback(function(r, g, b, a)
        self:NotifyChange({ r = r, g = g, b = b, a = a })
    end)
    assert(initValue.r and initValue.g and initValue.b and initValue.a,
        "Initial value for colorpicker must have r, g, b, a fields")
    self:SetValue(initValue)
end
