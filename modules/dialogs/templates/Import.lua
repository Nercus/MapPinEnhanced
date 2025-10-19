-- an import window for importing sets


---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")



function Dialogs:ShowImportDialog()
    if not self.importDialog then
        self.importDialog = CreateFrame("Frame", "MapPinEnhancedImportDialog", UIParent,
            "MapPinEnhancedImportDialogTemplate")
    end
    self.importDialog:Show()
end
