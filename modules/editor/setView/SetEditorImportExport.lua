-- Template: file://./SetEditorImportExport.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSetEditorImportExportFrameMixin : ScrollableTextarea
---@field exportTypeToggle MapPinEnhancedExportTypeToggle
---@field confirmImportButton Button
---@field cancelImportButton Button
---@field cancelExportButton Button
MapPinEnhancedSetEditorImportExportFrameMixin = {}

---@class MapPinEnhancedExportTypeToggle : MapPinEnhancedCheckboxMixin
---@field label FontString

local L = MapPinEnhanced.L
local CONSTANTS = MapPinEnhanced.CONSTANTS


function MapPinEnhancedSetEditorImportExportFrameMixin:ShowExportFrame()
    if self.mode == "export" then return end
    self:HideImportFrame()
    self.exportTypeToggle:Show()
    self.cancelExportButton:Show()
    self.exportTypeToggle:SetChecked(false)
    self.mode = "export"
    self:Show()
    self.body.importExportFrameOpened = true
    self:UpdateExportType(false)
    self.body:UpdateDisplayedElements()
end

function MapPinEnhancedSetEditorImportExportFrameMixin:HideExportFrame()
    self.exportTypeToggle:Hide()
    self.cancelExportButton:Hide()
    self:HideParent()
    self.body:UpdateDisplayedElements()
end

function MapPinEnhancedSetEditorImportExportFrameMixin:ShowImportFrame()
    if self.mode == "import" then return end
    self:HideExportFrame()
    self.editBox:SetText("")
    self.editBox:SetFocus()
    self.confirmImportButton:Show()
    self.cancelImportButton:Show()
    self.mode = "import"
    self:Show()
    self.body.importExportFrameOpened = true
    self.body:UpdateDisplayedElements()
    self.body.header:SetInfoText(L["Paste a string to import a set"])
end

function MapPinEnhancedSetEditorImportExportFrameMixin:HideImportFrame()
    self.confirmImportButton:Hide()
    self.cancelImportButton:Hide()
    self:HideParent()
    self.body:UpdateDisplayedElements()
    self.body.header:SetInfoText(L["Select a set to edit or create a new one."])
end

function MapPinEnhancedSetEditorImportExportFrameMixin:HideParent()
    self.mode = nil
    self:Hide()
    self.body.importExportFrameOpened = false
end

function MapPinEnhancedSetEditorImportExportFrameMixin:UpdateExportType(isCommand)
    local activeSet = self.body:GetActiveSet()
    if not activeSet then return end
    local pinCount = activeSet:GetPinCount()
    if pinCount == 0 then
        self.editBox:SetText(L["No Pins to export."])
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        return
    end
    local PinProvider = MapPinEnhanced:GetModule("PinProvider")
    if isCommand then
        local setPinData = activeSet:GetAllPinData()
        if not setPinData then return end
        local serializedString = ""
        for _, pinData in pairs(setPinData) do
            serializedString = serializedString .. PinProvider:SerializeWayString(pinData) .. "\n"
        end
        serializedString = string.sub(serializedString, 1, -2) -- remove last newline
        self.editBox:SetText(serializedString)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        return
    end
    local rawSetData = activeSet:GetRawSetData()
    if not rawSetData then return end
    local serializedString = PinProvider:SerializeImport(rawSetData)
    self.editBox:SetText(serializedString)
    self.editBox:HighlightText()
    self.editBox:SetFocus()
end

function MapPinEnhancedSetEditorImportExportFrameMixin:ImportCommands(commandString)
    local PinProvider = MapPinEnhanced:GetModule("PinProvider")
    local pins = PinProvider:DeserializeWayString(commandString)
    if not pins then return end
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    local setName = SetManager:GetPlaceholderSetNameByPrefix(L["Imported Set"])
    local set = SetManager:AddSet(setName)
    for _, pin in ipairs(pins) do
        set:AddPin({
            mapID = pin.mapID,
            x = pin.x,
            y = pin.y,
            title = pin.title,
        }, true)
    end
    SetManager:PersistSets(set.setID)
    self.body.sideBar:ToggleActiveSet(set.setID)
end

function MapPinEnhancedSetEditorImportExportFrameMixin:ImportString(importString)
    local PinProvider = MapPinEnhanced:GetModule("PinProvider")
    local importedData = PinProvider:DeserializeImport(importString)
    ---@cast importedData reducedSet
    if not importedData then return end
    local setName = importedData.name
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    local set = SetManager:AddSet(setName)
    for _, pinData in pairs(importedData.pins) do
        set:AddPin(pinData, true)
    end
    SetManager:PersistSets(set.setID)
end

function MapPinEnhancedSetEditorImportExportFrameMixin:ConfirmImport()
    local text = self.editBox:GetText()
    if text == "" then return end
    -- check if it has the import prefix
    if string.find(text, CONSTANTS.PREFIX) then
        self:ImportString(text)
    else
        self:ImportCommands(text)
    end
    self:HideImportFrame()
end

function MapPinEnhancedSetEditorImportExportFrameMixin:OnImportTextChanged()
    local text = self.editBox:GetText()
    if text == "" then
        self.confirmImportButton:Disable()
    else
        self.confirmImportButton:Enable()
    end
end

function MapPinEnhancedSetEditorImportExportFrameMixin:OnLoad()
    self.body = self:GetParent() --[[@as MapPinEnhancedSetEditorViewBodyMixin]]

    self.exportTypeToggle.label:SetText(L["Export as commands"])
    self.confirmImportButton:SetText(L["Confirm"])
    self.cancelImportButton:SetText(L["Back"])
    self.cancelExportButton:SetText(L["Cancel"])

    self.cancelExportButton:SetScript("OnClick", function() self:HideExportFrame() end)
    self.cancelImportButton:SetScript("OnClick", function() self:HideImportFrame() end)
    self.confirmImportButton:SetScript("OnClick", function() self:ConfirmImport() end)
    self.editBox:SetScript("OnTextChanged", function() self:OnImportTextChanged() end)


    self.exportTypeToggle:Setup({
        label = "", -- empty label because we have a custom text
        checked = false,
        onChange = function(checked)
            self:UpdateExportType(checked)
        end,
        default = false,
        init = function()
            return false
        end
    })
end
