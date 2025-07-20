---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerTemplate : Frame
---@field scrollBox Frame
---@field scrollBar Frame
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin
MapPinEnhancedTrackerMixin = {}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate

function MapPinEnhancedTrackerMixin:UpdateList()
    self.dataProvider:Flush()
    ---@param group MapPinEnhancedPinGroupMixin
    for group in Groups:EnumerateGroups() do
        local numPins = group:GetPinCount()
        if numPins > 0 then -- only add groups with pins
            local groupElement = self.dataProvider:Insert(group) --[[@as TreeNodeMixin]]
            for _, pin in group:EnumeratePins() do
                groupElement:Insert(pin)
            end
        end
    end
    self:UpdateHeight()
end

local MAX_HEIGHT = 500 -- Maximum height of the tracker frame
function MapPinEnhancedTrackerMixin:UpdateHeight()
    local numberOfEntries = self.dataProvider:GetSize(false)
    local newHeight = numberOfEntries * 47 -- Assuming each entry takes up 30 pixels in height
    self.scrollBox:SetHeight(math.min(newHeight, MAX_HEIGHT))
end

function MapPinEnhancedTrackerMixin:OnLoad()
    self.dataProvider = CreateTreeDataProvider()
    self.scrollView = CreateScrollBoxListTreeListView()
    self.scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)


    self.scrollView:SetElementFactory(function(factory, node)
        ---@type MapPinEnhancedPinGroupMixin | MapPinEnhancedPinMixin
        local data = node:GetData()
        factory(data.trackerTemplate, function(frame)
            frame:Init(node)
        end)
    end)
end

function MapPinEnhancedTrackerMixin:SetPosition(x, y)
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
    MapPinEnhanced:SetVar("trackerPosition", { x = x, y = y })
end

function MapPinEnhancedTrackerMixin:OnShow()
    self:UpdateList()
end
