---@class MapPinEnhancedOptionColorpickerTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedColorpickerTemplate
MapPinEnhancedOptionColorpickerMixin = {}

function MapPinEnhancedOptionColorpickerMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionColorpickerMixin:GetValue()
    return { r = self.child.r, g = self.child.g, b = self.child.b, a = self.child.a }
end

function MapPinEnhancedOptionColorpickerMixin:SetValue(r, g, b, a)
    self.child:SetColor(r, g, b, a, false)
end

---@param initValue {r: number, g: number, b: number, a: number}
function MapPinEnhancedOptionColorpickerMixin:Setup(initValue)
    self.child:SetCallback(function(r, g, b, a)
        if not self.callbacks then return end
        for _, cb in ipairs(self.callbacks) do
            cb({ r = r, g = g, b = b, a = a })
        end
    end)
    assert(initValue.r and initValue.g and initValue.b and initValue.a,
        "Initial value for colorpicker must have r, g, b, a fields")
    self:SetValue(initValue.r, initValue.g, initValue.b, initValue.a)
end
