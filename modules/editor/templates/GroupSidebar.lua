---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L
local Util = MapPinEnhancedEditorUtil

---@class MapPinEnhancedEditorGroupSidebarTemplate : Frame
---@field editor MapPinEnhancedEditorTemplate?
---@field title FontString
---@field search MapPinEnhancedInputTemplate
---@field createButton MapPinEnhancedIconButtonTemplate
---@field scrollBox Frame|ScrollBoxListMixin
---@field scrollBar ScrollBarMixin
---@field dataProvider DataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field dropTarget MapPinEnhancedGroupMixin?
MapPinEnhancedEditorGroupSidebarMixin = {}

function MapPinEnhancedEditorGroupSidebarMixin:OnLoad()
    self.title:SetText(L["Groups"])
    self.search:SetInlineIcon("search")
    self.search:SetPlaceholderText(L["Search"])
    self.createButton:SetIconTexture("plus")

    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetElementInitializer("MapPinEnhancedEditorGroupSidebarEntryTemplate", function(entry, group)
        ---@cast entry MapPinEnhancedEditorGroupSidebarEntryTemplate
        ---@cast group MapPinEnhancedGroupMixin
        entry:Init(group, self.editor)
    end)
    self.scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedEditorGroupSidebarEntryTemplate
        entry:Reset()
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.scrollBar:SetHideIfUnscrollable(true)
    self.scrollBar:SetInterpolateScroll(true)
    self.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.search:SetScript("OnTextChanged", function(_, userInput)
        if userInput then self:Refresh() end
    end)
    self.search:SetScript("OnEscapePressed", function(editBox)
        editBox:SetText("")
        editBox:ClearFocus()
        self:Refresh()
    end)
end

---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorGroupSidebarMixin:SetEditor(editor)
    self.editor = editor
    self.createButton:SetScript("OnClick", function() editor:CreateNewGroup() end)
end

function MapPinEnhancedEditorGroupSidebarMixin:ClearSearch()
    self.search:SetText("")
end

function MapPinEnhancedEditorGroupSidebarMixin:GetSearch()
    return strtrim(self.search:GetText() or "")
end

function MapPinEnhancedEditorGroupSidebarMixin:Refresh()
    if not self.dataProvider then return end
    local groups = {}
    local search = self:GetSearch()
    for group in Groups:EnumerateGroups() do
        if Util.ShouldShowGroup(group) and
            (search == "" or MapPinEnhanced:FuzzyMatch(search, group:GetName())) then
            table.insert(groups, group)
        end
    end
    table.sort(groups, Util.IsGroupBefore)
    self.dataProvider:Flush()
    for _, group in ipairs(groups) do self.dataProvider:Insert(group) end
end

---@param group MapPinEnhancedGroupMixin?
function MapPinEnhancedEditorGroupSidebarMixin:ScrollToGroup(group)
    if not group then return end
    self.scrollBox:ScrollToElementDataByPredicate(function(data)
        return data:GetGroupID() == group:GetGroupID()
    end)
end

function MapPinEnhancedEditorGroupSidebarMixin:ClearDropTarget()
    self.dropTarget = nil
    self.scrollBox:ForEachFrame(function(frame) frame:SetDropTarget(false) end)
end

function MapPinEnhancedEditorGroupSidebarMixin:GetDropTarget()
    return self.dropTarget
end

function MapPinEnhancedEditorGroupSidebarMixin:UpdateDropTarget()
    local target
    self.scrollBox:ForEachFrame(function(frame)
        local isTarget = not target and frame:IsMouseOver()
        frame:SetDropTarget(isTarget)
        if isTarget then target = frame.group end
    end)
    self.dropTarget = target
end
