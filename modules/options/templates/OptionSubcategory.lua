---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsSubgroupTemplate : Frame
---@field title FontString
MapPinEnhancedOptionsSubgroupMixin = {}

---@param node TreeNodeMixin
function MapPinEnhancedOptionsSubgroupMixin:Init(node)
    local data = node:GetData() --[[@as MapPinEnhancedOptionSubgroupMixin]]
    local subgroupName = data:GetName()
    self.title:SetText(subgroupName)
end

function MapPinEnhancedOptionsSubgroupMixin:Reset()
    self.title:SetText("")
end
