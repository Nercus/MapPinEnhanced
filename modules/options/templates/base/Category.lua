---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedOptionCategoryBaseHeader : Button
---@field icon MapPinEnhancedIconMixin
---@field title FontString

---@class MapPinEnhancedOptionCategoryBaseTemplate : Frame
---@field header MapPinEnhancedOptionCategoryBaseHeader
---@field categoryName string
MapPinEnhancedOptionCategoryBaseMixin = {}

function MapPinEnhancedOptionCategoryBaseMixin:UpdateHeight()
    local totalHeight = self.header:GetHeight()
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            totalHeight = totalHeight + child:GetHeight() + 4
        end
    end
    self:SetHeight(totalHeight + 8)
end

function MapPinEnhancedOptionCategoryBaseMixin:LayoutChildren()
    local headerHeight = self.header:GetHeight()
    local offsetY = -headerHeight - 8

    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", 16, offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -16, offsetY)
            offsetY = offsetY - child:GetHeight() - 4 -- 4px spacing
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
