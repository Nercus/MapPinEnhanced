---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionGroupTemplate : Frame
---@field label FontString
---@field key string
---@field topPadding number
---@field labelInsetX number
---@field contentInsetX number
---@field labelBottomSpacing number
---@field rowSpacing number
---@field bottomPadding number
MapPinEnhancedOptionGroupMixin = {}

local L = MapPinEnhanced.L

function MapPinEnhancedOptionGroupMixin:SetLabel(text)
    self.label:SetText(text)
end

function MapPinEnhancedOptionGroupMixin:UpdateLabelLayout()
    self.label:ClearAllPoints()
    self.label:SetPoint("TOPLEFT", self, "TOPLEFT", self.labelInsetX, -self.topPadding)
    self.label:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, -self.topPadding)
end

function MapPinEnhancedOptionGroupMixin:UpdateLayout()
    self:UpdateLabelLayout()

    local offsetY = self.topPadding + self.label:GetHeight() + self.labelBottomSpacing
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.label then
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", self.contentInsetX, -offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -self.contentInsetX, -offsetY)
            offsetY = offsetY + child:GetHeight() + self.rowSpacing
        end
    end
end

function MapPinEnhancedOptionGroupMixin:UpdateHeight()
    local labelHeight = self.label:GetHeight()
    local totalHeight = self.topPadding + labelHeight + self.labelBottomSpacing + self.bottomPadding
    local childCount = 0
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.label then
            childCount = childCount + 1
            totalHeight = totalHeight + child:GetHeight()
            if childCount > 1 then
                ---@type number
                totalHeight = totalHeight + self.rowSpacing
            end
        end
    end
    self:SetHeight(totalHeight)
end

function MapPinEnhancedOptionGroupMixin:OnLoad()
    assert(self.key, "OptionGroup requires a key")
    self:SetLabel(L[self.key .. "_GROUPLABEL"])
    self:UpdateLayout()
end

function MapPinEnhancedOptionGroupMixin:OnShow()
    self:UpdateLayout()
    self:UpdateHeight()
end
