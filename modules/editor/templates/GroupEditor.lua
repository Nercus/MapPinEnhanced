---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Util = MapPinEnhancedEditorUtil

MapPinEnhancedEditorGroupEditorMixin = {}

function MapPinEnhancedEditorGroupEditorMixin:OnLoad()
    self.emptyState.message:SetText(L["Select a group to start editing."])
    self.emptyState.createButton:SetText(L["Create Group"])
    local content = self.content
    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetElementInitializer("MapPinEnhancedEditorGroupEditorPinEntryTemplate", function(entry, pinNode)
        entry:Init(pinNode, self.editor)
    end)
    self.scrollView:SetElementResetter(function(entry) entry:Reset() end)
    self.scrollView:SetDataProvider(self.dataProvider)
    content.scrollBar:SetHideIfUnscrollable(true)
    content.scrollBar:SetInterpolateScroll(true)
    content.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(content.scrollBox, content.scrollBar, self.scrollView)
end

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
    for _, pinNode in ipairs(Util.GetSortedPins(group)) do self.dataProvider:Insert(pinNode) end
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
    local scrollBox = self.content.scrollBox
    local scale = scrollBox:GetEffectiveScale()
    cursorX, cursorY = cursorX / scale, cursorY / scale
    if cursorX < scrollBox:GetLeft() or cursorX > scrollBox:GetRight() then return end
    local top, bottom = scrollBox:GetTop(), scrollBox:GetBottom()
    if cursorY > top - 32 then
        scrollBox:ScrollBy(-18)
    elseif cursorY < bottom + 32 then
        scrollBox:ScrollBy(18)
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
    for _, node in ipairs(Util.GetSortedPins(target.group)) do
        if node.pinID ~= moved.pinID then
            if node.pinID == target.pinID and placement == "before" then table.insert(ids, moved.pinID) end
            table.insert(ids, node.pinID)
            if node.pinID == target.pinID and placement == "after" then table.insert(ids, moved.pinID) end
        end
    end
    Util.ApplyPinOrder(target.group, ids)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, target.group)
end
