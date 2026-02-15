---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate : Button
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedGroupMixin
---@field expandButton MapPinEnhancedTrackerGroupEntryExpandButton
---@field title FontString
MapPinEnhancedTrackerGroupEntryMixin = {}

---@class MapPinEnhancedTrackerGroupEntryExpandButton : Button
---@field normalTexture Texture
---@field highlightTexture Texture
---@field expandedTexture string
---@field collapsedTexture string

function MapPinEnhancedTrackerGroupEntryMixin:UpdateCollapseButton()
    if self.treeNode:IsCollapsed() then
        self.expandButton:GetNormalTexture():SetAtlas(self.expandButton.collapsedTexture)
    else
        self.expandButton:GetNormalTexture():SetAtlas(self.expandButton.expandedTexture)
    end
end

function MapPinEnhancedTrackerGroupEntryMixin:Reset()
    self:UpdateCollapseButton()
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:Init(treeNode)
    local group = treeNode:GetData()
    self.group = group
    self.treeNode = treeNode
    self:SetTitle(group:GetName())
    self:UpdateCollapseButton()
end

function MapPinEnhancedTrackerGroupEntryMixin:SetTitle(title)
    self.title:SetText(string.upper(title))
end

function MapPinEnhancedTrackerGroupEntryMixin:OnMouseDown(button)
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if button == "LeftButton" then
        self.treeNode:ToggleCollapsed()
        self:UpdateCollapseButton()
    end
end

function MapPinEnhancedTrackerGroupEntryMixin:OnEnter()
    self.expandButton:LockHighlight()
end

function MapPinEnhancedTrackerGroupEntryMixin:OnLeave()
    self.expandButton:UnlockHighlight()
end
