---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

MapPinEnhancedEditorGroupSidebarEntryMixin = {}

function MapPinEnhancedEditorGroupSidebarEntryMixin:Reset()
    self.group = nil
    self.editor = nil
    self.selectedGlow:Hide()
    self.dropGlow:Hide()
end

function MapPinEnhancedEditorGroupSidebarEntryMixin:Init(group, editor)
    self.group = group
    self.editor = editor
    self.icon:SetTexture(group:GetIcon())
    self.name:SetText(group:GetName())
    local detail = string.format(L["%d |4pin:pins;"], group:GetTotalPinCount())
    if group:IsHidden() then detail = L["Hidden"] .. " · " .. detail end
    self.detail:SetText(detail)
    self.selectedGlow:SetShown(editor.selectedGroup == group)
end

function MapPinEnhancedEditorGroupSidebarEntryMixin:SetDropTarget(isTarget)
    self.dropGlow:SetShown(isTarget and self.editor and self.editor.draggedPinNode and
        self.editor.draggedPinNode.group ~= self.group)
end

function MapPinEnhancedEditorGroupSidebarEntryMixin:OnClick(button)
    if button == "LeftButton" and self.editor and not self.editor.draggedPinNode then
        self.editor:SelectGroup(self.group)
    end
end

function MapPinEnhancedEditorGroupSidebarEntryMixin:OnMouseUp(button)
    if button == "LeftButton" and self.editor and self.editor.draggedPinNode then
        self.editor:StopPinDrag()
    end
end

function MapPinEnhancedEditorGroupSidebarEntryMixin:OnReceiveDrag()
    if self.editor and self.editor.draggedPinNode then self.editor:StopPinDrag() end
end
