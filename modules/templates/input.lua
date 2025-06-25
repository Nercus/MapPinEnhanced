---@class MapPinEnhanced : NercUtilsAddon
local MapPinEnhanced = LibStub("NercUtils"):GetAddon(...)

---@class MapPinEnhancedInputTemplate : EditBox
---@field left Texture
---@field right Texture
---@field middle Texture
---@field clearButton Button
---@field inlineLabel MapPinEnhancedInputInlineLabel
---@field placeholder FontString
---@field clearOnEscape boolean?
---@field icon MapPinEnhancedIcon? set through keyvalues
---@field label string? set through keyvalues
MapPinEnhancedInputMixin = {}

---@class MapPinEnhancedInputInlineLabel : Frame
---@field text FontString
---@field icon MapPinEnhancedIconMixin
---@field bg Texture

function MapPinEnhancedInputMixin:UpdatePlaceholderVisibility()
    local text = self:GetText()
    if not text or text == "" then
        self.placeholder:Show()
    else
        self.placeholder:Hide()
    end
end

function MapPinEnhancedInputMixin:UpdatePlaceholderPosition()
    local leftInset = self:GetTextInsets() or 0
    self.placeholder:ClearAllPoints()
    self.placeholder:SetPoint("LEFT", self, "LEFT", leftInset + 2, 0)
end

function MapPinEnhancedInputMixin:UpdateClearButtonVisibility()
    local text, hasFocus = self:GetText(), self:HasFocus()
    if not text or text == "" or not hasFocus then
        self.clearButton:Hide()
    else
        self.clearButton:Show()
    end
end

function MapPinEnhancedInputMixin:SetPlaceholderText(placeholderText)
    self.placeholder:SetText(placeholderText)
    self:UpdatePlaceholderVisibility()
end

function MapPinEnhancedInputMixin:ResetInline()
    self.inlineLabel:Hide()
    self:SetTextInsets(10, 5, 0, 0)
    self:UpdatePlaceholderPosition()
end

function MapPinEnhancedInputMixin:SetInlineLabel(label)
    if not label then
        self:ResetInline()
        return
    end
    self.inlineLabel.text:SetText(label)
    self.inlineLabel:Show()
    local labelWidth = self.inlineLabel.text:GetStringWidth() + 20
    self.inlineLabel:SetWidth(labelWidth)
    self:SetTextInsets(labelWidth, 5, 0, 0)
    self.inlineLabel.icon:Hide()
    self.inlineLabel.text:Show()
    self.inlineLabel.bg:Show()
    self:UpdatePlaceholderPosition()
end

---@param icon MapPinEnhancedIcon
function MapPinEnhancedInputMixin:SetInlineIcon(icon)
    if not icon then
        self:ResetInline()
        return
    end
    self.inlineLabel.icon:SetIconTexture(icon)
    self.inlineLabel:Show()
    local labelHeight = self.inlineLabel:GetHeight()
    local iconSize = labelHeight * 0.5
    self.inlineLabel.icon:SetSize(iconSize, iconSize)
    self:SetTextInsets(labelHeight, 5, 0, 0)
    self.inlineLabel:SetWidth(labelHeight)
    self.inlineLabel.icon:Show()
    self.inlineLabel.text:Hide()
    self.inlineLabel.bg:Hide()
    self:UpdatePlaceholderPosition()
end

function MapPinEnhancedInputMixin:OnLoad()
    self:RegisterEvent("GLOBAL_MOUSE_DOWN")
    if self.icon and not self.label then
        self:SetInlineIcon(self.icon)
    elseif self.label and not self.icon then
        self:SetInlineLabel(self.label)
    elseif self.icon and self.label then
        error("MapPinEnhancedInputMixin: Cannot set both icon and label at the same time.")
    else
        self:ResetInline()
    end
end

function MapPinEnhancedInputMixin:OnEvent(event)
    if event == "GLOBAL_MOUSE_DOWN" then
        if not self:IsMouseOver() and self:HasFocus() then
            self:ClearHighlightText()
            self:ClearFocus()
            self:UpdateClearButtonVisibility()
            self:UpdatePlaceholderVisibility()
        end
    end
end

function MapPinEnhancedInputMixin:OnChar()
    self:UpdateClearButtonVisibility()
    self:UpdatePlaceholderVisibility()
end

function MapPinEnhancedInputMixin:OnEscapePressed()
    if self.clearOnEscape then
        self:SetText("")
    end
    self:ClearHighlightText()
    self:ClearFocus()
    self:UpdateClearButtonVisibility()
    self:UpdatePlaceholderVisibility()
end

function MapPinEnhancedInputMixin:OnEditFocusGained()
    self:HighlightText()
    self:UpdateClearButtonVisibility()
    self:UpdatePlaceholderVisibility()
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedInputMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class MapPinEnhancedInputData
---@field onChange fun(text: string)
---@field init? fun(): string -- initial value can be nil if option has never been set before

---@param formData MapPinEnhancedInputData
function MapPinEnhancedInputMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")


    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self:SetText(initialValue)
        end
    else
        self:SetText("") -- default to empty if no init function is provided
    end

    self:SetCallback(formData.onChange)
    self:SetScript("OnTextChanged", function(_, userInput)
        if self.onChangeCallback and userInput then
            self.onChangeCallback(self:GetText())
        end
        self:UpdatePlaceholderVisibility()
        self:UpdateClearButtonVisibility()
    end)
end
