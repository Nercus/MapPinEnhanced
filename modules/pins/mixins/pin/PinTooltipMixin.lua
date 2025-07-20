---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTooltipMixin = {}

-- TODO: refactor the tooltipfunction mechanism as a function can't be saved persistently

---@param pin MapPinEnhancedPinMixin
local function DefaultTooltip(pin)
    GameTooltip:AddLine(pin.pinData.title)
    -- TODO: add pin source when not equal to MapPinEnhanced
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
    self:PersistPin()
end
