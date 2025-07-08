---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
MapPinEnhancedMinimapPinMixin = {}

function MapPinEnhancedMinimapPinMixin:OnEnter()
    if not self.tooltipFunction then return end
    self.tooltipFunction()
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 20)
    GameTooltip:Show()
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
