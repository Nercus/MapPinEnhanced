---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class Transfer
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Collections = MapPinEnhanced:GetModule("Collections")
local Groups = MapPinEnhanced:GetModule("Groups")

---@class MapPinEnhancedImportWindowCollectionDropdown : MapPinEnhancedDropdownTemplate
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedImportWindowNewCollectionInput : MapPinEnhancedInputTemplate
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedImportWindowTemplate : MapPinEnhancedWindowTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field cancelButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field importTypeRadio MapPinEnhancedRadioGroupTemplate
---@field collectionDropdown MapPinEnhancedImportWindowCollectionDropdown
---@field newCollectionNameInput MapPinEnhancedImportWindowNewCollectionInput
---@field description FontString
---@field dataString string?
MapPinEnhancedImportWindowMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@type MapPinEnhancedRadioGroupOption[]
local importOptions = {
    { label = L["Temporary import"],           value = "temporary" },
    { label = L["Create new collection"],      value = "create_new_collection" },
    { label = L["Add to existing collection"], value = "add_to_collection" },
}

---@param data CollectionInfo | pinData[]
---@param dataType "collection" | "pins"
function MapPinEnhancedImportWindowMixin:ImportTemporary(data, dataType)
    local group = Groups:GetGroupByName(L["Temporary Import"]) -- this is a default group and always exists
    if not group then
        return
    end
    if dataType == "collection" then
        local pinData = data.pins
        group:AddMultiplePins(pinData)
    elseif dataType == "pins" then
        group:AddMultiplePins(data)
    end
end

---@param data CollectionInfo | pinData[]
---@param dataType "collection" | "pins"
---@param collectionName string
function MapPinEnhancedImportWindowMixin:ImportToNewCollection(data, dataType, collectionName)
    local collection = Collections:CreateCollection(collectionName)
    if not collection then
        return
    end
    if dataType == "collection" then
        if data.icon then
            collection:SetIcon(data.icon)
        end
        if data.color then
            collection:SetColor(data.color)
        end
        collection:AddMultiplePins(data.pins)
    elseif dataType == "pins" then
        collection:AddMultiplePins(data)
    end
end

---@param data CollectionInfo | pinData[]
---@param dataType "collection" | "pins"
---@param collectionName string
function MapPinEnhancedImportWindowMixin:ImportToExistingCollection(data, dataType, collectionName)
    local collection = Collections:GetCollectionByName(collectionName)
    if not collection then
        return
    end
    if dataType == "collection" then
        collection:AddMultiplePins(data.pins)
    elseif dataType == "pins" then
        collection:AddMultiplePins(data)
    end
end

function MapPinEnhancedImportWindowMixin:UpdateImportButtonDisabledState()
    local text = self.textarea.editbox:GetText()
    local textEmpty = not text or text == ""

    if self.selectedImportType == "create_new_collection" then
        self.importButton:SetEnabled(not textEmpty and self.newCollectionName and self.newCollectionName ~= "")
    elseif self.selectedImportType == "add_to_collection" then
        self.importButton:SetEnabled(not textEmpty and self.selectedCollection and self.selectedCollection ~= "")
    else
        self.importButton:SetEnabled(not textEmpty)
    end
end

---@param data CollectionInfo | pinData[]
---@param dataType "collection" | "pins"
function MapPinEnhancedImportWindowMixin:Import(data, dataType)
    if self.selectedImportType == "temporary" then
        self:ImportTemporary(data, dataType)
    elseif self.selectedImportType == "create_new_collection" then
        if not self.newCollectionName or self.newCollectionName == "" then return end
        self:ImportToNewCollection(data, dataType, self.newCollectionName)
    elseif self.selectedImportType == "add_to_collection" then
        if not self.selectedCollection or self.selectedCollection == "" then return end
        self:ImportToExistingCollection(data, dataType, self.selectedCollection)
    end
end

function MapPinEnhancedImportWindowMixin:StartImport()
    if not self.dataString or self.dataString == "" then return end

    if MapPinEnhanced:IsSerializedData(self.dataString) then
        local data = MapPinEnhanced:DeserializeData(self.dataString) --[[@as CollectionInfo | pinData[] ]]
        if not data then return end
        local dataType = data.pins and "collection" or "pins"
        self:Import(data, dataType)
    else
        local pins = {}
        for line in self.dataString:gmatch("[^\n]+") do
            local normalizedLine = line:match("^%s*(.-)%s*$")
            if normalizedLine ~= "" then
                local linePins = MapPinEnhanced:DeserializeWayLine(normalizedLine)
                for _, pin in ipairs(linePins) do
                    table.insert(pins, pin)
                end
            end
        end
        if #pins == 0 then return end
        self:Import(pins, "pins")
    end
end

function MapPinEnhancedImportWindowMixin:PreparseImport(dataString)
    if not dataString or dataString == "" then return end
    local IsSerializedData = MapPinEnhanced:IsSerializedData(dataString)
    if not IsSerializedData then return end
    local data = MapPinEnhanced:DeserializeData(dataString) --[[@as CollectionInfo]]
    if not data or not data.name then return end
    self.newCollectionNameInput:SetValue(data.name, true)
end

function MapPinEnhancedImportWindowMixin:SetupTextArea()
    self.textarea:Setup({
        onChange = function(text)
            self:PreparseImport(text)
            self.dataString = text
            self:UpdateImportButtonDisabledState()
        end,
        placeholder = L["Click to paste export string or slash commands here"],
    })
end

function MapPinEnhancedImportWindowMixin:SetCollectionNameInputVisibility(show)
    local isShown = self.newCollectionNameInput:IsShown()
    if show and not isShown then
        self.newCollectionNameInput.fadeIn:Play()
    elseif not show and isShown then
        self.newCollectionNameInput.fadeOut:Play()
    end
end

function MapPinEnhancedImportWindowMixin:SetCollectionDropdownVisibility(show)
    local isShown = self.collectionDropdown:IsShown()
    if show and not isShown then
        self.collectionDropdown.fadeIn:Play()
    elseif not show and isShown then
        self.collectionDropdown.fadeOut:Play()
    end
end

function MapPinEnhancedImportWindowMixin:UpdateImportTypeSelection()
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

function MapPinEnhancedImportWindowMixin:UpdateOptionDisabledState()
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
                self:UpdateImportButtonDisabledState()
            end,
        })
    end
end

function MapPinEnhancedImportWindowMixin:SetupTypeRadioGroup()
    self.importTypeRadio:Setup({
        options = importOptions,
        onChange = function(value)
            self.selectedImportType = value
            self:UpdateImportTypeSelection()
            self:UpdateImportButtonDisabledState()
        end,
        init = function()
            return "temporary"
        end,
    })
end

function MapPinEnhancedImportWindowMixin:SetupNewCollectionInput()
    self.newCollectionNameInput:Setup({
        onChange = function(text)
            self.newCollectionName = text
            self:UpdateImportButtonDisabledState()
        end,
    })
    self.newCollectionNameInput:SetPlaceholderText(L["Enter collection name"])
end

function MapPinEnhancedImportWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)

    self.selectedImportType = "temporary"
    self.importButton:SetScript("OnClick", function()
        self:StartImport()
        Transfer:HideImportWindow()
    end)
    self.cancelButton:SetScript("OnClick", function()
        Transfer:HideImportWindow()
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
