---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L

---@class MapPinEnhancedEditorPinNodeData
---@field classification "editorPin"
---@field group MapPinEnhancedGroupMixin
---@field pin MapPinEnhancedPinMixin?
---@field pinID UUID
---@field pinData SaveablePinData
---@field archiveState "cleared"|"hidden"|nil
---@field order number

---@class MapPinEnhancedGroupEditorTemplate : MapPinEnhancedWindowTemplate
---@field groupEditorSidebar MapPinEnhancedGroupEditorSidebarTemplate
---@field groupEditorContent MapPinEnhancedGroupEditorContentTemplate
---@field pinDragGhost MapPinEnhancedEditorPinDragGhost
---@field selectedGroup MapPinEnhancedGroupMixin?
---@field draggedPinNode MapPinEnhancedEditorPinNodeData?
---@field dragSourceFrame MapPinEnhancedGroupEditorContentPinEntryTemplate?
---@field refreshPending boolean?
---@field focusCheckElapsed number?
MapPinEnhancedGroupEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

function MapPinEnhancedGroupEditorMixin:GetAvailableNewGroupName()
    local index = 1
    local name = string.format(L["New Group %d"], index)
    while Groups:GetGroupByName(name) do
        index = index + 1
        name = string.format(L["New Group %d"], index)
    end
    return name
end

function MapPinEnhancedGroupEditorMixin:CreateNewGroup()
    self.groupEditorSidebar:ClearSearch()
    local group = Groups:RegisterGroup({
        name = self:GetAvailableNewGroupName(),
        source = MapPinEnhanced.name,
        icon = Editor.DEFAULT_GROUP_ICON,
        order = GetTime(),
    })
    if not group then return end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
    self:SelectGroup(group, true)
end

---@param group MapPinEnhancedGroupMixin?
---@param focusName boolean?
function MapPinEnhancedGroupEditorMixin:SelectGroup(group, focusName)
    if group and group.isDeleting then return end
    if self.selectedGroup ~= group then Editor:CloseDescriptionEditor() end
    self.selectedGroup = group
    self.groupEditorSidebar:Refresh()
    self.groupEditorContent:SetGroup(group, focusName)
    if group then self.groupEditorSidebar:ScrollToGroup(group) end
end

function MapPinEnhancedGroupEditorMixin:RefreshUpdateHandler()
    local needsUpdate = self:IsVisible() and not self.visibilityHiding
        and (self.refreshPending or self.draggedPinNode)
    self:SetScript("OnUpdate", needsUpdate and self.OnUpdate or nil)
end

function MapPinEnhancedGroupEditorMixin:RequestRefresh()
    if not self.refreshPending then self.focusCheckElapsed = nil end
    self.refreshPending = true
    self:RefreshUpdateHandler()
end

---@param elapsed number
function MapPinEnhancedGroupEditorMixin:OnUpdate(elapsed)
    if not self:IsVisible() or self.visibilityHiding then
        self:SetScript("OnUpdate", nil)
        return
    end
    if self.refreshPending and not self.draggedPinNode then
        self.focusCheckElapsed = (self.focusCheckElapsed or 0.1) + elapsed
        if self.focusCheckElapsed >= 0.1 then
            self.focusCheckElapsed = 0
            ---@type ScriptRegion?
            local focused = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
            while focused and focused ~= self.groupEditorContent do
                focused = focused.GetParent and focused:GetParent()
            end
            if not focused then
                -- Consume before rebuilding so callbacks can request another refresh.
                self.refreshPending = nil
                if self.selectedGroup and not Groups:GetGroupByID(self.selectedGroup:GetGroupID()) then
                    Editor:CloseDescriptionEditor()
                    self.selectedGroup = nil
                end
                self.groupEditorSidebar:Refresh()
                self.groupEditorContent:SetGroup(self.selectedGroup)
            end
        end
    end
    if self.draggedPinNode then
        self.pinDragGhost:UpdatePosition()
        self.groupEditorContent:UpdateDrag()
        self.groupEditorSidebar:UpdateDropTarget()
    end
    self:RefreshUpdateHandler()
end

function MapPinEnhancedGroupEditorMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.pinDragGhost = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedEditorPinDragGhostTemplate")
    self.groupEditorSidebar:SetEditor(self)
    self.groupEditorContent:SetEditor(self)
    self.groupEditorContent.emptyState.createButton:SetScript("OnClick", function() self:CreateNewGroup() end)

    local function refresh() self:RequestRefresh() end
    MapPinEnhanced:RegisterCallback("PIN_ADDED", refresh)
    MapPinEnhanced:RegisterCallback("PIN_REMOVED", refresh)
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function(_, group)
        if group and group.pinsUpdating then
            self:CancelPinDrag()
            if self.selectedGroup == group then
                Editor:CloseDescriptionEditor()
                self.groupEditorContent:SetGroup(group)
                if group.isDeleting then self.selectedGroup = nil end
            end
            if self:IsVisible() and not self.visibilityHiding then
                self.groupEditorSidebar:Refresh()
            else
                -- Detach pooled group references without rebuilding a hidden sidebar.
                self.groupEditorSidebar.dataProvider:Flush()
                for _, entry in ipairs(self.groupEditorSidebar.systemGroups.entries) do
                    entry:Reset()
                    entry:Hide()
                end
            end
        end
        self:RequestRefresh()
    end)
    MapPinEnhanced:RegisterCallback("GROUP_DELETED", refresh)
end

function MapPinEnhancedGroupEditorMixin:StartPinDrag(pinNode, sourceFrame)
    self.draggedPinNode = pinNode
    self.dragSourceFrame = sourceFrame
    sourceFrame:SetAlpha(0.45)
    self.pinDragGhost:Init(Editor:GetPinData(pinNode))
    SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
    self:RefreshUpdateHandler()
end

function MapPinEnhancedGroupEditorMixin:StopPinDrag()
    if not self.draggedPinNode then return end
    self.pinDragGhost:Hide()
    if self.dragSourceFrame then self.dragSourceFrame:SetAlpha(1) end
    local targetGroup = self.groupEditorSidebar:GetDropTarget()
    if targetGroup and self.draggedPinNode then
        Editor:MovePinToGroup(self.draggedPinNode.group, self.draggedPinNode.pinID, targetGroup)
    else
        self.groupEditorContent:FinishPinDrop()
    end
    if self.dragSourceFrame and self.dragSourceFrame.dragHandle:IsMouseOver() then
        SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
    else
        ResetCursor()
    end
    self.draggedPinNode = nil
    self.dragSourceFrame = nil
    self.groupEditorSidebar:ClearDropTarget()
    self.groupEditorContent:ClearDropTarget()
    self:RequestRefresh()
end

function MapPinEnhancedGroupEditorMixin:CancelPinDrag()
    self.pinDragGhost:Hide()
    if self.dragSourceFrame then self.dragSourceFrame:SetAlpha(1) end
    ResetCursor()
    self.draggedPinNode = nil
    self.dragSourceFrame = nil
    self.groupEditorSidebar:ClearDropTarget()
    self.groupEditorContent:ClearDropTarget()
    self:RefreshUpdateHandler()
end

function MapPinEnhancedGroupEditorMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self.selectedGroup = nil
    self.refreshPending = nil
    self.groupEditorSidebar:ClearSearch()
    self.groupEditorSidebar:Refresh()
    self.groupEditorContent:SetGroup(nil)
    self:Show()
    self:RefreshUpdateHandler()
end

function MapPinEnhancedGroupEditorMixin:OnShow()
    MapPinEnhancedWindowMixin.OnShow(self)
    self:RefreshUpdateHandler()
end

function MapPinEnhancedGroupEditorMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self.focusCheckElapsed = nil
    Editor:CloseDescriptionEditor()
    MapPinEnhancedWindowMixin.OnHide(self)
    self:CancelPinDrag()
end

function MapPinEnhancedGroupEditorMixin:HideFrame()
    self:Hide()
end
