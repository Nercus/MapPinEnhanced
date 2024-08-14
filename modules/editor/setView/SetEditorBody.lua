-- Template: file://./SetEditorBody.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetEditorSetNameEditBox : EditBox
---@field editButton Button

---@class ImportFrameWithButton :ScrollableTextarea
---@field confirmButton Button


---@class SetEditorViewBodyHeader : Frame
---@field setName SetEditorSetNameEditBox
---@field deleteButton Button
---@field exportButton Button
---@field createSetButton Button
---@field importButton Button
---@field bg Texture

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet UUID | nil
---@field scrollFrame SetListScrollFrame
---@field sideBar MapPinEnhancedSetEditorViewSidebarMixin
---@field header SetEditorViewBodyHeader
---@field infoText FontString
---@field pinListHeader Frame
---@field addPinButton Button
---@field importFrame ImportFrameWithButton
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
            x = 0.5,
            y = 0.5,
            title = L["New Pin"]
        }, false)
        self:UpdatePinList()
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:OnLoad()
    local function DeleteSet()
        MapPinEnhanced:ShowPopup({
            text = L["Are you sure you want to delete this set?"],
            onAccept = function()
                ---@class SetManager : Module
                local SetManager = MapPinEnhanced:GetModule("SetManager")
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

    local function ToggleImportFrame()
        if self.importFrame:IsShown() then
            self.importFrame:Hide()
            self.infoText:Show()
        else
            self.importFrame:Show()
            self.infoText:Hide()
        end
    end
    self.header.importButton:SetScript("OnClick", ToggleImportFrame)

    local function OnImportStringUpdate()
        local text = self.importFrame.editBox:GetText()
        if text == "" then
            self.importFrame.confirmButton:Disable()
        else
            self.importFrame.confirmButton:Enable()
        end
    end
    self.importFrame.editBox:SetScript("OnTextChanged", OnImportStringUpdate)

    local function OnImportConfirm()
        local text = self.importFrame.editBox:GetText()
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
    self.importFrame.confirmButton:SetScript("OnClick", OnImportConfirm)

    self.header.createSetButton:SetScript("OnClick", function()
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setName = SetManager:GetPlaceholderSetNameByPrefix(L["New set"])
        local setObject = SetManager:AddSet(setName)
        self.sideBar:ToggleActiveSet(setObject.setID)
    end)

    self.infoText:SetText(L["Select a set to edit or create a new one."])
    self.header.createSetButton:SetText(L["Create Set"])
    self.header.importButton:SetText(L["Import"])
    self.addPinButton:SetText(L["Add Pin"])
    self.importFrame.confirmButton:SetText(L["Import"])
end

function MapPinEnhancedSetEditorViewBodyMixin:GetActiveSet()
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    return SetManager:GetSetByID(self.activeEditorSet)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateDisplayedElements()
    if not self.activeEditorSet then
        self.header.setName:Hide()
        self.header.deleteButton:Hide()
        self.header.exportButton:Hide()
        self.header.createSetButton:Show()
        self.header.importButton:Show()
        self.pinListHeader:Hide()
        self.scrollFrame:Hide()
        self.infoText:Show()
        return
    end
    self.infoText:Hide()
    self.scrollFrame:Show()
    self.header.setName:Show()
    self.header.deleteButton:Show()
    self.header.exportButton:Show()
    self.header.createSetButton:Hide()
    self.header.importButton:Hide()
    self.importFrame:Hide()
    self.pinListHeader:Show()
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
