-- Template: file://./button.xml
---@class MapPinEnhancedButtonMixin : Button, PropagateMouseMotion
---@field onChangeCallback function
---@field left Texture
---@field middle Texture
---@field right Texture
MapPinEnhancedButtonMixin = {}


---@param disabled boolean
function MapPinEnhancedButtonMixin:SetDisabled(disabled)
    if disabled then
        self:Disable()
        self:SetAlpha(0.5)
        self.left:SetDesaturated(true)
        self.middle:SetDesaturated(true)
        self.right:SetDesaturated(true)
    else
        self:Enable()
        self:SetAlpha(1)
        self.left:SetDesaturated(false)
        self.middle:SetDesaturated(false)
        self.right:SetDesaturated(false)
    end
end

function MapPinEnhancedButtonMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionButtonTyped
function MapPinEnhancedButtonMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetText(optionData.buttonLabel)
    self:SetDisabled(optionData.disabledState)
    if optionData.disabledState then return end -- dont set up click handler if disabled
    self:SetCallback(optionData.onChange)
    self:SetScript("OnClick", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback()
    end)
end
