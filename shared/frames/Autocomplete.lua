---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local ENTRY_HEIGHT = 24
local ENTRY_SPACING = 2
local RESULTS_PADDING = 20
local MIN_RESULTS_HEIGHT = 96
local MAX_VISIBLE_RESULTS = 10
local SYNC_OPTION_LIMIT = 100

---@class AutocompleteIndex
---@field searchOptions string[]
---@field bySearch table<string, AutocompleteOption>
---@field byValue table<string|number|boolean, AutocompleteOption>

-- Option arrays are immutable catalogues. Replacing the array creates a new index;
-- weak keys let short-lived catalogues go without retaining any row or callback.
---@type table<AutocompleteOption[], AutocompleteIndex>
local optionIndexes = setmetatable({}, { __mode = "k" })

---@param options AutocompleteOption[]
---@return AutocompleteIndex
local function GetOptionIndex(options)
    if optionIndexes[options] then return optionIndexes[options] end
    ---@type AutocompleteIndex
    local index = { searchOptions = {}, bySearch = {}, byValue = {} }
    for _, option in ipairs(options) do
        table.insert(index.searchOptions, option.searchString)
        -- Preserve last matching search string and first matching value.
        index.bySearch[option.searchString] = option
        if index.byValue[option.value] == nil then index.byValue[option.value] = option end
    end
    optionIndexes[options] = index
    return index
end

---@class MapPinEnhancedAutocompleteTemplate : MapPinEnhancedInputTemplate
---@field resultsFrame MapPinEnhancedAutocompleteResults
---@field spinner Texture
---@field options AutocompleteOption[]
---@field dataProvider DataProviderMixin
---@field selectedIndex number | nil
---@field filterFunction function
---@field cancelFilterFunction function?
---@field cancelFilterBatch function?
---@field searchChangeNumber number
---@field cancelOnChangeCallback function?
---@field optionIndex AutocompleteIndex
---@field searchText string?
---@field value AutocompleteOption
MapPinEnhancedAutocompleteMixin = {}

---@class MapPinEnhancedAutocompleteResults : Frame
---@field background Texture
---@field borderLeft Texture
---@field borderRight Texture
---@field borderMiddle Texture
---@field message FontString
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar

---@class AutocompleteOption
---@field label string display label for the option
---@field description string? additional description for the option, shown smaller below the label
---@field searchString string string to match against user input for filtering
---@field value number | string | boolean value associated with the option

function MapPinEnhancedAutocompleteMixin:OnLoad()
    MapPinEnhancedInputMixin.OnLoad(self)

    self.dataProvider = CreateDataProvider()
    self.searchChangeNumber = 0
    self.selectedIndex = nil

    local scrollView = CreateScrollBoxListLinearView()
    ---@diagnostic disable-next-line: redundant-parameter
    scrollView:SetPadding(0, 0, 0, 0, ENTRY_SPACING)
    scrollView:SetElementInitializer("MapPinEnhancedAutocompleteEntryTemplate", function(entry, elementData)
        ---@cast entry MapPinEnhancedAutocompleteEntryTemplate
        ---@cast elementData SearchResult
        local optionData = self.optionIndex.bySearch[elementData.line]
        entry:Init(optionData)
        if self.dataProvider:Find(self.selectedIndex) == elementData then
            entry:LockHighlight()
        else
            entry:UnlockHighlight()
        end
        entry:SetScript("OnClick", function()
            self:SetValue(optionData.value, true)
        end)
    end)
    scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedAutocompleteEntryTemplate
        entry:UnlockHighlight()
        entry:SetScript("OnClick", nil)
    end)

    scrollView:SetDataProvider(self.dataProvider)
    self.resultsFrame.scrollBar:SetInterpolateScroll(true);
    self.resultsFrame.scrollBox:SetInterpolateScroll(true);
    ScrollUtil.InitScrollBoxListWithScrollBar(self.resultsFrame.scrollBox, self.resultsFrame.scrollBar, scrollView)

    self.resultsFrame.scrollBar:SetHideIfUnscrollable(false)
end

function MapPinEnhancedAutocompleteMixin:CancelSearch()
    self.searchChangeNumber = self.searchChangeNumber + 1
    if self.cancelFilterFunction then self.cancelFilterFunction() end
    if self.cancelFilterBatch then self.cancelFilterBatch() end
    self.cancelFilterBatch = nil
    self.spinner:Hide()
    self.resultsFrame:Hide()
    self.searchText, self.selectedIndex = nil, nil
end

function MapPinEnhancedAutocompleteMixin:OnHide()
    self:CancelSearch()
    if self.cancelOnChangeCallback then self.cancelOnChangeCallback() end
    self.dataProvider:Flush()
end

function MapPinEnhancedAutocompleteMixin:Reset()
    self:OnHide()
    self.onChangeCallback, self.cancelOnChangeCallback = nil, nil
    self.value, self.selectedIndex = nil, nil
end

function MapPinEnhancedAutocompleteMixin:HighlightEntry(index)
    self.resultsFrame.scrollBox:ScrollToElementDataIndex(index, ScrollBoxConstants.AlignNearest, 0,
        ScrollBoxConstants.NoScrollInterpolation)
    self.resultsFrame.scrollBox:ForEachFrame(function(frame)
        ---@cast frame MapPinEnhancedAutocompleteEntryTemplate
        local orderIndex = frame:GetOrderIndex()
        if orderIndex == index then
            frame:LockHighlight()
        else
            frame:UnlockHighlight()
        end
    end)
end

---@param value number | string | boolean | nil this could be the searchstring or the value of the option
---@param triggerCallback boolean|nil
function MapPinEnhancedAutocompleteMixin:SetValue(value, triggerCallback)
    self:CancelSearch()
    if value == nil then
        self.value = nil
        self:SetText("")
        self:UpdatePlaceholderVisibility()
        if triggerCallback and self.onChangeCallback then
            self.onChangeCallback(nil)
        end
        return
    end
    local option = self.optionIndex.bySearch[value] or self.optionIndex.byValue[value]
    assert(option, "MapPinEnhancedAutocompleteMixin:SetValue: unknown option value")
    self.value = option
    self:SetText(option.label)
    self:UpdatePlaceholderVisibility()
    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(option)
    end
end

function MapPinEnhancedAutocompleteMixin:IncrementSelectedIndex()
    local numEntries = self.dataProvider:GetSize()
    if numEntries == 0 then return end

    if not self.selectedIndex then
        self.selectedIndex = 1
    else
        if self.selectedIndex < numEntries then
            self.selectedIndex = self.selectedIndex + 1
        end
    end

    self:HighlightEntry(self.selectedIndex)
end

function MapPinEnhancedAutocompleteMixin:DecrementSelectedIndex()
    local numEntries = self.dataProvider:GetSize()
    if numEntries == 0 then return end

    if not self.selectedIndex then
        self.selectedIndex = numEntries
    else
        if self.selectedIndex > 1 then
            self.selectedIndex = self.selectedIndex - 1
        end
    end

    self:HighlightEntry(self.selectedIndex)
end

function MapPinEnhancedAutocompleteMixin:OnKeyDown(key)
    if key == "ESCAPE" then
        self:CancelSearch()
        return
    end
    if not self.resultsFrame:IsShown() then return end
    if key == "DOWN" then
        self:IncrementSelectedIndex()
    elseif key == "UP" then
        self:DecrementSelectedIndex()
    elseif key == "ENTER" then
        ---@type SearchResult | nil
        local preselectedText = self.dataProvider:Find(self.selectedIndex)
        local preselectedEntry = preselectedText and self.optionIndex.bySearch[preselectedText.line]

        if preselectedEntry then
            self:SetValue(preselectedEntry.value, true)
        end
    end
end

---@param results SearchResult[]
function MapPinEnhancedAutocompleteMixin:UpdateResults(results)
    self.spinner:Hide()
    self.resultsFrame:SetWidth(math.max(320, self:GetWidth()))

    if self.value and self.value.label == self:GetText() then
        self.resultsFrame:Hide()
        return
    end

    if not results or #results == 0 then
        self.resultsFrame.message:Show()
        self.resultsFrame:SetHeight(MIN_RESULTS_HEIGHT)
        self.resultsFrame:Show()
        self.dataProvider:Flush()
        return
    end

    self.dataProvider:Flush()
    self.dataProvider:InsertTable(results)

    self.resultsFrame:Show()
    self.resultsFrame.message:Hide()

    self.selectedIndex = 1
    local visibleResults = math.min(#results, MAX_VISIBLE_RESULTS)
    local contentHeight = visibleResults * ENTRY_HEIGHT + (visibleResults - 1) * ENTRY_SPACING
    -- Match the XML insets and leave enough height for both scrollbar steppers.
    self.resultsFrame:SetHeight(math.max(MIN_RESULTS_HEIGHT, contentHeight + RESULTS_PADDING))

    self:HighlightEntry(self.selectedIndex)
end

function MapPinEnhancedAutocompleteMixin:UpdateOptions()
    local text, options = self.searchText, self.optionIndex.searchOptions
    if not text or text == "" then return end
    if #options <= SYNC_OPTION_LIMIT then
        self:UpdateResults(MapPinEnhanced:Filter(text, options, false))
        return
    end
    local changeNumber = self.searchChangeNumber
    ---@type SearchResult[]
    local results
    self.cancelFilterBatch = MapPinEnhanced:BatchExecution({ function()
        results = MapPinEnhanced:Filter(text, options, false, MapPinEnhanced:CreateBatchCheckpoint(2))
    end }, nil, function()
        if self.searchChangeNumber ~= changeNumber then return end
        self.cancelFilterBatch = nil
        self:UpdateResults(results)
    end, nil, function(message)
        if self.searchChangeNumber == changeNumber then self:CancelSearch() end
        geterrorhandler()(message)
    end)
end

function MapPinEnhancedAutocompleteMixin:OnTextChanged()
    assert(self.options, "Options must be set before using autocomplete.")

    local text = self:GetText()
    if not text or text == "" then
        self:SetValue(nil, true)
        return
    end
    if self.searchText == text then
        -- No change in text, no need to update
        return
    end

    self:CancelSearch()
    if self.value and self.value.label == text then
        -- If the value is already set to the current text, no need to update
        return
    end
    self.spinner:Show()
    self.searchText = text
    self.filterFunction()
end

function MapPinEnhancedAutocompleteMixin:OnEditFocusLost()
    MapPinEnhancedInputMixin.OnEditFocusLost(self)
    -- if over search results, do not hide
    if self.resultsFrame:IsShown() and self.resultsFrame:IsMouseOver() then return end
    self:CancelSearch()
end

function MapPinEnhancedAutocompleteMixin:OnGlobalMouseDown()
    if not self:IsVisible() then return end
    local foci = GetMouseFoci()
    for _, focus in ipairs(foci) do
        -- Result buttons and the scrollbar must keep their data until OnClick.
        while focus do
            if focus == self or focus == self.resultsFrame then return end
            focus = focus:GetParent()
        end
    end
    self:CancelSearch()
end

---@param options AutocompleteOption[] immutable; replace the array to change its entries
function MapPinEnhancedAutocompleteMixin:SetOptions(options)
    assert(type(options) == "table", "Options must be a table.")
    self:CancelSearch()
    if self.cancelOnChangeCallback then self.cancelOnChangeCallback() end
    self.dataProvider:Flush()
    self.value = nil
    self.options = options
    self.optionIndex = GetOptionIndex(options)

    self.filterFunction, self.cancelFilterFunction = MapPinEnhanced:DebounceChange(function()
        self:UpdateOptions()
    end, 0.2)
end

---@class MapPinEnhancedAutocompleteData
---@field options AutocompleteOption[] list of options to show in the autocomplete
---@field onChange fun(value: AutocompleteOption) callback when an option is selected
---@field init? fun(): number | string | boolean initial value for the autocomplete

---@param callback fun(value: any)
function MapPinEnhancedAutocompleteMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    if self.cancelOnChangeCallback then self.cancelOnChangeCallback() end
    self.onChangeCallback, self.cancelOnChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param formData MapPinEnhancedAutocompleteData
function MapPinEnhancedAutocompleteMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.options) == "table", "Options must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:Reset()
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

---@class MapPinEnhancedAutocompleteEntryTemplate : Button, { GetOrderIndex: fun(): number }
---@field label FontString
MapPinEnhancedAutocompleteEntryMixin = {}



---@param data AutocompleteOption
function MapPinEnhancedAutocompleteEntryMixin:Init(data)
    self.label:SetText(data.label)
end
