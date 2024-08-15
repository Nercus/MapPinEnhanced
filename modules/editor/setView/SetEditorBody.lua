-- Template: file://./SetEditorBody.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetEditorSetNameEditBox : EditBox
---@field editButton Button

---@class ImportExportFrameWithButton :ScrollableTextarea
---@field confirmButton Button
---@field cancelImportButton Button
---@field cancelExportButton Button
---@field exportTypeToggle MapPinEnhancedCheckboxMixin


---@class SetEditorViewBodyHeader : Frame
---@field setName SetEditorSetNameEditBox
---@field deleteButton MapPinEnhancedSquareButton
---@field exportButton MapPinEnhancedSquareButton
---@field importFromMapButton MapPinEnhancedSquareButton
---@field bg Texture
---@field infoText FontString

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet UUID | nil
---@field scrollFrame SetListScrollFrame
---@field sideBar MapPinEnhancedSetEditorViewSidebarMixin
---@field header SetEditorViewBodyHeader
---@field pinListHeader Frame
---@field addPinButton Button
---@field importExportFrame ImportExportFrameWithButton
---@field createSetButton Button
---@field importButton Button
MapPinEnhancedSetEditorViewBodyMixin = {}

local L = MapPinEnhanced.L
local CB = MapPinEnhanced.CB

local PinEntryFramePool = CreateFramePool("Frame", nil, "MapPinEnhancedSetEditorPinEntryTemplate")

---@alias changeableKeys 'mapID' | 'x' | 'y' | 'title' | 'color' | 'persistent' | 'delete'

---@param set SetObject
---@param setpinID UUID
---@param key changeableKeys
---@param value string
function MapPinEnhancedSetEditorViewBodyMixin:OnPinDataChange(set, setpinID, key, value)
    assert(set, "No set")
    if key == "delete" then
        set:RemovePinByID(setpinID)
        self:UpdatePinList()
        return
    end
    set:UpdatePin(setpinID, key, value)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdatePinList()
    local scrollChild = self.scrollFrame.Child
    for _, child in pairs({ scrollChild:GetChildren() }) do
        ---@cast child Frame
        child:Hide()
        child:ClearAllPoints()
    end
    PinEntryFramePool:ReleaseAll()
    if not self.activeEditorSet then
        self.addPinButton:Hide()
        return
    end
    local set = self:GetActiveSet()
    if not set then return end
    local pins = set:GetPinsByOrder()

    local lastFrame = nil
    for _, pin in ipairs(pins) do
        local pinFrame = PinEntryFramePool:Acquire() --[[@as MapPinEnhancedSetEditorPinEntryMixin]]
        pinFrame:SetParent(scrollChild)
        pinFrame:Show()
        if not lastFrame then
            pinFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
        else
            pinFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
        end
        lastFrame = pinFrame
        pinFrame:SetPin(pin.pinData)
        pinFrame:SetChangeCallback(function(key, value)
            self:OnPinDataChange(set, pin.setPinID, key, value)
        end)
    end

    self.addPinButton:ClearAllPoints()
    self.addPinButton:SetParent(scrollChild)
    if lastFrame then
        self.addPinButton:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
    else
        self.addPinButton:SetPoint("TOP", scrollChild, "TOP", 0, -10)
    end
    self.addPinButton:Show()
    self.addPinButton:SetScript("OnClick", function()
        local Blizz = MapPinEnhanced:GetModule("Blizz")
        set:AddPin({
            mapID = Blizz:GetPlayerMap() or 1,
            x = math.random(),
            y = math.random(),
        }, false)
        self:UpdatePinList()
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:ShowImportFrame()
    self.createSetButton:Hide()
    self.header.infoText:SetText(L["Paste a string to import a set"])
    self.importButton:Hide()
    self.importExportFrame:Show()
    self.importExportFrame.cancelExportButton:Hide()
    self.importExportFrame.cancelImportButton:Show()
    self.importExportFrame.confirmButton:Show()
    self.importExportFrame.exportTypeToggle:Hide()
end

function MapPinEnhancedSetEditorViewBodyMixin:HideImportFrame()
    self.createSetButton:Show()
    self.header.infoText:SetText(L["Select a set to edit or create a new one."])
    self.importButton:Show()
    self.importExportFrame:Hide()
end

---@params exportString string
function MapPinEnhancedSetEditorViewBodyMixin:ShowExportFrame(exportString)
    self.createSetButton:Hide()
    self.header.deleteButton:Hide()
    self.header.exportButton:Hide()
    self.header.importFromMapButton:Hide()
    self.header.infoText:SetText(L["Copy the string below to export the set."])
    self.header.infoText:Show()
    self.header.setName:Hide()
    self.importButton:Hide()
    self.importExportFrame:Show()
    self.importExportFrame.cancelExportButton:Show()
    self.importExportFrame.cancelImportButton:Hide()
    self.importExportFrame.confirmButton:Hide()
    self.importExportFrame.editBox:HighlightText()
    self.importExportFrame.editBox:SetFocus()
    self.importExportFrame.editBox:SetText(exportString)
    self.importExportFrame.exportTypeToggle:Show()
    self.pinListHeader:Hide()
    self.scrollFrame.Child:Hide()
end

function MapPinEnhancedSetEditorViewBodyMixin:HideExportFrame()
    self:UpdatePinList()
    self.createSetButton:Hide()
    self.header.deleteButton:Show()
    self.header.exportButton:Show()
    self.header.importFromMapButton:Show()
    self.header.infoText:Hide()
    self.header.setName:Show()
    self.importButton:Hide()
    self.importExportFrame:Hide()
    self.pinListHeader:Show()
    self.scrollFrame.Child:Show()
end

function MapPinEnhancedSetEditorViewBodyMixin:OnLoad()
    local function DeleteSet()
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        if IsShiftKeyDown() then
            SetManager:DeleteSet(self.activeEditorSet)
            self:SetActiveEditorSetID()
            CB:Fire('UpdateSetList')
            return
        end
        MapPinEnhanced:ShowPopup({
            text = L["Are you sure you want to delete this set?"],
            onAccept = function()
                SetManager:DeleteSet(self.activeEditorSet)
                self:SetActiveEditorSetID()
                CB:Fire('UpdateSetList')
            end
        })
    end
    self.header.deleteButton:SetScript("OnClick", DeleteSet)

    local function UpdateSetName()
        if not self.activeEditorSet then return end
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        SetManager:UpdateSetNameByID(self.activeEditorSet, self.header.setName:GetText())
    end
    self.header.setName:SetScript("OnTextChanged", UpdateSetName)

    local function StartMoving()
        MapPinEnhanced.editorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end
    self.header:SetScript("OnMouseDown", StartMoving)

    local function StopMoving()
        MapPinEnhanced.editorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end
    self.header:SetScript("OnMouseUp", StopMoving)

    local function ToggleImportExportFrame()
        if self.importExportFrame:IsShown() then
            self:HideImportFrame()
        else
            self:ShowImportFrame()
        end
    end
    self.importButton:SetScript("OnClick", ToggleImportExportFrame)

    local function OnImportStringUpdate()
        local text = self.importExportFrame.editBox:GetText()
        if text == "" then
            self.importExportFrame.confirmButton:Disable()
        else
            self.importExportFrame.confirmButton:Enable()
        end
    end
    self.importExportFrame.editBox:SetScript("OnTextChanged", OnImportStringUpdate)

    local function OnImportConfirm()
        local text = self.importExportFrame.editBox:GetText()
        if text == "" then return end
        -- check if it has the import prefix
        if string.find(text, MapPinEnhanced.CONSTANTS.PREFIX) then
            local SetManager = MapPinEnhanced:GetModule("SetManager")
            local importedData = MapPinEnhanced:DeserializeImport(text) --[[@as {name:string, pins:table<UUID, pinData>}]]
            if not importedData then return end
            local setName = importedData.name
            local set = SetManager:AddSet(setName)
            for _, pinData in pairs(importedData.pins) do
                set:AddPin(pinData, true)
            end
            return
        end

        local PinProvider = MapPinEnhanced:GetModule("PinProvider")
        local pins = PinProvider:DeserializeWayString(text)
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
            })
        end
        self.sideBar:ToggleActiveSet(set.setID)
    end
    self.importExportFrame.confirmButton:SetScript("OnClick", OnImportConfirm)
    self.importExportFrame.cancelImportButton:SetScript("OnClick", ToggleImportExportFrame)

    local function OnCreateNewSet()
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setName = SetManager:GetPlaceholderSetNameByPrefix(L["New Set"])
        local setObject = SetManager:AddSet(setName)
        self.sideBar:ToggleActiveSet(setObject.setID)
    end
    self.createSetButton:SetScript("OnClick", OnCreateNewSet)


    local function OnImportFromMap()
        local PinManager = MapPinEnhanced:GetModule("PinManager")
        local activeSet = self:GetActiveSet()
        if not activeSet then return end
        local pins = PinManager:GetPins()
        for _, pin in pairs(pins) do
            activeSet:AddPin({
                mapID = pin.pinData.mapID,
                x = pin.pinData.x,
                y = pin.pinData.y,
                title = pin.pinData.title,
            })
        end
        self:UpdatePinList()
    end
    self.header.importFromMapButton:SetScript("OnClick", OnImportFromMap)


    local function ExportActiveSet()
        local activeSet = self:GetActiveSet()
        if not activeSet then return end
        local rawSetData = activeSet:GetRawSetData()
        if not rawSetData then return end
        local serializedString = MapPinEnhanced:SerializeImport(rawSetData)
        self:ShowExportFrame(serializedString)
    end
    self.header.exportButton:SetScript("OnClick", ExportActiveSet)


    self.importExportFrame.exportTypeToggle:SetScript("OnClick", function()
        local exportType = self.importExportFrame.exportTypeToggle:GetChecked()
        if not exportType then
            ExportActiveSet()
            return
        end
        local activeSet = self:GetActiveSet()
        if not activeSet then return end
        local setPinData = activeSet:GetAllPinData()
        if not setPinData then return end
        local PinProvider = MapPinEnhanced:GetModule("PinProvider")
        local serializedString = ""
        for _, pinData in pairs(setPinData) do
            serializedString = serializedString .. PinProvider:SerializeWayString(pinData) .. "\n"
        end
        serializedString = string.sub(serializedString, 1, -2) -- remove last newline
        self:ShowExportFrame(serializedString)
    end)


    self.importExportFrame.cancelExportButton:SetScript("OnClick", function()
        self:HideExportFrame()
    end)


    self.createSetButton:SetText(L["Create Set"])
    self.importButton:SetText(L["Import Set"])
    self.addPinButton:SetText(L["Add Pin"])
    self.importExportFrame.confirmButton:SetText(L["Import"])
    self.header.deleteButton.tooltip = L["Delete Set"]
    self.header.exportButton.tooltip = L["Export Set"]
end

function MapPinEnhancedSetEditorViewBodyMixin:GetActiveSet()
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    return SetManager:GetSetByID(self.activeEditorSet)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateDisplayedElements()
    if not self.activeEditorSet then
        self.createSetButton:Show()
        self.header.deleteButton:Hide()
        self.header.exportButton:Hide()
        self.header.importFromMapButton:Hide()
        self.header.infoText:Show()
        self.header.setName:Hide()
        self.importButton:Show()
        self.pinListHeader:Hide()
        self.scrollFrame:Hide()
        return
    end
    self.createSetButton:Hide()
    self.header.deleteButton:Show()
    self.header.exportButton:Show()
    self.header.importFromMapButton:Show()
    self.header.infoText:Hide()
    self.header.setName:Show()
    self.importButton:Hide()
    self.importExportFrame:Hide()
    self.pinListHeader:Show()
    self.scrollFrame:Show()
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateHeader()
    local set = self:GetActiveSet()
    local setName = ""
    if set then
        setName = set.name
    end
    self.header.setName:SetText(setName)
    self.header.setName:SetCursorPosition(0)
    self.header.setName:Disable()
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateEditor()
    self:UpdateDisplayedElements()
    self:UpdatePinList()
    self:UpdateHeader()
end

---@param setID UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSetID(setID)
    self.activeEditorSet = setID
    self:UpdateEditor()
end

---@return UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:GetActiveEditorSetID()
    return self.activeEditorSet
end
