---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerSetEntryTemplate
---@field treeNode TreeNodeMixin
---@field set MapPinEnhancedPinSetMixin
MapPinEnhancedTrackerSetEntryMixin = {}


function MapPinEnhancedTrackerSetEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedPinSetMixin
    local set = treeNode:GetData()
    self.set = set
    set.trackerEntry:SetFrame(self)

    self.treeNode = treeNode
    set.trackerEntry:SetTreeNode(self.treeNode)
end

function MapPinEnhancedTrackerSetEntryMixin:OnMouseDown()
    assert(self.set, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    self.set:LoadSet()
end
