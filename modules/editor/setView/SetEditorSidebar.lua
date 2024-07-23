-- Template: file://./SetEditorSidebar.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local lower = string.lower


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