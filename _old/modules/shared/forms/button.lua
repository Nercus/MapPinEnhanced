-- Template: file://./button.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedButtonMixin : Button, PropagateMouseMotion
---@field onChangeCallback function
---@field left Texture
---@field middle Texture
---@field right Texture
MapPinEnhancedButtonMixin = {}


---@class ButtonOptions
---@field buttonLabel string
---@field onChange fun(value: mouseButton, down: boolean)

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
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param optionData OptionButtonTyped | ButtonOptions
function MapPinEnhancedButtonMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetText(optionData.buttonLabel)
    self:SetDisabled(optionData.disabledState)
    self:SetCallback(optionData.onChange)
    self:SetScript("OnClick", function(_, button, down)
        if not self.onChangeCallback then return end
        self.onChangeCallback(button, down)
    end)
end
