-- Template: file://./MinimapPin.xml
---@class MapPinEnhancedMinimapPinMixin : MapPinEnhancedBasePinMixin
MapPinEnhancedMinimapPinMixin = {}



function MapPinEnhancedMinimapPinMixin:OnLoad()
    local width, height = self:GetSize()
    self.icon:SetSize(width - 6, height - 6)
end

function MapPinEnhancedMinimapPinMixin:ShowTooltip()
    if not self.pinData then return end
    if not self.pinData.title then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText(self.pinData.title)
    GameTooltip:Show()
end

function MapPinEnhancedMinimapPinMixin:OnEnter()
    self:ShowTooltip()
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
