---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerTemplate : Frame
---@field scrollBox ScrollBoxListMixin
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
local Pins = MapPinEnhanced:GetModule("Pins")

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate | MapPinEnhancedTrackerSetEntryTemplate

---@alias EntryTemplateString 'MapPinEnhancedTrackerGroupEntryTemplate' | 'MapPinEnhancedTrackerPinEntryTemplate' | 'MapPinEnhancedTrackerSetEntryTemplate'

---@param groupnode1 TreeNodeMixin
---@param groupnode2 TreeNodeMixin
---@return boolean
local function GroupSortComparator(groupnode1, groupnode2)
    ---@type MapPinEnhancedGroupMixin, MapPinEnhancedGroupMixin
    local group1, group2 = groupnode1:GetData(), groupnode2:GetData()

    if group1.classification ~= "group" or group2.classification ~= "group" then
        return false
    end
    local order1 = group1.order or 0
    local order2 = group2.order or 0

    if order1 ~= order2 then
        return order1 > order2
    end
    return (group1.name or "") < (group2.name or "")
end

---@param setNode1 TreeNodeMixin
---@param setNode2 TreeNodeMixin
---@return boolean
local function SetSortComparator(setNode1, setNode2)
    ---@type MapPinEnhancedSetMixin, MapPinEnhancedSetMixin
    local set1, set2 = setNode1:GetData(), setNode2:GetData()

    if set1.classification ~= "set" or set2.classification ~= "set" then
        return false
    end
    return (set1.name or "") < (set2.name or "")
end

local function PinSortComparator(pinNode1, pinNode2)
    ---@type MapPinEnhancedPinMixin, MapPinEnhancedPinMixin
    local pin1, pin2 = pinNode1:GetData(), pinNode2:GetData()

    if pin1.classification ~= "pin" or pin2.classification ~= "pin" then
        return false
    end

    local order1 = pin1.pinData.order or 0
    local order2 = pin2.pinData.order or 0

    if order1 ~= order2 then
        return order1 > order2
    end

    local title1 = pin1.pinData.title or pin1.pinID or ""
    local title2 = pin2.pinData.title or pin2.pinID or ""
    return title1 < title2
end

function MapPinEnhancedTrackerMixin:UpdateSetList()
    ---@param set MapPinEnhancedSetMixin
    for set in Sets:EnumerateSets() do
        self.dataProvider:Insert(set) --[[@as TreeNodeMixin]]
    end
    self.dataProvider:SetSortComparator(SetSortComparator, false, false)
end

function MapPinEnhancedTrackerMixin:UpdatePinList()
    ---@param group MapPinEnhancedGroupMixin
    for group in Groups:EnumerateGroups() do
        local numPins = group:GetPinCount()
        if numPins > 0 then -- only add groups with pins
            local groupElement = self.dataProvider:Insert(group) --[[@as TreeNodeMixin]]
            for _, pin in group:EnumeratePins() do
                groupElement:Insert(pin)
            end
            groupElement:SetSortComparator(PinSortComparator, false, false)
        end
    end
    self.dataProvider:SetSortComparator(GroupSortComparator, false, false)
end

function MapPinEnhancedTrackerMixin:UpdateList()
    self.dataProvider:Flush()
    if self.activeView == "set" then
        self:UpdateSetList()
    else
        self:UpdatePinList()
    end
end

---@param group MapPinEnhancedGroupMixin
---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerMixin:AddPinToGroup(group, pin)
    if self.activeView ~= "pin" or not self:IsShown() then return end

    ---@type TreeNodeMixin?
    local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
        ---@type MapPinEnhancedGroupMixin
        local nodeData = node:GetData()
        return nodeData.classification == "group" and nodeData.name == group.name
    end, TreeDataProviderConstants.IncludeCollapsed)
    if not groupNode then
        groupNode = self.dataProvider:Insert(group)
        groupNode:SetSortComparator(PinSortComparator, false, false)
    end
    groupNode:Insert(pin)
    groupNode:Invalidate() -- we invalidate here to trigger a resort
end

function MapPinEnhancedTrackerMixin:RemovePinFromGroup(group, pin)
    if self.activeView ~= "pin" or not self:IsShown() then return end

    ---@type TreeNodeMixin?
    local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
        ---@type MapPinEnhancedGroupMixin
        local nodeData = node:GetData()
        return nodeData.classification == "group" and nodeData.name == group.name
    end, TreeDataProviderConstants.IncludeCollapsed)
    if not groupNode then return end

    ---@type TreeNodeMixin?
    local pinNode = self.dataProvider:FindElementDataByPredicate(function(node)
        ---@type MapPinEnhancedPinMixin
        local nodeData = node:GetData()
        return nodeData.classification == "pin" and nodeData.pinID == pin.pinID
    end, TreeDataProviderConstants.IncludeCollapsed)
    if not pinNode then return end

    groupNode:Remove(pinNode)

    -- if the group has no more pins, remove the group as well
    if groupNode:GetSize() == 0 then
        self.dataProvider:Remove(groupNode)
    end
end

function MapPinEnhancedTrackerMixin:ScrollToTrackedPin()
    if self.activeView ~= "pin" or not self:IsShown() then return end

    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end

    self.scrollBox:ScrollToElementDataByPredicate(function(node)
        ---@type MapPinEnhancedPinMixin
        local nodeData = node:GetData()
        return nodeData.classification == "pin" and nodeData.pinID == trackedPin.pinID
    end, TreeDataProviderConstants.IncludeCollapsed)
end

-- Maximum number of entries to display
local MAX_ENTRIES = 7
function MapPinEnhancedTrackerMixin:UpdateHeight()
    local headerHeight = self.header:GetHeight() + 5 -- header plus padding
    local numberOfEntries = self.dataProvider:GetSize(false)
    local visibleEntries = math.min(numberOfEntries, MAX_ENTRIES)
    local newHeight = visibleEntries * 35 -- Assuming each entry takes up 35 pixels in height
    local oldHeight = self:GetHeight()
    newHeight = newHeight + headerHeight  -- Add the height of the header

    local currentPoint, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
    if not currentPoint or not relativeTo or not relativePoint or not xOfs or not yOfs then
        self:SetHeight(newHeight)
        return
    end

    self:SetHeight(newHeight)

    local heightDelta = newHeight - oldHeight
    local yOffset = 0

    if string.find(currentPoint:upper(), "TOP") then
        yOffset = 0
    elseif string.find(currentPoint:upper(), "BOTTOM") then
        yOffset = heightDelta
    else
        yOffset = heightDelta / 2
    end

    self:ClearAllPoints()
    self:SetPoint(currentPoint, relativeTo, relativePoint, xOfs, yOfs - yOffset)
    self:UpdateTrackerHeader()
end

---@param factory fun(template: EntryTemplateString, initFunc: fun(frame: EntryTemplate))
---@param node TreeNode
local function TrackerElementFactory(factory, node)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin | MapPinEnhancedSetMixin
    local data = node:GetData()

    if data.classification == "group" then
        factory("MapPinEnhancedTrackerGroupEntryTemplate", function(frame)
            frame:Init(node)
        end)
    elseif data.classification == "pin" then
        factory("MapPinEnhancedTrackerPinEntryTemplate", function(frame)
            frame:Init(node)
        end)
    elseif data.classification == "set" then
        factory("MapPinEnhancedTrackerSetEntryTemplate", function(frame)
            frame:Init(node)
        end)
    end
end

---@param frame MapPinEnhancedTrackerPinEntryTemplate | MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerSetEntryTemplate
---@param data TreeNodeMixin
local function TrackerElementResetter(frame, data)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin | MapPinEnhancedSetMixin
    local data = data:GetData()
    if data.classification == "group" then
        frame:Reset()
    elseif data.classification == "pin" then
        frame:Reset(data.pinID)
    elseif data.classification == "set" then
        frame:Reset()
    end
end



function MapPinEnhancedTrackerMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "tracker", self.header, function()
        return MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    end)
    self.scrollBar:SetHideIfUnscrollable(true)
    self.dataProvider = CreateTreeDataProvider()
    self.scrollView = CreateScrollBoxListTreeListView()

    self.scrollView:SetElementFactory(TrackerElementFactory)
    self.scrollView:SetElementResetter(TrackerElementResetter)
    self.scrollView:SetDataProvider(self.dataProvider)

    self.scrollBar:SetInterpolateScroll(true);
    self.scrollBox:SetInterpolateScroll(true);

    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.dataProvider:RegisterCallback(DataProviderMixin.Event.OnSizeChanged, self.UpdateHeight, self);

    MapPinEnhanced:RegisterCallback("PIN_ADDED", function(_, group, pin)
        self:AddPinToGroup(group, pin)
    end)

    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function(_, group, pin)
        self:RemovePinFromGroup(group, pin)
    end)

    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function()
        if self.activeView ~= "pin" or not self:IsShown() then return end
        self:UpdateList()
        self:UpdateHeight()
    end)
end

function MapPinEnhancedTrackerMixin:GetActiveView()
    return self.activeView
end

function MapPinEnhancedTrackerMixin:UpdateTrackerHeader()
    if self.activeView == "set" then
        local numSets = self.dataProvider:GetSize(false)
        self.header:SetTitle(string.format("Sets (%d)", numSets))
        self.header:SetIcon("set")
    else
        local totalElements = self.dataProvider:GetSize(false)
        local numGroups = 0

        ---@param node TreeNodeMixin
        for _, node in self.dataProvider:EnumerateEntireRange() do
            ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
            local data = node:GetData()
            if data.classification == "group" then
                numGroups = numGroups + 1
            end
        end

        local numPins = totalElements - numGroups
        self.header:SetTitle(string.format("Pins (%d)", numPins))
        self.header:SetIcon("pin")
    end
end

function MapPinEnhancedTrackerMixin:ToggleActiveView()
    if self.activeView == "set" then
        self.activeView = "pin"
    else
        self.activeView = "set"
    end
    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
end

function MapPinEnhancedTrackerMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
    self:ScrollToTrackedPin()
    self:Show()
end

function MapPinEnhancedTrackerMixin:HideFrame()
    self:Hide()
end
