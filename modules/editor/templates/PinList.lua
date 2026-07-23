---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedEditorPinListTemplate : Frame
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar

function MapPinEnhancedEditorMixin:SetupPinList()
    local pinList = self.collectionEditor.editor.pinList
    self.pinDataProvider = CreateDataProvider()

    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("MapPinEnhancedEditorPinEntryTemplate", function(entry, pinData)
        ---@cast entry MapPinEnhancedEditorPinEntryTemplate
        ---@cast pinData pinData
        entry:Init(pinData, self)
    end)
    scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedEditorPinEntryTemplate
        entry:Reset()
    end)
    scrollView:SetDataProvider(self.pinDataProvider)

    pinList.scrollBar:SetInterpolateScroll(true)
    pinList.scrollBox:SetInterpolateScroll(true)
    pinList.scrollBar:SetHideIfUnscrollable(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(pinList.scrollBox, pinList.scrollBar, scrollView)
end

function MapPinEnhancedEditorMixin:UpdatePinList()
    self.pinDataProvider:Flush()
    if not self.selectedCollection then return end

    for _, pinData in ipairs(self.selectedCollection.pins or {}) do
        self.pinDataProvider:Insert(pinData)
    end
end

---@param pinData pinData
function MapPinEnhancedEditorMixin:DeletePinData(pinData)
    if not self.selectedCollection then return end

    local pinIndex = self.selectedCollection:GetPinIndexByPindata(pinData)
    if not pinIndex then return end

    self.selectedCollection:RemovePin(pinIndex)
    self:UpdatePinList()
end

---@param pinData pinData
function MapPinEnhancedEditorMixin:DuplicatePinData(pinData)
    if not self.selectedCollection then return end

    local pinIndex = self.selectedCollection:GetPinIndexByPindata(pinData)
    if not pinIndex then return end

    local duplicatePinData = CopyTable(pinData)
    table.insert(self.selectedCollection.pins, pinIndex + 1, duplicatePinData)
    self.selectedCollection.count = self.selectedCollection.count + 1
    self:PersistSelectedCollection()
    self:UpdatePinList()
end

---@param entry MapPinEnhancedEditorPinEntryTemplate
function MapPinEnhancedEditorMixin:StartPinDrag(entry)
    self:ClearPinDragState()
    self.draggedPinEntry = entry
    self.pinDropTarget = entry
    entry:SetDragging(true)
    entry:SetScript("OnUpdate", function()
        self:UpdatePinDrag()
    end)
    SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
end

---@param entry MapPinEnhancedEditorPinEntryTemplate?
function MapPinEnhancedEditorMixin:SetPinDropTarget(entry)
    if not self.draggedPinEntry then return end
    if self.pinDropTarget == entry then return end
    if self.pinDropTarget then
        self.pinDropTarget:SetDropTarget(false)
    end

    self.pinDropTarget = entry
    if entry and entry ~= self.draggedPinEntry then
        entry:SetDropTarget(true)
    end
end

function MapPinEnhancedEditorMixin:UpdatePinDrag()
    if not self.draggedPinEntry then return end
    if not IsMouseButtonDown("LeftButton") then
        self:FinishPinDrag()
        return
    end

    local hoveredEntry
    self.collectionEditor.editor.pinList.scrollBox:ForEachFrame(function(frame)
        ---@cast frame MapPinEnhancedEditorPinEntryTemplate
        if frame:IsMouseOver() then
            hoveredEntry = frame
        end
    end)

    if hoveredEntry then
        self:SetPinDropTarget(hoveredEntry)
    end
end

function MapPinEnhancedEditorMixin:ClearPinDragState()
    if self.draggedPinEntry then
        self.draggedPinEntry:SetDragging(false)
        self.draggedPinEntry:SetScript("OnUpdate", nil)
    end
    if self.pinDropTarget then
        self.pinDropTarget:SetDropTarget(false)
    end

    self.draggedPinEntry = nil
    self.pinDropTarget = nil
    ResetCursor()
end

function MapPinEnhancedEditorMixin:FinishPinDrag()
    local draggedEntry = self.draggedPinEntry
    local dropTarget = self.pinDropTarget
    self:ClearPinDragState()

    if not self.selectedCollection or not draggedEntry or not dropTarget or draggedEntry == dropTarget then return end
    if not draggedEntry.pinData or not dropTarget.pinData then return end

    local fromIndex = self.selectedCollection:GetPinIndexByPindata(draggedEntry.pinData)
    local toIndex = self.selectedCollection:GetPinIndexByPindata(dropTarget.pinData)
    if not fromIndex or not toIndex or fromIndex == toIndex then return end

    local movedPinData = table.remove(self.selectedCollection.pins, fromIndex)
    if fromIndex < toIndex then
        toIndex = toIndex - 1
    end
    table.insert(self.selectedCollection.pins, toIndex, movedPinData)

    self:PersistSelectedCollection()
    self:UpdatePinList()
end
