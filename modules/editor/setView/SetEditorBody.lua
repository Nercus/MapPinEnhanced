-- Template: file://./SetEditorBody.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet UUID | nil
---@field scrollFrame SetListScrollFrame
---@field sideBar MapPinEnhancedSetEditorViewSidebarMixin
---@field header MapPinEnhancedSetEditorBodyHeaderMixin
---@field pinListHeader Frame
---@field addPinButton Button
---@field importExportFrame MapPinEnhancedSetEditorImportExportFrameMixin
---@field createSetButton Button
---@field importButton Button
---@field importExportFrameOpened boolean?
MapPinEnhancedSetEditorViewBodyMixin = {}

local L = MapPinEnhanced.L


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
            pinFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT")
            pinFrame:SetPoint("TOPRIGHT", scrollChild, "TOPRIGHT")
        else
            pinFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
            pinFrame:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, -5)
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
        }, true) -- don't persist yet
        self:UpdatePinList()
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:OnLoad()
    self.importButton:SetScript("OnClick", function()
        self:SetActiveEditorSetID()
        self.importExportFrame:ShowImportFrame()
    end)

    local function OnCreateNewSet()
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setName = SetManager:GetPlaceholderSetNameByPrefix(L["New Set"])
        local setObject = SetManager:AddSet(setName)
        self.sideBar:ToggleActiveSet(setObject.setID)
    end
    self.createSetButton:SetScript("OnClick", OnCreateNewSet)

    self.createSetButton:SetText(L["Create Set"])
    self.importButton:SetText(L["Import Set"])
    self.addPinButton:SetText(L["Add Pin"])
end

function MapPinEnhancedSetEditorViewBodyMixin:GetActiveSet()
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    return SetManager:GetSetByID(self.activeEditorSet)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateDisplayedElements()
    self.createSetButton:SetShown(self.activeEditorSet == nil and not self.importExportFrameOpened)
    self.importButton:SetShown(self.activeEditorSet == nil and not self.importExportFrameOpened)
    self.pinListHeader:SetShown(self.activeEditorSet ~= nil and not self.importExportFrameOpened)
    self.scrollFrame:SetShown(self.activeEditorSet ~= nil and not self.importExportFrameOpened)
end

---@param setID UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSetID(setID)
    self.activeEditorSet = setID
    self.importExportFrame:HideParent()
    if setID then
        self.header:SetMode('editor')
        self.header:UpdateSetName()
    else
        self.header:SetMode('info')
        self.header:SetInfoText(L["Select a Set to Edit or Create a New One."])
    end
    self:UpdateDisplayedElements()
    self:UpdatePinList()
end

---@return UUID | nil
function MapPinEnhancedSetEditorViewBodyMixin:GetActiveEditorSetID()
    return self.activeEditorSet
end

function MapPinEnhancedSetEditorViewBodyMixin:ExportSet(setID)
    self:SetActiveEditorSetID(setID)
    self.importExportFrame:ShowExportFrame()
end

function MapPinEnhanced:ShowExportFrameForSet(setID)
    if self.editorWindow.setView.body.ExportSet then
        self.editorWindow:Open()
        self.editorWindow.setView.body:ExportSet(setID)
    end
end
