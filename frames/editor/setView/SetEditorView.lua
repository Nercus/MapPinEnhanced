local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet SetObject | nil
---@field scrollFrame SetListScrollFrame
---@field sidebar MapPinEnhancedSetEditorViewSidebarMixin
MapPinEnhancedSetEditorViewBodyMixin = {}


local lower = string.lower







local PinEntryFramePool = CreateFramePool("Frame", nil, "MapPinEnhancedSetEditorPinEntryTemplate")


---@param key 'mapID' | 'xCoord' | 'yCoord' | 'title'
---@param value string
function MapPinEnhancedSetEditorViewBodyMixin:OnPinDataChange(key, value)
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

function MapPinEnhancedSetEditorViewBodyMixin:UpdateEditor()
    self:UpdatePinList()
end

function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSet(set)
    self.activeEditorSet = set
    self:UpdateEditor()
end

---@class SetListScrollFrame : ScrollFrame
---@field Child Frame


---@class MapPinEnhancedSetEditorViewSidebarMixin : Frame
---@field activeEditorSet SetObject | nil
---@field searchInput MapPinEnhancedInputMixin
---@field scrollFrame SetListScrollFrame
---@field switchViewButton Button
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
    end
end

function MapPinEnhancedSetEditorViewSidebarMixin:GetFilteredSets()
    local searchQuery = self.searchInput:GetText()
    if searchQuery == "" then
        return nil
    end
    local sets = self:GetAlphabeticalSortedSets()
    local filteredSets = {}
    for _, setObject in ipairs(sets) do
        if string.find(setObject.name, searchQuery) then
            table.insert(filteredSets, setObject)
        end
    end
    return filteredSets
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnLoad()
    self.searchInput:SetScript("OnTextChanged", function()
        self:OnSearchChange()
    end)
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnSearchChange()
    local filteredSets = self:GetFilteredSets()
    self:UpdateSetList(filteredSets)
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnShow()
    print("show sets")
    self:UpdateSetList()
end
