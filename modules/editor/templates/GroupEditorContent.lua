---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Editor = MapPinEnhanced:GetModule("Editor")

---@class MapPinEnhancedGroupEditorContentEmptyState : Frame
---@field message FontString
---@field createButton Button

---@class MapPinEnhancedGroupEditorContentBody : Frame
---@field header MapPinEnhancedGroupEditorContentHeaderTemplate
---@field scrollBox Frame|ScrollBoxListMixin
---@field scrollBar ScrollBarMixin

---@class MapPinEnhancedGroupEditorContentLoadingOverlay : Frame
---@field message FontString

---@class MapPinEnhancedGroupEditorContentTemplate : Frame
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field group MapPinEnhancedGroupMixin?
---@field emptyState MapPinEnhancedGroupEditorContentEmptyState
---@field content MapPinEnhancedGroupEditorContentBody
---@field dataProvider DataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field dropTarget MapPinEnhancedEditorPinNodeData?
---@field dropPlacement "before"|"after"|nil
---@field loadingOverlay MapPinEnhancedGroupEditorContentLoadingOverlay
MapPinEnhancedGroupEditorContentMixin = {}

function MapPinEnhancedGroupEditorContentMixin:OnLoad()
    self.emptyState.message:SetText(L["Select a group to start editing."])
    self.loadingOverlay.message:SetText(L["Loading"])
    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetPadding(8, 8, 0, 0, 0)
    self.scrollView:SetElementInitializer("MapPinEnhancedGroupEditorContentPinEntryTemplate", function(entry, pinNode)
        ---@cast entry MapPinEnhancedGroupEditorContentPinEntryTemplate
        ---@cast pinNode MapPinEnhancedEditorPinNodeData
        entry:Init(pinNode, self.editor)
    end)
    self.scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedGroupEditorContentPinEntryTemplate
        entry:Reset()
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.content.scrollBar:SetHideIfUnscrollable(true)
    self.content.scrollBar:SetInterpolateScroll(true)
    self.content.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.content.scrollBox, self.content.scrollBar, self.scrollView)
end

---@param loading boolean
function MapPinEnhancedGroupEditorContentMixin:SetLoading(loading)
    self.loadingOverlay:SetShown(loading)
end

---@param editor MapPinEnhancedGroupEditorTemplate
function MapPinEnhancedGroupEditorContentMixin:SetEditor(editor)
    self.editor = editor
end

---@param group MapPinEnhancedGroupMixin?
---@param focusName boolean?
function MapPinEnhancedGroupEditorContentMixin:SetGroup(group, focusName)
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

function MapPinEnhancedGroupEditorContentMixin:ClearDropTarget()
    self.dropTarget, self.dropPlacement = nil, nil
    self.content.scrollBox:ForEachFrame(function(frame) frame:ClearDropTarget() end)
end

function MapPinEnhancedGroupEditorContentMixin:AutoScrollForDrag()
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

function MapPinEnhancedGroupEditorContentMixin:UpdateDrag()
    self:AutoScrollForDrag()
    ---@type MapPinEnhancedEditorPinNodeData?
    local target
    ---@type "before"|"after"|nil
    local placement
    ---@param frame MapPinEnhancedGroupEditorContentPinEntryTemplate
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

function MapPinEnhancedGroupEditorContentMixin:FinishPinDrop()
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
end
