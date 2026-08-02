---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

MapPinEnhancedEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)
MapPinEnhancedEditorUtil = MapPinEnhancedEditorUtil or {}
local Util = MapPinEnhancedEditorUtil

Util.DEFAULT_GROUP_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Util.ShouldShowGroup(group)
    return group.groupType ~= "wayBack"
end

---@param group1 MapPinEnhancedGroupMixin
---@param group2 MapPinEnhancedGroupMixin
---@return boolean
function Util.IsGroupBefore(group1, group2)
    local order1, order2 = group1.order or 0, group2.order or 0
    if order1 ~= order2 then return order1 > order2 end
    return (group1.name or "") < (group2.name or "")
end

---@param value string|number|nil
---@return number?
function Util.ParsePercent(value)
    local numberValue = tonumber(value)
    if not numberValue then return nil end
    if numberValue > 1 then numberValue = numberValue / 100 end
    if numberValue < 0 or numberValue > 1 then return nil end
    return numberValue
end

---@param value number?
---@return string
function Util.FormatPercent(value)
    return value and string.format("%.2f", value * 100) or ""
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return SaveablePinData
function Util.GetPinData(pinNode)
    return pinNode.pin and pinNode.pin:GetPinData() or pinNode.archivedPin.data
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData[]
function Util.GetSortedPins(group)
    local nodes = {}
    for pinID, pin in group:EnumeratePins() do
        table.insert(nodes, {
            classification = "editorPin", group = group, pin = pin, pinID = pinID,
            order = group:GetPinOrder(pinID),
        })
    end
    for pinID, archivedPin in group:EnumerateArchivedPins() do
        table.insert(nodes, {
            classification = "editorPin", group = group, pinID = pinID, archivedPin = archivedPin,
            archiveState = archivedPin.state, order = archivedPin.order or 0,
        })
    end
    table.sort(nodes, function(a, b)
        if (a.order or 0) ~= (b.order or 0) then return (a.order or 0) > (b.order or 0) end
        return ((Util.GetPinData(a).title or "") < (Util.GetPinData(b).title or ""))
    end)
    return nodes
end

---@param group MapPinEnhancedGroupMixin
---@param pinIDs UUID[]
function Util.ApplyPinOrder(group, pinIDs)
    local count = #pinIDs
    for index, pinID in ipairs(pinIDs) do
        local order = count - index + 1
        local archivedPin = group:GetArchivedPinByID(pinID)
        if archivedPin then
            archivedPin.order = order
            group.pinOrder[pinID] = nil
        else
            group:SetPinOrder(pinID, order, true)
        end
    end
    Groups:PersistGroup(group)
end

---@param group MapPinEnhancedGroupMixin
---@param pinID UUID
function Util.RemovePinCompletely(group, pinID)
    group:RemovePin(pinID)
end

---@param sourceGroup MapPinEnhancedGroupMixin
---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return boolean
function Util.MovePinToGroup(sourceGroup, pinID, targetGroup)
    if sourceGroup == targetGroup then return false end
    local pin = sourceGroup:GetPinByID(pinID)
    local archivedPin = sourceGroup:GetArchivedPinByID(pinID)
    local data = pin and CopyTable(pin:GetSaveableData()) or
        (archivedPin and CopyTable(archivedPin.data) or nil)
    if not data then return false end

    Util.RemovePinCompletely(sourceGroup, pinID)
    local targetNodes = Util.GetSortedPins(targetGroup)
    targetGroup:AddPin(data, pinID, true, true)
    local ids = {}
    for _, node in ipairs(targetNodes) do table.insert(ids, node.pinID) end
    table.insert(ids, pinID)
    Util.ApplyPinOrder(targetGroup, ids)
    Groups:PersistGroup(targetGroup)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)
    return true
end

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
        icon = Util.DEFAULT_GROUP_ICON,
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
    if Util.GetPinData(pinNode).texture then
        self.pinDragGhost.pinFrame:SetIconTexture(
            Util.GetPinData(pinNode).texture,
            Util.GetPinData(pinNode).usesAtlas
        )
    else
        self.pinDragGhost.pinFrame:SetColor(Util.GetPinData(pinNode).color)
    end
    self.pinDragGhost.pinFrame:SetTracked(true)
    self.pinDragGhost.pinFrame:SetLock(Util.GetPinData(pinNode).lock)
    self.pinDragGhost.title:SetText(Util.GetPinData(pinNode).title or L["Map Pin"])
    self:UpdatePinDragGhostPosition()
    self.pinDragGhost:Show()
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
        Util.MovePinToGroup(self.draggedPinNode.group, self.draggedPinNode.pinID, targetGroup)
    else
        self.groupEditor:FinishPinDrop()
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
