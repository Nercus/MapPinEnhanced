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


function MapPinEnhancedTrackerMixin:UpdateSetList()
    ---@param set MapPinEnhancedSetMixin
    for set in Sets:EnumerateSets() do
        self.dataProvider:Insert(set) --[[@as TreeNodeMixin]]
    end
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

---@param group MapPinEnhancedGroupMixin
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
    end
    groupNode:Insert(pin)
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



---@param el1 TreeNodeMixin
---@param el2 TreeNodeMixin
---@return boolean
function MapPinEnhancedTrackerMixin:SortComparator(el1, el2)
    local data1 = el1:GetData()
    local data2 = el2:GetData()

    if self.activeView == "set" then
        --[[@cast data1 MapPinEnhancedSetMixin]]
        --[[@cast data2 MapPinEnhancedSetMixin]]
        return data1.name < data2.name
    elseif self.activeView == "pin" then
        -- Compare by order - HIGHER values first (newer at top)
        local order1 = data1.order or 0
        local order2 = data2.order or 0

        if order1 ~= order2 then
            return order1 > order2
        end

        -- when orders are the same, sort by name - groups first, then pins
        if data1.classification == "group" and data2.classification == "group" then
            return (data1.name or "") < (data2.name or "")
        elseif data1.classification == "pin" and data2.classification == "pin" then
            local title1 = data1.title or data1.pinID or ""
            local title2 = data2.title or data2.pinID or ""
            return title1 < title2
        end
    end

    return false
end

function MapPinEnhancedTrackerMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "tracker", self.header, function()
        return MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    end)
    self.scrollBar:SetHideIfUnscrollable(true)
    self.dataProvider = CreateTreeDataProvider()
    self.scrollView = CreateScrollBoxListTreeListView()

    self.dataProvider:SetSortComparator(function(...)
        return self:SortComparator(...)
    end)

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
