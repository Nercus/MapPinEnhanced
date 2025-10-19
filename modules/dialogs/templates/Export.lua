-- an export window to export sets to strings or send to chat to share over addon comms


---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


function Dialogs:ShowExportDialog()
    if not self.exportDialog then
        self.exportDialog = CreateFrame("Frame", "MapPinEnhancedExportDialog", UIParent,
            "MapPinEnhancedExportDialogTemplate")
    end
    self.exportDialog:Show()
end
