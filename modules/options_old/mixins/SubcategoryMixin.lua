---@class MapPinEnhancedOptionSubgroupMixin
---@field name string
---@field template string
MapPinEnhancedOptionSubgroupMixin = {
    template = "MapPinEnhancedOptionsSubgroupTemplate"
}

function MapPinEnhancedOptionSubgroupMixin:SetName(name)
    self.name = name
end

function MapPinEnhancedOptionSubgroupMixin:GetName()
    return self.name
end
