---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTooltipMixin = {}


---@param pin MapPinEnhancedPinMixin
local function DefaultTooltip(pin)
    GameTooltip:AddLine(pin.pinData.title)
end

function MapPinEnhancedPinTooltipMixin:SetTooltip(tooltipFunction)
    if not tooltipFunction or type(tooltipFunction) ~= "function" then
        self.worldmapPin:UpdateTooltip(function()
            DefaultTooltip(self)
        end)
        self.minimapPin:UpdateTooltip(function()
            DefaultTooltip(self)
        end)
        return
    end

    self.worldmapPin:UpdateTooltip(tooltipFunction)
    self.minimapPin:UpdateTooltip(tooltipFunction)
end
