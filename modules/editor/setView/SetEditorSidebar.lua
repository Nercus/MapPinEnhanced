-- Template: file://./SetEditorSidebar.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local lower = string.lower


---@class SetListScrollFrame : ScrollFrame
---@field Child Frame

---@class SetSearchInput : MapPinEnhancedInputMixin
---@field clearButton Button

---@class SetSidebarHeader : Frame
---@field title FontString

---@class MapPinEnhancedSetEditorViewSidebarMixin : Frame
---@field searchInput SetSearchInput
---@field scrollFrame SetListScrollFrame
---@field switchViewButton Button
---@field createSetButton Button
---@field body MapPinEnhancedSetEditorViewBodyMixin
---@field header SetSidebarHeader
MapPinEnhancedSetEditorViewSidebarMixin = {}

local L = MapPinEnhanced.L


---@param setID UUID | nil
function MapPinEnhancedSetEditorViewSidebarMixin:ToggleActiveSet(setID)
    if not setID then return end
    local SetEditorBody = self.body
    local activeSetID = SetEditorBody:GetActiveEditorSetID()
    if activeSetID then -- there is currently an active set
        local set = SetEditorBody:GetActiveSet()
        if not set then return end
        set.setEditorEntry:SetInactive()
    end
    if setID == activeSetID then -- if we click on the active set we want to close it
        local set = SetEditorBody:GetActiveSet()
        if not set then return end
        set.setEditorEntry:SetInactive()
        SetEditorBody:SetActiveEditorSetID()
        return
    end
    SetEditorBody:SetActiveEditorSetID(setID)
    local newSet = SetEditorBody:GetActiveSet()
    if not newSet then return end
    newSet.setEditorEntry:SetActive()
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
        ---@cast child Frame
        child:Hide()
        child:ClearAllPoints()
    end
    local childWidth = scrollChild:GetWidth()
    local lastFrame = nil
    for _, setObject in ipairs(sets) do
        local setFrame = setObject.setEditorEntry
        if not lastFrame then
            setFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
            setFrame:SetPoint("TOPRIGHT", scrollChild, "TOPRIGHT", -34, -10)
        else
            setFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
            setFrame:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, -5)
        end
        setFrame:SetWidth(childWidth)
        setFrame:SetParent(scrollChild)
        setFrame:Show()
        lastFrame = setFrame
        -- not the nicest solution but it works for now, we overwrite the OnClick function to set the active editor set and hope we dont need to update the set list too often
        setFrame:SetScript("OnClick", function()
            self:ToggleActiveSet(setObject.setID)
        end)
    end
end

---@param searchQuery string
---@return SetObject[] | nil
function MapPinEnhancedSetEditorViewSidebarMixin:GetFilteredSets(searchQuery)
    if searchQuery == "" then return nil end
    local sets = self:GetAlphabeticalSortedSets()
    local filteredSets = {}
    searchQuery = lower(searchQuery)
    for _, setObject in ipairs(sets) do
        local setObjectName = lower(setObject.name)
        if string.find(setObjectName, searchQuery) then
            table.insert(filteredSets, setObject)
        end
    end
    return filteredSets
end

function MapPinEnhancedSetEditorViewSidebarMixin:SetFirstSetActive()
    local searchQuery = self.searchInput:GetText()
    local sets = self:GetFilteredSets(searchQuery)
    if sets and #sets > 0 then
        self:ToggleActiveSet(sets[1].setID)
        self.searchInput:ClearFocus()
        self.searchInput:SetText("")
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

    self.createSetButton:SetScript("OnClick", function()
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setName = SetManager:GetPlaceholderSetNameByPrefix(L["New set"])
        local setObject = SetManager:AddSet(setName)
        self:ToggleActiveSet(setObject.setID)
    end)

    self.header:SetScript("OnMouseDown", function()
        MapPinEnhanced.editorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end)
    self.header:SetScript("OnMouseUp", function()
        MapPinEnhanced.editorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end)

    self.header.title:SetText(L["Sets"])
    self.createSetButton:SetText(L["Create Set"])
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
    self:UpdateSetList() -- init population
    MapPinEnhanced.RegisterCallback(self, 'UpdateSetList', function()
        self:UpdateSetList()
    end)
end
