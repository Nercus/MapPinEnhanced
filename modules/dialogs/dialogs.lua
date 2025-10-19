---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


---@enum DialogTypes
local DIALOG_TYPES = {
    IMPORT = "IMPORT",
    EXPORT = "EXPORT",
}


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
