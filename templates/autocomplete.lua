---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedAutocompleteTemplate : MapPinEnhancedInputTemplate
---@field resultsFrame MapPinEnhancedAutocompleteResults
---@field spinner Texture
---@field options AutocompleteOption[]
---@field dataProvider DataProviderMixin
---@field selectedIndex number | nil
---@field filterFunction function
---@field optionsValueMap table<string, AutocompleteOption>
---@field searchOptions string[]
---@field searchText string
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
---@field searchString string string to match against user input for filtering
---@field value number | string | boolean value associated with the option

function MapPinEnhancedAutocompleteMixin:OnLoad()
    MapPinEnhancedInputMixin.OnLoad(self)

    self.dataProvider = CreateDataProvider()
    self.selectedIndex = nil

    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("MapPinEnhancedAutocompleteEntryTemplate", function(entry, elementData)
        ---@cast entry MapPinEnhancedAutocompleteEntryTemplate
        ---@cast elementData SearchResult
        local optionData = self.optionsValueMap[elementData.line]
        entry:Init(optionData)
        entry:SetScript("OnClick", function()
            self:SetValue(optionData.value)
            self.resultsFrame:Hide()
            self.spinner:Hide()
        end)
    end)
    scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedAutocompleteEntryTemplate
        entry:UnlockHighlight()
    end)

    scrollView:SetDataProvider(self.dataProvider)
    self.resultsFrame.scrollBar:SetInterpolateScroll(true);
    self.resultsFrame.scrollBox:SetInterpolateScroll(true);
    ScrollUtil.InitScrollBoxListWithScrollBar(self.resultsFrame.scrollBox, self.resultsFrame.scrollBar, scrollView)

    self.resultsFrame.scrollBar:SetHideIfUnscrollable(true)
    MapPinEnhanced:Debug(self.resultsFrame.scrollBar)
end

function MapPinEnhancedAutocompleteMixin:HighlightEntry(index)
    self.resultsFrame.scrollBox:ScrollToElementDataIndex(index)
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
function MapPinEnhancedAutocompleteMixin:SetValue(value)
    if value == nil then
        self.value = nil
        self:SetText("")
        self:UpdatePlaceholderVisibility()
        if self.onChangeCallback then
            self.onChangeCallback(nil)
        end
        return
    end
    local option = self.optionsValueMap[value]
    if not option then
        for _, opt in ipairs(self.options) do
            if opt.value == value then
                option = opt
                break
            end
        end
    end
    self.value = option
    self:SetText(option.label)
    self:UpdatePlaceholderVisibility()
    if self.onChangeCallback then
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
    if key == "DOWN" then
        self:IncrementSelectedIndex()
    elseif key == "UP" then
        self:DecrementSelectedIndex()
    elseif key == "ENTER" then
        ---@type SearchResult | nil
        local preselectedText = self.dataProvider:Find(self.selectedIndex)
        local preselectedEntry = preselectedText and self.optionsValueMap[preselectedText.line]

        if preselectedEntry then
            self:SetValue(preselectedEntry.value)
            self.resultsFrame:Hide()
            self.spinner:Hide()
        end
    elseif key == "ESCAPE" then
        self.resultsFrame:Hide()
    end
end

local MAX_HEIGHT = 200
local ENTRY_HEIGHT = 20

---@param results SearchResult[]
function MapPinEnhancedAutocompleteMixin:UpdateResults(results)
    self.spinner:Hide()

    if self.value and self.value.label == self:GetText() then
        self.resultsFrame:Hide()
        return
    end

    if not results or #results == 0 then
        self.resultsFrame.message:Show()
        self.resultsFrame:SetHeight(25)
        self.resultsFrame:Show()
        self.dataProvider:Flush()
        return
    end

    self.dataProvider:Flush()
    self.dataProvider:InsertTable(results)

    self.resultsFrame:Show()
    self.resultsFrame.message:Hide()

    self.selectedIndex = 1
    local totalHeight = #results * ENTRY_HEIGHT
    if totalHeight > MAX_HEIGHT then
        totalHeight = MAX_HEIGHT
    end
    self.resultsFrame:SetHeight(totalHeight + 5) -- +5 for padding

    self:HighlightEntry(self.selectedIndex)
end

function MapPinEnhancedAutocompleteMixin:UpdateOptions()
    if not self.searchText or self.searchText == "" then
        self.resultsFrame:Hide()
        return
    end
    local results = MapPinEnhanced:Filter(self.searchText, self.searchOptions, false)
    self:UpdateResults(results)
end

function MapPinEnhancedAutocompleteMixin:OnTextChanged()
    assert(self.options, "Options must be set before using autocomplete.")

    local text = self:GetText()
    if not text or text == "" then
        self.resultsFrame:Hide()
        self:SetValue(nil)
        return
    end
    if self.searchText == text then
        -- No change in text, no need to update
        return
    end

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
    self.resultsFrame:Hide()
end

function MapPinEnhancedAutocompleteMixin:OnGlobalMouseDown()
    if not self:IsVisible() or not self.resultsFrame:IsShown() then return end
    local foci = GetMouseFoci()
    local inside = false
    for _, focus in ipairs(foci) do
        if focus == self or focus == self.resultsFrame then
            inside = true
            break
        end
    end
    if not inside then
        self.resultsFrame:Hide()
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
        self:UpdateOptions()
    end, 0.2, function()
        self.spinner:Hide()
    end)
end

---@class MapPinEnhancedAutocompleteData
---@field options AutocompleteOption[] list of options to show in the autocomplete
---@field onChange fun(value: number | string | boolean) callback when an option is selected
---@field init? fun(): number | string | boolean initial value for the autocomplete

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

---@class MapPinEnhancedAutocompleteEntryTemplate : Button, { GetOrderIndex: fun(): number }
---@field text FontString
MapPinEnhancedAutocompleteEntryMixin = {}


---@param data AutocompleteOption
function MapPinEnhancedAutocompleteEntryMixin:Init(data)
    self.text:SetText(data.label)
end
