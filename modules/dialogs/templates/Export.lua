---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


function Dialogs:GetExportContent()
    if not self.exportDialog then
        self.exportDialog = CreateFrame("Frame", "MapPinEnhancedExportDialogContent", UIParent,
            "MapPinEnhancedExportDialogContentTemplate")
    end
    return self.exportDialog
end

---@class MapPinEnhancedExportDialogContentTemplate : Frame
MapPinEnhancedExportDialogContentMixin = {}
