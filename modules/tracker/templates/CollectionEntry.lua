---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerCollectionEntryTemplate : Button
---@field collection MapPinEnhancedCollectionMixin
---@field title FontString
---@field background Texture
---@field pinCount FontString
MapPinEnhancedTrackerCollectionEntryMixin = {}

local Tracker = MapPinEnhanced:GetModule("Tracker")
local Transfer = MapPinEnhanced:GetModule("Transfer")

local L = MapPinEnhanced.L

function MapPinEnhancedTrackerCollectionEntryMixin:Reset()
    self.collection = nil
end

function MapPinEnhancedTrackerCollectionEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedCollectionMixin
    local collection = treeNode:GetData()
    self.collection = collection
    self:SetTitle(collection.name)
    self:SetPinCountText(string.format(L["%d |4pin:pins;"], collection:GetPinCount()))
end

function MapPinEnhancedTrackerCollectionEntryMixin:SetPinCountText(text)
    self.pinCount:SetText(text)
end

function MapPinEnhancedTrackerCollectionEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerCollectionEntryMixin:OnMouseDown(button)
    assert(self.collection, "TreeNode is not set for MapPinEnhancedTrackerCollectionEntryMixin")
    if button == "LeftButton" then
        self.collection:LoadCollection()
        Tracker:ToggleActiveView()
    elseif button == "RightButton" then
        MapPinEnhanced:GenerateMenu(self, { {
            type = "button",
            label = MapPinEnhanced.L["Export"],
            onClick = function() Transfer:ShowExportWindow(self.collection) end,
        } })
    end
end
