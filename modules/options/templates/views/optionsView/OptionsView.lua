---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsViewTemplate
---@field sidebar MapPinEnhancedOptionsViewSidebar
---@field scrollBox ScrollBoxListMixin
---@field scrollBar ScrollBarMixin
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider DataProviderMixin
---@field sidebarDataProvider TreeDataProviderMixin
MapPinEnhancedOptionsViewMixin = {}

---@class MapPinEnhancedOptionsViewSidebar
---@field scrollBox ScrollBoxListMixin
---@field scrollBar ScrollBarMixin
---@field scrollView ScrollBoxListTreeListViewMixin
---@field searchBox MapPinEnhancedInputTemplate

local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedOptionsViewMixin:UpdateOptions()
    self.dataProvider:Flush()
    ---@param category MapPinEnhancedOptionCategoryMixin
    for category in Options:EnumerateCategories() do
        local categoryElement = self.dataProvider:Insert(category) --[[@as TreeNodeMixin]]
        for _, option in category:EnumerateOptions() do
            categoryElement:Insert(option) --[[@as TreeNodeMixin]]
        end
    end
end

---@param searchText string?
function MapPinEnhancedOptionsViewMixin:UpdateSidebar(searchText)
    self.sidebarDataProvider:Flush()
    local filter = searchText and searchText:lower() or nil

    ---@param category MapPinEnhancedOptionCategoryMixin
    for category in Options:EnumerateCategories() do
        local categoryName = category:GetName()
        local categoryMatches = filter and categoryName:lower():find(filter, 1, true)
        ---@type SidebarEntryData[]
        local optionsToAdd = {}

        for _, option in category:EnumerateOptions() do
            local optionData = option:GetOptionData()
            local optionLabel = optionData.label
            local optionMatches = filter and optionLabel:lower():find(filter, 1, true)
            if not filter or optionMatches then
                table.insert(optionsToAdd, {
                    label = optionLabel,
                    value = optionLabel,
                    isCategory = false,
                })
            end
        end

        if not filter or categoryMatches or #optionsToAdd > 0 then
            ---@type TreeNodeMixin
            local categoryNode = self.sidebarDataProvider:Insert({
                label = categoryName,
                value = category,
                isCategory = true,
            })

            for _, optionEntry in ipairs(optionsToAdd) do
                categoryNode:Insert(optionEntry)
            end
        end
    end
end

function MapPinEnhancedOptionsViewMixin:Update()
    self:UpdateSidebar()
    self:UpdateOptions()
end

function MapPinEnhancedOptionsViewMixin:InitSidebar()
    self.sidebar.scrollBar:SetHideIfUnscrollable(true)
    self.sidebarDataProvider = CreateTreeDataProvider()
    self.sidebarScrollView = CreateScrollBoxListTreeListView()
    self.sidebarScrollView:SetDataProvider(self.sidebarDataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.sidebar.scrollBox, self.sidebar.scrollBar, self.sidebarScrollView)

    self.sidebarScrollView:SetElementInitializer("MapPinEnhancedOptionsSidebarEntryTemplate", function(button, node)
        ---@cast button MapPinEnhancedOptionsSidebarEntryTemplate
        button:Init(node)
        ---@type SidebarEntryData
        local nodeData = node:GetData()
        button.scrollToSelf = function()
            self:ScrollToOption(nodeData.value, nodeData.label)
        end
    end)

    self.sidebar.searchBox:SetScript("OnTextChanged", function()
        local searchText = self.sidebar.searchBox:GetText()
        self:UpdateSidebar(searchText)
    end)
end

function MapPinEnhancedOptionsViewMixin:ScrollToOption(category, label)
    assert(category and label, "Category and label must be provided to scroll to an option")
    self.scrollBox:ScrollToElementDataByPredicate(function(elementData)
        if elementData:GetData().category == category and elementData:GetData().label == label then
            return true
        end
        return false
    end)
end

function MapPinEnhancedOptionsViewMixin:OnLoad()
    self.scrollBar:SetHideIfUnscrollable(true)
    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)


    self.scrollView:SetElementFactory(function(factory, node)
        ---@type MapPinEnhancedOptionCategoryMixin | MapPinEnhancedOptionMixin
        local data = node:GetData()
        factory(data.template, function(frame)
            ---@cast frame MapPinEnhancedOptionEntryTemplate
            frame:Init(data)
        end)
    end)


    self:InitSidebar()
end

function MapPinEnhancedOptionsViewMixin:OnShow()
    self.sidebar.searchBox:SetText("")
    self:Update()
end
