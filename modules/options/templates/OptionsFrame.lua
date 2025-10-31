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


---@param searchString string
function MapPinEnhancedOptionsFrameMixin:UpdateList(searchString)
    self.dataProvider:Flush()
    ---@param category MapPinEnhancedOptionCategoryMixin
    for category in Options:EnumerateCategories() do
        local categoryMatches = matchCategory(category, searchString)
        local categoryNode = nil

        for _, option in category:EnumerateOptions() do
            local optionMatches = matchOption(option, searchString)
            if categoryMatches or optionMatches then
                if not categoryNode then
                    ---@type TreeNodeMixin
                    categoryNode = self.dataProvider:Insert(category)
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
