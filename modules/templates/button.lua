---@class MapPinEnhancedButtonTemplate : Button
---@field icon MapPinEnhancedIconMixin
---@field text FontString
MapPinEnhancedButtonMixin = {};



function MapPinEnhancedButtonMixin:OnLoad()
end

function MapPinEnhancedButtonMixin:Update()
    -- 3 different states for the button
    -- 1. Label only
    -- 2. Icon only
    -- 3. Icon left then label

    local hasIcon = self.icon and self.icon.icon
    local hasLabel = self:GetText() and self:GetText() ~= ""
    self.icon:ClearAllPoints()
    self.text:ClearAllPoints()
    if hasIcon and not hasLabel then
        self.icon:Show()
        local buttonHeight = self:GetHeight()
        local padding = buttonHeight * 0.3
        self.text:SetText("")
        self.text:SetAllPoints()
        self.icon:SetPoint("TOPLEFT", self.text, "TOPLEFT", padding, -padding)
        self.icon:SetPoint("BOTTOMRIGHT", self.text, "BOTTOMRIGHT", -padding, padding)
    elseif hasLabel and not hasIcon then
        self.icon:Hide()
        self.text:SetAllPoints(self)
        self.text:Show()
    elseif hasIcon and hasLabel then
        -- calculate the width of the label set the size of the icon to match the height of the button -> sum the width values add some padding and then position correctly
        local labelHeight = self.text:GetLineHeight()
        self.icon:SetSize(labelHeight, labelHeight)
        local padding = labelHeight * 0.25
        local labelOffset = labelHeight / 2 + padding
        self.text:SetPoint("CENTER", self, "CENTER", labelOffset, 0)
        self.icon:SetPoint("RIGHT", self.text, "LEFT", -padding, 0)
        self.icon:Show()
    end
end

---@param icon MapPinEnhancedIcon
function MapPinEnhancedButtonMixin:SetIcon(icon)
    self.icon:SetIconTexture(icon)
    self:Update()
end

---@param label string
function MapPinEnhancedButtonMixin:SetLabel(label)
    self:SetText(label)
    self:Update()
end
