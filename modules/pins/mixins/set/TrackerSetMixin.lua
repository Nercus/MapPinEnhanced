---@class MapPinEnhancedTrackerSetMixin
---@field trackerEntry MapPinEnhancedTrackerSetEntryTemplate
---@field treeNode TreeNodeMixin
---@field template string the template used for the tracker entry
MapPinEnhancedTrackerSetMixin = {
    template = "MapPinEnhancedTrackerSetEntryTemplate",
}


function MapPinEnhancedTrackerSetMixin:SetFrame(frame)
    self.trackerEntry = frame
end

function MapPinEnhancedTrackerSetMixin:GetFrame()
    return self.trackerEntry
end

function MapPinEnhancedTrackerSetMixin:SetTreeNode(treeNode)
    self.treeNode = treeNode
end

function MapPinEnhancedTrackerSetMixin:GetTreeNode()
    return self.treeNode
end
