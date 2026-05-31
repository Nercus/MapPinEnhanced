---@class MapPinEnhancedOptionInputTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedInputTemplate
MapPinEnhancedOptionInputMixin = {}


function MapPinEnhancedOptionInputMixin:OnMouseDown()
    self.child:SetFocus()
end

function MapPinEnhancedOptionInputMixin:GetValue()
    return self.child:GetText()
end

function MapPinEnhancedOptionInputMixin:SetValue(value)
    self.child:SetText(value)
end

---@param initValue string
function MapPinEnhancedOptionInputMixin:Setup(initValue)
    self.child:Setup({
        onChange = function(text)
            self:NotifyChange(text)
        end,
    })
    assert(type(initValue) == "string", "Initial value for input must be a string")
    self:SetValue(initValue)
end
