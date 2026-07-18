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
---@field summary FontString
---@field dataString string?
---@field parsedData CollectionInfo|pinData[]?
---@field parsedDataType "collection"|"pins"?
---@field validPinCount number
---@field invalidPinCount number
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
    local hasValidPins = (self.validPinCount or 0) > 0

    if self.selectedImportType == "create_new_collection" then
        self.importButton:SetEnabled(hasValidPins and self.newCollectionName and self.newCollectionName ~= "")
    elseif self.selectedImportType == "add_to_collection" then
        self.importButton:SetEnabled(hasValidPins and self.selectedCollection and self.selectedCollection ~= "")
    else
        self.importButton:SetEnabled(hasValidPins)
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
    if not self.parsedData or not self.parsedDataType or self.validPinCount == 0 then
        MapPinEnhanced:Notify(L["No valid pins were found to import."], "ERROR")
        return false
    end
    self:Import(self.parsedData, self.parsedDataType)
    MapPinEnhanced:Notify(string.format(L["Imported %d pins; skipped %d invalid entries."],
        self.validPinCount, self.invalidPinCount))
    return true
end

---@param pinData any
---@return boolean
local function IsValidPinData(pinData)
    return type(pinData) == "table" and type(pinData.mapID) == "number" and
        type(pinData.x) == "number" and type(pinData.y) == "number"
end

---@param formatName string
---@param pins pinData[]
---@param invalidCount number
function MapPinEnhancedImportWindowMixin:UpdateSummary(formatName, pins, invalidCount)
    ---@type table<number, boolean>
    local maps = {}
    for _, pinData in ipairs(pins) do maps[pinData.mapID] = true end
    local mapCount = 0
    for _mapID in pairs(maps) do mapCount = mapCount + 1 end

    local summary = string.format(L["%s: %d pins across %d maps"], formatName, #pins, mapCount)
    if invalidCount > 0 then
        summary = summary .. " | " .. string.format(L["%d invalid entries will be skipped"], invalidCount)
        self.summary:SetTextColor(1, 0.45, 0.1)
    else
        self.summary:SetTextColor(0.4, 1, 0.4)
    end
    self.summary:SetText(summary)
end

---@param dataString string?
function MapPinEnhancedImportWindowMixin:PreparseImport(dataString)
    self.parsedData = nil
    self.parsedDataType = nil
    self.validPinCount = 0
    self.invalidPinCount = 0

    if not dataString or dataString == "" then
        self.summary:SetText("")
        return
    end

    ---@cast dataString string
    ---@type pinData[]
    local pins = {}
    ---@type "collection" | "pins"
    local dataType = "pins"
    ---@type string
    local formatName = L["Way commands"]
    ---@type CollectionInfo | pinData[] | nil
    local data

    if MapPinEnhanced:IsSerializedData(dataString) then
        formatName = L["Serialized data"]
        data = MapPinEnhanced:DeserializeData(dataString)
        if type(data) ~= "table" then
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(L["Invalid or corrupted serialized data."])
            return
        end

        ---@cast data CollectionInfo | pinData[]
        ---@type pinData[]
        local sourcePins = data.pins or data
        if type(sourcePins) ~= "table" then
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(L["Invalid or corrupted serialized data."])
            return
        end
        dataType = data.pins and "collection" or "pins"
        for _, pinData in ipairs(sourcePins) do
            if IsValidPinData(pinData) then
                table.insert(pins, pinData)
            else
                self.invalidPinCount = self.invalidPinCount + 1
            end
        end
        if dataType == "collection" then
            data = CopyTable(data)
            data.pins = pins
            if data.name then self.newCollectionNameInput:SetValue(data.name, true) end
        else
            data = pins
        end
    else
        for line in dataString:gmatch("[^\n]+") do
            local normalizedLine = line:match("^%s*(.-)%s*$") or ""
            if normalizedLine ~= "" then
                local linePins = MapPinEnhanced:DeserializeWayLine(normalizedLine)
                if #linePins == 0 then
                    self.invalidPinCount = self.invalidPinCount + 1
                else
                    table.insert(pins, linePins[1])
                end
            end
        end
        data = pins
    end

    self.parsedData = data
    self.parsedDataType = dataType
    self.validPinCount = #pins
    self:UpdateSummary(formatName, pins, self.invalidPinCount)
end

function MapPinEnhancedImportWindowMixin:SetupTextArea()
    self.textarea:Setup({
        onChange = function(text)
            self.dataString = text
            self:PreparseImport(text)
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
    self.validPinCount = 0
    self.invalidPinCount = 0
    self.importButton:SetScript("OnClick", function()
        if self:StartImport() then Transfer:HideImportWindow() end
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
