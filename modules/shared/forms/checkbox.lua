-- Template: file://./checkbox.xml
---@class MapPinEnhancedCheckboxMixin : CheckButton, PropagateMouseMotion
---@onChangeCallback function
MapPinEnhancedCheckboxMixin = {}


function MapPinEnhancedCheckboxMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionCheckboxTyped
function MapPinEnhancedCheckboxMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetChecked(optionData.init)
    self:SetScript("OnClick", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetChecked())
    end)
    self:SetCallback(optionData.onChange)
end
