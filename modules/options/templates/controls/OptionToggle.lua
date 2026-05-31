---@class MapPinEnhancedOptionToggleTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedToggleTemplate
MapPinEnhancedOptionToggleMixin = {}

function MapPinEnhancedOptionToggleMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionToggleMixin:GetValue()
    return self.child:GetChecked()
end

function MapPinEnhancedOptionToggleMixin:SetValue(value)
    if value then
        self.child:SetChecked()
    else
        self.child:SetUnchecked()
    end
end

---@params initValue boolean
function MapPinEnhancedOptionToggleMixin:Setup(initValue)
    self.child:Setup({
        onChange = function(isChecked)
            self:NotifyChange(isChecked)
        end,
    })
    assert(type(initValue) == "boolean", "Initial value for toggle must be a boolean")
    self:SetValue(initValue)
end
