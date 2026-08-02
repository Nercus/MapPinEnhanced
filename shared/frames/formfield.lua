---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedFormFieldTemplate : Frame
---@field label FontString
---@field description FontString
---@field child Frame
---@field labelText string?
---@field descriptionText string?
---@field hideLabel boolean?
---@field hideDescription boolean?
---@field orientation "vertical"|"horizontal"
---@field padding number
---@field labelBottomSpacing number
---@field descriptionBottomSpacing number
MapPinEnhancedFormFieldMixin = {}

function MapPinEnhancedFormFieldMixin:GetLabelText()
    return self.labelText and L[self.labelText] or nil
end

function MapPinEnhancedFormFieldMixin:GetDescriptionText()
    return self.descriptionText and L[self.descriptionText] or nil
end

function MapPinEnhancedFormFieldMixin:HasLabel()
    return self:GetLabelText() ~= nil and not self.hideLabel
end

function MapPinEnhancedFormFieldMixin:HasDescription()
    return self:GetDescriptionText() ~= nil and not self.hideDescription
end

function MapPinEnhancedFormFieldMixin:UpdateDescriptionWidth()
    if self.orientation == "vertical" then
        self.description:SetWidth(self:GetWidth())
    else
        self.description:SetWidth(math.floor(math.max(self:GetWidth() - self.child:GetWidth(), 0) * 0.9))
    end
end

function MapPinEnhancedFormFieldMixin:SetLayout()
    self.child:ClearAllPoints()
    if self.orientation == "horizontal" then
        self.child:SetPoint("TOPRIGHT")
    elseif self:HasDescription() then
        self.child:SetPoint("TOPLEFT", self.description, "BOTTOMLEFT", 0, -self.descriptionBottomSpacing)
    elseif self:HasLabel() then
        self.child:SetPoint("TOPLEFT", self.label, "BOTTOMLEFT", 0, -self.labelBottomSpacing)
    else
        self.child:SetPoint("TOPLEFT")
    end
end

function MapPinEnhancedFormFieldMixin:UpdateHeight()
    local labelHeight = self:HasLabel() and self.label:GetHeight() + self.labelBottomSpacing or 0
    local descriptionHeight = self:HasDescription() and
        self.description:GetHeight() + self.descriptionBottomSpacing or 0
    if self.orientation == "horizontal" then
        self:SetHeight(math.max(labelHeight + descriptionHeight, self.child:GetHeight()) + self.padding * 2)
    else
        self:SetHeight(labelHeight + descriptionHeight + self.child:GetHeight() + self.padding * 2)
    end
end

function MapPinEnhancedFormFieldMixin:OnSizeChanged()
    if self:HasDescription() then self:UpdateDescriptionWidth() end
end

function MapPinEnhancedFormFieldMixin:OnLoad()
    assert(self.child, "Form field must have a child frame")
    assert(self.orientation == "vertical" or self.orientation == "horizontal", "Invalid form field orientation")
    self.label:SetShown(self:HasLabel())
    self.description:SetShown(self:HasDescription())
    if self:HasLabel() then self.label:SetText(self:GetLabelText()) end
    if self:HasDescription() then
        self.description:SetText(self:GetDescriptionText())
        self:UpdateDescriptionWidth()
    end
    self:SetLayout()
    self:UpdateHeight()
end
