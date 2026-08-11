---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollBox : Frame, ScrollBoxListMixin

---@class MapPinEnhancedTrackerScrollBar : ScrollBarMixin
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedTrackerTemplate : Frame
---@field scrollBox MapPinEnhancedTrackerScrollBox
---@field scrollBar MapPinEnhancedTrackerScrollBar
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin
---@field header MapPinEnhancedTrackerHeaderTemplate
MapPinEnhancedTrackerMixin = {}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local L = MapPinEnhanced.L

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate

---@alias EntryTemplateString 'MapPinEnhancedTrackerGroupEntryTemplate' | 'MapPinEnhancedTrackerPinEntryTemplate'

---@param group MapPinEnhancedGroupMixin
---@param pin1 MapPinEnhancedPinMixin
---@param pin2 MapPinEnhancedPinMixin
---@return boolean
local function IsPinBefore(group, pin1, pin2)
    local order1 = group:GetPinOrder(pin1.pinID)
    local order2 = group:GetPinOrder(pin2.pinID)

    if order1 ~= order2 then
        return order1 > order2
    end

    local title1 = pin1.pinData.title or pin1.pinID or ""
    local title2 = pin2.pinData.title or pin2.pinID or ""
    if title1 ~= title2 then
        return title1 < title2
    end

    return (pin1.pinID or "") < (pin2.pinID or "")
end

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

---@param pinNode1 TreeNodeMixin
---@param pinNode2 TreeNodeMixin
---@return boolean
local function PinSortComparator(pinNode1, pinNode2)
    ---@type MapPinEnhancedPinMixin, MapPinEnhancedPinMixin
    local pin1, pin2 = pinNode1:GetData(), pinNode2:GetData()

    if pin1.classification ~= "pin" or pin2.classification ~= "pin" then
        return false
    end

    local group1 = pin1.group
    local group2 = pin2.group
    if group1 and group1 == group2 then
        return IsPinBefore(group1, pin1, pin2)
    end

    return false
end

---@param group MapPinEnhancedGroupMixin
function MapPinEnhancedTrackerMixin:RefreshGroupEntry(group)
    self.scrollBox:ForEachFrame(function(frame)
        ---@cast frame MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate
        if frame.group and frame.group:GetGroupID() == group:GetGroupID() then
            frame:UpdateTitle()
        end
    end)
end

function MapPinEnhancedTrackerMixin:UpdatePinList()
    ---@param group MapPinEnhancedGroupMixin
    for group in Groups:EnumerateGroups() do
        local totalPins = group:GetTotalPinCount()
        if not group:IsHidden() and totalPins > 0 then
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
    self:UpdatePinList()
end

function MapPinEnhancedTrackerMixin:UpdateListAndScrollToTrackedPin()
    if not self:IsShown() then return end

    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
    self:ScrollToTrackedPin()
end

---@param group MapPinEnhancedGroupMixin
---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerMixin:AddPinToGroup(group, pin)
    if not self:IsShown() then return end
    if group:IsHidden() then return end

    ---@type TreeNodeMixin?
    local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
        ---@type MapPinEnhancedGroupMixin
        local nodeData = node:GetData()
        return nodeData.classification == "group" and nodeData:GetGroupID() == group:GetGroupID()
    end, TreeDataProviderConstants.IncludeCollapsed)
    if not groupNode then
        groupNode = self.dataProvider:Insert(group)
        groupNode:SetSortComparator(PinSortComparator, false, false)
    end
    groupNode:Insert(pin)
    groupNode:Sort()
    groupNode:Invalidate()
    self:RefreshGroupEntry(group)
    self:UpdateTrackerHeader()
end

---@param group MapPinEnhancedGroupMixin
---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerMixin:RemovePinFromGroup(group, pin)
    if not self:IsShown() then return end

    ---@type TreeNodeMixin?
    local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
        ---@type MapPinEnhancedGroupMixin
        local nodeData = node:GetData()
        return nodeData.classification == "group" and nodeData:GetGroupID() == group:GetGroupID()
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

    if group:GetTotalPinCount() == 0 then
        self.dataProvider:Remove(groupNode)
    else
        self:UpdateList()
    end
end

function MapPinEnhancedTrackerMixin:ScrollToTrackedPin()
    if not self:IsShown() then return end

    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end

    local trackedGroup = trackedPin.group
    if trackedGroup then
        ---@type TreeNode?
        local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
            ---@type MapPinEnhancedGroupMixin
            local nodeData = node:GetData()
            return nodeData.classification == "group" and nodeData:GetGroupID() == trackedGroup:GetGroupID()
        end, TreeDataProviderConstants.IncludeCollapsed)
        if groupNode then
            groupNode:SetCollapsed(false)
        end
    end

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
    local entryHeight = 35
    local searchHeight = 0
    local numberOfEntries = self.dataProvider:GetSize(false)
    local visibleEntries = math.min(numberOfEntries, MAX_ENTRIES)
    local newHeight = visibleEntries * entryHeight
    local oldHeight = self:GetHeight()
    newHeight = newHeight + headerHeight + searchHeight

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

---@param factory fun(template: EntryTemplateString, initFunc: fun(frame: any))
---@param node TreeNodeMixin
local function TrackerElementFactory(factory, node)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
    local data = node:GetData()

    if data.classification == "group" then
        factory("MapPinEnhancedTrackerGroupEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedTrackerGroupEntryTemplate
            frame:Init(node)
        end)
    elseif data.classification == "pin" then
        factory("MapPinEnhancedTrackerPinEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedTrackerPinEntryTemplate
            frame:Init(node)
        end)
    end
end

---@param frame MapPinEnhancedTrackerPinEntryTemplate | MapPinEnhancedTrackerGroupEntryTemplate
---@param node TreeNodeMixin
local function TrackerElementResetter(frame, node)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
    local data = node:GetData()
    if data.classification == "group" then
        ---@cast frame MapPinEnhancedTrackerGroupEntryTemplate
        frame:Reset()
    elseif data.classification == "pin" then
        ---@cast frame MapPinEnhancedTrackerPinEntryTemplate
        ---@cast data MapPinEnhancedPinMixin
        frame:Reset(data.pinID)
    end
end

function MapPinEnhancedTrackerMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "tracker", self.header, function()
        return MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    end)
    self.scrollBar:SetHideIfUnscrollable(false)
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
        ---@cast group MapPinEnhancedGroupMixin
        ---@cast pin MapPinEnhancedPinMixin
        self:AddPinToGroup(group, pin)
        self:ScrollToTrackedPin()
    end)

    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function(_, group, pin)
        ---@cast group MapPinEnhancedGroupMixin
        ---@cast pin MapPinEnhancedPinMixin
        self:RemovePinFromGroup(group, pin)
        self:ScrollToTrackedPin()
    end)

    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)

    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", function(_, _, isTracked)
        if not isTracked then return end
        self:ScrollToTrackedPin()
    end)
end

function MapPinEnhancedTrackerMixin:OnShow()
    self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
end

function MapPinEnhancedTrackerMixin:OnHide()
    self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
end

function MapPinEnhancedTrackerMixin:OnUpdate()
    if self:IsMouseOver() and self.scrollBar:HasScrollableExtent() and self.scrollBar:IsScrollAllowed() then
        self.scrollBar.fadeIn:PlayShowing(self.scrollBar.fadeOut)
    else
        self.scrollBar.fadeOut:PlayHiding(self.scrollBar.fadeIn)
    end
end

function MapPinEnhancedTrackerMixin:UpdateTrackerHeader()
    local reachedPins = 0
    local totalPins = 0

    ---@param node TreeNodeMixin
    for _, node in self.dataProvider:EnumerateEntireRange() do
        ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
        local data = node:GetData()
        if data.classification == "group" then
            reachedPins = reachedPins + data:GetReachedPinCount()
            totalPins = totalPins + data:GetTotalPinCount()
        end
    end

    self.header:SetTitle(string.format(L["Pins (%d/%d)"], reachedPins, totalPins))
    self.header:SetIcon("pin")
    self.header.hiddenGroupsButton:SetIconTexture("tick")
end

function MapPinEnhancedTrackerMixin:UpdateViewLayout()
    self.scrollBox:ClearAllPoints()
    self.scrollBox:SetPoint("TOPLEFT", self.header, "BOTTOMLEFT", 5, 0)
    self.scrollBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5)
end

function MapPinEnhancedTrackerMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self:UpdateViewLayout()
    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
    self:Show()
    self:ScrollToTrackedPin()
end

function MapPinEnhancedTrackerMixin:HideFrame()
    self:Hide()
end
