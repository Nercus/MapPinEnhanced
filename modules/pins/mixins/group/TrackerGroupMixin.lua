---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupMixin
---@field trackerEntry MapPinEnhancedTrackerGroupEntryTemplate
---@field treeNode TreeNodeMixin
---@field template string the template used for the tracker entry
MapPinEnhancedTrackerGroupMixin = {
    template = "MapPinEnhancedTrackerGroupEntryTemplate"
}

local Tracker = MapPinEnhanced:GetModule("Tracker")

function MapPinEnhancedTrackerGroupMixin:Reset()
    self:SetFrame(nil)
    self:SetTreeNode(nil)
end

function MapPinEnhancedTrackerGroupMixin:SetFrame(frame)
    self.trackerEntry = frame
end

function MapPinEnhancedTrackerGroupMixin:GetFrame()
    return self.trackerEntry
end

function MapPinEnhancedTrackerGroupMixin:SetTreeNode(treeNode)
    self.treeNode = treeNode
end

function MapPinEnhancedTrackerGroupMixin:GetTreeNode()
    return self.treeNode
end

---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerGroupMixin:AddPin(pin)
    if Tracker:GetActiveView() ~= "pin" then
        return
    end

    local treeNode = self:GetTreeNode()
    if not treeNode then
        return
    end
    local pinTreeNode = treeNode:Insert(pin)
    pin.trackerEntry:SetTreeNode(pinTreeNode)
end

---@param pinTrackerEntry MapPinEnhancedTrackerPinMixin
function MapPinEnhancedTrackerGroupMixin:RemovePin(pinTrackerEntry)
    local treeNode = self:GetTreeNode()
    if not treeNode then return end
    local pinNode = pinTrackerEntry:GetTreeNode() --[[@as TreeNodeMixin]]
    treeNode:Remove(pinNode, false)
end
