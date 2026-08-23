---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedTextApplyScripts
---@field onEnter function?
---@field onFocusLost function?
---@field onEscape function?

---@class MapPinEnhancedInputTemplate : EditBox
---@field left Texture
---@field right Texture
---@field middle Texture
---@field clearButton Button
---@field inlineIcon MapPinEnhancedInputInlineIcon
---@field placeholderText FontString
---@field clearOnEscape boolean?
---@field icon MapPinEnhancedIcon? set through keyvalues
---@field placeholder string? set through keyvalues
---@field placeholderFont string? set through keyvalues
---@field appliedText string?
---@field applyText? fun(text: string, previousText: string): string?
---@field textApplyScripts MapPinEnhancedTextApplyScripts?
---@field applyingText boolean?
MapPinEnhancedInputMixin = {}

---@class MapPinEnhancedInputInlineIcon : Frame
---@field icon MapPinEnhancedIconMixin

function MapPinEnhancedInputMixin:UpdatePlaceholderVisibility()
    local text = self:GetText()
    if not text or text == "" then
        self.placeholderText:Show()
    else
        self.placeholderText:Hide()
    end
end

function MapPinEnhancedInputMixin:UpdatePlaceholderPosition()
    local leftInset = self:GetTextInsets() or 0
    self.placeholderText:ClearAllPoints()
    self.placeholderText:SetPoint("LEFT", self, "LEFT", leftInset + 3, 0)
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
    self.placeholderText:SetText(placeholderText)
    self:UpdatePlaceholderVisibility()
end

---@param placeholderFont string
function MapPinEnhancedInputMixin:SetPlaceholderFont(placeholderFont)
    assert(placeholderFont, "MapPinEnhancedInputMixin:SetPlaceholderFont: placeholderFont is nil")
    assert(type(placeholderFont) == "string",
        "MapPinEnhancedInputMixin:SetPlaceholderFont: placeholderFont must be a string")

    ---@type FontObject?
    local fontObject = _G[placeholderFont]
    assert(fontObject, "MapPinEnhancedInputMixin:SetPlaceholderFont: unknown font object: " .. placeholderFont)
    self.placeholderText:SetFontObject(fontObject)
end

function MapPinEnhancedInputMixin:ResetInlineIcon()
    self.inlineIcon:Hide()
    self:SetTextInsets(13, 0, 0, 0)
    self:UpdatePlaceholderPosition()
end

---@param icon MapPinEnhancedIcon
function MapPinEnhancedInputMixin:SetInlineIcon(icon)
    if not icon then
        self:ResetInlineIcon()
        return
    end
    self.inlineIcon.icon:SetIconTexture(icon)
    self.inlineIcon:Show()
    local iconHeight = self.inlineIcon:GetHeight()
    self.inlineIcon.icon:SetSize(iconHeight * 0.5, iconHeight * 0.5)
    self:SetTextInsets(iconHeight, 5, 0, 0)
    self.inlineIcon:SetWidth(iconHeight)
    self:UpdatePlaceholderPosition()
end

function MapPinEnhancedInputMixin:OnLoad()
    self:RegisterEvent("GLOBAL_MOUSE_DOWN")
    if self.placeholderFont then
        self:SetPlaceholderFont(self.placeholderFont)
    end

    if self.placeholder then
        self:SetPlaceholderText(L[self.placeholder])
    end

    if self.icon then
        self:SetInlineIcon(self.icon)
    else
        self:ResetInlineIcon()
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
    self:ClearFocus()
end

function MapPinEnhancedInputMixin:OnEditFocusGained()
    self:HighlightText()
    self:UpdateClearButtonVisibility()
    self:UpdatePlaceholderVisibility()
end

function MapPinEnhancedInputMixin:OnEditFocusLost()
    self:ClearHighlightText()
    self:UpdateClearButtonVisibility()
    self:UpdatePlaceholderVisibility()
end

---Set up text that applies on Enter or focus loss and restores on Escape.
---The apply function receives trimmed text and the previously applied text. It
---returns the text to display, or nil to keep the previous text.
---@param startingText string
---@param apply fun(text: string, previousText: string): string?
function MapPinEnhancedInputMixin:SetTextApply(startingText, apply)
    assert(type(startingText) == "string",
        "MapPinEnhancedInputMixin:SetTextApply: startingText must be a string")
    assert(type(apply) == "function",
        "MapPinEnhancedInputMixin:SetTextApply: apply must be a function")

    self:ClearTextApply()
    self.textApplyScripts = {
        onEnter = self:GetScript("OnEnterPressed"),
        onFocusLost = self:GetScript("OnEditFocusLost"),
        onEscape = self:GetScript("OnEscapePressed"),
    }
    self.appliedText = startingText
    self.applyText = apply
    self:SetValue(startingText)

    ---@param editBox MapPinEnhancedInputTemplate
    local function applyCurrentText(editBox)
        if editBox.applyingText then return end
        local applyText = editBox.applyText
        local previousText = editBox.appliedText
        if not applyText or previousText == nil then return end

        editBox.applyingText = true
        local newText = applyText(strtrim(editBox:GetText() or ""), previousText)
        if editBox.applyText == applyText then
            assert(newText == nil or type(newText) == "string",
                "MapPinEnhancedInputMixin:SetTextApply: apply must return a string or nil")
            if newText == nil then newText = previousText end
            editBox.appliedText = newText
            editBox:SetValue(newText)
            editBox:ClearFocus()
            local scripts = editBox.textApplyScripts
            if scripts and scripts.onFocusLost then scripts.onFocusLost(editBox) end
            editBox.applyingText = nil
        end
    end

    ---@param editBox MapPinEnhancedInputTemplate
    local function restoreAppliedText(editBox)
        if editBox.applyingText or editBox.appliedText == nil then return end
        editBox.applyingText = true
        editBox:SetValue(editBox.appliedText)
        editBox:ClearFocus()
        local scripts = editBox.textApplyScripts
        if scripts and scripts.onFocusLost then scripts.onFocusLost(editBox) end
        editBox.applyingText = nil
    end

    self:SetScript("OnEnterPressed", applyCurrentText)
    self:SetScript("OnEditFocusLost", applyCurrentText)
    self:SetScript("OnEscapePressed", restoreAppliedText)
end

function MapPinEnhancedInputMixin:ClearTextApply()
    local scripts = self.textApplyScripts
    if not scripts then return end

    self.applyText = nil
    self.appliedText = nil
    self.textApplyScripts = nil
    self.applyingText = nil
    self:SetScript("OnEnterPressed", scripts.onEnter)
    self:SetScript("OnEditFocusLost", scripts.onFocusLost)
    self:SetScript("OnEscapePressed", scripts.onEscape)
    self:ClearFocus()
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedInputMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class InputSetup
---@field onChange fun(text: string)
---@field init? fun(): string -- initial value can be nil if option has never been set before

---@param formData InputSetup
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

---@param value string
---@param triggerCallback boolean|nil
function MapPinEnhancedInputMixin:SetValue(value, triggerCallback)
    self:SetText(value)
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(value)
    end
end
