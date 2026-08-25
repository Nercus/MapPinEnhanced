---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")
local Transfer = MapPinEnhanced:GetModule("Transfer")

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
    local show = isTarget and self.editor and self.editor.draggedPinNode and
        self.editor.draggedPinNode.group ~= self.group
    self.dropGlow:SetShown(show)
    local selected = self.editor and self.editor.selectedGroup == self.group
    self:SetAlpha((show or selected) and 1 or 0.5)
end

---@return AnyMenuEntry[]
function MapPinEnhancedGroupEditorSidebarEntryMixin:BuildMenu()
    local group = assert(self.group)
    local editor = assert(self.editor)
    local protected = group:IsProtected()
    local menu = {
        {
            type = "button",
            label = MapPinEnhanced:Iconize("tick", L["Select"]),
            onClick = function() editor:SelectGroup(group) end,
        },
    }

    if group:GetTotalPinCount() > 0 then
        table.insert(menu, {
            type = "button",
            label = MapPinEnhanced:Iconize("export", L["Export"]),
            onClick = function() Transfer:ShowExportWindow(group) end,
        })
    end

    table.insert(menu, { type = "divider" })
    table.insert(menu, {
        type = "button",
        label = MapPinEnhanced:Iconize("trash", protected and L["Clear Group"] or L["Delete Group"]),
        onClick = function()
            local function destroy()
                if protected then
                    group:ClearGroup()
                    editor:RequestRefresh()
                else
                    Groups:DeleteGroup(group)
                    if editor.selectedGroup == group then editor:SelectGroup(nil) end
                end
            end
            if protected then
                MapPinEnhanced:ShowConfirmDialog(L["Clear Group"],
                    string.format(L["Clear all pins from \"%s\"?"], group:GetName()), destroy)
            else
                MapPinEnhanced:ShowConfirmDialog(L["Delete Group"],
                    string.format(L["Delete group \"%s\" and all of its pins?"], group:GetName()), destroy)
            end
        end,
    })

    return menu
end

---@param button mouseButton
function MapPinEnhancedGroupEditorSidebarEntryMixin:OnClick(button)
    if button == "LeftButton" and self.editor and not self.editor.draggedPinNode then
        self.editor:SelectGroup(self.group)
    elseif button == "RightButton" and self.group and self.editor and not self.editor.draggedPinNode then
        MapPinEnhanced:GenerateMenu(self, self:BuildMenu())
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
