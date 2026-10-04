---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
---@field groupBadge MapPinEnhancedPinGroupBadgeTemplate
MapPinEnhancedMinimapPinMixin = {}

local Options = MapPinEnhanced:GetModule("Options")

function MapPinEnhancedMinimapPinMixin:OnLoad()
    self.pulseHighlight:SetIgnoreParentScale(true)
    Options:SubscribeToOptionChanges("Pins.Appearance.MinimapScale", function(value)
        self:SetSize(22 * value, 22 * value)
    end)
    Options:SubscribeToOptionChanges("Pins.Appearance.FadeUntracked", function()
        self:ApplyHoverStyle()
    end)
end

function MapPinEnhancedMinimapPinMixin:OnEnter()
    self:SetHovered(true)
    if not self.pin then return end
    self.pin:ShowTooltip(self)
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    self:SetHovered(false)
    GameTooltip:Hide()
end

function MapPinEnhancedMinimapPinMixin:ApplyHoverStyle()
    MapPinEnhancedBasePinMixin.ApplyHoverStyle(self)
    self:SetAlpha(Options:GetOptionValue("Pins.Appearance.FadeUntracked") and
        not self.tracked and not self.hovered and 0.4 or 1)
end
