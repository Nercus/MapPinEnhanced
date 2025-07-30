---@class MapPinEnhancedPinGroupMixin
MapPinEnhancedPinGroupProxyMixin = {}


---@class GroupProxy
---@field AddPin fun(self: GroupProxy, pinData: table): PinProxy?
---@field RemovePin fun(self: GroupProxy, pinID: string)
---@field SetName fun(self: GroupProxy, name: string)
---@field GetName fun(self: GroupProxy): string
---@field SetIcon fun(self: GroupProxy, icon: string)
---@field GetIcon fun(self: GroupProxy): string
---@field GetPinCount fun(self: GroupProxy): number
---@field GetPinByID fun(self: GroupProxy, pinID: string): PinProxy
---@field GetPins fun(self: GroupProxy): PinProxy[]

---@return GroupProxy
function MapPinEnhancedPinGroupProxyMixin:GetProxy()
    local proxy = {}

    proxy.AddPin = function(_, pinData)
        local pin = self:AddPin(pinData)
        if not pin then
            return nil
        end
        return pin:GetProxy()
    end

    proxy.RemovePin = function(_, pinID)
        self:RemovePin(pinID)
    end

    proxy.SetName = function(_, name)
        self:SetName(name)
    end

    proxy.GetName = function()
        return self.name
    end

    proxy.SetIcon = function(_, icon)
        self:SetIcon(icon)
    end

    proxy.GetIcon = function()
        return self.icon
    end

    proxy.GetPinCount = function()
        return self:GetPinCount()
    end

    proxy.GetPinByID = function(_, pinID)
        return self:GetPinByID(pinID):GetProxy()
    end

    proxy.GetPins = function()
        local pins = {}
        for _, pin in self:EnumeratePins() do
            table.insert(pins, pin:GetProxy())
        end
        return pins
    end

    return proxy
end
