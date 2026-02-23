---@class MapPinEnhancedOptionToggleTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedToggleTemplate
MapPinEnhancedOptionToggleMixin = {}

function MapPinEnhancedOptionToggleMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionToggleMixin:GetValue()
    self.child:GetChecked()
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
            if not self.callbacks then return end
            for _, cb in ipairs(self.callbacks) do
                cb(isChecked)
            end
        end,
    })
    assert(type(initValue) == "boolean", "Initial value for toggle must be a boolean")
    self:SetValue(initValue)
end
