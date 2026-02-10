---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerSetEntryTemplate
---@field treeNode TreeNodeMixin
---@field set MapPinEnhancedSetMixin
MapPinEnhancedTrackerSetEntryMixin = {}


function MapPinEnhancedTrackerSetEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedSetMixin
    local set = treeNode:GetData()
    self.set = set
    self.treeNode = treeNode
end

function MapPinEnhancedTrackerSetEntryMixin:OnMouseDown()
    assert(self.set, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    self.set:LoadSet()
end
