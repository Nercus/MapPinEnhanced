---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinProxyMixin = {}

---@class PinProxy
---@field SetPinColor fun(self: PinProxy, color: PinColors | "Custom")
---@field SetPinIcon fun(self: PinProxy, icon: string, usesAtlas: boolean)
---@field SetTooltip fun(self: PinProxy, tooltip: string)
---@field Track fun(self: PinProxy)
---@field GetPinData fun(self: PinProxy): table
---@field GetPinID fun(self: PinProxy): string


---@return PinProxy
function MapPinEnhancedPinProxyMixin:GetProxy()
    local proxy = {}

    proxy.SetPinColor = function(_, color)
        self:SetPinColor(color)
    end

    proxy.SetPinIcon = function(_, icon, usesAtlas)
        self:SetPinIcon(icon, usesAtlas)
    end

    proxy.SetTooltip = function(_, tooltipInfo)
        self:SetTooltip(tooltipInfo)
    end

    proxy.Track = function()
        self:Track()
    end

    proxy.GetPinData = function()
        return self.pinData
    end

    proxy.GetPinID = function()
        return self.pinID
    end

    return proxy
end
