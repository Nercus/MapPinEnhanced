---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetEditorViewBodyHeader : Frame
---@field setName EditBox
---@field deleteButton Button
---@field importButton Button
---@field exportButton Button

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet SetObject | nil
---@field scrollFrame SetListScrollFrame
---@field sidebar MapPinEnhancedSetEditorViewSidebarMixin
---@field setHeader SetEditorViewBodyHeader
MapPinEnhancedSetEditorViewBodyMixin = {}



local CB = MapPinEnhanced.CB
local lower = string.lower


local PinEntryFramePool = CreateFramePool("Frame", nil, "MapPinEnhancedSetEditorPinEntryTemplate")


---@param key 'mapID' | 'xCoord' | 'yCoord' | 'title'
---@param value string
function MapPinEnhancedSetEditorViewBodyMixin:OnPinDataChange(key, value)
    print(key, value)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdatePinList()
    local scrollChild = self.scrollFrame.Child
    for _, child in pairs({ scrollChild:GetChildren() }) do
        local child = child --[[@as Frame]]
        child:Hide()
        child:ClearAllPoints()
    end
    PinEntryFramePool:ReleaseAll()
    if not self.activeEditorSet then return end
    local pins = self.activeEditorSet:GetPins()

    local lastFrame = nil
    for _, pin in pairs(pins) do
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
            self:OnPinDataChange(key, value)
        end)
    end
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateSetHeader()
    if not self.activeEditorSet then
        self.setHeader:Hide()
        return
    end
    self.setHeader:Show()
    self.setHeader.setName:SetText(self.activeEditorSet.name)
    self.setHeader.deleteButton:SetScript("OnClick", function()
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        SetManager:DeleteSet(self.activeEditorSet.setID)
        self:SetActiveEditorSet()
        CB:Fire('UpdateSetList')
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateEditor()
    self:UpdatePinList()
    self:UpdateSetHeader()
end

function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSet(set)
    self.activeEditorSet = set
    if set then
        self.setHeader.setName:SetText(set.name)
    end
    self:UpdateEditor()
    self:UpdateSetHeader()
end

---@class SetListScrollFrame : ScrollFrame
---@field Child Frame


---@class SetSearchInput : MapPinEnhancedInputMixin
---@field clearButton Button

---@class MapPinEnhancedSetEditorViewSidebarMixin : Frame
---@field activeEditorSet SetObject | nil
---@field searchInput SetSearchInput
---@field scrollFrame SetListScrollFrame
---@field switchViewButton Button
---@field createSetButton Button
---@field body MapPinEnhancedSetEditorViewBodyMixin
MapPinEnhancedSetEditorViewSidebarMixin = {}

---@param set SetObject | nil
function MapPinEnhancedSetEditorViewSidebarMixin:SetActiveEditorSet(set)
    if not set then return end
    local SetEditorBody = self.body
    if self.activeEditorSet and set.setID == self.activeEditorSet.setID then
        self.activeEditorSet.SetEditorEntry:SetInActive()
        self.activeEditorSet = nil
        SetEditorBody:SetActiveEditorSet()
        return
    end

    if self.activeEditorSet then
        self.activeEditorSet.SetEditorEntry:SetInActive()
    end
    self.activeEditorSet = set
    set.SetEditorEntry:SetActive()
    SetEditorBody:SetActiveEditorSet(set)
end

---@param a SetObject
---@param b SetObject
---@return boolean
local function SortBySetName(a, b)
    return lower(a.name) < lower(b.name)
end

---@return SetObject[]
function MapPinEnhancedSetEditorViewSidebarMixin:GetAlphabeticalSortedSets()
    ---@class SetManager : Module
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    local sets = SetManager:GetSets()
    local sortedSets = {}
    for _, setObject in pairs(sets) do
        table.insert(sortedSets, setObject)
    end
    table.sort(sortedSets, SortBySetName)
    return sortedSets
end

---The set list can be updated with a custom set list, if not provided the set manager will be used -> used for search
---@param sets table<string, SetObject> | nil
function MapPinEnhancedSetEditorViewSidebarMixin:UpdateSetList(sets)
    if not sets then
        sets = self:GetAlphabeticalSortedSets()
    end
    local scrollChild = self.scrollFrame.Child
    for _, child in ipairs({ scrollChild:GetChildren() }) do
        local child = child --[[@as Frame]]
        child:Hide()
        child:ClearAllPoints()
    end
    local lastFrame = nil
    for _, setObject in ipairs(sets) do
        local setFrame = setObject.SetEditorEntry
        if not lastFrame then
            setFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
        else
            setFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
        end
        setFrame:SetParent(scrollChild)
        setFrame:Show()
        lastFrame = setFrame
        -- not the nicest solution but it works for now, we overwrite the OnClick function to set the active editor set and hope we dont need to update the set list too often
        setFrame:SetScript("OnClick", function()
            self:SetActiveEditorSet(setObject)
        end)
        hooksecurefunc(setObject, "AddPin", function()
            self.body:UpdateEditor()
        end)
    end
end

---@param searchQuery string
---@return SetObject[] | nil
function MapPinEnhancedSetEditorViewSidebarMixin:GetFilteredSets(searchQuery)
    if searchQuery == "" then return nil end
    local sets = self:GetAlphabeticalSortedSets()
    local filteredSets = {}
    for _, setObject in ipairs(sets) do
        if string.find(setObject.name, searchQuery) then
            table.insert(filteredSets, setObject)
        end
    end
    return filteredSets
end

function MapPinEnhancedSetEditorViewSidebarMixin:SetFirstSetActive()
    local searchQuery = self.searchInput:GetText()
    local sets = self:GetFilteredSets(searchQuery)
    if sets and #sets > 0 then
        self:SetActiveEditorSet(sets[1])
        self.searchInput:ClearFocus()
    end
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnLoad()
    self.searchInput:SetScript("OnTextChanged", function()
        local searchQuery = self.searchInput:GetText()
        if searchQuery == "" then
            self.searchInput.clearButton:Hide()
        else
            self.searchInput.clearButton:Show()
        end
        self:OnSearchChange(searchQuery)
    end)
    self.searchInput:SetScript("OnEscapePressed", function()
        self.searchInput:ClearFocus()
        self.searchInput:SetText("")
    end)
    self.searchInput:SetScript("OnEnterPressed", function()
        self:SetFirstSetActive()
    end)
    self.searchInput:SetTextInsets(16, 20, 0, 0);

    self.createSetButton:SetScript("OnClick", function()
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setObject = SetManager:AddSet("Set name")
        self:SetActiveEditorSet(setObject)
    end)
end

---@param searchQuery string
function MapPinEnhancedSetEditorViewSidebarMixin:OnSearchChange(searchQuery)
    local filteredSets = self:GetFilteredSets(searchQuery)
    self:UpdateSetList(filteredSets)
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnHide()
    MapPinEnhanced.UnregisterCallback(self, 'UpdateSetList')
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnShow()
    print("show sets")
    self:UpdateSetList() -- init population
    MapPinEnhanced.RegisterCallback(self, 'UpdateSetList', function()
        self:UpdateSetList()
    end)
end
