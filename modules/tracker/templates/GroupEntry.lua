---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedPinGroupMixin
---@field expandButton Button
MapPinEnhancedTrackerGroupEntryMixin = {}

function MapPinEnhancedTrackerGroupEntryMixin:UpdateCollapseButton()
    if self.treeNode:IsCollapsed() then
        self.expandButton:SetNormalAtlas("QuestLog-icon-expand")
    else
        self.expandButton:SetNormalAtlas("QuestLog-icon-shrink")
    end
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:Init(treeNode)
    local group = treeNode:GetData()
    self.group = group
    group.trackerEntry:SetFrame(self)

    self.treeNode = treeNode
    group.trackerEntry:SetTreeNode(self.treeNode)
    self:UpdateCollapseButton()
end

function MapPinEnhancedTrackerGroupEntryMixin:OnMouseDown()
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    self.treeNode:ToggleCollapsed()
    self:UpdateCollapseButton()
end
