---@class MapPinEnhancedWorldmapPinTemplate : MapPinEnhancedBasePinTemplate,Button
MapPinEnhancedWorldmapPinMixin = {}

function MapPinEnhancedWorldmapPinMixin:OnEnter()
    if not self.pin then return end
    self.pin:ShowTooltip(self)
end

function MapPinEnhancedWorldmapPinMixin:OnLeave()
    GameTooltip:Hide()
end
