---@class MapPinEnhancedWorldMapPinMixin : MapPinEnhancedBasePinMixin, Button
MapPinEnhancedWorldMapPinMixin = {}

function MapPinEnhancedWorldMapPinMixin:Setup()
    print("MapPinEnhancedWorldMapPinMixin:Setup()")
end

function MapPinEnhancedWorldMapPinMixin:OnClick()
    print("MapPinEnhancedWorldMapPinMixin:OnClick()")
end

-- function MapPinEnhancedWorldMapPinMixin:SetClickCallback(callback)
--     self.callback = callback
-- end
