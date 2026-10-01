---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollBox : Frame, ScrollBoxListMixin

---@class MapPinEnhancedTrackerScrollBar : ScrollBarMixin
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedTrackerTemplate : Frame, MapPinEnhancedFadingFrameTemplate
---@field scrollBox MapPinEnhancedTrackerScrollBox
---@field scrollBar MapPinEnhancedTrackerScrollBar
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin?
---@field collapsedGroups table<UUID, boolean>
---@field refreshPending boolean?
---@field scrollPending boolean?
---@field changeNumber number
---@field reachedPins number
---@field totalPins number
---@field position MapPinEnhancedTrackerPositionTemplate
---@field desiredHeight number?
---@field header MapPinEnhancedTrackerHeaderTemplate
---@field superTrackedEntry MapPinEnhancedSuperTrackedEntryTemplate
MapPinEnhancedTrackerMixin = {}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Providers = MapPinEnhanced:GetModule("Providers")
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
    return Groups:IsGroupBefore(group1, group2)
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

---@class MapPinEnhancedTrackerGroupNode : TreeNodeMixin
---@field groupID UUID
---@field activePins number
---@field reachedPins number
---@field totalPins number

function MapPinEnhancedTrackerMixin:SaveCollapsedGroups()
    if not self.dataProvider then return end
    wipe(self.collapsedGroups)
    for _, node in ipairs(self.dataProvider:GetChildrenNodes()) do
        ---@cast node MapPinEnhancedTrackerGroupNode
        -- Capture identity on construction: the domain group may already be released.
        self.collapsedGroups[node.groupID] = node:IsCollapsed() or false
    end
end

---@param scrollToTrackedPin boolean?
---@return TreeDataProviderMixin, number, number
function MapPinEnhancedTrackerMixin:UpdatePinList(scrollToTrackedPin)
    local dataProvider = CreateTreeDataProvider()
    local reachedPins, totalPins = 0, 0
    local trackedPin = scrollToTrackedPin and Pins:GetTrackedPin() or nil
    for group in Groups:EnumerateGroups() do
        if not group:IsHidden() then
            local active, reached, total = group:GetPinCounts()
            if total > 0 then
                local node = dataProvider:Insert(group) --[[@as MapPinEnhancedTrackerGroupNode]]
                node.groupID = group:GetGroupID()
                node.activePins, node.reachedPins, node.totalPins = active, reached, total
                for _, pin in group:EnumeratePins() do
                    node:Insert(pin)
                end
                -- Insert sorts when a comparator exists. Install it only after all children.
                node:SetSortComparator(PinSortComparator, false, false)
                local collapsed = self.collapsedGroups[node.groupID] or false
                if trackedPin and trackedPin.group == group then collapsed = false end
                node:SetCollapsed(collapsed, false, TreeDataProviderConstants.SkipInvalidation)
                reachedPins, totalPins = reachedPins + reached, totalPins + total
            end
        end
    end
    dataProvider:SetSortComparator(GroupSortComparator, false, false)
    return dataProvider, reachedPins, totalPins
end

---@param scrollToTrackedPin boolean?
function MapPinEnhancedTrackerMixin:UpdateList(scrollToTrackedPin)
    self:SaveCollapsedGroups()
    local changeNumber = self.changeNumber
    local dataProvider, reachedPins, totalPins = self:UpdatePinList(scrollToTrackedPin)
    if changeNumber ~= self.changeNumber then return end

    self.dataProvider = dataProvider
    self.reachedPins, self.totalPins = reachedPins, totalPins
    -- Only the complete tree reaches ScrollBox; replacement releases rows via their resetters.
    self.scrollBox:SetDataProvider(dataProvider, ScrollBoxConstants.RetainScrollPosition)
    self:UpdateHeight()
    self:UpdateTrackerHeader()
end

---@param scrollToTrackedPin boolean?
function MapPinEnhancedTrackerMixin:RequestListUpdate(scrollToTrackedPin)
    if not self:IsShown() or self.visibilityHiding then return end
    self.refreshPending = true
    self.scrollPending = self.scrollPending or scrollToTrackedPin
end

function MapPinEnhancedTrackerMixin:UpdateListAndScrollToTrackedPin()
    self:RequestListUpdate(true)
end

function MapPinEnhancedTrackerMixin:ScrollToTrackedPin()
    if not self:IsShown() or not self.dataProvider then return end

    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end

    local trackedGroup = trackedPin.group
    if trackedGroup then
        ---@type MapPinEnhancedTrackerGroupNode?
        local groupNode
        for _, node in ipairs(self.dataProvider:GetChildrenNodes()) do
            ---@cast node MapPinEnhancedTrackerGroupNode
            if node.groupID == trackedGroup:GetGroupID() then
                groupNode = node
                break
            end
        end
        if groupNode and groupNode:IsCollapsed() then
            groupNode:SetCollapsed(false)
            self:UpdateHeight()
            self.scrollBox:ForEachFrame(function(frame)
                if frame.treeNode == groupNode then frame:UpdateExpandIcon() end
            end)
        end
    end

    -- The target group is already expanded. Query the visible index directly;
    -- ScrollToElementDataByPredicate would invalidate the tree again even then.
    ---@type number?
    local index = self.scrollBox:FindElementDataIndexByPredicate(function(node)
        ---@type MapPinEnhancedPinMixin
        local nodeData = node:GetData()
        return nodeData.classification == "pin" and nodeData.pinID == trackedPin.pinID
    end)
    if index then self.scrollBox:ScrollToElementDataIndex(index) end
end

-- Maximum number of entries to display
local MAX_ENTRIES = 7
function MapPinEnhancedTrackerMixin:UpdateHeight()
    local headerHeight = self.header:GetHeight() + 5 -- header plus padding
    local entryHeight = 35
    local fixedEntryHeight = self.superTrackedEntry:IsShown() and self.superTrackedEntry:GetHeight() or 0
    local numberOfEntries = self.dataProvider and self.dataProvider:GetSize(TreeDataProviderConstants.ExcludeCollapsed) or 0
    local visibleEntries = math.min(numberOfEntries, MAX_ENTRIES)
    local newHeight = visibleEntries * entryHeight
    self.desiredHeight = newHeight + headerHeight + fixedEntryHeight
    self:UpdateViewportHeight()
end

function MapPinEnhancedTrackerMixin:UpdateViewportHeight()
    if not self.desiredHeight or not self.position.restored then return end
    local top = self:GetTop()
    if not top then return end

    -- Both edges must use this frame's units, including its inherited saved scale.
    local screenBottom = (UIParent:GetBottom() or 0) * UIParent:GetEffectiveScale() / self:GetEffectiveScale()
    local height = math.min(self.desiredHeight, math.max(1, top - screenBottom))
    if self:GetHeight() ~= height then self:SetHeight(height) end
end

---@param factory fun(template: EntryTemplateString, initFunc: fun(frame: any))
---@param node TreeNodeMixin
local function TrackerElementFactory(factory, node)
    ---@type MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
    local data = node:GetData()

    if data.classification == "group" then
        factory("MapPinEnhancedTrackerGroupEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedTrackerGroupEntryTemplate
            ---@cast node MapPinEnhancedTrackerGroupNode
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
        frame:Reset()
    end
end

function MapPinEnhancedTrackerMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.position = self:GetParent() --[[@as MapPinEnhancedTrackerPositionTemplate]]
    MapPinEnhanced:RegisterDraggableFrame(self.position, "tracker", self.header, function()
        return MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    end)
    self.scrollBar:SetHideIfUnscrollable(false)
    self.collapsedGroups = {}
    self.changeNumber = 0
    self.reachedPins, self.totalPins = 0, 0
    self.scrollView = CreateScrollBoxListTreeListView()

    self.scrollView:SetElementFactory(TrackerElementFactory)
    self.scrollView:SetElementResetter(TrackerElementResetter)

    self.scrollBar:SetInterpolateScroll(true);
    self.scrollBox:SetInterpolateScroll(true);

    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    MapPinEnhanced:RegisterCallback("PIN_ADDED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)
    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", function(_, _, isTracked)
        if isTracked and self:IsShown() and not self.visibilityHiding then self.scrollPending = true end
    end)
    MapPinEnhanced:RegisterCallback("SUPER_TRACKING_ENTRY_CHANGED", function()
        if self:IsShown() then self:UpdateSuperTrackedEntry() end
    end)
end

function MapPinEnhancedTrackerMixin:OnShow()
    self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
    self.refreshPending, self.scrollPending = nil, nil
    self:UpdateSuperTrackedEntry(true)
    self:UpdateList(true)
    self.position:RestoreTrackerPosition(self.desiredHeight or self.header:GetHeight())
    self:UpdateViewportHeight()
    self:ScrollToTrackedPin()
end

function MapPinEnhancedTrackerMixin:OnHide()
    self.changeNumber = self.changeNumber + 1
    self.refreshPending, self.scrollPending = nil, nil
    self:SaveCollapsedGroups()
    self.scrollBox:RemoveDataProvider()
    self.dataProvider = nil
    self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
end

function MapPinEnhancedTrackerMixin:OnUpdate()
    if self.visibilityHiding then return end
    local refresh, scroll = self.refreshPending, self.scrollPending
    -- Consume before building so a callback during publication remains pending next frame.
    self.refreshPending, self.scrollPending = nil, nil
    if refresh then self:UpdateList(scroll) end
    if scroll then self:ScrollToTrackedPin() end
    -- Position can change during a drag or a screen/scale change; resizing never moves it.
    self:UpdateViewportHeight()
    if self:IsMouseOver() and self.scrollBar:HasScrollableExtent() and self.scrollBar:IsScrollAllowed() then
        self.scrollBar.fadeIn:PlayShowing(self.scrollBar.fadeOut)
    else
        self.scrollBar.fadeOut:PlayHiding(self.scrollBar.fadeIn)
    end
end

function MapPinEnhancedTrackerMixin:UpdateTrackerHeader()
    self.header:SetTitle(string.format(L["Pins (%d/%d)"], self.reachedPins, self.totalPins))
    self.header:SetIcon("pin")
    self.header.hiddenGroupsButton:SetIconTexture("eyeslash")
end

function MapPinEnhancedTrackerMixin:UpdateViewLayout()
    self.scrollBox:ClearAllPoints()
    if self.superTrackedEntry:IsShown() then
        self.scrollBox:SetPoint("TOPLEFT", self.superTrackedEntry, "BOTTOMLEFT", 0, 0)
    else
        self.scrollBox:SetPoint("TOPLEFT", self.header, "BOTTOMLEFT", 5, 0)
    end
    self.scrollBox:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5)
end

---@param skipHeight boolean?
function MapPinEnhancedTrackerMixin:UpdateSuperTrackedEntry(skipHeight)
    self.superTrackedEntry:ApplyEntry(Providers:GetSuperTrackingEntry())
    self:UpdateViewLayout()
    if not skipHeight then self:UpdateHeight() end
end

function MapPinEnhancedTrackerMixin:ShowFrame()
    local wasShown = self:IsShown()
    self:Show()
    -- Reversing a fade does not fire OnShow; it still needs the latest tree.
    if wasShown then self:OnShow() end
end

function MapPinEnhancedTrackerMixin:HideFrame()
    self.changeNumber = self.changeNumber + 1
    self.refreshPending, self.scrollPending = nil, nil
    self.header.hiddenGroupsMenu:Close()
    self:Hide()
end
