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
    ---@param group MapPinEnhancedPinGroupMixin
    for group in Groups:EnumerateGroups() do
        local groupElement = self.dataProvider:Insert(group) --[[@as TreeNodeMixin]]
        for _, pin in group:EnumeratePins() do
            groupElement:Insert(pin)
        end
    end
end

function MapPinEnhancedTrackerMixin:OnLoad()
    self.dataProvider = CreateTreeDataProvider()
    self.scrollView = CreateScrollBoxListTreeListView()
    self.scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.scrollView:SetElementFactory(function(factory, node)
        ---@type EntryTemplate
        local data = node:GetData()
        local template = data.template
        factory(template, function(frame)
            frame:Init(node, data)
        end)
    end)
end

function MapPinEnhancedTrackerMixin:OnShow()
    self:UpdateList()
end
