---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
---@field openDialog DialogTypes?
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@enum DialogTypes
Dialogs.DIALOG_TYPES = {
    IMPORT = "IMPORT",
    EXPORT = "EXPORT",
    CONFIRM = "CONFIRM",
    INFO = "INFO",
    ABOUT = "ABOUT",
}


---@param dialogType DialogTypes
---@param overrideTitle string?
---@return DialogContentFrame
function Dialogs:ShowDialog(dialogType, overrideTitle)
    local dialogFrame = self.dialogFrame
    ---@type DialogContentFrame
    local content
    local title = overrideTitle
    if dialogType == self.DIALOG_TYPES.IMPORT then
        content = self:GetImportContent()
        title = title or L["Import"]
    elseif dialogType == self.DIALOG_TYPES.EXPORT then
        content = self:GetExportContent()
        title = title or L["Export"]
    elseif dialogType == self.DIALOG_TYPES.CONFIRM then
        content = self:GetConfirmContent()
        title = title or L["Confirm"]
    elseif dialogType == self.DIALOG_TYPES.INFO then
        content = self:GetInfoContent()
        title = title or L["Info"]
    elseif dialogType == self.DIALOG_TYPES.ABOUT then
        content = self:GetAboutContent()
        title = title or "by Nerc"
    else
        error("Unknown dialog type: " .. tostring(dialogType))
    end
    self.openDialog = dialogType
    dialogFrame:ShowDialog(content, title)
    return content
end

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
function Dialogs:ShowConfirmDialog(title, message, onConfirm, onCancel)
    local confirmContentFrame = self:ShowDialog(self.DIALOG_TYPES.CONFIRM, title)
    confirmContentFrame:Setup({
        title = title,
        message = message,
        onConfirm = onConfirm,
        onCancel = onCancel,
    })
end

---@param title string?
---@param message string
---@param onClose function?
function Dialogs:ShowInfoDialog(title, message, onClose)
    local infoContentFrame = self:ShowDialog(self.DIALOG_TYPES.INFO, title)
    infoContentFrame:Setup({
        title = title,
        message = message,
        onClose = onClose,
    })
end

function Dialogs:HideDialog(dialogType)
    if self.openDialog and dialogType ~= self.openDialog then
        return
    end
    self.openDialog = nil
    self.dialogFrame:Hide()
end

MapPinEnhanced:AddSlashCommand("import",
    function() Dialogs:ShowDialog(Dialogs.DIALOG_TYPES.IMPORT) end, L
    ["Open the import dialog to import map pins from a string."])

MapPinEnhanced:AddSlashCommand("export",
    function() Dialogs:ShowDialog(Dialogs.DIALOG_TYPES.EXPORT) end,
    L["Open the export dialog to export your map pins to a string."])


MapPinEnhanced:AddSlashCommand({ "version", "about" },
    function() Dialogs:ShowDialog(Dialogs.DIALOG_TYPES.ABOUT) end,
    L["Open the about dialog to view version information."])
