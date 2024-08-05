-- Template: file://./SetEditorBody.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetEditorSetNameEditBox : EditBox
---@field editButton Button

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
---@field sidebar MapPinEnhancedSetEditorViewSidebarMixin
---@field header SetEditorViewBodyHeader
---@field infoText FontString
---@field pinListHeader Frame
---@field addPinButton Button
MapPinEnhancedSetEditorViewBodyMixin = {}


local CB = MapPinEnhanced.CB

local PinEntryFramePool = CreateFramePool("Frame", nil, "MapPinEnhancedSetEditorPinEntryTemplate")

---@param set SetObject
---@param setpinID UUID
---@param key 'mapID' | 'x' | 'y' | 'title'
---@param value string
function MapPinEnhancedSetEditorViewBodyMixin:OnPinDataChange(set, setpinID, key, value)
    assert(set, "No set")
    set:UpdatePin(setpinID, key, value)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdatePinList()
    local scrollChild = self.scrollFrame.Child
    for _, child in pairs({ scrollChild:GetChildren() }) do
        local child = child --[[@as Frame]]
        child:Hide()
        child:ClearAllPoints()
    end
    PinEntryFramePool:ReleaseAll()
    if not self.activeEditorSet then
        self.addPinButton:Hide()
        return
    end
    local set = self:GetActiveSetData()
    if not set then return end
    local pins = set:GetPins()

    local lastFrame = nil
    for setpinID, pin in pairs(pins) do
        local pinFrame = PinEntryFramePool:Acquire() --[[@as MapPinEnhancedSetEditorPinEntryMixin]]
        pinFrame:SetParent(scrollChild)
        pinFrame:Show()
        if not lastFrame then
            pinFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
        else
            pinFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
        end
        lastFrame = pinFrame
        pinFrame:SetPin(pin)
        pinFrame:SetChangeCallback(function(key, value)
            self:OnPinDataChange(set, setpinID, key, value)
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
            title = "New Pin"
        }, false)
        self:UpdatePinList()
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:OnLoad()
    self.header.deleteButton:SetScript("OnClick", function()
        -- TODO: add a confirmation dialog
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        SetManager:DeleteSet(self.activeEditorSet)
        self:SetActiveEditorSet()
        CB:Fire('UpdateSetList')
    end)

    self.header.setName:SetScript("OnTextChanged", function()
        if not self.activeEditorSet then return end
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        SetManager:UpdateSetNameByID(self.activeEditorSet, self.header.setName:GetText())
    end)
    self.header:SetScript("OnMouseDown", function(self)
        MapPinEnhanced.editorWindow:StartMoving()
    end)

    self.header:SetScript("OnMouseUp", function(self)
        MapPinEnhanced.editorWindow:StopMovingOrSizing()
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:GetActiveSetData()
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
    self.pinListHeader:Show()
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateHeader()
    local set = self:GetActiveSetData()
    local setName = ""
    if set then
        setName = set.name
    end
    self.header.setName:SetText(setName)
    self.header.setName:Disable()
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateEditor()
    self:UpdateDisplayedElements()
    self:UpdatePinList()
    self:UpdateHeader()
end

---@param setID UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSet(setID)
    self.activeEditorSet = setID
    self:UpdateEditor()
end

---@return UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:GetActiveEditorSet()
    return self.activeEditorSet
end
