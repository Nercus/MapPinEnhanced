---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderReadoutTemplate : MapPinEnhancedFadingFrameTemplate
---@field text FontString
---@field distanceText string?
---@field etaText string?
---@field hasETA boolean?
---@field showETA boolean?
---@field displayVisible boolean?
---@field onTextChanged fun()?
---@field maxWidth number?
---@field statusText string?
MapPinEnhancedWayfinderReadoutMixin = {}

function MapPinEnhancedWayfinderReadoutMixin:UpdateText()
    local text = self.statusText or self.distanceText or ""
    local showETA = not self.statusText and self.showETA and self.hasETA
    if text ~= "" and showETA then
        text = string.format(L["%s - %s"], text, self.etaText or "")
    end
    if text ~= "" or not self:IsVisible() then
        self.text:SetText(text)
        local width = self.maxWidth or 325
        if text ~= "" and showETA and self.text:GetUnboundedStringWidth() > width then
            self.text:SetText(self.distanceText .. "\n" .. (self.etaText or ""))
        end
        self.text:SetWidth(width)
        self.text:SetHeight(0)
        self.text:SetWordWrap(true)
        self.text:SetNonSpaceWrap(true)
        self:SetSize(width, math.max(1, self.text:GetStringHeight()))
        if self.onTextChanged then self.onTextChanged() end
    end
    self:SetShown(self.displayVisible == true and text ~= "")
end

---@param text string?
function MapPinEnhancedWayfinderReadoutMixin:SetStatusText(text)
    self.statusText = text
    self:UpdateText()
end

-- Floating's clamped presentation can suppress a readout while samples continue.
---@param visible boolean
function MapPinEnhancedWayfinderReadoutMixin:SetDisplayVisible(visible)
    self.displayVisible = visible
    self:UpdateText()
end

function MapPinEnhancedWayfinderReadoutMixin:OnHide()
    if not self.distanceText or self.distanceText == "" then self.text:SetText("") end
    if self.onTextChanged then self.onTextChanged() end
end

---@param showETA boolean
function MapPinEnhancedWayfinderReadoutMixin:SetShowETA(showETA)
    self.showETA = showETA
    self:UpdateText()
end

---@param distanceText string?
---@param etaText string?
---@param hasETA boolean
function MapPinEnhancedWayfinderReadoutMixin:SetValues(distanceText, etaText, hasETA)
    self.distanceText = distanceText
    self.etaText = etaText
    self.hasETA = hasETA
    self:UpdateText()
end

function MapPinEnhancedWayfinderReadoutMixin:PrepareForTarget()
    self.statusText = nil
    self:HideImmediately()
    self:SetValues(nil, nil, false)
end

function MapPinEnhancedWayfinderReadoutMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.displayVisible = true
    self.showETA = true
    self:PrepareForTarget()
end
