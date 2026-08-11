---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedTextareaPlayerholderOverlay : Frame
---@field bg Texture
---@field text FontString
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedTextareaTemplate : ScrollFrame
---@field editbox EditBox
---@field placeholderOverlay MapPinEnhancedTextareaPlayerholderOverlay
MapPinEnhancedTextareaMixin = {};


function MapPinEnhancedTextareaMixin:OnSizeChanged()
    local x, y = self:GetSize();
    self.editbox:SetSize(x - 5, y - 5);
end

function MapPinEnhancedTextareaMixin:OnMouseDown()
    self.editbox:SetFocus();
end

function MapPinEnhancedTextareaMixin:OnEditFocusGained()
    self.placeholderOverlay.fadeOut:PlayHiding(self.placeholderOverlay.fadeIn)
end

function MapPinEnhancedTextareaMixin:OnEditFocusLost()
    if self.editbox:GetText() == "" then
        self.placeholderOverlay.fadeIn:PlayShowing(self.placeholderOverlay.fadeOut)
    end
end

function MapPinEnhancedTextareaMixin:SetPlaceholder(text)
    self.placeholderOverlay.text:SetText(string.format("[%s]", text))
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedTextareaMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

function MapPinEnhancedTextareaMixin:OnLoad()
    self.editbox:SetScript("OnEditFocusGained", function() self:OnEditFocusGained() end)
    self.editbox:SetScript("OnEditFocusLost", function() self:OnEditFocusLost() end)
end

---@class TextareaSetup
---@field onChange fun(text: string)
---@field placeholder string?
---@field init? fun(): string -- initial value can be nil if option has never been set before

local DEFAULT_PLACEHOLDER = L["Click to edit"]

---@param formData TextareaSetup
function MapPinEnhancedTextareaMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self.editbox:SetText(initialValue)
        else
            self.editbox:SetText("") -- default to empty if init returns nil
        end
    else
        self.editbox:SetText("") -- default to empty if no init function is provided
    end
    self:SetPlaceholder(formData.placeholder or DEFAULT_PLACEHOLDER)

    self.editbox:SetScript("OnTextChanged", function(_, userInput)
        if self.onChangeCallback and userInput then
            self.onChangeCallback(self.editbox:GetText())
        end
    end)
    self:SetCallback(formData.onChange)
end

---@param value string
---@param triggerCallback boolean|nil
function MapPinEnhancedTextareaMixin:SetValue(value, triggerCallback)
    self.editbox:SetText(value)
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
