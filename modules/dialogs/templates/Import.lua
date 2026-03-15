---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Providers = MapPinEnhanced:GetModule("Providers")
local Collections = MapPinEnhanced:GetModule("Collections")

function Dialogs:GetImportContent()
    if not self.importDialog then
        self.importDialog = CreateFrame("Frame", "MapPinEnhancedImportDialogContent", UIParent,
            "MapPinEnhancedImportDialogContentTemplate")
    end
    return self.importDialog
end

---@class MapPinEnhancedImportDialogContentCollectionDropdown : MapPinEnhancedDropdownTemplate
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedImportDialogContentNewCollectionInput : MapPinEnhancedInputTemplate
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedImportDialogContentTemplate : DefaultPanelFlatTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field importTypeRadio MapPinEnhancedRadioGroupTemplate
---@field collectionDropdown MapPinEnhancedImportDialogContentCollectionDropdown
---@field newCollectionNameInput MapPinEnhancedImportDialogContentNewCollectionInput
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

function MapPinEnhancedImportDialogContentMixin:UpdateImportButtonDisabledState()
    local text = self.textarea.editbox:GetText()
    self.importButton:SetEnabled(text and text ~= "")
end

function MapPinEnhancedImportDialogContentMixin:Import()
    -- TODO: implement import
end

function MapPinEnhancedImportDialogContentMixin:PreparseImport(dataString)
    if not dataString or dataString == "" then return end
    local IsSerializedData = MapPinEnhanced:IsSerializedData(dataString)
    if not IsSerializedData then return end
    local data = MapPinEnhanced:DeserializeData(dataString) --[[@as CollectionInfo]]
    if not data or not data.name then return end
    self.newCollectionNameInput:SetText(data.name)
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
    { label = L["Temporary import"],           value = "temporary" },
    { label = L["Create new collection"],      value = "create_new_collection" },
    { label = L["Add to existing collection"], value = "add_to_collection" },
}

function MapPinEnhancedImportDialogContentMixin:SetCollectionNameInputVisibility(show)
    local isShown = self.newCollectionNameInput:IsShown()
    if show and not isShown then
        self.newCollectionNameInput.fadeIn:Play()
    elseif not show and isShown then
        self.newCollectionNameInput.fadeOut:Play()
    end
end

function MapPinEnhancedImportDialogContentMixin:SetCollectionDropdownVisibility(show)
    local isShown = self.collectionDropdown:IsShown()
    if show and not isShown then
        self.collectionDropdown.fadeIn:Play()
    elseif not show and isShown then
        self.collectionDropdown.fadeOut:Play()
    end
end

function MapPinEnhancedImportDialogContentMixin:UpdateImportTypeSelection()
    if self.selectedImportType == "temporary" then
        self:SetCollectionDropdownVisibility(false)
        self:SetCollectionNameInputVisibility(false)
    elseif self.selectedImportType == "create_new_collection" then
        self:SetCollectionDropdownVisibility(false)
        self:SetCollectionNameInputVisibility(true)
    elseif self.selectedImportType == "add_to_collection" then
        self:SetCollectionDropdownVisibility(true)
        self:SetCollectionNameInputVisibility(false)
    end
end

function MapPinEnhancedImportDialogContentMixin:UpdateOptionDisabledState()
    local hasCollections = Collections:GetObjectPool():GetNumActive() > 0
    self.importTypeRadio:SetOptionDisabledState("add_to_collection", not hasCollections)
    if hasCollections then
        local collectionOptions = {}
        ---@param collection MapPinEnhancedCollectionMixin
        for collection in Collections:EnumerateCollections() do
            table.insert(collectionOptions, { label = collection:GetName(), value = collection:GetName() })
        end
        self.collectionDropdown:Setup({
            options = collectionOptions,
            onChange = function(value)
                self.selectedCollection = value
            end,
        })
    end
end

function MapPinEnhancedImportDialogContentMixin:SetupTypeRadioGroup()
    self.importTypeRadio:Setup({
        options = importOptions,
        onChange = function(value)
            self.selectedImportType = value
            self:UpdateImportTypeSelection()
        end,
        init = function()
            return "temporary"
        end,
    })
end

function MapPinEnhancedImportDialogContentMixin:SetupNewCollectionInput()
    self.newCollectionNameInput:Setup({
        onChange = function(text)
            self.newCollectionName = text
        end,
    })
    self.newCollectionNameInput:SetPlaceholderText(L["Enter collection name"])
end

function MapPinEnhancedImportDialogContentMixin:OnLoad()
    self.importButton:SetScript("OnClick", function()
        self:Import()
    end)

    local descriptionText = L
        ["You can import pins or collections by pasting the either multiple slash commands or a Map Pin Enhanced export string (starting with %s)"]
    self.description:SetText(string.format(descriptionText, MapPinEnhanced.PREFIX))
    self:SetupTextArea()
    self:SetupTypeRadioGroup()
    self:SetupNewCollectionInput()
    self:UpdateImportTypeSelection()
    self:UpdateOptionDisabledState()
    self:UpdateImportButtonDisabledState()
end
