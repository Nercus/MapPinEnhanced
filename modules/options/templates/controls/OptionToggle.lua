---@class MapPinEnhancedOptionToggleTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedToggleTemplate
MapPinEnhancedOptionToggleMixin = {}

function MapPinEnhancedOptionToggleMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionToggleMixin:GetValue()
    return self.child:GetChecked()
end

---@param skipAnimation? boolean
function MapPinEnhancedOptionToggleMixin:SetValue(value, skipAnimation)
    if value then
        self.child:SetChecked(skipAnimation)
    else
        self.child:SetUnchecked(skipAnimation)
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
    self:SetValue(initValue, true)
end
