---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedGroupEditorSidebarEntryTemplate : Button
---@field group MapPinEnhancedGroupMixin?
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field icon Texture
---@field name FontString
---@field detail FontString
---@field selectedGlow Texture
---@field dropGlow Texture
MapPinEnhancedGroupEditorSidebarEntryMixin = {}

function MapPinEnhancedGroupEditorSidebarEntryMixin:Reset()
    self.group = nil
    self.editor = nil
    self.selectedGlow:Hide()
    self.dropGlow:Hide()
end

---@param group MapPinEnhancedGroupMixin
---@param editor MapPinEnhancedGroupEditorTemplate
function MapPinEnhancedGroupEditorSidebarEntryMixin:Init(group, editor)
    self.group = group
    self.editor = editor
    self.icon:SetTexture(group:GetIcon())
    self.name:SetText(group:GetName())
    local detail = string.format(L["%d |4pin:pins;"], group:GetTotalPinCount())
    if group:IsHidden() then detail = L["Hidden"] .. " · " .. detail end
    self.detail:SetText(detail)
    self.selectedGlow:SetShown(editor.selectedGroup == group)
end

---@param isTarget boolean
function MapPinEnhancedGroupEditorSidebarEntryMixin:SetDropTarget(isTarget)
    self.dropGlow:SetShown(isTarget and self.editor and self.editor.draggedPinNode and
        self.editor.draggedPinNode.group ~= self.group)
end

---@param button mouseButton
function MapPinEnhancedGroupEditorSidebarEntryMixin:OnClick(button)
    if button == "LeftButton" and self.editor and not self.editor.draggedPinNode then
        self.editor:SelectGroup(self.group)
    end
end

---@param button mouseButton
function MapPinEnhancedGroupEditorSidebarEntryMixin:OnMouseUp(button)
    if button == "LeftButton" and self.editor and self.editor.draggedPinNode then
        self.editor:StopPinDrag()
    end
end

function MapPinEnhancedGroupEditorSidebarEntryMixin:OnReceiveDrag()
    if self.editor and self.editor.draggedPinNode then self.editor:StopPinDrag() end
end
