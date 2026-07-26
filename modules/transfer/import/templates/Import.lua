---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class Transfer
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Groups = MapPinEnhanced:GetModule("Groups")




---@class MapPinEnhancedImportWindowTemplate : MapPinEnhancedWindowTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field cancelButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field description FontString
---@field summary FontString
---@field dataString string?
---@field parsedData SaveableGroupData|pinData[]?
---@field parsedDataType "group"|"pins"?
---@field groupName string?
---@field validPinCount number
---@field invalidPinCount number
MapPinEnhancedImportWindowMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@param usedPinIDs table<UUID, boolean>
---@return UUID
local function GenerateUnusedPinID(usedPinIDs)
    local pinID = MapPinEnhanced:GenerateUUID("pin")
    while Groups:IsPinIDInUse(pinID) or usedPinIDs[pinID] do
        pinID = MapPinEnhanced:GenerateUUID("pin")
    end
    usedPinIDs[pinID] = true
    return pinID
end

---@param data SaveableGroupData
---@return SaveablePinData[]
---@return table<UUID, number>
local function PrepareGroupImportData(data)
    ---@type SaveablePinData[]
    local pins = {}
    ---@type table<UUID, number>
    local pinOrder = {}
    ---@type table<UUID, UUID>
    local pinIDMap = {}
    ---@type table<UUID, boolean>
    local usedPinIDs = {}

    for _, pinData in ipairs(data.pins or {}) do
        local importedPinData = CopyTable(pinData)
        ---@cast importedPinData SaveablePinData
        local oldPinID = importedPinData.pinID
        local newPinID = oldPinID

        if not newPinID or Groups:IsPinIDInUse(newPinID) or usedPinIDs[newPinID] then
            newPinID = GenerateUnusedPinID(usedPinIDs)
        else
            usedPinIDs[newPinID] = true
        end

        importedPinData.pinID = newPinID
        if oldPinID then
            pinIDMap[oldPinID] = newPinID
        end
        table.insert(pins, importedPinData)
    end

    for oldPinID, order in pairs(data.pinOrder or {}) do
        local newPinID = pinIDMap[oldPinID]
        if newPinID then
            pinOrder[newPinID] = order
        end
    end

    return pins, pinOrder
end

---@param data SaveableGroupData | pinData[]
---@param dataType "group" | "pins"
---@param groupName string
---@return boolean
function MapPinEnhancedImportWindowMixin:ImportToNewGroup(data, dataType, groupName)
    ---@type string?
    local icon
    ---@type SaveablePinData[]|pinData[]?
    local pins
    ---@type table<UUID, number>?
    local pinOrder
    ---@type GroupTrackingMode?
    local trackingMode
    if dataType == "group" then
        icon = data.icon
        trackingMode = data.trackingMode
        pins, pinOrder = PrepareGroupImportData(data)
    elseif dataType == "pins" then
        pins = data
    end

    local group = Groups:RegisterGroup({
        name = groupName,
        source = MapPinEnhanced.name,
        icon = icon,
        order = GetTime(),
        trackingMode = trackingMode,
    })
    if not group then return false end

    for pinID, order in pairs(pinOrder or {}) do
        group:SetPinOrder(pinID, order, true)
    end
    group:AddMultiplePins(pins or {})
    return true
end

function MapPinEnhancedImportWindowMixin:UpdateImportButtonDisabledState()
    local hasValidPins = (self.validPinCount or 0) > 0
    local hasValidGroupName = self.groupName and Groups:IsValidGroupName(self.groupName)
    local hasDuplicateGroup = hasValidGroupName and Groups:GetGroupByName(self.groupName)
    self.importButton:SetEnabled(hasValidPins and hasValidGroupName and not hasDuplicateGroup)
end

---@param data SaveableGroupData | pinData[]
---@param dataType "group" | "pins"
---@return boolean
function MapPinEnhancedImportWindowMixin:Import(data, dataType)
    if not self.groupName or not Groups:IsValidGroupName(self.groupName) then return false end
    if Groups:GetGroupByName(self.groupName) then
        MapPinEnhanced:Notify(string.format(L["A group named \"%s\" already exists."], self.groupName), "ERROR")
        return false
    end
    return self:ImportToNewGroup(data, dataType, self.groupName)
end

function MapPinEnhancedImportWindowMixin:StartImport()
    if not self.parsedData or not self.parsedDataType or self.validPinCount == 0 then
        MapPinEnhanced:Notify(L["No valid pins were found to import."], "ERROR")
        return false
    end
    if not self:Import(self.parsedData, self.parsedDataType) then
        MapPinEnhanced:Notify(L["Import failed."], "ERROR")
        return false
    end
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
    ---@type "group" | "pins"
    local dataType = "pins"
    ---@type string
    local formatName = L["Way commands"]
    ---@type SaveableGroupData | pinData[] | nil
    local data

    if MapPinEnhanced:IsSerializedData(dataString) then
        formatName = L["Serialized data"]
        data = MapPinEnhanced:DeserializeData(dataString)
        if type(data) ~= "table" then
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(L["Invalid or corrupted serialized data."])
            return
        end

        ---@cast data SaveableGroupData | pinData[]
        ---@type pinData[]
        local sourcePins = data.pins or data
        if type(sourcePins) ~= "table" then
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(L["Invalid or corrupted serialized data."])
            return
        end
        dataType = data.pins and "group" or "pins"
        for _, pinData in ipairs(sourcePins) do
            if IsValidPinData(pinData) then
                table.insert(pins, pinData)
            else
                self.invalidPinCount = self.invalidPinCount + 1
            end
        end
        if dataType == "group" then
            data = CopyTable(data)
            data.pins = pins
            if data.name then
                self.groupName = data.name
            end
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

function MapPinEnhancedImportWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)

    self.validPinCount = 0
    self.invalidPinCount = 0
    self.importButton:SetScript("OnClick", function()
        if self:StartImport() then Transfer:HideImportWindow() end
    end)
    self.cancelButton:SetScript("OnClick", function()
        Transfer:HideImportWindow()
    end)

    local descriptionText = L
        ["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"]
    self.description:SetText(string.format(descriptionText, MapPinEnhanced.PREFIX))
    self:SetupTextArea()
    self:UpdateImportButtonDisabledState()

    self.groupName = Groups:GetAvailableImportGroupName()
end
