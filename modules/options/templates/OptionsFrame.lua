---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedOptionsFrameTemplate
---@field options MapPinEnhancedOptionsList
---@field preview MapPinEnhancedPreview
MapPinEnhancedOptionsFrameMixin = {}

---@class MapPinEnhancedOptionsList : Frame
---@field search MapPinEnhancedInputTemplate
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar

---@class MapPinEnhancedPreview : Frame
---@field image MapPinEnhancedImageTemplate
---@field description FontString

function MapPinEnhancedOptionsFrameMixin:UpdateList()
    self.dataProvider:Flush()
    ---@param category MapPinEnhancedOptionCategoryMixin
    for category in Options:EnumerateCategories() do
        local isEmpty = category:GetOptionCount() == 0
        if not isEmpty then
            local categoryNode = self.dataProvider:Insert(category) --[[@as TreeNodeMixin]]
            for _, option in category:EnumerateOptions() do
                categoryNode:Insert(option) --[[@as TreeNodeMixin]]
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

    self.scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.options.scrollBox, self.options.scrollBar, self.scrollView)
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
    self:UpdateList()
end
