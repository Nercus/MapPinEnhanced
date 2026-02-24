---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionGroupTemplate : Frame
---@field label FontString
---@field key string
MapPinEnhancedOptionGroupMixin = {}

local L = MapPinEnhanced.L

function MapPinEnhancedOptionGroupMixin:SetLabel(text)
    self.label:SetText(text)
end

function MapPinEnhancedOptionGroupMixin:UpdateLayout()
    local offsetY = self.label:GetHeight() + 4
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.label then
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -10, -offsetY)
            offsetY = offsetY + child:GetHeight()
        end
    end
end

function MapPinEnhancedOptionGroupMixin:UpdateHeight()
    local labelHeight = self.label:GetHeight()
    local totalHeight = labelHeight + 4
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.label then
            totalHeight = totalHeight + child:GetHeight() + 4
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
    self:UpdateHeight()
end
