---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderFloatingTitleTemplate : MapPinEnhancedFadingFrameTemplate
---@field background Texture
---@field title FontString
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field border Texture
---@field fullTitle string?
---@field titleTruncated boolean?
MapPinEnhancedWayfinderFloatingTitleMixin = {}

local MAX_TITLE_WIDTH = 325

function MapPinEnhancedWayfinderFloatingTitleMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.description.onHidden = function() self:UpdateLayout() end
    self:SetMouseClickEnabled(false)
    self:SetTitle("")
    self:SetVisible(false)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingTitleMixin:SetTitle(title)
    self:OnLeave()
    self.fullTitle = title
    self.titleTruncated = Wayfinders:ApplyWrappedText(self.title, title, MAX_TITLE_WIDTH, 4)
    self:EnableMouse(self.titleTruncated)
    self:SetMouseClickEnabled(false)
    self:UpdateLayout()
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingTitleMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.border:SetVertexColor(r, g, b, 1)

    local textR, textG, textB = math.min(r * 1.5, 1), math.min(g * 1.5, 1), math.min(b * 1.5, 1)
    self.title:SetTextColor(textR, textG, textB)
end

---@param shown boolean
function MapPinEnhancedWayfinderFloatingTitleMixin:SetVisible(shown)
    if not shown then self:OnLeave() end
    self:EnableMouse(shown and self.titleTruncated == true)
    self:SetMouseClickEnabled(false)
    self:SetShown(shown)
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingTitleMixin:SetDestinationText(title, description)
    self:SetTitle(title)
    self.description:Apply(title, description)
    self:UpdateLayout()
end

function MapPinEnhancedWayfinderFloatingTitleMixin:UpdateLayout()
    local shown = self.description:IsShown()
    local width = math.max(self.title:GetWidth(), shown and self.description:GetWidth() or 0, 40)
    local height = self.title:GetHeight() + (shown and self.description:GetHeight() + 3 or 0)
    self:SetSize(width + 30, height + 20)
end

function MapPinEnhancedWayfinderFloatingTitleMixin:OnEnter()
    if self.titleTruncated then Wayfinders:ShowTextTooltip(self, self.fullTitle, self.description.description) end
end

function MapPinEnhancedWayfinderFloatingTitleMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end
