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
---@field archiveState "reached"|"hidden"|nil
---@field order number

---@class MapPinEnhancedEditorPinDragGhost : Frame
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field title FontString

---@class MapPinEnhancedEditorTemplate : MapPinEnhancedWindowTemplate
---@field groupSidebar MapPinEnhancedEditorGroupSidebarTemplate
---@field groupEditor MapPinEnhancedEditorGroupEditorTemplate
---@field pinDragGhost MapPinEnhancedEditorPinDragGhost
---@field selectedGroup MapPinEnhancedGroupMixin?
---@field draggedPinNode MapPinEnhancedEditorPinNodeData?
---@field dragSourceFrame MapPinEnhancedEditorGroupEditorPinEntryTemplate?
---@field refreshPending boolean?
MapPinEnhancedEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

function MapPinEnhancedEditorMixin:GetAvailableNewGroupName()
    local index = 1
    local name = string.format(L["New Group %d"], index)
    while Groups:GetGroupByName(name) do
        index = index + 1
        name = string.format(L["New Group %d"], index)
    end
    return name
end

function MapPinEnhancedEditorMixin:CreateNewGroup()
    self.groupSidebar:ClearSearch()
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
function MapPinEnhancedEditorMixin:SelectGroup(group, focusName)
    self.selectedGroup = group
    self.groupSidebar:Refresh()
    self.groupEditor:SetGroup(group, focusName)
    if group then self.groupSidebar:ScrollToGroup(group) end
end

function MapPinEnhancedEditorMixin:RequestRefresh()
    self.refreshPending = true
end

function MapPinEnhancedEditorMixin:OnUpdate()
    if self.refreshPending and not self.groupEditor:IsEditing() and not self.draggedPinNode then
        self.refreshPending = nil
        if self.selectedGroup and not Groups:GetGroupByID(self.selectedGroup:GetGroupID()) then
            self.selectedGroup = nil
        end
        self.groupSidebar:Refresh()
        self.groupEditor:SetGroup(self.selectedGroup)
    end
    if self.draggedPinNode then
        self:UpdatePinDragGhostPosition()
        self.groupEditor:UpdateDrag()
        self.groupSidebar:UpdateDropTarget()
    end
end

function MapPinEnhancedEditorMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.pinDragGhost = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedEditorPinDragGhostTemplate")
    self.groupSidebar:SetEditor(self)
    self.groupEditor:SetEditor(self)
    self.groupEditor.emptyState.createButton:SetScript("OnClick", function() self:CreateNewGroup() end)

    local function refresh() self:RequestRefresh() end
    MapPinEnhanced:RegisterCallback("PIN_ADDED", refresh)
    MapPinEnhanced:RegisterCallback("PIN_REMOVED", refresh)
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", refresh)
    MapPinEnhanced:RegisterCallback("GROUP_DELETED", refresh)
end

function MapPinEnhancedEditorMixin:StartPinDrag(pinNode, sourceFrame)
    self.draggedPinNode = pinNode
    self.dragSourceFrame = sourceFrame
    sourceFrame:SetAlpha(0.45)
    if Editor:GetPinData(pinNode).texture then
        self.pinDragGhost.pinFrame:SetIconTexture(
            Editor:GetPinData(pinNode).texture,
            Editor:GetPinData(pinNode).usesAtlas
        )
    else
        self.pinDragGhost.pinFrame:SetColor(Editor:GetPinData(pinNode).color)
    end
    self.pinDragGhost.pinFrame:SetTracked(true)
    self.pinDragGhost.pinFrame:SetLock(Editor:GetPinData(pinNode).lock)
    self.pinDragGhost.title:SetText(Editor:GetPinData(pinNode).title or L["Map Pin"])
    self:UpdatePinDragGhostPosition()
    self.pinDragGhost:Show()
    SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
end

function MapPinEnhancedEditorMixin:UpdatePinDragGhostPosition()
    local cursorX, cursorY = GetCursorPosition()
    cursorX = cursorX / UIParent:GetEffectiveScale()
    cursorY = cursorY / UIParent:GetEffectiveScale()
    self.pinDragGhost:ClearAllPoints()
    self.pinDragGhost:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", cursorX + 16, cursorY - 16)
end

function MapPinEnhancedEditorMixin:StopPinDrag()
    if not self.draggedPinNode then return end
    self.pinDragGhost:Hide()
    if self.dragSourceFrame then self.dragSourceFrame:SetAlpha(1) end
    local targetGroup = self.groupSidebar:GetDropTarget()
    if targetGroup and self.draggedPinNode then
        Editor:MovePinToGroup(self.draggedPinNode.group, self.draggedPinNode.pinID, targetGroup)
    else
        self.groupEditor:FinishPinDrop()
    end
    if self.dragSourceFrame and self.dragSourceFrame.dragHandle:IsMouseOver() then
        SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
    else
        ResetCursor()
    end
    self.draggedPinNode = nil
    self.dragSourceFrame = nil
    self.groupSidebar:ClearDropTarget()
    self.groupEditor:ClearDropTarget()
    self:RequestRefresh()
end

function MapPinEnhancedEditorMixin:CancelPinDrag()
    self.pinDragGhost:Hide()
    if self.dragSourceFrame then self.dragSourceFrame:SetAlpha(1) end
    ResetCursor()
    self.draggedPinNode = nil
    self.dragSourceFrame = nil
    self.groupSidebar:ClearDropTarget()
    self.groupEditor:ClearDropTarget()
end

function MapPinEnhancedEditorMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self.selectedGroup = nil
    self.groupSidebar:ClearSearch()
    self.groupSidebar:Refresh()
    self.groupEditor:SetGroup(nil)
    self:Show()
end

function MapPinEnhancedEditorMixin:OnHide()
    MapPinEnhancedWindowMixin.OnHide(self)
    self:CancelPinDrag()
end

function MapPinEnhancedEditorMixin:HideFrame()
    self:Hide()
end
