---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsCategoryTemplate
---@field treeNode TreeNodeMixin
---@field expandButton MapPinEnhancedTrackerGroupEntryExpandButton
---@field title FontString
MapPinEnhancedOptionsCategoryMixin = {}


---@class MapPinEnhancedOptionsCategoryExpandButton : Button
---@field normalTexture Texture
---@field highlightTexture Texture
---@field expand AnimationGroup
---@field collapse AnimationGroup

function MapPinEnhancedOptionsCategoryMixin:UpdateCollapseButton()
    self.expandButton.expand:Stop()
    self.expandButton.collapse:Stop()
    if self.treeNode:IsCollapsed() then
        self.expandButton.collapse:Play()
    else
        self.expandButton.expand:Play()
    end
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedOptionsCategoryMixin:Init(treeNode)
    self.treeNode = treeNode
    local data = treeNode:GetData() --[[@as MapPinEnhancedOptionCategoryMixin]]
    self:UpdateCollapseButton()
    self.title:SetText(data:GetName())
end

function MapPinEnhancedOptionsCategoryMixin:Reset()
    self.treeNode = nil
end

function MapPinEnhancedOptionsCategoryMixin:OnMouseDown()
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedOptionsCategoryMixin")
    self.treeNode:ToggleCollapsed()
    self:UpdateCollapseButton()
end

function MapPinEnhancedOptionsCategoryMixin:OnEnter()
    self.expandButton:LockHighlight()
end

function MapPinEnhancedOptionsCategoryMixin:OnLeave()
    self.expandButton:UnlockHighlight()
end
