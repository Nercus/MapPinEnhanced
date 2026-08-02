---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

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
