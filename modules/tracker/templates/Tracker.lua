---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollBox : Frame, ScrollBoxListMixin

---@class MapPinEnhancedTrackerScrollBar : ScrollBarMixin
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedTrackerTemplate : Frame, MapPinEnhancedFadingFrameTemplate
---@field contentBackground Texture
---@field minimized boolean?
---@field automaticallyMinimized boolean?
---@field minimizedScroll number?
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
MapPinEnhancedTrackerMixin = CreateFromMixins(MapPinEnhancedTrackerListMixin)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local L = MapPinEnhanced.L
local Options = MapPinEnhanced:GetModule("Options")

---@alias EntryTemplate MapPinEnhancedTrackerGroupEntryTemplate | MapPinEnhancedTrackerPinEntryTemplate

---@alias EntryTemplateString 'MapPinEnhancedTrackerGroupEntryTemplate' | 'MapPinEnhancedTrackerPinEntryTemplate'

---@class MapPinEnhancedTrackerGroupNode : TreeNodeMixin
---@field groupID UUID
---@field activePins number
---@field reachedPins number
---@field totalPins number

function MapPinEnhancedTrackerMixin:SaveCollapsedGroups()
    if not self.dataProvider then return end
    for groupID in pairs(self.collapsedGroups) do
        if not Groups:GetGroupByID(groupID) then self.collapsedGroups[groupID] = nil end
    end
    for _, node in ipairs(self.dataProvider:GetChildrenNodes()) do
        ---@cast node MapPinEnhancedTrackerGroupNode
        -- Capture identity on construction: the domain group may already be released.
        self.collapsedGroups[node.groupID] = node:IsCollapsed() or false
    end
end

---@param scrollToTrackedPin boolean?
function MapPinEnhancedTrackerMixin:UpdateList(scrollToTrackedPin)
    if self.minimized then
        self.reachedPins, self.totalPins = 0, 0
        for group in Groups:EnumerateGroups() do
            if not group.pinsUpdating and not group:IsHidden() then
                local _, reached, total = group:GetPinCounts()
                self.reachedPins, self.totalPins = self.reachedPins + reached, self.totalPins + total
            end
        end
        self:UpdateTrackerHeader()
        self:UpdateHeight()
        return
    end
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

function MapPinEnhancedTrackerMixin:UpdateHeight()
    local headerHeight = self.header:GetHeight() + 5 -- header plus padding
    local entryHeight = 35
    self.contentBackground:SetShown(not self.minimized)
    local numberOfEntries = self.dataProvider and self.dataProvider:GetSize(TreeDataProviderConstants.ExcludeCollapsed) or
        0
    local visibleEntries = self.minimized and 0 or math.min(numberOfEntries,
        Options:GetOptionValue("Miscellaneous.Tracker.MaximumRows"))
    local newHeight = visibleEntries * entryHeight
    self.desiredHeight = newHeight + headerHeight
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
            ---@cast node MapPinEnhancedTrackerPinNode
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
    Options:SubscribeToOptionChanges("Miscellaneous.Tracker.MaximumRows", function() self:UpdateHeight() end)
    Options:SubscribeToOptionChanges("Miscellaneous.Tracker.BackgroundOpacity", function(value)
        self.contentBackground:SetAlpha(value / 100)
    end)
    Options:SubscribeToOptionChanges("Miscellaneous.Tracker.Scale", function() self.position:ApplyTrackerScale() end)
    MapPinEnhanced:RegisterCallback("PIN_ADDED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)
    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function()
        self:UpdateListAndScrollToTrackedPin()
    end)
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function(_, group)
        if group and group.pinsUpdating and self.dataProvider then
            self:UpdateList()
        else
            self:UpdateListAndScrollToTrackedPin()
        end
    end)
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", function(_, _, isTracked)
        if isTracked and self:IsShown() and not self.visibilityHiding then self.scrollPending = true end
    end)
end

function MapPinEnhancedTrackerMixin:OnShow()
    self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
    self.refreshPending, self.scrollPending = nil, nil
    local restoreScroll = self.minimizedScroll ~= nil
    self:ApplyMinimizedState(true)
    self:UpdateList(not self.minimizedScroll)
    self:RestoreListScroll()
    self.position:RestoreTrackerPosition(self.desiredHeight or self.header:GetHeight())
    self.position:ApplyTrackerScale()
    self:UpdateViewportHeight()
    if not restoreScroll then self:ScrollToTrackedPin() end
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
    if refresh then
        self:UpdateList(scroll)
        self:RestoreListScroll()
    end
    if scroll then self:ScrollToTrackedPin() end
    -- Position can change during a drag or a screen/scale change; resizing never moves it.
    self:UpdateViewportHeight()
    if not self.minimized and self:IsMouseOver() and self.scrollBar:HasScrollableExtent() and self.scrollBar:IsScrollAllowed() then
        self.scrollBar.fadeIn:PlayShowing(self.scrollBar.fadeOut)
    else
        self.scrollBar.fadeOut:PlayHiding(self.scrollBar.fadeIn)
    end
end

function MapPinEnhancedTrackerMixin:UpdateTrackerHeader()
    self.header:SetTitle(string.format(L["Your pins (%d/%d)"], self.reachedPins, self.totalPins))
    self.header:SetIcon("pin")
    self.header.hiddenGroupsButton:SetIconTexture("eyeslash")
end

function MapPinEnhancedTrackerMixin:ShowFrame()
    local wasShown, wasHiding = self:IsShown(), self.visibilityHiding
    self:Show()
    -- Reversing a fade does not fire OnShow; it still needs the latest tree.
    if wasShown and wasHiding then
        self:OnShow()
    elseif wasShown then
        self:ApplyMinimizedState()
        self:RequestListUpdate()
    end
end

function MapPinEnhancedTrackerMixin:HideFrame()
    self.changeNumber = self.changeNumber + 1
    self.refreshPending, self.scrollPending = nil, nil
    self.header.hiddenGroupsMenu:Close()
    self:Hide()
end

---@param skipRefresh boolean?
function MapPinEnhancedTrackerMixin:ApplyMinimizedState(skipRefresh)
    local minimizeMode = Options:GetOptionValue("Miscellaneous.Tracker.CloseAction") == true
    local wasMinimized = self.minimized
    self.minimized = minimizeMode and (self.automaticallyMinimized or MapPinEnhanced:GetVar("trackerMinimized") == true) or
        false
    self.header.closeButton:SetIconTexture(minimizeMode and (self.minimized and "downcaret" or "upcaret") or "close")
    self.header.closeButton:SetTooltip(L[minimizeMode and (self.minimized and "Expand" or "Minimize") or "Close"])
    if GameTooltip:IsOwned(self.header.closeButton) then self.header.closeButton:OnTooltipEnter() end
    self.scrollBox:SetShown(not self.minimized)
    if self.minimized then
        if self.dataProvider then self.minimizedScroll = self.scrollBox:GetScrollPercentage() end
        self:SaveCollapsedGroups()
        self.scrollBox:RemoveDataProvider()
        self.dataProvider = nil
        self.refreshPending, self.scrollPending = nil, nil
        self.scrollBar.fadeOut:SetParentShownInstantly(false, self.scrollBar.fadeIn)
        self.header.hiddenGroupsMenu:Close()
    elseif wasMinimized ~= self.minimized and self:IsShown() and not skipRefresh then
        self:RequestListUpdate(true)
    end
    self:UpdateHeight()
end

function MapPinEnhancedTrackerMixin:RestoreListScroll()
    if self.minimized or not self.minimizedScroll then return end
    self.scrollBox:SetScrollPercentage(self.minimizedScroll)
    self.minimizedScroll = nil
end
