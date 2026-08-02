---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedButtonTemplate : Button
---@field icon MapPinEnhancedIcon?
---@field iconTexture MapPinEnhancedIconMixin
---@field text FontString
MapPinEnhancedButtonMixin = {};

local L = MapPinEnhanced.L

function MapPinEnhancedButtonMixin:OnLoad()
    local label = self:GetText()
    if label and label ~= "" then
        self:SetText(L[label])
    end
    if self.icon then
        self.iconTexture:SetIconTexture(self.icon)
    end
    self:Update()
end

function MapPinEnhancedButtonMixin:Update()
    -- 3 different states for the button
    -- 1. Label only
    -- 2. Icon only
    -- 3. Icon left then label

    local hasIcon = self.icon ~= nil
    local hasLabel = self:GetText() and self:GetText() ~= ""
    self.iconTexture:ClearAllPoints()
    self.text:ClearAllPoints()
    if hasIcon and not hasLabel then
        self.iconTexture:Show()
        local buttonHeight = self:GetHeight()
        local padding = buttonHeight * 0.3
        self.text:SetText("")
        self.text:SetAllPoints()
        self.iconTexture:SetPoint("TOPLEFT", self.text, "TOPLEFT", padding, -padding)
        self.iconTexture:SetPoint("BOTTOMRIGHT", self.text, "BOTTOMRIGHT", -padding, padding)
    elseif hasLabel and not hasIcon then
        self.iconTexture:Hide()
        self.text:SetAllPoints(self)
        self.text:Show()
    elseif hasIcon and hasLabel then
        -- calculate the width of the label set the size of the icon to match the height of the button -> sum the width values add some padding and then position correctly
        local labelHeight = self.text:GetLineHeight()
        self.iconTexture:SetSize(labelHeight, labelHeight)
        local padding = labelHeight * 0.25
        local labelOffset = labelHeight / 2 + padding
        self.text:SetPoint("CENTER", self, "CENTER", labelOffset, 0)
        self.iconTexture:SetPoint("RIGHT", self.text, "LEFT", -padding, 0)
        self.iconTexture:Show()
    end
end

---@param icon MapPinEnhancedIcon?
function MapPinEnhancedButtonMixin:SetIcon(icon)
    self.icon = icon
    if icon then
        self.iconTexture:SetIconTexture(icon)
    end
    self:Update()
end

---@param label string
function MapPinEnhancedButtonMixin:SetLabel(label)
    self:SetText(label)
    self:Update()
end

---@param callback fun(value: mouseButton, down: boolean)
function MapPinEnhancedButtonMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class ButtonSetup
---@field buttonText {icon: MapPinEnhancedIcon?, label: string?} -- text and icon for the button
---@field onChange fun(value: mouseButton, down: boolean)

---@param formData ButtonSetup
function MapPinEnhancedButtonMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

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
