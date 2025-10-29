---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedPinGroupMixin
---@field expandButton MapPinEnhancedTrackerGroupEntryExpandButton
MapPinEnhancedTrackerGroupEntryMixin = {}


---@class MapPinEnhancedTrackerGroupEntryExpandButton : Button
---@field normalTexture Texture
---@field highlightTexture Texture
---@field expand AnimationGroup
---@field collapse AnimationGroup

function MapPinEnhancedTrackerGroupEntryMixin:UpdateCollapseButton()
    self.expandButton.expand:Stop()
    self.expandButton.collapse:Stop()
    if self.treeNode:IsCollapsed() then
        self.expandButton.collapse:Play()
    else
        self.expandButton.expand:Play()
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

function MapPinEnhancedTrackerGroupEntryMixin:OnEnter()
    self.expandButton:LockHighlight()
end

function MapPinEnhancedTrackerGroupEntryMixin:OnLeave()
    self.expandButton:UnlockHighlight()
end
