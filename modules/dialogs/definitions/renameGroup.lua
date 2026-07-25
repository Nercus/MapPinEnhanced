---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L
local definition = Dialogs.DIALOG_DEFINITIONS.RENAME_GROUP

---@class RenameGroupDialogOptions
---@field group MapPinEnhancedGroupMixin

Dialogs:RegisterStaticDialogDefinition(definition, {
    text = "",
    button1 = L["Save"],
    button2 = L["Cancel"],
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenameGroupDialogOptions
        local editBox = Dialogs:GetStaticDialogEditBox(self)
        if not editBox then return end

        editBox:SetNumeric(false)
        editBox:SetMaxLetters(0)
        editBox:SetText(data and data.group and data.group:GetName() or "")
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenameGroupDialogOptions
        if not data or not data.group then return end

        local editBox = Dialogs:GetStaticDialogEditBox(self)
        local groupName = Groups:NormalizeGroupName(editBox and editBox:GetText() or "")
        if groupName == "" then
            return true
        end

        if groupName == data.group:GetName() then
            return
        end

        local existingGroup = Groups:GetGroupByName(groupName)
        if existingGroup and existingGroup ~= data.group then
            MapPinEnhanced:Notify(string.format(L["A group named \"%s\" already exists."], groupName), "ERROR")
            return true
        end

        if not data.group:SetName(groupName) then
            return true
        end
    end,
    EditBoxOnEnterPressed = function(editBox)
        Dialogs:ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        Dialogs:ClickStaticDialogButtonForEditBox(editBox, 2)
    end,
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        local editBox = Dialogs:GetStaticDialogEditBox(self)
        if editBox then
            editBox:ClearFocus()
        end
        Dialogs:MarkStaticDialogClosed(definition)
    end,
})

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowRenameGroupDialog(group)
    return self:ShowDialog(definition, L["Rename Group"], {
        group = group,
    })
end

Dialogs:RegisterDialogHandler(definition, function(dialogs, overrideTitle, options)
    ---@cast options RenameGroupDialogOptions
    assert(options.group, "Dialogs:ShowRenameGroupDialog: group is nil")

    return dialogs:ShowStaticDialog(definition, overrideTitle or L["Rename Group"], options)
end)
