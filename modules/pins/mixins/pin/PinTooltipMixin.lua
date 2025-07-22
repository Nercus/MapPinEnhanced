---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTooltipMixin = {}

---@param tooltipInfo? PinTooltip
function MapPinEnhancedPinTooltipMixin:SetTooltip(tooltipInfo)
    self.worldmapPin:UpdateTooltip(tooltipInfo)
    self.minimapPin:UpdateTooltip(tooltipInfo)
    self:PersistPin()
end
