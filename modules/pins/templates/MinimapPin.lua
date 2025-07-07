---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
MapPinEnhancedMinimapPinMixin = {}

function MapPinEnhancedMinimapPinMixin:OnEnter()
    if not self.tooltipFunction then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 20)
    self.tooltipFunction(GameTooltip)
    GameTooltip:Show()
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
