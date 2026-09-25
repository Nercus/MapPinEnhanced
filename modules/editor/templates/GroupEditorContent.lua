---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Editor = MapPinEnhanced:GetModule("Editor")
local Transfer = MapPinEnhanced:GetModule("Transfer")
local ADD_PIN_ROW = {}
local PIN_INPUT_FIELDS = { "nameField", "mapField", "xField", "yField" }

---@class MapPinEnhancedGroupEditorAddPinRow : Frame
---@field button MapPinEnhancedButtonTemplate

---@class MapPinEnhancedGroupEditorContentEmptyState : Frame
---@field message FontString
---@field createButton Button
---@field importButton MapPinEnhancedButtonTemplate

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
    self.emptyState.importButton:SetScript("OnClick", function() Transfer:ShowImportWindow() end)
    self.loadingOverlay.message:SetText(L["Loading"])
    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    ---@diagnostic disable-next-line: redundant-parameter
    self.scrollView:SetPadding(8, 8, 0, 0, 0)
    self.scrollView:SetElementFactory(function(factory, data)
        if data == ADD_PIN_ROW then
            factory("MapPinEnhancedGroupEditorAddPinRowTemplate", function(entry)
                ---@cast entry MapPinEnhancedGroupEditorAddPinRow
                local group = self.group
                entry.button:SetEnabled(group ~= nil and
                    (not group:IsProtected() or group.groupType == "ungrouped"))
                entry.button:SetScript("OnClick", function() self:AddPin() end)
            end)
        else
            factory("MapPinEnhancedGroupEditorContentPinEntryTemplate", function(entry)
                ---@cast entry MapPinEnhancedGroupEditorContentPinEntryTemplate
                entry:Init(data, self.editor)
            end)
        end
    end)
    self.scrollView:SetElementResetter(function(entry, data)
        if data == ADD_PIN_ROW then
            ---@cast entry MapPinEnhancedGroupEditorAddPinRow
            entry.button:SetScript("OnClick", nil)
            entry.button:Disable()
        else
            ---@cast entry MapPinEnhancedGroupEditorContentPinEntryTemplate
            entry:Reset()
        end
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.content.scrollBar:SetHideIfUnscrollable(true)
    self.content.scrollBar:SetInterpolateScroll(true)
    self.content.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.content.scrollBox, self.content.scrollBar, self.scrollView)
end

function MapPinEnhancedGroupEditorContentMixin:AddPin()
    local group = self.group
    if not group or (group:IsProtected() and group.groupType ~= "ungrouped") then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then
        MapPinEnhanced:Print(L["Unable to determine your current map location."])
        return
    end
    local _, pinID = group:AddPin({ mapID = mapID, x = x, y = y })
    if not pinID then return end
    ---@type UUID[]
    local pinIDs = {}
    for _, node in ipairs(Editor:GetSortedPins(group)) do
        if node.pinID ~= pinID then pinIDs[#pinIDs + 1] = node.pinID end
    end
    pinIDs[#pinIDs + 1] = pinID
    Editor:ApplyPinOrder(group, pinIDs)
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
    local retainScrollPosition = group ~= nil and self.group == group
    self.group = group
    self.emptyState:SetShown(not group)
    self.content:SetShown(group ~= nil)
    -- Publish the complete list once so pooled rows never display a partially rebuilt list.
    local pins = group and Editor:GetSortedPins(group) or {}
    self.dataProvider = CreateDataProvider(pins)
    if group then self.dataProvider:Insert(ADD_PIN_ROW) end
    self.content.scrollBox:SetDataProvider(self.dataProvider, retainScrollPosition)
    if not group then
        self.content.header:Reset()
        return
    end
    self.content.header:SetGroup(group, self.editor, focusName)
end

---@param entry MapPinEnhancedGroupEditorContentPinEntryTemplate
---@param input EditBox
function MapPinEnhancedGroupEditorContentMixin:FocusNextPinInput(entry, input)
    ---@type number?
    local pinIndex = self.dataProvider:FindIndex(entry.pinNode)
    if not pinIndex then return end
    ---@type number?
    local inputIndex
    for index, field in ipairs(PIN_INPUT_FIELDS) do
        if entry[field].child == input then
            inputIndex = index
            break
        end
    end
    if not inputIndex then return end

    local direction = IsShiftKeyDown() and -1 or 1
    local inputCount = #PIN_INPUT_FIELDS
    local nextIndex = ((pinIndex - 1) * inputCount + inputIndex - 1 + direction) %
        ((self.dataProvider:GetSize() - 1) * inputCount)
    local nextPinIndex = math.floor(nextIndex / inputCount) + 1
    local nextField = PIN_INPUT_FIELDS[nextIndex % inputCount + 1]
    ---@type MapPinEnhancedEditorPinNodeData
    local nextNode = self.dataProvider:Find(nextPinIndex)

    -- Apply the current edit before scrolling can release its pooled row.
    input:ClearFocus()
    if input == entry.mapField.child then
        local mapInput = entry.mapField.child
        if mapInput.cancelFilterFunction then mapInput.cancelFilterFunction() end
        mapInput.resultsFrame:Hide()
        mapInput.spinner:Hide()
    end
    local scrollBox = self.content.scrollBox
    scrollBox:ScrollToElementDataIndex(nextPinIndex, ScrollBoxConstants.AlignNearest, 0,
        ScrollBoxConstants.NoScrollInterpolation)
    ---@type MapPinEnhancedGroupEditorContentPinEntryTemplate?
    local nextEntry = scrollBox:FindFrame(nextNode)
    if nextEntry then
        nextEntry[nextField].child:SetFocus()
    end
end

function MapPinEnhancedGroupEditorContentMixin:ClearDropTarget()
    self.dropTarget, self.dropPlacement = nil, nil
    self.content.scrollBox:ForEachFrame(function(frame)
        if frame.ClearDropTarget then frame:ClearDropTarget() end
    end)
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
        if not frame.pinNode then return end
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
