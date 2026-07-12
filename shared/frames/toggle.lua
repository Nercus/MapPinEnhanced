---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedToggleTemplate : Button
---@field isChecked boolean
---@field checkAnimation AnimationGroup
---@field uncheckAnimation AnimationGroup
---@field thumb Texture
MapPinEnhancedToggleMixin = {}

local CHECKED_OFFSET_X = 27
local UNCHECKED_OFFSET_X = 2
local CHECKED_ALPHA = 1
local UNCHECKED_ALPHA = 0.5

local function SetThumbState(self, isChecked)
    self.thumb:ClearAllPoints()
    self.thumb:SetPoint("LEFT", isChecked and CHECKED_OFFSET_X or UNCHECKED_OFFSET_X, 0)
    self.thumb:SetAlpha(isChecked and CHECKED_ALPHA or UNCHECKED_ALPHA)
    if isChecked then
        self.thumb:SetVertexColor(1, 0.82, 0)
    else
        self.thumb:SetVertexColor(0.6, 0.6, 0.6)
    end
end

---@param skipAnimation? boolean
function MapPinEnhancedToggleMixin:SetChecked(skipAnimation)
    local wasChecked = self.isChecked
    self.isChecked = true
    self.uncheckAnimation:Stop()
    if skipAnimation or wasChecked then
        self.checkAnimation:Stop()
        SetThumbState(self, true)
    else
        self.checkAnimation:Play()
        self.thumb:SetVertexColor(1, 0.82, 0)
    end
end

function MapPinEnhancedToggleMixin:GetChecked()
    return self.isChecked
end

---@param skipAnimation? boolean
function MapPinEnhancedToggleMixin:SetUnchecked(skipAnimation)
    local wasChecked = self.isChecked
    self.isChecked = false
    self.checkAnimation:Stop()
    if skipAnimation or not wasChecked then
        self.uncheckAnimation:Stop()
        SetThumbState(self, false)
    else
        self.uncheckAnimation:Play()
        self.thumb:SetVertexColor(0.6, 0.6, 0.6)
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
    SetThumbState(self, false)
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
            self:SetValue(initialValue, false, true)
        end
    else
        self:SetUnchecked(true) -- default to unchecked if no init function is provided
    end
end

---@param value boolean
---@param triggerCallback boolean|nil
---@param skipAnimation boolean|nil
function MapPinEnhancedToggleMixin:SetValue(value, triggerCallback, skipAnimation)
    if value then
        self:SetChecked(skipAnimation)
    else
        self:SetUnchecked(skipAnimation)
    end
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
