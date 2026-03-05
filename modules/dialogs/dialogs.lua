---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@enum DialogTypes
local DIALOG_TYPES = {
    IMPORT = "IMPORT",
    EXPORT = "EXPORT",
    CONFIRM = "CONFIRM",
    INFO = "INFO",
}

---@param dialogType DialogTypes
---@param overrideTitle string?
---@return DialogContentFrame
function Dialogs:ShowDialog(dialogType, overrideTitle)
    local dialogFrame = self.dialogFrame
    ---@type DialogContentFrame
    local content
    local title = overrideTitle
    if dialogType == DIALOG_TYPES.IMPORT then
        content = self:GetImportContent()
        title = title or L["Import"]
    elseif dialogType == DIALOG_TYPES.EXPORT then
        content = self:GetExportContent()
        title = title or L["Export"]
    elseif dialogType == DIALOG_TYPES.CONFIRM then
        content = self:GetConfirmContent()
        title = title or L["Confirm"]
    elseif dialogType == DIALOG_TYPES.INFO then
        content = self:GetInfoContent()
        title = title or L["Info"]
    else
        error("Unknown dialog type: " .. tostring(dialogType))
    end
    dialogFrame:ShowDialog(content, title)
    return content
end

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
function Dialogs:ShowConfirmDialog(title, message, onConfirm, onCancel)
    local confirmContentFrame = self:ShowDialog(DIALOG_TYPES.CONFIRM, title)
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
    local infoContentFrame = self:ShowDialog(DIALOG_TYPES.INFO, title)
    infoContentFrame:Setup({
        title = title,
        message = message,
        onClose = onClose,
    })
end

MapPinEnhanced:AddSlashCommand("import",
    function() Dialogs:ShowDialog(DIALOG_TYPES.IMPORT) end, L
    ["Open the import dialog to import map pins from a string."])

MapPinEnhanced:AddSlashCommand("export",
    function() Dialogs:ShowDialog(DIALOG_TYPES.EXPORT) end,
    L["Open the export dialog to export your map pins to a string."])
