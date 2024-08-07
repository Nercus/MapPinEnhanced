-- Template: file://./checkbox.xml
---@class MapPinEnhancedCheckboxMixin : CheckButton, PropagateMouseMotion
---@onChangeCallback function
MapPinEnhancedCheckboxMixin = {}


function MapPinEnhancedCheckboxMixin:SetDisabled(disabled)
    if disabled then
        self:Disable()
        self:SetAlpha(0.5)
    else
        self:Enable()
        self:SetAlpha(1)
    end
end

function MapPinEnhancedCheckboxMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionCheckboxTyped
function MapPinEnhancedCheckboxMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetChecked(optionData.init)
    self:SetDisabled(optionData.disabledState)
    if optionData.disabledState then return end -- dont set up click handler if disabled
    self:SetScript("OnClick", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetChecked())
    end)
    self:SetCallback(optionData.onChange)
end
