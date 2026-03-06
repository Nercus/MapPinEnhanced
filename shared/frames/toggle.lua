---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedToggleTemplate : Button
---@field isChecked boolean
---@field checkAnimation AnimationGroup
---@field uncheckAnimation AnimationGroup
MapPinEnhancedToggleMixin = {}


function MapPinEnhancedToggleMixin:SetChecked(skipAnimation)
    self.isChecked = true
    if not skipAnimation then
        self.checkAnimation:Play()
    end
end

function MapPinEnhancedToggleMixin:GetChecked()
    return self.isChecked
end

function MapPinEnhancedToggleMixin:SetUnchecked(skipAnimation)
    self.isChecked = false
    if not skipAnimation then
        self.uncheckAnimation:Play()
    end
end

function MapPinEnhancedToggleMixin:OnClick()
    if self.isChecked then
        self:SetUnchecked()
    else
        self:SetChecked()
    end
end

function MapPinEnhancedToggleMixin:OnLoad()
    self.isChecked = false
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedToggleMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class CheckboxSetup
---@field onChange fun(isChecked: boolean)
---@field init? fun(): boolean

---@param formData CheckboxSetup
function MapPinEnhancedToggleMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:SetCallback(formData.onChange)
    self:SetScript("OnClick", function()
        self:OnClick()
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

---@param value boolean
---@param triggerCallback boolean|nil
function MapPinEnhancedToggleMixin:SetValue(value, triggerCallback)
    self:SetChecked(value)
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
