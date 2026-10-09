---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

---@class MapPinEnhancedOptionWayfinderCard : Button
---@field background Texture
---@field image Texture
---@field label FontString
---@field value WayfinderSelection
MapPinEnhancedOptionWayfinderCardMixin = {}

function MapPinEnhancedOptionWayfinderCardMixin:OnClick()
    local option = self:GetParent():GetParent() --[[@as MapPinEnhancedOptionWayfinderTemplate]]
    Options:SetOptionValue(option.key, self.value)
end

---@class MapPinEnhancedOptionWayfinderChoices : MapPinEnhancedOptionControl
---@field arrow MapPinEnhancedOptionWayfinderCard
---@field floating MapPinEnhancedOptionWayfinderCard
MapPinEnhancedOptionWayfinderChoicesMixin = {}

function MapPinEnhancedOptionWayfinderChoicesMixin:SetEnabled(enabled)
    self.arrow:SetEnabled(enabled)
    self.floating:SetEnabled(enabled)
end

---@class MapPinEnhancedOptionWayfinderTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedOptionWayfinderChoices
---@field value WayfinderSelection
MapPinEnhancedOptionWayfinderMixin = {}

function MapPinEnhancedOptionWayfinderMixin:GetValue()
    return self.value
end

---@param value WayfinderSelection
function MapPinEnhancedOptionWayfinderMixin:SetValue(value)
    assert(value == "arrow" or value == "floating", "OptionWayfinder:SetValue: expected arrow or floating")
    self.value = value
    for _, card in ipairs({ self.child.arrow, self.child.floating }) do
        local selected = card.value == value
        local labelColor = selected and 1 or 0.6
        card.label:SetTextColor(labelColor, labelColor, labelColor)
        card.image:SetDesaturated(not selected)
        card.background:SetVertexColor(1, selected and 0.82 or 1, selected and 0 or 1)
    end
end

function MapPinEnhancedOptionWayfinderMixin:SetLayout()
    -- This stacked control owns its anchors in XML, including the full-width preview row.
end

function MapPinEnhancedOptionWayfinderMixin:UpdateLayout()
    local cardWidth = math.max(1, (self:GetWidth() - 16) / 2)
    local cardHeight = cardWidth * 9 / 16 + 24
    self.child.arrow:SetSize(cardWidth, cardHeight)
    self.child.floating:SetSize(cardWidth, cardHeight)
    self.child:SetHeight(cardHeight)
    self:UpdateHeight()
end

function MapPinEnhancedOptionWayfinderMixin:OnSizeChanged()
    self:UpdateDescriptionWidth()
    self:UpdateLayout()
end

---@param initialValue WayfinderSelection
function MapPinEnhancedOptionWayfinderMixin:Setup(initialValue)
    self.child.arrow.label:SetText(L["Arrow"])
    self.child.floating.label:SetText(L["Floating"])
    self:SetValue(initialValue)
    self:UpdateLayout()
end
