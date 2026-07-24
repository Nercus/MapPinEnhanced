---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

---@return MapPinEnhancedRenameGroupDialogContentTemplate
function Dialogs:GetRenameGroupContent()
    if not self.renameGroupDialog then
        self.renameGroupDialog = CreateFrame("Frame", "MapPinEnhancedRenameGroupDialogContent", UIParent,
            "MapPinEnhancedRenameGroupDialogContentTemplate")
    end
    return self.renameGroupDialog
end

---@class MapPinEnhancedRenameGroupDialogContentTemplate : Frame
---@field nameInput MapPinEnhancedInputTemplate
---@field group MapPinEnhancedGroupMixin | nil
MapPinEnhancedRenameGroupDialogContentMixin = {}

---@class RenameGroupDialogOptions
---@field group MapPinEnhancedGroupMixin

function MapPinEnhancedRenameGroupDialogContentMixin:Accept()
    if not self.group then return false end

    local groupName = Groups:NormalizeGroupName(self.nameInput:GetText() or "")
    if groupName == "" then
        return false
    end

    if groupName == self.group:GetName() then
        return true
    end

    local existingGroup = Groups:GetGroupByName(groupName)
    if existingGroup and existingGroup ~= self.group then
        MapPinEnhanced:Notify(string.format(L["A group named \"%s\" already exists."], groupName), "ERROR")
        return false
    end

    return self.group:SetName(groupName)
end

---@param options RenameGroupDialogOptions
function MapPinEnhancedRenameGroupDialogContentMixin:Setup(options)
    assert(options.group, "MapPinEnhancedRenameGroupDialogContentMixin:Setup requires a group")

    self.group = options.group
    self.nameInput:SetPlaceholderText(L["Group Name"])
    self.nameInput:SetScript("OnEnterPressed", function()
        if self:Accept() then
            Dialogs:HideDialog(Dialogs.DIALOG_TYPES.RENAME_GROUP)
        end
    end)

    self.nameInput:SetText(self.group:GetName() or "")
    self.nameInput:UpdatePlaceholderVisibility()
    self.nameInput:UpdateClearButtonVisibility()
    self.nameInput:SetFocus()
    self.nameInput:HighlightText()
end

function MapPinEnhancedRenameGroupDialogContentMixin:OnClose()
    self.group = nil
    self.nameInput:SetScript("OnEnterPressed", nil)
    self.nameInput:ClearFocus()
end

Dialogs.dialogTypeConfig[Dialogs.DIALOG_TYPES.RENAME_GROUP] = {
    title = L["Rename Group"],
    getContent = function(dialogs)
        return dialogs:GetRenameGroupContent()
    end,
    setup = function(content, options)
        ---@cast content MapPinEnhancedRenameGroupDialogContentTemplate
        ---@cast options RenameGroupDialogOptions
        content:Setup(options)
    end,
    buttons = function(content)
        ---@cast content MapPinEnhancedRenameGroupDialogContentTemplate
        return {
            {
                label = L["Save"],
                callback = function()
                    if content:Accept() then
                        Dialogs:HideDialog(Dialogs.DIALOG_TYPES.RENAME_GROUP)
                    end
                end,
                accept = true,
                closeDialog = false,
            },
        }
    end,
}
