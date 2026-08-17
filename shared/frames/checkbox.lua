---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCheckboxCheckedTexture : Texture
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedCheckboxTemplate : CheckButton
---@field text FontString
MapPinEnhancedCheckboxMixin = {}

---@class MapPinEnhancedCheckboxWithLabelTemplate : MapPinEnhancedCheckboxTemplate
---@field value any This typing only exists to make it useable inside the checkboxgroup


function MapPinEnhancedCheckboxMixin:SetLabel(label)
    assert(self.text, "CheckboxMixin requires 'text' field to be defined.")
    self.text:SetText(label)
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedCheckboxMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class CheckboxSetup
---@field onChange fun(isChecked: boolean)
---@field init? fun(): boolean

---@param formData CheckboxSetup
function MapPinEnhancedCheckboxMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:SetCallback(formData.onChange)
    self:SetScript("OnClick", function()
        if self.onChangeCallback then
            self.onChangeCallback(self:GetChecked())
        end
    end)

    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self:SetValue(initialValue, false, true)
        end
    else
        self:SetValue(false, false, true) -- default to unchecked if no init function is provided
    end
end

---@param value boolean
---@param triggerCallback boolean|nil
---@param skipAnimation boolean|nil
function MapPinEnhancedCheckboxMixin:SetValue(value, triggerCallback, skipAnimation)
    if skipAnimation then
        local checkedTexture = self:GetCheckedTexture()
        ---@cast checkedTexture MapPinEnhancedCheckboxCheckedTexture
        checkedTexture.fadeIn:SetParentShownInstantly(value, checkedTexture.fadeOut)
    end
    self:SetChecked(value)
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
