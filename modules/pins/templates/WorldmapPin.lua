---@class MapPinEnhancedWorldmapPinTemplate : MapPinEnhancedBasePinTemplate,Button
MapPinEnhancedWorldmapPinMixin = {}

function MapPinEnhancedWorldmapPinMixin:OnEnter()
    if not self.tooltipFunction then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 20)
    self.tooltipFunction()
    GameTooltip:Show()
end

function MapPinEnhancedWorldmapPinMixin:OnLeave()
    GameTooltip:Hide()
end
