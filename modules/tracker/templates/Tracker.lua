---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollBox : Frame, ScrollBoxListMixin

---@class MapPinEnhancedTrackerTemplate : Frame
---@field scrollBox MapPinEnhancedTrackerScrollBox
---@field scrollBar ScrollBarMixin
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin
---@field header MapPinEnhancedTrackerHeaderTemplate
---@field searchBox MapPinEnhancedInputTemplate
---@field activeView 'collection' | 'pin'
MapPinEnhancedTrackerMixin = {
    activeView = "pin", -- Default view is pin
}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Collections = MapPinEnhanced:GetModule("Collections")
local Pins = MapPinEnhanced:GetModule("Pins")

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate | MapPinEnhancedTrackerCollectionEntryTemplate

---@alias EntryTemplateString 'MapPinEnhancedTrackerGroupEntryTemplate' | 'MapPinEnhancedTrackerPinEntryTemplate' | 'MapPinEnhancedTrackerCollectionEntryTemplate'

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

---@param collectionNode1 TreeNodeMixin
---@param collectionNode2 TreeNodeMixin
---@return boolean
local function CollectionSortComparator(collectionNode1, collectionNode2)
    ---@type MapPinEnhancedCollectionMixin, MapPinEnhancedCollectionMixin
    local collection1, collection2 = collectionNode1:GetData(), collectionNode2:GetData()

    if collection1.classification ~= "collection" or collection2.classification ~= "collection" then
        return false
    end
    return (collection1.name or "") < (collection2.name or "")
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
    local order1 = group1 and group1:GetPinOrder(pin1.pinID) or 0
    local order2 = group2 and group2:GetPinOrder(pin2.pinID) or 0

    if order1 ~= order2 then
        return order1 > order2
    end

    local title1 = pin1.pinData.title or pin1.pinID or ""
    local title2 = pin2.pinData.title or pin2.pinID or ""
    return title1 < title2
end

function MapPinEnhancedTrackerMixin:UpdateCollectionList()
    local searchText = self.searchBox:GetText() or ""

    if searchText == "" then
        ---@param collection MapPinEnhancedCollectionMixin
        for collection in Collections:EnumerateCollections() do
            self.dataProvider:Insert(collection)
        end
        self.dataProvider:SetSortComparator(CollectionSortComparator, false, false)
        return
    end

    ---@type MapPinEnhancedCollectionMixin[]
    local collections = {}
    ---@type string[]
    local collectionNames = {}

    ---@param collection MapPinEnhancedCollectionMixin
    for collection in Collections:EnumerateCollections() do
        table.insert(collections, collection)
        table.insert(collectionNames, collection.name or "")
    end

    local results = MapPinEnhanced:Filter(searchText, collectionNames, false)
    for _, result in ipairs(results) do
        self.dataProvider:Insert(collections[result.i])
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
            groupElement:SetSortComparator(PinSortComparator, false, false)
        end
    end
    self.dataProvider:SetSortComparator(GroupSortComparator, false, false)
end

function MapPinEnhancedTrackerMixin:UpdateList()
    self.dataProvider:Flush()
    if self.activeView == "collection" then
        self:UpdateCollectionList()
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

---@param group MapPinEnhancedGroupMixin
---@param pin MapPinEnhancedPinMixin
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
    local entryHeight = self.activeView == "collection" and 73 or 35
    local searchHeight = self.activeView == "collection" and 28 or 0
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
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin | MapPinEnhancedCollectionMixin
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
    elseif data.classification == "collection" then
        factory("MapPinEnhancedTrackerCollectionEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedTrackerCollectionEntryTemplate
            frame:Init(node)
        end)
    end
end

---@param frame MapPinEnhancedTrackerPinEntryTemplate | MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerCollectionEntryTemplate
---@param node TreeNodeMixin
local function TrackerElementResetter(frame, node)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin | MapPinEnhancedCollectionMixin
    local data = node:GetData()
    if data.classification == "group" then
        ---@cast frame MapPinEnhancedTrackerGroupEntryTemplate
        frame:Reset()
    elseif data.classification == "pin" then
        ---@cast frame MapPinEnhancedTrackerPinEntryTemplate
        ---@cast data MapPinEnhancedPinMixin
        frame:Reset(data.pinID)
    elseif data.classification == "collection" then
        ---@cast frame MapPinEnhancedTrackerCollectionEntryTemplate
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

    self.searchBox:Setup({
        onChange = function()
            if self.activeView == "collection" then
                self:UpdateList()
                self:UpdateTrackerHeader()
            end
        end,
    })

    self.dataProvider:RegisterCallback(DataProviderMixin.Event.OnSizeChanged, self.UpdateHeight, self);

    MapPinEnhanced:RegisterCallback("PIN_ADDED", function(_, group, pin)
        ---@cast group MapPinEnhancedGroupMixin
        ---@cast pin MapPinEnhancedPinMixin
        self:AddPinToGroup(group, pin)
    end)

    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function(_, group, pin)
        ---@cast group MapPinEnhancedGroupMixin
        ---@cast pin MapPinEnhancedPinMixin
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
    if self.activeView == "collection" then
        local numCollections = self.dataProvider:GetSize(false)
        self.header:SetTitle(string.format("Collections (%d)", numCollections))
        self.header:SetIcon("collection")
        self.header.viewButton:SetIconTexture("pin")
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
        self.header.viewButton:SetIconTexture("collection")
    end
end

function MapPinEnhancedTrackerMixin:UpdateViewLayout()
    self.scrollBox:ClearAllPoints()
    if self.activeView == "collection" then
        self.searchBox:Show()
        self.scrollBox:SetPoint("TOPLEFT", self.searchBox, "BOTTOMLEFT", 0, -4)
    else
        self.searchBox:Hide()
        self.searchBox:ClearFocus()
        self.scrollBox:SetPoint("TOPLEFT", self.header, "BOTTOMLEFT", 5, 0)
    end
    self.scrollBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5)
end

function MapPinEnhancedTrackerMixin:ToggleActiveView()
    if self.activeView == "collection" then
        self.activeView = "pin"
    else
        self.activeView = "collection"
    end
    self:UpdateViewLayout()
    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
end

function MapPinEnhancedTrackerMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self:UpdateViewLayout()
    self:UpdateList()
    self:UpdateHeight()
    self:UpdateTrackerHeader()
    self:ScrollToTrackedPin()
    self:Show()
end

function MapPinEnhancedTrackerMixin:HideFrame()
    self:Hide()
end
