---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedButtonTemplate : Button, MapPinEnhancedTooltipMixin
---@field icon MapPinEnhancedIcon?
---@field iconOnRight boolean?
---@field fontSize MapPinEnhancedButtonFontSize
---@field iconTexture MapPinEnhancedIconMixin
---@field text FontString
---@field bottomLine Texture
MapPinEnhancedButtonMixin = {};

local L = MapPinEnhanced.L

---@alias MapPinEnhancedButtonFontSize "small"|"medium"|"large"

---@type table<MapPinEnhancedButtonFontSize, {normal: Font, highlight: Font, disabled: Font}>
local FONT_OBJECTS = {
    small = {
        normal = MapPinEnhancedFontNormalSmall,
        highlight = MapPinEnhancedFontHighlightSmall,
        disabled = MapPinEnhancedFontDisabledSmall,
    },
    medium = {
        normal = MapPinEnhancedFontNormal,
        highlight = MapPinEnhancedFontHighlight,
        disabled = MapPinEnhancedFontDisabled,
    },
    large = {
        normal = MapPinEnhancedFontNormalLarge,
        highlight = MapPinEnhancedFontHighlightLarge,
        disabled = MapPinEnhancedFontDisabledLarge,
    },
}

function MapPinEnhancedButtonMixin:OnLoad()
    self:OnTooltipLoad()
    local label = self:GetText()
    assert(type(label) == "string" and label ~= "", "MapPinEnhancedButtonMixin: button requires a label")
    self:SetText(L[label])
    if self.icon then
        self.iconTexture:SetIconTexture(self.icon)
    end
    self.iconTexture:SetIconEnabled(self:IsEnabled())
    self.bottomLine:SetShown(self:IsEnabled())
    self:UpdateFontSize()
end

function MapPinEnhancedButtonMixin:OnShow()
    self:Update()
end

function MapPinEnhancedButtonMixin:UpdateFontSize()
    local fonts = FONT_OBJECTS[self.fontSize]
    assert(fonts, "MapPinEnhancedButtonMixin: invalid fontSize: " .. tostring(self.fontSize))
    self:SetNormalFontObject(fonts.normal)
    self:SetHighlightFontObject(fonts.highlight)
    self:SetDisabledFontObject(fonts.disabled)
end

function MapPinEnhancedButtonMixin:Update()
    local hasIcon = self.icon ~= nil
    assert(self:GetText() and self:GetText() ~= "", "MapPinEnhancedButtonMixin: button requires a label")
    self.iconTexture:ClearAllPoints()
    self.text:ClearAllPoints()
    self.text:Show()
    if not hasIcon then
        self.iconTexture:Hide()
        self.text:SetAllPoints(self)
    else
        local _, labelHeight = self.text:GetFont()
        self.iconTexture:SetSize(labelHeight, labelHeight)
        local padding = labelHeight * 0.25
        local labelOffset = labelHeight / 2
        self.text:SetPoint("CENTER", self, "CENTER", self.iconOnRight and -labelOffset or labelOffset, 0)
        if self.iconOnRight then
            self.iconTexture:SetPoint("LEFT", self.text, "RIGHT", padding, 0)
        else
            self.iconTexture:SetPoint("RIGHT", self.text, "LEFT", -padding, 0)
        end
        self.iconTexture:Show()
    end
    self.text:AdjustPointsOffset(0, 1)
    -- Click handlers can rebuild anchors before WoW removes the pressed offset.
    -- Keep that offset in the new layout so release restores the normal position.
    if self:GetButtonState() == "PUSHED" then
        self.text:AdjustPointsOffset(self:GetPushedTextOffset())
    end
end

---@param icon MapPinEnhancedIcon?
---@param onRight boolean?
function MapPinEnhancedButtonMixin:SetIcon(icon, onRight)
    self.icon = icon
    self.iconOnRight = onRight
    if icon then
        self.iconTexture:SetIconTexture(icon)
    end
    self:Update()
end

---@param label string
function MapPinEnhancedButtonMixin:SetLabel(label)
    assert(type(label) == "string" and label ~= "", "MapPinEnhancedButtonMixin:SetLabel: label is empty")
    self:SetText(label)
    self:Update()
end

---@param callback fun(value: mouseButton, down: boolean)
function MapPinEnhancedButtonMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class ButtonSetup
---@field buttonText {icon: MapPinEnhancedIcon?, label: string} text and optional icon for the button
---@field onChange fun(value: mouseButton, down: boolean)

---@param formData ButtonSetup
function MapPinEnhancedButtonMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")
    assert(type(formData.buttonText) == "table", "MapPinEnhancedButtonMixin:Setup: buttonText is missing")
    assert(type(formData.buttonText.label) == "string" and formData.buttonText.label ~= "",
        "MapPinEnhancedButtonMixin:Setup: buttonText.label is empty")

    self:SetIcon(formData.buttonText.icon)
    self:SetLabel(formData.buttonText.label)

    self:SetCallback(formData.onChange)
    self:SetScript("OnClick", function(_, button, down)
        if self.onChangeCallback then
            self.onChangeCallback(button, down)
        end
    end)
end

---@param triggerCallback boolean|nil
function MapPinEnhancedButtonMixin:SetValue(_, triggerCallback)
    if triggerCallback and self.onChangeCallback then
        -- simulate a left button click
        self.onChangeCallback("LeftButton", false)
    end
end

function MapPinEnhancedButtonMixin:OnEnable()
    self.iconTexture:SetIconEnabled(true)
    self.bottomLine:Show()
end

function MapPinEnhancedButtonMixin:OnDisable()
    self.iconTexture:SetIconEnabled(false)
    self.bottomLine:Hide()
end
