---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerCollectionEntryTemplate : Button
---@field collection MapPinEnhancedCollectionMixin
---@field title FontString
MapPinEnhancedTrackerCollectionEntryMixin = {}

local Tracker = MapPinEnhanced:GetModule("Tracker")

function MapPinEnhancedTrackerCollectionEntryMixin:Reset()
    self.collection = nil
end

function MapPinEnhancedTrackerCollectionEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedCollectionMixin
    local collection = treeNode:GetData()
    self.collection = collection
    self.title:SetText(collection.name)
end

function MapPinEnhancedTrackerCollectionEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerCollectionEntryMixin:OnMouseDown(button)
    assert(self.collection, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if button == "LeftButton" then
        self.collection:LoadCollection()
        Tracker:ToggleActiveView()
    end
end

MapPinEnhancedTrackerSetEntryMixin = MapPinEnhancedTrackerCollectionEntryMixin
