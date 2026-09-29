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
MapPinEnhancedWayfinderReadoutMixin = {}

function MapPinEnhancedWayfinderReadoutMixin:UpdateText()
    local text = self.distanceText or ""
    if text ~= "" and self.showETA and self.hasETA then
        text = string.format(L["%s - %s"], text, self.etaText or "")
    end
    if text ~= "" or not self:IsVisible() then
        self.text:SetText(text)
        if self.onTextChanged then self.onTextChanged() end
    end
    self:SetShown(self.displayVisible == true and text ~= "")
end

-- Floating's clamped presentation can suppress a readout while samples continue.
---@param visible boolean
function MapPinEnhancedWayfinderReadoutMixin:SetDisplayVisible(visible)
    self.displayVisible = visible
    self:UpdateText()
end

function MapPinEnhancedWayfinderReadoutMixin:OnHide()
    if not self.distanceText or self.distanceText == "" then self.text:SetText("") end
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
    self:HideImmediately()
    self:SetValues(nil, nil, false)
end

function MapPinEnhancedWayfinderReadoutMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.displayVisible = true
    self.showETA = true
    self:PrepareForTarget()
end
