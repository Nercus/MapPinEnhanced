---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerSetEntryTemplate : Button
---@field treeNode TreeNodeMixin
---@field set MapPinEnhancedSetMixin
---@field title FontString
MapPinEnhancedTrackerSetEntryMixin = {}

local Tracker = MapPinEnhanced:GetModule("Tracker")


function MapPinEnhancedTrackerSetEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedSetMixin
    local set = treeNode:GetData()
    self.set = set
    self.treeNode = treeNode
    self.title:SetText(set.name)
end

function MapPinEnhancedTrackerSetEntryMixin:Reset()
    self.set = nil
    self.treeNode = nil
end

function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntryMixin:OnMouseDown(button)
    assert(self.set, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if button == "LeftButton" then
        self.set:LoadSet()
        Tracker:ToggleActiveView()
    end
end
