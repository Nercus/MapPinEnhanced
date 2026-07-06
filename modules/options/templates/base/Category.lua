---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

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
MapPinEnhancedOptionCategoryBaseMixin = {}

function MapPinEnhancedOptionCategoryBaseMixin:UpdateHeight()
    ---@type number
    local totalHeight = self.header:GetHeight() + self.headerBottomSpacing + self.bottomPadding
    local childCount = 0
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            childCount = childCount + 1
            totalHeight = totalHeight + child:GetHeight()
            if childCount > 1 then
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
        if child ~= self.header then
            if child.UpdateLayout then
                child:UpdateLayout()
            end
            if child.UpdateHeight then
                child:UpdateHeight()
            end
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", self.contentInsetX, offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -self.contentInsetX, offsetY)
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
    self:LayoutChildren()
    self:UpdateHeight()
end
