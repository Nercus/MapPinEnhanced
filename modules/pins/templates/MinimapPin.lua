---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
MapPinEnhancedMinimapPinMixin = {}

function MapPinEnhancedMinimapPinMixin:OnEnter()
    if not self.pin then return end
    self.pin:ShowTooltip(self)
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
