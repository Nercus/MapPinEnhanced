---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Providers = MapPinEnhanced:GetModule("Providers")

function Dialogs:GetImportContent()
    if not self.importDialog then
        self.importDialog = CreateFrame("Frame", "MapPinEnhancedImportDialogContent", UIParent,
            "MapPinEnhancedImportDialogContentTemplate")
    end
    return self.importDialog
end

---@class MapPinEnhancedImportDialogContentTemplate : DefaultPanelFlatTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field importTypeRadio MapPinEnhancedRadioGroupTemplate
---@field description FontString
MapPinEnhancedImportDialogContentMixin = {}




function MapPinEnhancedImportDialogContentMixin:Import()
    local text = self.textarea.editbox:GetText()
    if text and text ~= "" then
        self:Hide()
        for line in text:gmatch("[^\r\n]+") do
            Providers:ImportSlashCommand(line)
        end
    end
end

---@type MapPinEnhancedRadioGroupOption[]
local importOptions = {
    { label = "Temporary Import",     value = "temporary" },
    { label = "Import to Collection", value = "collection" },
}

function MapPinEnhancedImportDialogContentMixin:OnLoad()
    self.importButton:SetScript("OnClick", function()
        self:Import()
    end)

    self.importTypeRadio:SetOptions(importOptions)
    self.importTypeRadio:SetActiveOption("temporary")
    self.description:SetText(L
        ["You can import pins or collections by pasting the either multiple slash commands or a Map Pin Enhanced export string (starting with )"])
end
