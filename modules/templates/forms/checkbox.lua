---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Utils = MapPinEnhanced:GetModule("Utils")

---@class MapPinEnhancedCheckboxMixin : CheckButton, PropagateMouseMotion
---@field onChangeCallback function
MapPinEnhancedCheckboxMixin = {}

---@class CheckboxOptions
---@field onChange fun(value: boolean)
---@field init? fun(): boolean -- initial value can be nil if option has never been set before
---@field default boolean

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
    self.onChangeCallback = Utils:DebounceChange(callback, 0.1)
end

---@param optionData OptionCheckboxTyped | CheckboxOptions
function MapPinEnhancedCheckboxMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetChecked(optionData.init())
    self:SetDisabled(optionData.disabledState)
    self:SetScript("OnClick", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetChecked())
    end)
    self:SetCallback(optionData.onChange)
end