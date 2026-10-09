---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedOptionCategoryBaseHeader : Button
---@field icon MapPinEnhancedIconMixin
---@field title FontString

---@class MapPinEnhancedOptionCategoryBaseTemplate : Frame
---@field header MapPinEnhancedOptionCategoryBaseHeader
---@field categoryName string
---@field contentInsetX number
---@field headerBottomSpacing number
---@field groupSpacing number
---@field bottomPadding number
---@field enableKey string?
---@field unsubscribeEnable fun()?
---@field showNumber number?
MapPinEnhancedOptionCategoryBaseMixin = {}

function MapPinEnhancedOptionCategoryBaseMixin:UpdateHeight()
    ---@type number
    local totalHeight = self.header:GetHeight() + self.headerBottomSpacing + self.bottomPadding
    local childCount = 0
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header and child:IsShown() then
            childCount = childCount + 1
            totalHeight = totalHeight + child:GetHeight()
            if childCount > 1 then
                ---@type number
                totalHeight = totalHeight + self.groupSpacing
            end
        end
    end
    self:SetHeight(totalHeight)
end

function MapPinEnhancedOptionCategoryBaseMixin:LayoutChildren()
    local headerHeight = self.header:GetHeight()
    local offsetY = -headerHeight - self.headerBottomSpacing

    ---@param child MapPinEnhancedFormElementTemplate | MapPinEnhancedOptionTwoColumnTemplate | MapPinEnhancedOptionGroupTemplate
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header and child:IsShown() then
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", self.contentInsetX, offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -self.contentInsetX, offsetY)
            if child.UpdateLayout then child:UpdateLayout() end
            if child.UpdateHeight then child:UpdateHeight() end
            offsetY = offsetY - child:GetHeight() - self.groupSpacing
        end
    end
end

function MapPinEnhancedOptionCategoryBaseMixin:UpdateTitle()
    self.header.title:SetText(L[self.categoryName] or self.categoryName)
end

function MapPinEnhancedOptionCategoryBaseMixin:OnLoad()
    assert(self.categoryName, "Category frame must have a categoryName keyvalue")
    self:UpdateTitle()
end

function MapPinEnhancedOptionCategoryBaseMixin:OnShow()
    if self.enableKey then
        self.showNumber = (self.showNumber or 0) + 1
        local showNumber = self.showNumber
        self.unsubscribeEnable = Options:SubscribeToOptionChanges(self.enableKey, function()
            -- Startup may deliver an initial value after this show has ended.
            if self.showNumber ~= showNumber then return end
            self:RefreshEnabledOptions()
        end)
        self:RefreshEnabledOptions()
    end
    self:LayoutChildren()
    self:UpdateHeight()
end

function MapPinEnhancedOptionCategoryBaseMixin:RefreshEnabledOptions()
    local enabled = Options:GetOptionValue(self.enableKey) == true
    ---@param child MapPinEnhancedFormElementTemplate
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header and child.key ~= self.enableKey then
            child:SetEnabledState(enabled)
            child:SetShown(enabled)
            if not enabled then child.searchHighlight:Hide() end
        end
    end
    if Options.frame then Options.frame:UpdateLayout() end
end

function MapPinEnhancedOptionCategoryBaseMixin:OnHide()
    self.showNumber = (self.showNumber or 0) + 1
    if self.unsubscribeEnable then self.unsubscribeEnable() end
    self.unsubscribeEnable = nil
end
