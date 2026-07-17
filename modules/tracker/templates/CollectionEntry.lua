---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerCollectionEntryTemplate : Button
---@field collection MapPinEnhancedCollectionMixin
---@field title FontString
---@field background Texture
MapPinEnhancedTrackerCollectionEntryMixin = {}

local Tracker = MapPinEnhanced:GetModule("Tracker")
local Collections = MapPinEnhanced:GetModule("Collections")
local COLLECTION_COLORS_BY_NAME = Collections.COLLECTION_COLORS_BY_NAME
local Transfer = MapPinEnhanced:GetModule("Transfer")

function MapPinEnhancedTrackerCollectionEntryMixin:Reset()
    self.collection = nil
end

---@param color CollectionColor
function MapPinEnhancedTrackerCollectionEntryMixin:SetColor(color)
    local colorValue = COLLECTION_COLORS_BY_NAME[color] or COLLECTION_COLORS_BY_NAME[Collections.DEFAULT_COLOR]
    local r, g, b = colorValue:GetRGB()
    self.background:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0.8), CreateColor(r, g, b, 0.18))
end

function MapPinEnhancedTrackerCollectionEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedCollectionMixin
    local collection = treeNode:GetData()
    self.collection = collection
    self.title:SetText(collection.name)
    self:SetColor(collection.color)
end

function MapPinEnhancedTrackerCollectionEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerCollectionEntryMixin:OnMouseDown(button)
    assert(self.collection, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if button == "LeftButton" then
        self.collection:LoadCollection()
        Tracker:ToggleActiveView()
    elseif button == "RightButton" then
        MapPinEnhanced:GenerateMenu(self, {{
            type = "button", label = MapPinEnhanced.L["Export"],
            onClick = function() Transfer:ShowExportWindow(self.collection) end,
        }})
    end
end
