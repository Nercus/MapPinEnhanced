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

---@class MapPinEnhancedGroupEditorTemplate : MapPinEnhancedWindowTemplate
---@field groupEditorSidebar MapPinEnhancedGroupEditorSidebarTemplate
---@field groupEditorContent MapPinEnhancedGroupEditorContentTemplate
---@field pinDragGhost MapPinEnhancedEditorPinDragGhost
---@field selectedGroup MapPinEnhancedGroupMixin?
---@field draggedPinNode MapPinEnhancedEditorPinNodeData?
---@field dragSourceFrame MapPinEnhancedGroupEditorContentPinEntryTemplate?
---@field refreshPending boolean?
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
    self.selectedGroup = group
    self.groupEditorSidebar:Refresh()
    self.groupEditorContent:SetGroup(group, focusName)
    if group then self.groupEditorSidebar:ScrollToGroup(group) end
end

function MapPinEnhancedGroupEditorMixin:RequestRefresh()
    self.refreshPending = true
end

function MapPinEnhancedGroupEditorMixin:OnUpdate()
    ---@type ScriptRegion?
    local focused = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
    local groupEditorContentHasFocus = false
    while focused do
        if focused == self.groupEditorContent then
            groupEditorContentHasFocus = true
            break
        end
        focused = focused.GetParent and focused:GetParent()
    end

    if self.refreshPending and not groupEditorContentHasFocus and not self.draggedPinNode then
        self.refreshPending = nil
        if self.selectedGroup and not Groups:GetGroupByID(self.selectedGroup:GetGroupID()) then
            self.selectedGroup = nil
        end
        self.groupEditorSidebar:Refresh()
        self.groupEditorContent:SetGroup(self.selectedGroup)
    end
    if self.draggedPinNode then
        self:UpdatePinDragGhostPosition()
        self.groupEditorContent:UpdateDrag()
        self.groupEditorSidebar:UpdateDropTarget()
    end
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
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", refresh)
    MapPinEnhanced:RegisterCallback("GROUP_DELETED", refresh)
end

function MapPinEnhancedGroupEditorMixin:StartPinDrag(pinNode, sourceFrame)
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

function MapPinEnhancedGroupEditorMixin:UpdatePinDragGhostPosition()
    local cursorX, cursorY = GetCursorPosition()
    cursorX = cursorX / UIParent:GetEffectiveScale()
    cursorY = cursorY / UIParent:GetEffectiveScale()
    self.pinDragGhost:ClearAllPoints()
    self.pinDragGhost:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", cursorX + 16, cursorY - 16)
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
end

function MapPinEnhancedGroupEditorMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self.selectedGroup = nil
    self.groupEditorSidebar:ClearSearch()
    self.groupEditorSidebar:Refresh()
    self.groupEditorContent:SetGroup(nil)
    self:Show()
end

function MapPinEnhancedGroupEditorMixin:OnHide()
    MapPinEnhancedWindowMixin.OnHide(self)
    self:CancelPinDrag()
end

function MapPinEnhancedGroupEditorMixin:HideFrame()
    self:Hide()
end
