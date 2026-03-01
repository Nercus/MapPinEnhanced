---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


---@enum DialogTypes
local DIALOG_TYPES = {
    IMPORT = "IMPORT",
    EXPORT = "EXPORT",
}
-- TODO: add type CONFIRM (confirmation dialog with accept and cancel buttons), INFO (okay dialog with just an okay button)

---@param dialogType DialogTypes
function Dialogs:ShowDialog(dialogType)
    if dialogType == DIALOG_TYPES.IMPORT then
        self:ShowImportDialog()
    elseif dialogType == DIALOG_TYPES.EXPORT then
        self:ShowExportDialog()
    else
        error("Unknown dialog type: " .. tostring(dialogType))
    end
end

MapPinEnhanced:AddSlashCommand("import", function() Dialogs:ShowDialog(DIALOG_TYPES.IMPORT) end,
    "Open the import dialog to import map pins from a string.")
