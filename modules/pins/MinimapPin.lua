-- Template: file://./MinimapPin.xml
---@class MapPinEnhancedMinimapPinMixin : MapPinEnhancedBasePinMixin
MapPinEnhancedMinimapPinMixin = {}



function MapPinEnhancedMinimapPinMixin:OnLoad()
    self:SetSize(20, 20)
    self.icon:SetSize(10, 10)
end
