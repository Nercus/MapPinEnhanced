---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
---@field groupBadge MapPinEnhancedPinGroupBadgeTemplate
MapPinEnhancedMinimapPinMixin = {}

function MapPinEnhancedMinimapPinMixin:OnLoad()
    self.pulseHighlight:SetIgnoreParentScale(true)
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
