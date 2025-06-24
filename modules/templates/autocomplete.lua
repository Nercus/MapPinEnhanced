---@class MapPinEnhanced : NercUtilsAddon
local MapPinEnhanced = LibStub("NercUtils"):GetAddon(...)

---@class MapPinEnhancedAutocompleteTemplate : MapPinEnhancedInputTemplate
---@field loadingIndicator Texture
---@field SearchResults MapPinEnhancedAutocompleteSearchResults
---@field pool FramePool<MapPinEnhancedAutocompleteEntryTemplate>
---@field searchText string
---@field searchOptions string[]
---@field filterFunction function
---@field entryList MapPinEnhancedAutocompleteEntryTemplate[]
---@field selectedEntryIndex number
---@field options {label: string, value: any}[]
MapPinEnhancedAutocompleteMixin = {}

---@class MapPinEnhancedAutocompleteSearchResults : Frame
---@field noResultsMsg FontString

local Utils = MapPinEnhanced:GetModule("Utils")
local MAX_ENTRIES_TO_SHOW = 10

---@param results SearchResult[]
function MapPinEnhancedAutocompleteMixin:ShowAutocomplete(results)
    self.pool:ReleaseAll()

    -- Hide if no results
    if not results or #results == 0 then
        self:SetLoadingIndicatorVisibility(false)
        self:ShowNoResultsMessage(true)
        self.SearchResults:Show()
        self.SearchResults:SetHeight(25)
        return
    end

    -- Hide if first result is the same as the input text
    if results[1] and results[1].line == self:GetText() then
        self:SetLoadingIndicatorVisibility(false)
        self.SearchResults:Hide()
        return
    end

    self:ShowNoResultsMessage(false)

    local count = 0
    ---@type MapPinEnhancedAutocompleteEntryTemplate | nil
    local lastEntry
    local totalHeight = 0
    self.entryList = {}
    for index, result in ipairs(results) do
        if count >= MAX_ENTRIES_TO_SHOW then break end

        local entry = self.pool:Acquire()
        entry:SetText(result.line)
        entry.resultValue = result.line
        entry.index = index
        table.insert(self.entryList, entry)

        if lastEntry then
            entry:SetPoint("TOPLEFT", lastEntry, "BOTTOMLEFT", 0, -5)
            entry:SetPoint("TOPRIGHT", lastEntry, "BOTTOMRIGHT", 0, -5)
        else
            entry:SetPoint("TOPLEFT", self.SearchResults, "TOPLEFT", 3, 0)
            entry:SetPoint("TOPRIGHT", self.SearchResults, "TOPRIGHT", 0, 0)
        end
        entry:Show()

        entry:SetScript("OnClick", function()
            self:SetText(result.line)
            self.pool:ReleaseAll()
            self.SearchResults:Hide()
            self:SetLoadingIndicatorVisibility(false)
        end)

        lastEntry = entry
        totalHeight = totalHeight + entry:GetHeight() + (index < #results and 5 or 0)
        count = count + 1
    end

    self.SearchResults:SetHeight(totalHeight)

    self.SearchResults:Show()
    self:SetLoadingIndicatorVisibility(false)
    self.selectedEntryIndex = 1
    self:HighlightEntry(self.selectedEntryIndex)
end

function MapPinEnhancedAutocompleteMixin:ShowNoResultsMessage(show)
    self.SearchResults.noResultsMsg:SetShown(show)
end

function MapPinEnhancedAutocompleteMixin:OnTextChanged()
    local text = self:GetText()
    if not text or text == "" then
        self.pool:ReleaseAll()
        self.SearchResults:Hide()
        return
    end

    self:SetLoadingIndicatorVisibility(true)
    self.searchText = text
    self.filterFunction()
end

function MapPinEnhancedAutocompleteMixin:UpdateAutocomplete()
    if not self.searchText or self.searchText == "" then
        self.pool:ReleaseAll()
        self.SearchResults:Hide()
        return
    end

    local results = Utils:Filter(self.searchText, self.searchOptions, false)
    self:ShowAutocomplete(results)
end

function MapPinEnhancedAutocompleteMixin:SetLoadingIndicatorVisibility(visible)
    if visible then
        self.loadingIndicator:Show()
    else
        self.loadingIndicator:Hide()
    end
end

---@param options {label: string, value: any}[]
function MapPinEnhancedAutocompleteMixin:SetOptions(options)
    assert(type(options) == "table", "Options must be a table.")
    self.options = options
    self.searchOptions = {}
    for _, option in ipairs(options) do
        if option.label and option.value then
            table.insert(self.searchOptions, option.label)
        end
    end
    self.filterFunction = MapPinEnhanced:DebounceChange(function()
        self:UpdateAutocomplete()
    end, 0.2, function()
        self:SetLoadingIndicatorVisibility(false)
    end)
end

function MapPinEnhancedAutocompleteMixin:HighlightEntry(index)
    if not self.entryList then return end
    ---@param entry MapPinEnhancedAutocompleteEntryTemplate
    for i, entry in ipairs(self.entryList) do
        if i == index then
            entry.text:SetTextColor(1, 1, 0) -- yellow
            entry:LockHighlight()
        else
            entry.text:SetTextColor(1, 1, 1)
            entry:UnlockHighlight()
        end
    end
end

function MapPinEnhancedAutocompleteMixin:OnKeyDown(key)
    if not self.entryList or #self.entryList == 0 then return end
    if key == "DOWN" then
        self.selectedEntryIndex = math.min(self.selectedEntryIndex + 1, #self.entryList)
        self:HighlightEntry(self.selectedEntryIndex)
    elseif key == "UP" then
        self.selectedEntryIndex = math.max(self.selectedEntryIndex - 1, 1)
        self:HighlightEntry(self.selectedEntryIndex)
    elseif key == "ENTER" then
        local entry = self.entryList[self.selectedEntryIndex]
        if entry then
            self:SetText(entry.resultValue)
            self.pool:ReleaseAll()
            self.SearchResults:Hide()
            self:SetLoadingIndicatorVisibility(false)
        end
    elseif key == "ESCAPE" then
        self.SearchResults:Hide()
        self.pool:ReleaseAll()
    end
end

function MapPinEnhancedAutocompleteMixin:OnEditFocusLost()
    -- if over search results, do not hide
    if self.SearchResults:IsShown() and self.SearchResults:IsMouseOver() then return end
    self.SearchResults:Hide()
    self.pool:ReleaseAll()
end

function MapPinEnhancedAutocompleteMixin:OnGlobalMouseDown()
    if not self:IsVisible() or not self.SearchResults:IsShown() then return end
    local foci = GetMouseFoci()
    local inside = false
    for _, focus in ipairs(foci) do
        if focus == self or focus == self.SearchResults then
            inside = true
            break
        end
    end
    if not inside then
        self.SearchResults:Hide()
        self.pool:ReleaseAll()
    end
end

function MapPinEnhancedAutocompleteMixin:OnLoad()
    MapPinEnhancedInputMixin.OnLoad(self)
    self.pool = CreateFramePool("Button", self.SearchResults, "MapPinEnhancedAutocompleteEntryTemplate")
    self.entryList = {}
    self.selectedEntryIndex = 1
end

---@class MapPinEnhancedAutocompleteEntryTemplate : Button
---@field text FontString
---@field resultValue string
---@field index number
MapPinEnhancedAutocompleteEntryMixin = {}

function MapPinEnhancedAutocompleteEntryMixin:SetText(text)
    self.text:SetText(text)
end
