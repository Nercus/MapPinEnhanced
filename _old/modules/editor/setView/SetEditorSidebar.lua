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
---@field switchViewButton MapPinEnhancedSquareButton
---@field createSetButton Button
---@field importButton MapPinEnhancedSquareButton
---@field body MapPinEnhancedSetEditorViewBodyMixin
---@field header SetSidebarHeader
MapPinEnhancedSetEditorViewSidebarMixin = {}

local L = MapPinEnhanced.L


---@param setID UUID | nil
---@param override boolean | nil
function MapPinEnhancedSetEditorViewSidebarMixin:ToggleActiveSet(setID, override)
    if not setID then return end
    local SetEditorBody = self.body
    local activeSetID = SetEditorBody:GetActiveEditorSetID()
    if activeSetID then -- there is currently an active set
        local set = SetEditorBody:GetActiveSet()
        if not set then return end
        set.setEditorEntry:SetInactive()
    end
    if setID == activeSetID and not override then -- if we click on the active set we want to close it
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

---@param setObject SetObject
---@return AnyMenuEntry[]
function MapPinEnhancedSetEditorViewSidebarMixin:GetSetEntryMenuTemplate(setObject)
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    return {
        {
            type = "button",
            label = L["Load Set"],
            onClick = function()
                setObject.LoadSet(IsShiftKeyDown())
            end
        },
        {
            type = "button",
            label = L["Export Set"],
            onClick = function()
                self:ToggleActiveSet(setObject.setID, true)
                SetManager:ExportSet(setObject.setID)
            end
        },
        {
            type = "button",
            label = L["Delete Set"],
            onClick = function()
                self:ToggleActiveSet(setObject.setID)
                self.body:SetActiveEditorSetID() -- set nil
                SetManager:DeleteSet(setObject.setID)
            end
        }
    }
end

---The set list can be updated with a custom set list, if not provided the set manager will be used -> used for search
---@param sets table<string, SetObject> | nil
function MapPinEnhancedSetEditorViewSidebarMixin:UpdateSetList(sets)
    if not sets then
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        sets = SetManager:GetAlphabeticalSortedSets()
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
        setFrame:SetScript("OnClick", function(buttonFrame, button)
            if button == "LeftButton" then
                self:ToggleActiveSet(setObject.setID)
            else
                local menuTemplate = self:GetSetEntryMenuTemplate(setObject)
                MapPinEnhanced:GenerateMenu(buttonFrame, menuTemplate)
            end
        end)
    end
end

---@param searchQuery string
---@return SetObject[] | nil
function MapPinEnhancedSetEditorViewSidebarMixin:GetFilteredSets(searchQuery)
    if searchQuery == "" then return nil end
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    local sets = SetManager:GetAlphabeticalSortedSets()
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
        self.searchInput:ClearFocus()
    end)

    self.createSetButton:SetScript("OnClick", function()
        ---@class SetManager
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local setName = SetManager:GetPlaceholderSetNameByPrefix(L["New Set"])
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

    self.importButton:SetScript("OnClick", function()
        if self.body.importExportFrame:IsShown() and self.body.importExportFrame.mode == "import" then
            self.body.importExportFrame:HideImportFrame()
            return
        end
        -- hide export frame if its visible
        self.body.importExportFrame:HideExportFrame()
        local currentSetId = self.body:GetActiveEditorSetID()
        self:ToggleActiveSet(currentSetId)
        self.body:SetActiveEditorSetID() -- set nil
        self.body.importExportFrame:ShowImportFrame()
        self:UpdateSetList()
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
    self:UpdateSetList() -- init population
    MapPinEnhanced.RegisterCallback(self, 'UpdateSetList', function()
        self:UpdateSetList()
        self.body:UpdatePinList()
    end)
end

function MapPinEnhanced:ShowEditorForSet(setID)
    local editorWindow = self:GetEditorWindow()
    if editorWindow.setView.sideBar.ToggleActiveSet then
        editorWindow:Open()
        editorWindow.setView.sideBar:ToggleActiveSet(setID, true)
    end
end
