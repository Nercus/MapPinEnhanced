---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate
---@field template string
---@field treeNode TreeNodeMixin
MapPinEnhancedTrackerGroupEntryMixin = {}


---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:Init(treeNode)
    self:SetTreeNode(treeNode)
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:SetTreeNode(treeNode)
    self.treeNode = treeNode
end

function MapPinEnhancedTrackerGroupEntryMixin:OnMouseDown()
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    self.treeNode:ToggleCollapsed()
end
