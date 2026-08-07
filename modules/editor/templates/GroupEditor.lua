---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Editor = MapPinEnhanced:GetModule("Editor")

---@class MapPinEnhancedEditorGroupEditorEmptyState : Frame
---@field message FontString
---@field createButton Button

---@class MapPinEnhancedEditorGroupEditorContent : Frame
---@field header MapPinEnhancedEditorGroupEditorHeaderTemplate
---@field scrollBox Frame|ScrollBoxListMixin
---@field scrollBar ScrollBarMixin

---@class MapPinEnhancedEditorLoadingOverlay : Frame
---@field message FontString

---@class MapPinEnhancedEditorGroupEditorTemplate : Frame
---@field editor MapPinEnhancedEditorTemplate?
---@field group MapPinEnhancedGroupMixin?
---@field emptyState MapPinEnhancedEditorGroupEditorEmptyState
---@field content MapPinEnhancedEditorGroupEditorContent
---@field dataProvider DataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field dropTarget MapPinEnhancedEditorPinNodeData?
---@field dropPlacement "before"|"after"|nil
---@field loadingOverlay MapPinEnhancedEditorLoadingOverlay
MapPinEnhancedEditorGroupEditorMixin = {}

function MapPinEnhancedEditorGroupEditorMixin:OnLoad()
    self.emptyState.message:SetText(L["Select a group to start editing."])
    self.loadingOverlay.message:SetText(L["Loading"])
    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetElementInitializer("MapPinEnhancedEditorGroupEditorPinEntryTemplate", function(entry, pinNode)
        ---@cast entry MapPinEnhancedEditorGroupEditorPinEntryTemplate
        ---@cast pinNode MapPinEnhancedEditorPinNodeData
        entry:Init(pinNode, self.editor)
    end)
    self.scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedEditorGroupEditorPinEntryTemplate
        entry:Reset()
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.content.scrollBar:SetHideIfUnscrollable(true)
    self.content.scrollBar:SetInterpolateScroll(true)
    self.content.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.content.scrollBox, self.content.scrollBar, self.scrollView)
end

---@param loading boolean
function MapPinEnhancedEditorGroupEditorMixin:SetLoading(loading)
    self.loadingOverlay:SetShown(loading)
end

---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorGroupEditorMixin:SetEditor(editor)
    self.editor = editor
end

---@param group MapPinEnhancedGroupMixin?
---@param focusName boolean?
function MapPinEnhancedEditorGroupEditorMixin:SetGroup(group, focusName)
    self.group = group
    self.emptyState:SetShown(not group)
    self.content:SetShown(group ~= nil)
    self.dataProvider:Flush()
    if not group then
        self.content.header:Reset()
        return
    end
    self.content.header:SetGroup(group, self.editor, focusName)
    for _, pinNode in ipairs(Editor:GetSortedPins(group)) do self.dataProvider:Insert(pinNode) end
end

function MapPinEnhancedEditorGroupEditorMixin:IsEditing()
    local focused = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
    while focused do
        if focused == self then return true end
        focused = focused.GetParent and focused:GetParent()
    end
    return false
end

function MapPinEnhancedEditorGroupEditorMixin:ClearDropTarget()
    self.dropTarget, self.dropPlacement = nil, nil
    self.content.scrollBox:ForEachFrame(function(frame) frame:ClearDropTarget() end)
end

function MapPinEnhancedEditorGroupEditorMixin:AutoScrollForDrag()
    local cursorX, cursorY = GetCursorPosition()
    local scale = self.content.scrollBox:GetEffectiveScale()
    cursorX, cursorY = cursorX / scale, cursorY / scale
    if cursorX < self.content.scrollBox:GetLeft() or cursorX > self.content.scrollBox:GetRight() then return end
    local top, bottom = self.content.scrollBox:GetTop(), self.content.scrollBox:GetBottom()
    if cursorY > top - 32 then
        self.content.scrollBox:ScrollToOffset(
            self.content.scrollBox:GetDerivedScrollOffset() - 18,
            ScrollBoxConstants.NoScrollInterpolation
        )
    elseif cursorY < bottom + 32 then
        self.content.scrollBox:ScrollToOffset(
            self.content.scrollBox:GetDerivedScrollOffset() + 18,
            ScrollBoxConstants.NoScrollInterpolation
        )
    end
end

function MapPinEnhancedEditorGroupEditorMixin:UpdateDrag()
    self:AutoScrollForDrag()
    local target, placement
    self.content.scrollBox:ForEachFrame(function(frame)
        local valid = not target and frame:IsMouseOver() and self.editor.draggedPinNode and
            frame.pinNode.pinID ~= self.editor.draggedPinNode.pinID
        if valid then
            target, placement = frame.pinNode, frame:GetDropPlacement()
            frame:SetDropTarget(placement)
        else
            frame:ClearDropTarget()
        end
    end)
    self.dropTarget, self.dropPlacement = target, placement
end

function MapPinEnhancedEditorGroupEditorMixin:FinishPinDrop()
    local moved = self.editor.draggedPinNode
    local target, placement = self.dropTarget, self.dropPlacement
    if not moved or not target or moved.group ~= target.group or moved.pinID == target.pinID then return end

    local ids = {}
    for _, node in ipairs(Editor:GetSortedPins(target.group)) do
        if node.pinID ~= moved.pinID then
            if node.pinID == target.pinID and placement == "before" then table.insert(ids, moved.pinID) end
            table.insert(ids, node.pinID)
            if node.pinID == target.pinID and placement == "after" then table.insert(ids, moved.pinID) end
        end
    end
    Editor:ApplyPinOrder(target.group, ids)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, target.group)
end
