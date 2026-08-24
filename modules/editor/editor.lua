---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Editor
---@field EditGroup fun(self: Editor, group: MapPinEnhancedGroupMixin)
local Editor = MapPinEnhanced:GetModule("Editor")
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
    return group.groupType == "ungrouped"
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
---@return pinData
function Editor:GetPinData(pinNode)
    if pinNode.pin then return pinNode.pin:GetPinData() end
    local archivedPin = pinNode.group:GetArchivedPinByID(pinNode.pinID)
    return archivedPin and archivedPin.data or pinNode.pinData
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData[]
function Editor:GetSortedPins(group)
    ---@type MapPinEnhancedEditorPinNodeData[]
    local nodes = {}
    for _, entry in ipairs(group:GetPinEntries()) do
        table.insert(nodes, {
            classification = "editorPin",
            group = group,
            pin = entry.pin,
            pinID = entry.pinID,
            pinData = entry.data,
            archiveState = entry.state ~= "active" and entry.state or nil,
            order = entry.order,
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
    group:ReorderPins(pinIDs)
end

---@param group MapPinEnhancedGroupMixin
---@param pinID UUID
function Editor:RemovePinCompletely(group, pinID)
    group:RemovePin(pinID)
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return UUID?
function Editor:DuplicatePin(pinNode)
    return pinNode.group:DuplicatePin(pinNode.pinID)
end

---@param sourceGroup MapPinEnhancedGroupMixin
---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return boolean
function Editor:MovePinToGroup(sourceGroup, pinID, targetGroup)
    return sourceGroup:MovePinToGroup(pinID, targetGroup)
end

function Editor:GetGroupEditorFrame()
    if not self.groupEditor then
        self.groupEditor = CreateFrame("Frame", "MapPinEnhancedGroupEditor", UIParent,
            "MapPinEnhancedGroupEditorTemplate")
    end
    return self.groupEditor
end

function Editor:ShowEditor()
    local frame = self:GetGroupEditorFrame()
    frame:ShowFrame()
end

---@param group MapPinEnhancedGroupMixin
function Editor:EditGroup(group)
    assert(type(group) == "table" and group.classification == "group", "Editor:EditGroup requires a group")
    if not self:ShouldShowGroup(group) and not self:ShouldShowSystemGroup(group) then return end
    local frame = self:GetGroupEditorFrame()
    frame:ShowFrame()
    frame:SelectGroup(group)
end

function Editor:HideEditor()
    local frame = self:GetGroupEditorFrame()
    if frame:IsShown() then
        frame:HideFrame()
    end
end

function Editor:IsShown()
    local frame = self:GetGroupEditorFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:AddSlashCommand("editor", function()
    if Editor:IsShown() then
        Editor:HideEditor()
    else
        Editor:ShowEditor()
    end
end, L["Toggle the group editor."])
