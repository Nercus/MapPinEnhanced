---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate
---@field template string
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedPinGroupMixin
MapPinEnhancedTrackerGroupEntryMixin = {}


---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:Init(treeNode)
    local group = treeNode:GetData()
    self.group = group
    group.trackerEntry:SetFrame(self)

    self.treeNode = treeNode
    group.trackerEntry:SetTreeNode(self.treeNode)
end

function MapPinEnhancedTrackerGroupEntryMixin:OnMouseDown()
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    self.treeNode:ToggleCollapsed()
end
