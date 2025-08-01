---@class MapPinEnhancedOptionsSidebarEntryTemplate : Button
---@field treeNode TreeNodeMixin
MapPinEnhancedOptionsSidebarEntryMixin = {};


---@class SidebarEntryData
---@field label string Displayed name of the entry most likely localized
---@field value string Internal value used to identify the entry
---@field isCategory boolean If true, the entry is a category, otherwise it is an option


---@param treeNode TreeNodeMixin
function MapPinEnhancedOptionsSidebarEntryMixin:Init(treeNode)
    ---@type SidebarEntryData
    local data = treeNode:GetData()
    self.treeNode = treeNode
    self:SetText(data.label)
    self.value = data.value
    self.isCategory = data.isCategory
end

function MapPinEnhancedOptionsSidebarEntryMixin:OnClick()
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if self.isCategory then
        self.treeNode:ToggleCollapsed()
    else
        -- TODO: scroll to the option here
    end
end
