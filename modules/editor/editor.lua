---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Editor
---@field EditGroup fun(self: Editor, group: MapPinEnhancedGroupMixin)
local Editor = MapPinEnhanced:GetModule("Editor")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

Editor.DEFAULT_GROUP_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Editor:ShouldShowGroup(group)
    return not group:IsProtected()
end

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Editor:ShouldShowSystemGroup(group)
    return group:IsProtected()
end

---@param group1 MapPinEnhancedGroupMixin
---@param group2 MapPinEnhancedGroupMixin
---@return boolean
function Editor:IsGroupBefore(group1, group2)
    local order1, order2 = group1.order or 0, group2.order or 0
    if order1 ~= order2 then return order1 > order2 end
    return (group1.name or "") < (group2.name or "")
end

---@param value string|number|nil
---@return number?
function Editor:ParsePercent(value)
    local numberValue = tonumber(value)
    if not numberValue then return nil end
    if numberValue > 1 then numberValue = numberValue / 100 end
    if numberValue < 0 or numberValue > 1 then return nil end
    return numberValue
end

---@param value number?
---@return string
function Editor:FormatPercent(value)
    return value and string.format("%.2f", value * 100) or ""
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return SaveablePinData
function Editor:GetPinData(pinNode)
    return pinNode.pin and pinNode.pin:GetPinData() or pinNode.archivedPin.data
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData[]
function Editor:GetSortedPins(group)
    local nodes = {}
    for pinID, pin in group:EnumeratePins() do
        table.insert(nodes, {
            classification = "editorPin",
            group = group,
            pin = pin,
            pinID = pinID,
            order = group:GetPinOrder(pinID),
        })
    end
    for pinID, archivedPin in group:EnumerateArchivedPins() do
        table.insert(nodes, {
            classification = "editorPin",
            group = group,
            pinID = pinID,
            archivedPin = archivedPin,
            archiveState = archivedPin.state,
            order = archivedPin.order or 0,
        })
    end
    table.sort(nodes, function(a, b)
        if (a.order or 0) ~= (b.order or 0) then return (a.order or 0) > (b.order or 0) end
        return ((self:GetPinData(a).title or "") < (self:GetPinData(b).title or ""))
    end)
    return nodes
end

---@param group MapPinEnhancedGroupMixin
---@param pinIDs UUID[]
function Editor:ApplyPinOrder(group, pinIDs)
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
function Editor:RemovePinCompletely(group, pinID)
    group:RemovePin(pinID)
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return UUID?
function Editor:DuplicatePin(pinNode)
    local data = CopyTable(self:GetPinData(pinNode))
    data.pinID = nil

    local _, duplicatePinID = pinNode.group:AddPin(data)
    if not duplicatePinID then return nil end

    local ids = {}
    for _, node in ipairs(self:GetSortedPins(pinNode.group)) do
        if node.pinID ~= duplicatePinID then
            table.insert(ids, node.pinID)
            if node.pinID == pinNode.pinID then
                table.insert(ids, duplicatePinID)
            end
        end
    end
    self:ApplyPinOrder(pinNode.group, ids)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, pinNode.group)
    return duplicatePinID
end

---@param sourceGroup MapPinEnhancedGroupMixin
---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return boolean
function Editor:MovePinToGroup(sourceGroup, pinID, targetGroup)
    if sourceGroup == targetGroup then return false end
    local pin = sourceGroup:GetPinByID(pinID)
    local archivedPin = sourceGroup:GetArchivedPinByID(pinID)
    local data = pin and CopyTable(pin:GetSaveableData()) or
        (archivedPin and CopyTable(archivedPin.data) or nil)
    if not data then return false end

    self:RemovePinCompletely(sourceGroup, pinID)
    local targetNodes = self:GetSortedPins(targetGroup)
    targetGroup:AddPin(data, pinID, true, true)
    local ids = {}
    for _, node in ipairs(targetNodes) do table.insert(ids, node.pinID) end
    table.insert(ids, pinID)
    self:ApplyPinOrder(targetGroup, ids)
    Groups:PersistGroup(targetGroup)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)
    return true
end

function Editor:GetEditorFrame()
    if not self.editorFrame then
        self.editorFrame = CreateFrame("Frame", "MapPinEnhancedEditor", UIParent, "MapPinEnhancedEditorTemplate")
    end
    return self.editorFrame
end

function Editor:ShowEditor()
    local frame = self:GetEditorFrame()
    frame:ShowFrame()
end

---@param group MapPinEnhancedGroupMixin
function Editor:EditGroup(group)
    assert(type(group) == "table" and group.classification == "group", "Editor:EditGroup requires a group")
    local frame = self:GetEditorFrame()
    frame:ShowFrame()
    frame:SelectGroup(group)
end

--@debug@

MapPinEnhanced:Test("Opening the editor preserves the requested group selection", function()
    local group = { classification = "group" }
    local frame = {
        selectedGroup = nil,
        ShowFrame = function(self) self.selectedGroup = nil end,
        SelectGroup = function(self, selectedGroup) self.selectedGroup = selectedGroup end,
    }
    local GetEditorFrame = Editor.GetEditorFrame
    Editor.GetEditorFrame = function() return frame end

    Editor:EditGroup(group)

    Editor.GetEditorFrame = GetEditorFrame
    assert(frame.selectedGroup == group, "Editor:EditGroup must select the group after showing the editor")
end)

--@end-debug@

function Editor:HideEditor()
    local frame = self:GetEditorFrame()
    if frame:IsShown() then
        frame:HideFrame()
    end
end

function Editor:IsShown()
    local frame = self:GetEditorFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:AddSlashCommand("editor", function()
    if Editor:IsShown() then
        Editor:HideEditor()
    else
        Editor:ShowEditor()
    end
end, L["Toggle the group editor."])
