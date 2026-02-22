---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFormElementTemplate : Frame
---@field orientation "vertical" | "horizontal" | nil
---@field label FontString
---@field description FontString
---@field child Frame
---@field optionKey string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@field hideLabel boolean If true, the label will be hidden and not take up space.
---@field hideDescription boolean If true, the description will be hidden and not take up space.
MapPinEnhancedFormElementMixin = {}

local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

local PADDING = 4

function MapPinEnhancedFormElementMixin:UpdateHeight()
    local hasLabel = self.label:IsShown()
    local hasDescription = self.description:IsShown()

    local labelHeight = hasLabel and (self.label:GetHeight() + 4) or 0
    local descriptionHeight = hasDescription and (self.description:GetHeight() + 4) or 0
    local childHeight = self.child:GetHeight()

    ---@type number
    local totalHeight
    if self.orientation == "vertical" then
        totalHeight = labelHeight + descriptionHeight + childHeight
    elseif self.orientation == "horizontal" then
        totalHeight = math.max(labelHeight + descriptionHeight, childHeight)
    end
    totalHeight = totalHeight + PADDING * 2

    self:SetHeight(totalHeight)
end

function MapPinEnhancedFormElementMixin:SetLayout(orientation)
    if orientation == "vertical" then
        local hasLabel = self.label:IsShown()
        local hasDescription = self.description:IsShown()

        ---@type Region
        local anchor = self
        local anchorPoint = "TOPLEFT"
        if hasDescription then
            anchor = self.description
            anchorPoint = "BOTTOMLEFT"
        elseif hasLabel then
            anchor = self.label
            anchorPoint = "BOTTOMLEFT"
        end

        self.child:ClearAllPoints()
        self.child:SetPoint("TOPLEFT", anchor, anchorPoint, 0, anchor == self and 0 or -PADDING)
    elseif orientation == "horizontal" then
        self.child:ClearAllPoints()
        self.child:SetPoint("TOPRIGHT", self, "TOPRIGHT")
    else
        error("Invalid orientation: " .. tostring(orientation))
    end
    self:UpdateHeight()
end

function MapPinEnhancedFormElementMixin:OnShow()
    self:UpdateHeight()
end

function MapPinEnhancedFormElementMixin:OnLoad()
    assert(self.child, "Form element must have a child frame")
    assert(self.optionKey, "Form element must have an optionKey")

    local labelKey = self.optionKey .. "_LABEL"
    local labelText = L[labelKey]
    if labelText and labelText ~= labelKey then
        self:SetLabel(labelText)
    end

    local descKey = self.optionKey .. "_DESCRIPTION"
    local descText = L[descKey]
    if descText and descText ~= descKey then
        self:SetDescription(descText)
    else
        self:SetDescription(nil)
    end

    self.label:SetShown(not self.hideLabel)
    self.description:SetShown(not self.hideDescription)

    self:SetLayout(self.orientation or "vertical")
    Options:RegisterOption(self.optionKey, self.child)
end

function MapPinEnhancedFormElementMixin:SetLabel(text)
    if not text or text == "" then
        self.label:Hide()
    else
        self.label:SetText(text)
        self.label:Show()
    end
    self:UpdateHeight()
end

function MapPinEnhancedFormElementMixin:SetDescription(text)
    if not text or text == "" then
        self.description:Hide()
    else
        self.description:SetText(text)
        self.description:Show()
    end
    self:UpdateHeight()
end
