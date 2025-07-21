---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCheckboxTemplate : CheckButton
---@field text FontString
MapPinEnhancedCheckboxMixin = {}

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
            self:SetChecked(initialValue)
        end
    else
        self:SetChecked(false) -- default to unchecked if no init function is provided
    end
end
