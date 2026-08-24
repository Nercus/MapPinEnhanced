---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L
local Editor = MapPinEnhanced:GetModule("Editor")

---@class MapPinEnhancedEditorSystemGroupHeader : Frame
---@field title FontString
---@field info FontString

---@class MapPinEnhancedGroupEditorSidebarTemplate : Frame
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field title FontString
---@field search MapPinEnhancedInputTemplate
---@field createButton MapPinEnhancedIconButtonTemplate
---@field scrollBox Frame|ScrollBoxListMixin
---@field scrollBar ScrollBarMixin
---@field systemGroups Frame
---@field systemHeader MapPinEnhancedEditorSystemGroupHeader
---@field ungroupedPinsEntry MapPinEnhancedGroupEditorSidebarEntryTemplate
---@field systemEntries MapPinEnhancedGroupEditorSidebarEntryTemplate[]
---@field dataProvider DataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field dropTarget MapPinEnhancedGroupMixin?
MapPinEnhancedGroupEditorSidebarMixin = {}

---@param scrollBox Frame|ScrollBoxListMixin
---@param scrollBar ScrollBarMixin
---@return DataProviderMixin, ScrollBoxListLinearViewMixin
function MapPinEnhancedGroupEditorSidebarMixin:CreateGroupList(scrollBox, scrollBar)
    local dataProvider = CreateDataProvider()
    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("MapPinEnhancedGroupEditorSidebarEntryTemplate", function(entry, group)
        ---@cast entry MapPinEnhancedGroupEditorSidebarEntryTemplate
        ---@cast group MapPinEnhancedGroupMixin
        entry:Init(group, self.editor)
    end)
    scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedGroupEditorSidebarEntryTemplate
        entry:Reset()
    end)
    scrollView:SetDataProvider(dataProvider)
    scrollBar:SetHideIfUnscrollable(true)
    scrollBar:SetInterpolateScroll(true)
    scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)
    return dataProvider, scrollView
end

function MapPinEnhancedGroupEditorSidebarMixin:OnLoad()
    self.title:SetText(L["Groups"])
    self.systemHeader.title:SetText(L["System Groups"])
    self.search:SetInlineIcon("search")
    self.search:SetPlaceholderText(L["Search"])
    self.createButton:SetIconTexture("plus")

    self.dataProvider, self.scrollView = self:CreateGroupList(self.scrollBox, self.scrollBar)
    self.systemEntries = { self.ungroupedPinsEntry }

    self.search:SetScript("OnTextChanged", function(_, userInput)
        if userInput then self:Refresh() end
    end)
    self.search:SetScript("OnEscapePressed", function(editBox)
        editBox:SetText("")
        editBox:ClearFocus()
        self:Refresh()
    end)
    self.systemHeader:SetScript("OnEnter", function(header)
        GameTooltip:SetOwner(header, "ANCHOR_RIGHT")
        GameTooltip:AddLine(L["System Groups"])
        GameTooltip:AddLine(
            L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."],
            1, 1, 1, true)
        GameTooltip:Show()
    end)
    self.systemHeader:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

---@param editor MapPinEnhancedGroupEditorTemplate
function MapPinEnhancedGroupEditorSidebarMixin:SetEditor(editor)
    self.editor = editor
    self.createButton:SetScript("OnClick", function() editor:CreateNewGroup() end)
end

function MapPinEnhancedGroupEditorSidebarMixin:ClearSearch()
    self.search:SetText("")
end

function MapPinEnhancedGroupEditorSidebarMixin:GetSearch()
    return strtrim(self.search:GetText() or "")
end

function MapPinEnhancedGroupEditorSidebarMixin:Refresh()
    if not self.dataProvider then return end
    ---@type MapPinEnhancedGroupMixin[]
    local groups = {}
    ---@type table<string, MapPinEnhancedGroupMixin>
    local systemGroups = {}
    local search = self:GetSearch()
    for group in Groups:EnumerateGroups() do
        if Editor:ShouldShowGroup(group) and
            (search == "" or MapPinEnhanced:FuzzyMatch(search, group:GetName())) then
            table.insert(groups, group)
        elseif Editor:ShouldShowSystemGroup(group) then
            local groupType = group.groupType
            if groupType then systemGroups[groupType] = group end
        end
    end
    table.sort(groups, function(group1, group2) return Groups:IsGroupBefore(group1, group2) end)
    self.dataProvider:Flush()
    for _, group in ipairs(groups) do
        self.dataProvider:Insert(group)
    end

    ---@type {entry: MapPinEnhancedGroupEditorSidebarEntryTemplate, group: MapPinEnhancedGroupMixin?}[]
    local systemEntries = {
        { entry = self.ungroupedPinsEntry, group = systemGroups.ungrouped },
    }
    for _, systemEntry in ipairs(systemEntries) do
        local entry, group = systemEntry.entry, systemEntry.group
        entry:Reset()
        entry:SetShown(group ~= nil)
        if group then entry:Init(group, self.editor) end
    end
end

---@param group MapPinEnhancedGroupMixin?
function MapPinEnhancedGroupEditorSidebarMixin:ScrollToGroup(group)
    if not group then return end
    if group:IsProtected() then return end
    self.scrollBox:ScrollToElementDataByPredicate(function(data)
        return data:GetGroupID() == group:GetGroupID()
    end)
end

function MapPinEnhancedGroupEditorSidebarMixin:ClearDropTarget()
    self.dropTarget = nil
    self.scrollBox:ForEachFrame(function(frame) frame:SetDropTarget(false) end)
    for _, entry in ipairs(self.systemEntries) do entry:SetDropTarget(false) end
end

function MapPinEnhancedGroupEditorSidebarMixin:GetDropTarget()
    return self.dropTarget
end

function MapPinEnhancedGroupEditorSidebarMixin:UpdateDropTarget()
    ---@type MapPinEnhancedGroupMixin?
    local target
    ---@param scrollBox Frame|ScrollBoxListMixin
    local function update(scrollBox)
        ---@param frame MapPinEnhancedGroupEditorSidebarEntryTemplate
        scrollBox:ForEachFrame(function(frame)
            local isTarget = not target and frame:IsMouseOver()
            frame:SetDropTarget(isTarget)
            if isTarget then target = frame.group end
        end)
    end
    update(self.scrollBox)
    for _, entry in ipairs(self.systemEntries) do
        local isTarget = not target and entry:IsShown() and entry:IsMouseOver()
        entry:SetDropTarget(isTarget)
        if isTarget then target = entry.group end
    end
    self.dropTarget = target
end
