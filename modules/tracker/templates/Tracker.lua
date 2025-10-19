---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerTemplate : Frame
---@field scrollBox ScrollBoxMixin
---@field scrollBar ScrollBarMixin
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin
---@field header MapPinEnhancedTrackerHeaderTemplate
---@field activeView 'set' | 'pin'
MapPinEnhancedTrackerMixin = {
    activeView = "pin", -- Default view is pin
}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Sets = MapPinEnhanced:GetModule("Sets")

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate

function MapPinEnhancedTrackerMixin:UpdateSetList()
    ---@param set MapPinEnhancedPinSetMixin
    for set in Sets:EnumerateSets() do
        self.dataProvider:Insert(set) --[[@as TreeNodeMixin]]
    end
end

function MapPinEnhancedTrackerMixin:UpdatePinList()
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
end

function MapPinEnhancedTrackerMixin:UpdateList()
    self.dataProvider:Flush()
    if self.activeView == "set" then
        self:UpdateSetList()
    else
        self:UpdatePinList()
    end
end

---@param group MapPinEnhancedPinGroupMixin
---@return TreeNodeMixin?
function MapPinEnhancedTrackerMixin:AddGroup(group)
    if self.activeView ~= "pin" then
        return nil -- Cannot add groups in set view
    end
    return self.dataProvider:Insert(group)
end

function MapPinEnhancedTrackerMixin:RemoveGroup(groupTreeNode)
    if self.activeView ~= "pin" then
        return -- Cannot remove groups in set view
    end
    self.dataProvider:Remove(groupTreeNode)
end

-- Maximum number of entries to display
local MAX_ENTRIES = 6
function MapPinEnhancedTrackerMixin:UpdateHeight()
    -- TODO: update height also when elements get collapsed
    local trackerHeight = self.header:GetHeight() + 5 -- header plus padding
    local numberOfEntries = self.dataProvider:GetSize(false)
    local visibleEntries = math.min(numberOfEntries, MAX_ENTRIES)
    local newHeight = visibleEntries * 35 -- Assuming each entry takes up 33 pixels in height
    newHeight = newHeight + trackerHeight -- Add the height of the header
    self:SetHeight(newHeight)
end

function MapPinEnhancedTrackerMixin:OnLoad()
    self.scrollBar:SetHideIfUnscrollable(true)
    self.dataProvider = CreateTreeDataProvider()
    self.scrollView = CreateScrollBoxListTreeListView()


    self.scrollView:SetElementFactory(function(factory, node)
        ---@type MapPinEnhancedPinGroupMixin | MapPinEnhancedPinMixin | MapPinEnhancedPinSetMixin
        local data = node:GetData()
        factory(data.trackerEntry.template, function(frame)
            frame:Init(node)
        end)
    end)

    self.scrollView:SetDataProvider(self.dataProvider)
    self.scrollBar:SetInterpolateScroll(true);
    self.scrollBox:SetInterpolateScroll(true);
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.dataProvider:RegisterCallback(DataProviderMixin.Event.OnSizeChanged, self.UpdateHeight, self);
end

function MapPinEnhancedTrackerMixin:SetPosition(x, y)
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
    MapPinEnhanced:SetVar("trackerPosition", { x = x, y = y })
end

function MapPinEnhancedTrackerMixin:GetActiveView()
    return self.activeView
end

function MapPinEnhancedTrackerMixin:ToggleActiveView()
    if self.activeView == "set" then
        self.activeView = "pin"
    else
        self.activeView = "set"
    end
    self:UpdateList()
    self:UpdateHeight()
end

function MapPinEnhancedTrackerMixin:OnShow()
    self:UpdateList()
end
