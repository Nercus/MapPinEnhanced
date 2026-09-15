---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderReadoutTemplate : Frame
---@field text FontString
---@field distanceText string?
---@field etaText string?
---@field hasETA boolean?
---@field showETA boolean?
MapPinEnhancedWayfinderReadoutMixin = {}

function MapPinEnhancedWayfinderReadoutMixin:UpdateText()
    local text = self.distanceText or ""
    if text ~= "" and self.showETA and self.hasETA then
        text = string.format(L["%s - %s"], text, self.etaText or "")
    end
    self.text:SetText(text)
    self.text:SetShown(text ~= "")
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
    self:SetValues(nil, nil, false)
end

function MapPinEnhancedWayfinderReadoutMixin:OnLoad()
    self.showETA = true
    self:PrepareForTarget()
end
