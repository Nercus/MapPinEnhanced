---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderFloatingTitleTemplate : MapPinEnhancedFadingFrameTemplate
---@field background Texture
---@field title FontString
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field border Texture
---@field fullTitle string?
---@field fullDescription string?
---@field titleTruncated boolean?
---@field info Frame
---@field fallback boolean?
---@field normalFontSize number
---@field normalTextAnchor Frame
---@field fallbackTextAnchor Frame
MapPinEnhancedWayfinderFloatingTitleMixin = {}

local MAX_TITLE_WIDTH = 325
local FALLBACK_TITLE_WIDTH = 180

function MapPinEnhancedWayfinderFloatingTitleMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    local _, fontSize = self.title:GetFont()
    self.normalFontSize = fontSize
    self.description.onHidden = function() self:UpdateLayout() end
    self.info:SetMouseClickEnabled(false)
    self:SetMouseClickEnabled(false)
    self:SetTitle("")
    self:SetVisible(false)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingTitleMixin:SetTitle(title)
    self:OnLeave()
    self.fullTitle = title
    self.titleTruncated = Wayfinders:ApplyWrappedText(self.title, title,
        self.fallback and FALLBACK_TITLE_WIDTH or MAX_TITLE_WIDTH, self.fallback and 2 or 4)
    self:EnableMouse(self.titleTruncated)
    self:SetMouseClickEnabled(false)
    self:UpdateLayout()
end

---@param fallback boolean
function MapPinEnhancedWayfinderFloatingTitleMixin:SetFallback(fallback)
    if self.fallback == fallback then return end
    self.fallback = fallback
    local font, _, flags = self.title:GetFont()
    self.title:SetFont(font, fallback and math.max(8, self.normalFontSize - 1) or self.normalFontSize, flags)
    self.title:SetSpacing(fallback and 2 or 3)
    self.title:ClearAllPoints()
    self.title:SetPoint("TOPLEFT", fallback and self.fallbackTextAnchor or self.normalTextAnchor, "TOPLEFT")
    self.info:SetShown(fallback)
    self:SetDestinationText(self.fullTitle, self.fullDescription)
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
    self.fullDescription = description
    self:SetTitle(title)
    self.description:Apply(title, nil)
    self.description:HideImmediately()
    self:UpdateLayout()
end

function MapPinEnhancedWayfinderFloatingTitleMixin:UpdateLayout()
    local shown = self.description:IsShown()
    local width = math.max(self.title:GetWidth(), shown and self.description:GetWidth() or 0, 40)
    local height = self.title:GetHeight() + (shown and self.description:GetHeight() + 3 or 0)
    self:SetSize(width + (self.fallback and 38 or 30), height + (self.fallback and 10 or 20))
end

function MapPinEnhancedWayfinderFloatingTitleMixin:ShowInfoTooltip()
    GameTooltip:SetOwner(self.info, "ANCHOR_RIGHT")
    GameTooltip:SetText(L["Why do I see this navigation element?"], 1, 0.82, 0, 1, true)
    GameTooltip:AddLine(L["Wayfinder.Floating.Fallback_DESCRIPTION"], 1, 1, 1, true)
    GameTooltip:Show()
end

function MapPinEnhancedWayfinderFloatingTitleMixin:HideInfoTooltip()
    if GameTooltip:IsOwned(self.info) then GameTooltip:Hide() end
end

function MapPinEnhancedWayfinderFloatingTitleMixin:OnEnter()
    if self.titleTruncated then Wayfinders:ShowTextTooltip(self, self.fullTitle, self.description.description) end
end

function MapPinEnhancedWayfinderFloatingTitleMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
    self:HideInfoTooltip()
end
