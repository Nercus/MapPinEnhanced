---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedAutocompleteTemplate : MapPinEnhancedInputTemplate
---@field loadingIndicator Texture
---@field SearchResults MapPinEnhancedAutocompleteSearchResults
---@field pool FramePool<MapPinEnhancedAutocompleteEntryTemplate>
---@field searchText string
---@field searchOptions string[]
---@field filterFunction function
---@field entryList MapPinEnhancedAutocompleteEntryTemplate[]
---@field selectedEntryIndex number
---@field options AutocompleteOption[]
---@field optionsValueMap table<string, AutocompleteOption>
MapPinEnhancedAutocompleteMixin = {}


---@class MapPinEnhancedAutocompleteSearchResults : Frame
---@field noResultsMsg FontString

---@alias AutocompleteOption {label: string, searchString: string, value: any}

local MAX_ENTRIES_TO_SHOW = 10

---@param value any this could be the searchstring or the value of the option
function MapPinEnhancedAutocompleteMixin:SetValue(value)
    local option = self.optionsValueMap[value]
    if not option then
        for _, opt in ipairs(self.options) do
            if opt.value == value then
                option = opt
                break
            end
        end
    end
    self.activeValue = option
    self:SetText(option.label)
    self:UpdatePlaceholderVisibility()
    if self.onChangeCallback then
        self.onChangeCallback(option.value)
    end
end

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
        local option = self.optionsValueMap[result.line]
        entry:SetText(option.label or result.line)
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
            self:SetValue(result.line)
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
    assert(self.options, "Options must be set before using autocomplete.")

    local text = self:GetText()
    if not text or text == "" then
        self.pool:ReleaseAll()
        self.SearchResults:Hide()
        return
    end
    if self.searchText == text then
        -- No change in text, no need to update
        return
    end

    if self.activeValue and self.activeValue.label == text then
        -- If the value is already set to the current text, no need to update
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

    local results = MapPinEnhanced:Filter(self.searchText, self.searchOptions, false)
    self:ShowAutocomplete(results)
end

function MapPinEnhancedAutocompleteMixin:SetLoadingIndicatorVisibility(visible)
    if visible then
        self.loadingIndicator:Show()
    else
        self.loadingIndicator:Hide()
    end
end

---@param options AutocompleteOption[]
function MapPinEnhancedAutocompleteMixin:SetOptions(options)
    assert(type(options) == "table", "Options must be a table.")
    self.options = options
    self.searchOptions = {}
    self.optionsValueMap = {}
    for _, option in ipairs(options) do
        self.optionsValueMap[option.searchString] = option
        table.insert(self.searchOptions, option.searchString)
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
            self:SetValue(entry.resultValue)
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

---@class MapPinEnhancedAutocompleteData
---@field options AutocompleteOption[] list of options to show in the autocomplete
---@field onChange fun(value: any) callback when an option is selected
---@field init? fun(): any initial value for the autocomplete

---@param callback fun(value: any)
function MapPinEnhancedAutocompleteMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param formData MapPinEnhancedAutocompleteData
function MapPinEnhancedAutocompleteMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.options) == "table", "Options must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:SetOptions(formData.options)
    if formData.init then
        local initialValue = formData.init()
        if initialValue then
            self:SetValue(initialValue)
        end
    end

    self:SetCallback(formData.onChange)
    self:UpdatePlaceholderVisibility()
end

---@class MapPinEnhancedAutocompleteEntryTemplate : Button
---@field text FontString
---@field resultValue string
---@field index number
MapPinEnhancedAutocompleteEntryMixin = {}

function MapPinEnhancedAutocompleteEntryMixin:SetText(text)
    self.text:SetText(text)
end
