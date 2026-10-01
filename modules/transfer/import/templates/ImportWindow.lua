---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Groups = MapPinEnhanced:GetModule("Groups")

---@class MapPinEnhancedImportWindowTemplate : MapPinEnhancedWindowTemplate
---@field importButton MapPinEnhancedButtonTemplate
---@field cancelButton MapPinEnhancedButtonTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field description FontString
---@field summary FontString
---@field dataString string?
---@field parsedData SerializedExportGroup?
---@field groupName string?
---@field validPinCount number
---@field invalidPinCount number
---@field previewChangeNumber number
---@field cancelPreview fun()?
MapPinEnhancedImportWindowMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---The preview owns these copies. Remap at confirmation, without yielding, so
---IDs cannot become occupied between checking them and handing them to Groups.
---@param savedGroup SerializedExportGroup
---@return table<UUID, number>
local function RemapImportedPins(savedGroup)
    ---@type table<UUID, number>
    local pinOrder = {}
    ---@type table<UUID, boolean>
    local usedPinIDs = {}
    for _, data in ipairs(savedGroup.pins) do
        local oldPinID = data.pinID
        local pinID = oldPinID
        while not pinID or Groups:IsPinIDInUse(pinID) or usedPinIDs[pinID] do
            pinID = MapPinEnhanced:GenerateUUID("pin")
        end
        usedPinIDs[pinID] = true
        data.pinID = pinID
        pinOrder[pinID] = oldPinID and savedGroup.pinOrder[oldPinID] or nil
    end
    return pinOrder
end

function MapPinEnhancedImportWindowMixin:UpdateImportButtonDisabledState()
    self.importButton:SetEnabled(self.parsedData ~= nil and self.validPinCount > 0 and
        self.groupName ~= nil and Groups:IsValidGroupName(self.groupName))
end

function MapPinEnhancedImportWindowMixin:StartImport()
    local data = self.parsedData
    if not data or self.validPinCount == 0 then
        MapPinEnhanced:Notify(L["No valid pins were found to import."], "ERROR")
        return false
    end
    if not self.groupName or not Groups:IsValidGroupName(self.groupName) then return false end
    if Groups:GetGroupByName(self.groupName) then
        self.groupName = Groups:GetAvailableImportGroupName()
    end
    data.pinOrder = RemapImportedPins(data)
    local group = Groups:RegisterGroup({
        name = self.groupName,
        source = MapPinEnhanced.name,
        icon = data.icon,
        order = GetTime(),
        trackingMode = data.trackingMode,
    })
    if not group or not group:AddMultiplePins(data.pins, false, data.pinOrder) then
        MapPinEnhanced:Notify(L["Import failed."], "ERROR")
        return false
    end
    -- Groups owns activation, capacity failures and partial-completion reporting.
    -- Release the preview: these tables now belong to its existing bulk worker.
    self.parsedData = nil
    self.dataString = nil
    self.textarea:SetValue("")
    self:UpdateImportButtonDisabledState()
    MapPinEnhanced:Notify(string.format(L["Importing %d pins; skipped %d invalid entries."],
        self.validPinCount, self.invalidPinCount))
    return true
end

function MapPinEnhancedImportWindowMixin:CancelPreview()
    self.previewChangeNumber = (self.previewChangeNumber or 0) + 1
    if self.cancelPreview then self.cancelPreview() end
    self.cancelPreview = nil
end

---@param input string|table?
---@param onReady? fun(name: string)
---@return fun() cancel
function MapPinEnhancedImportWindowMixin:PreparseImport(input, onReady)
    self:CancelPreview()
    local changeNumber = self.previewChangeNumber
    self.parsedData = nil
    self.validPinCount, self.invalidPinCount = 0, 0
    self:UpdateImportButtonDisabledState()
    local function Cancel()
        if self.previewChangeNumber == changeNumber then
            self:CancelPreview()
            self.summary:SetText("")
        end
    end
    if not input or input == "" or not self:IsVisible() or self.visibilityHiding then
        self.summary:SetText("")
        return Cancel
    end
    self.summary:SetTextColor(1, 1, 1)
    self.summary:SetText(L["Loading"])
    ---@type SerializedExportGroup?
    local group
    local invalidCount, mapCount, formatName = 0, 0, ""
    ---@type string?
    local errorMessage
    self.cancelPreview = MapPinEnhanced:BatchExecution({ function()
        group, invalidCount, mapCount, formatName, errorMessage =
            Transfer:ParseImport(input, MapPinEnhanced:CreateBatchCheckpoint(2))
    end }, nil, function()
        if self.previewChangeNumber ~= changeNumber then return end
        self.cancelPreview = nil
        if not self:IsVisible() or self.visibilityHiding then return end
        if not group then
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(errorMessage)
            return
        end
        self.parsedData = group
        self.validPinCount, self.invalidPinCount = #group.pins, invalidCount
        self.groupName = Groups:IsValidGroupName(group.name) and not Groups:GetGroupByName(group.name)
            and group.name or Groups:GetAvailableImportGroupName()
        local summary = string.format(L["%s: %d pins across %d maps"], formatName, #group.pins, mapCount)
        if invalidCount > 0 then
            summary = summary .. " | " .. string.format(L["%d invalid entries will be skipped"], invalidCount)
            self.summary:SetTextColor(1, 0.45, 0.1)
        else
            self.summary:SetTextColor(0.4, 1, 0.4)
        end
        self.summary:SetText(summary)
        self:UpdateImportButtonDisabledState()
        if #group.pins > 0 and onReady then onReady(self.groupName) end
    end, 1, function(message)
        if self.previewChangeNumber == changeNumber then
            self.cancelPreview = nil
            self.summary:SetTextColor(1, 0.2, 0.2)
            self.summary:SetText(L["Import failed."])
        end
        geterrorhandler()(message)
    end)
    return Cancel
end

function MapPinEnhancedImportWindowMixin:OnShow()
    MapPinEnhancedWindowMixin.OnShow(self)
    if not self.parsedData then self:PreparseImport(self.dataString) end
end

function MapPinEnhancedImportWindowMixin:OnHide()
    MapPinEnhancedWindowMixin.OnHide(self)
    self:CancelPreview()
    if self:IsShown() and not self.visibilityHiding and self.parsedData then return end
    self.summary:SetText("")
    self.parsedData = nil
    self.validPinCount, self.invalidPinCount = 0, 0
    self:UpdateImportButtonDisabledState()
end

function MapPinEnhancedImportWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.validPinCount, self.invalidPinCount = 0, 0
    self.importButton:SetScript("OnClick", function()
        if self:StartImport() then Transfer:HideImportWindow() end
    end)
    self.cancelButton:SetScript("OnClick", function() Transfer:HideImportWindow() end)
    self.description:SetText(string.format(L[
        "You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"],
        MapPinEnhanced.PREFIX))
    self.textarea:Setup({
        onChange = function() end,
        placeholder = L["Click to paste export string or slash commands here"],
    })
    -- Invalidate immediately on input. A delayed textarea callback could publish
    -- an old preview or leave its Import button usable while the text changes.
    self.textarea.editbox:SetScript("OnTextChanged", function(editbox, userInput)
        if not userInput then return end
        self.dataString = editbox:GetText()
        self:PreparseImport(self.dataString)
    end)
    self:UpdateImportButtonDisabledState()
end
