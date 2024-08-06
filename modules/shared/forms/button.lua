-- Template: file://./button.xml
---@class MapPinEnhancedButtonMixin : Button, PropagateMouseMotion
---@field onChangeCallback function
MapPinEnhancedButtonMixin = {}


function MapPinEnhancedButtonMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionButtonTyped
function MapPinEnhancedButtonMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetText(optionData.buttonLabel)
    self:SetCallback(optionData.onChange)
    self:SetScript("OnClick", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback()
    end)
end
