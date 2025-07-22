---@class MapPinEnhancedWorldmapPinTemplate : MapPinEnhancedBasePinTemplate,Button
MapPinEnhancedWorldmapPinMixin = {}

function MapPinEnhancedWorldmapPinMixin:OnEnter()
    if not self.tooltipData then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 20)
    local title = self.tooltipData.title
    local text = self.tooltipData.text
    if title then
        GameTooltip:AddLine(self.tooltipData.title, 1, 0.82, 0)
    end
    if text then
        GameTooltip:AddLine(self.tooltipData.text, 1, 1, 1)
    end
    GameTooltip:Show()
end

function MapPinEnhancedWorldmapPinMixin:OnLeave()
    GameTooltip:Hide()
end
