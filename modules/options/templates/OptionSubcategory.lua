---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsSubgroupTemplate : Frame
---@field title FontString
MapPinEnhancedOptionsSubgroupMixin = {}

---@param node TreeNodeMixin
function MapPinEnhancedOptionsSubgroupMixin:Init(node)
    local data = node:GetData() --[[@as MapPinEnhancedOptionSubgroupMixin]]
    self.title:SetText(data:GetName())
end

function MapPinEnhancedOptionsSubgroupMixin:Reset()
    self.title:SetText("")
end
