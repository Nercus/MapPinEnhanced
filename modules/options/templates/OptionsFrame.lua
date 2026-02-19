---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedOptionsFrameTemplate
---@field options MapPinEnhancedOptionsList
---@field preview MapPinEnhancedPreview
MapPinEnhancedOptionsFrameMixin = {}

---@class MapPinEnhancedInputWithSpinnerTemplate : MapPinEnhancedInputTemplate
---@field spinner Texture

---@class MapPinEnhancedOptionsList : Frame
---@field search MapPinEnhancedInputWithSpinnerTemplate
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar

---@class MapPinEnhancedPreview : Frame
---@field image MapPinEnhancedImageTemplate
---@field description FontString

---@param category MapPinEnhancedOptionCategoryMixin
---@param searchString string?
---@return boolean
local function matchCategory(category, searchString)
    if category:GetOptionCount() == 0 then
        return false
    end

    if not searchString or searchString == "" then
        return true
    end

    local categoryName = category:GetName()
    return MapPinEnhanced:FuzzyMatch(searchString, categoryName, false)
end

---@param option MapPinEnhancedOptionMixin
---@param searchString string?
---@return boolean
local function matchOption(option, searchString)
    if not searchString or searchString == "" then
        return true
    end

    local optionName = option:GetOptionData().label
    return MapPinEnhanced:FuzzyMatch(searchString, optionName, false)
end


---@param el1 TreeNodeMixin
---@param el2 TreeNodeMixin
---@return boolean
local function SortComparator(el1, el2)
    ---@type MapPinEnhancedOptionCategoryMixin | MapPinEnhancedOptionMixin | MapPinEnhancedOptionSubgroupMixin
    local data1 = el1:GetData()
    ---@type MapPinEnhancedOptionCategoryMixin | MapPinEnhancedOptionMixin | MapPinEnhancedOptionSubgroupMixin
    local data2 = el2:GetData()
    local categories = Options.CATEGORIES

    local isCategory1 = data1.template == "MapPinEnhancedOptionsCategoryTemplate"
    local isCategory2 = data2.template == "MapPinEnhancedOptionsCategoryTemplate"

    -- sort categories
    if isCategory1 and isCategory2 then
        local order1 = categories[data1.id] and categories[data1.id].order or math.huge
        local order2 = categories[data2.id] and categories[data2.id].order or math.huge
        return order1 < order2
    end


    local isOption1 = data1.template == "MapPinEnhancedOptionsEntryTemplate"
    local isOption2 = data2.template == "MapPinEnhancedOptionsEntryTemplate"
    local isSubgroup1 = data1.template == "MapPinEnhancedOptionsSubgroupTemplate"
    local isSubgroup2 = data2.template == "MapPinEnhancedOptionsSubgroupTemplate"

    if isOption1 and isOption2 then
        local sub1 = data1.optionData.subCategory or ""
        local sub2 = data2.optionData.subCategory or ""

        if sub1 == "" and sub2 ~= "" then
            return true
        elseif sub1 ~= "" and sub2 == "" then
            return false
        end

        if sub1 ~= sub2 then
            return sub1 < sub2
        end
        return data1.optionData.label < data2.optionData.label
    elseif isOption1 and isSubgroup2 then
        local sub1 = data1.optionData.subCategory or ""
        if sub1 == "" then
            return true
        else
            if sub1 ~= data2.name then
                return sub1 < data2.name
            end
            return false
        end
    elseif isSubgroup1 and isOption2 then
        local sub2 = data2.optionData.subCategory or ""
        if sub2 == "" then
            return false
        else
            if data1.name ~= sub2 then
                return data1.name < sub2
            end
            return true
        end
    elseif isSubgroup1 and isSubgroup2 then
        return data1.name < data2.name
    end

    return false
end

-- FIXME: only sort with the comparator. maybe trigger sort manually, we have to remove sorting when inserting a bunch of nodes

---@param searchString string
function MapPinEnhancedOptionsFrameMixin:UpdateList(searchString)
    self.dataProvider:Flush()
    ---@param category MapPinEnhancedOptionCategoryMixin
    for category in Options:EnumerateCategories() do
        local categoryMatches = matchCategory(category, searchString)
        ---@type MapPinEnhancedOptionMixin[]
        local matchingOptions = {}
        for _, option in category:EnumerateOptions() do
            local optionMatches = matchOption(option, searchString)
            if categoryMatches or optionMatches then
                table.insert(matchingOptions, option)
            end
        end

        if #matchingOptions > 0 then
            local categoryNode = self.dataProvider:Insert(category)

            table.sort(matchingOptions, function(a, b)
                local subCategoryA = a:GetOptionData().subCategory or ""
                local subCategoryB = b:GetOptionData().subCategory or ""
                if subCategoryA ~= subCategoryB then
                    return subCategoryA < subCategoryB
                end
                return a:GetOptionData().label < b:GetOptionData().label
            end)

            local previousSubCategory = nil
            for _, option in ipairs(matchingOptions) do
                local currentSubCategory = option:GetOptionData().subCategory

                if currentSubCategory and currentSubCategory ~= previousSubCategory then
                    local subCategoryMixin = CreateFromMixins(MapPinEnhancedOptionSubgroupMixin)
                    subCategoryMixin:SetName(currentSubCategory)
                    categoryNode:Insert(subCategoryMixin)
                    previousSubCategory = currentSubCategory
                end

                categoryNode:Insert(option)
            end
        end
    end
end

function MapPinEnhancedOptionsFrameMixin:OnLoad()
    self.options.scrollBar:SetInterpolateScroll(true)
    self.options.scrollBox:SetInterpolateScroll(true)
    self.options.scrollBar:SetHideIfUnscrollable(true)

    self.scrollView = CreateScrollBoxListTreeListView()
    self.dataProvider = CreateTreeDataProvider()

    -- self.dataProvider:SetSortComparator(SortComparator)

    self.scrollView:SetElementFactory(function(factory, node)
        ---@type MapPinEnhancedOptionCategoryMixin | MapPinEnhancedOptionMixin
        local data = node:GetData()
        factory(data.template, function(frame)
            frame:Init(node)
        end)
    end)

    self.scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedOptionsEntryTemplate | MapPinEnhancedOptionsCategoryTemplate
        entry:Reset()
    end)

    self.scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.options.scrollBox, self.options.scrollBar, self.scrollView)


    self.filterFunction = MapPinEnhanced:DebounceChange(function()
        local text = self.options.search:GetText()
        self:UpdateList(text)
    end, 0.2, function()
        self.options.search.spinner:Hide()
    end)

    self.options.search:SetScript("OnTextChanged", function()
        self.filterFunction()
    end)
end

---@class DescriptionInfo
---@field image {texture: string, width: number, height: number}?
---@field text string


---@param descriptionInfo DescriptionInfo | nil
function MapPinEnhancedOptionsFrameMixin:SetDescription(descriptionInfo)
    if not descriptionInfo then
        self.preview.image:Hide()
        self.preview.description:SetText("")
        return
    end
    if descriptionInfo.image then
        self.preview.image:SetPoint("TOPLEFT", self.preview, "TOPLEFT", 10, -10)
        self.preview.image:SetPoint("TOPRIGHT", self.preview, "TOPRIGHT", -10, -10)
        self.preview.image:SetImage(descriptionInfo.image.texture, descriptionInfo.image.width,
            descriptionInfo.image.height)
        self.preview.image:Show()
        self.preview.description:SetPoint("TOPLEFT", self.preview.image, "BOTTOMLEFT", 0, -10)
        self.preview.description:SetPoint("BOTTOMRIGHT", self.preview, "BOTTOMRIGHT", -10, 10)
    else
        self.preview.description:SetPoint("TOPLEFT", self.preview, "TOPLEFT", 10, -10)
        self.preview.description:SetPoint("BOTTOMRIGHT", self.preview, "BOTTOMRIGHT", -10, 10)
        self.preview.image:Hide()
    end

    self.preview.description:SetText(descriptionInfo.text)
end

function MapPinEnhancedOptionsFrameMixin:OnCommit()
    --("Options committed")
end

function MapPinEnhancedOptionsFrameMixin:OnDefault()
    --("Options defaulted")
end

function MapPinEnhancedOptionsFrameMixin:OnRefresh()
    self:UpdateList(self.options.search:GetText())
end

-- TODO: add category tabs for quick scroll to navigation
