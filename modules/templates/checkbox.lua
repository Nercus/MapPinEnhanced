---@class MapPinEnhancedCheckboxTemplate : CheckButton
---@field text FontString
MapPinEnhancedCheckboxMixin = {}

function MapPinEnhancedCheckboxMixin:SetLabel(label)
    assert(self.text, "CheckboxMixin requires 'text' field to be defined.")
    self.text:SetText(label)
end
