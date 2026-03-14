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
---@field dataString string?
MapPinEnhancedImportDialogContentMixin = {}

-- TODO: add logic for importing in here. Ignore providers. Following possibilities:
-- wayString -> Temporary Import: nothing
-- dataString -> Temporary Import: nothing
-- wayString -> Insert Into Existing Collection: select collection
-- dataString -> Insert Into Existing Collection: select collection
-- wayString -> Create New Collection: collectionName
-- dataString -> Create New Collection: collectionName, but prefill by dataString

-- function MapPinEnhancedImportDialogContentMixin:IsSerializedData(dataString)
--     return MapPinEnhanced:IsSerializedData(dataString)
-- end

-- function MapPinEnhancedImportDialogContentMixin:PrefillCollectionName(dataString)
--     if not self:IsSerializedData(dataString) then return end
--     local data = MapPinEnhanced:DeserializeData(dataString) --[[@as CollectionInfo]]
--     if not data or not data.name then return end
--     -- self.collectionNameEditbox:SetText(data.name)
-- end

function MapPinEnhancedImportDialogContentMixin:Import()
    local text = self.textarea.editbox:GetText()
    if text and text ~= "" then
        self:Hide()
        for line in text:gmatch("[^\r\n]+") do
            Providers:ImportSlashCommand(line)
        end
    end
end

function MapPinEnhancedImportDialogContentMixin:PreparseImport(dataString)
    if not dataString or dataString == "" then return end
    local IsSerializedData = MapPinEnhanced:IsSerializedData(dataString)
    if not IsSerializedData then return end
    local data = MapPinEnhanced:DeserializeData(dataString) --[[@as CollectionInfo]]
    -- TODO: preset the collection name when input field is implemented
end

function MapPinEnhancedImportDialogContentMixin:SetupTextArea()
    self.textarea:Setup({
        onChange = function(text)
            self:PreparseImport(text)
            self.dataString = text
        end,
        placeholder = L["Click to paste export string or slash commands here"],
    })
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
    self:SetupTextArea()
end
