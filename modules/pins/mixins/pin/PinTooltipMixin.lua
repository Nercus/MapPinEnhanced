---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinProxyMixin = {}

---@param tooltipInfo? PinTooltip
function MapPinEnhancedPinProxyMixin:SetTooltip(tooltipInfo)
    self.worldmapPin:UpdateTooltip(tooltipInfo)
    self.minimapPin:UpdateTooltip(tooltipInfo)
    self:PersistPin()
end
