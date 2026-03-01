---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Providers = MapPinEnhanced:GetModule("Providers")

function Dialogs:ShowImportDialog()
    if not self.importDialog then
        self.importDialog = CreateFrame("Frame", "MapPinEnhancedImportDialog", UIParent,
            "MapPinEnhancedImportDialogTemplate")
    end
    self.importDialog:Show()
end

---@class MapPinEnhancedImportDialogTemplate : DefaultPanelFlatTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
MapPinEnhancedImportDialogMixin = {}

function MapPinEnhancedImportDialogMixin:Import()
    local text = self.textarea.editbox:GetText()
    if text and text ~= "" then
        self:Hide()
        -- iterate over newlines
        for line in text:gmatch("[^\r\n]+") do
            Providers:ImportSlashCommand(line)
        end
    end
end

function MapPinEnhancedImportDialogMixin:OnLoad()
    self:SetTitle(MapPinEnhanced.displayName .. ": Import")
    MapPinEnhanced:RegisterDraggableFrame(self, "MapPinEnhancedImportDialog", self.TitleContainer, function()
        return false
    end)
    self.importButton:SetScript("OnClick", function()
        self:Import()
    end)
end
