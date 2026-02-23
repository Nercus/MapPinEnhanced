---@class MapPinEnhancedOptionToggleTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedToggleTemplate
---@field callbacks function[]
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

function MapPinEnhancedOptionToggleMixin:OnChange(callback)
    if not self.callbacks then
        self.callbacks = {}
    end
    table.insert(self.callbacks, callback)
    self.child:SetCallback(function(isChecked)
        for _, cb in ipairs(self.callbacks) do
            cb(isChecked)
        end
    end)
end
