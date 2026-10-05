---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWorldmapPinTemplate : MapPinEnhancedBasePinTemplate,Button
---@field groupBadge MapPinEnhancedPinGroupBadgeTemplate
---@field hoverScaleEnabled boolean
---@field hoverScaleTarget number | nil
MapPinEnhancedWorldmapPinMixin = {}

local Options = MapPinEnhanced:GetModule("Options")

local HOVER_SCALE = 1.4
local HOVER_SCALE_DURATION = 0.15
local HOVER_SCALE_SPEED = (HOVER_SCALE - 1) / HOVER_SCALE_DURATION

function MapPinEnhancedWorldmapPinMixin:OnLoad()
    self.pulseHighlight:SetIgnoreParentScale(true)
end

function MapPinEnhancedWorldmapPinMixin:ResetHoverScale()
    self:SetScript("OnUpdate", nil)
    self.hoverScaleTarget = nil
    self:SetScale(1)
end

function MapPinEnhancedWorldmapPinMixin:OnShow()
    if Options:GetOptionValue("Pins.Appearance.AlwaysPingTracked") then self:RefreshTrackingPulse() end
end

function MapPinEnhancedWorldmapPinMixin:OnHide()
    self:ResetHoverScale()
    self:HidePulse()
end

---@param elapsed number
function MapPinEnhancedWorldmapPinMixin:OnHoverScaleUpdate(elapsed)
    local target = self.hoverScaleTarget or 1
    local scale = self:GetScale()
    local step = HOVER_SCALE_SPEED * elapsed

    if scale < target then
        scale = math.min(scale + step, target)
    else
        scale = math.max(scale - step, target)
    end

    self:SetScale(scale)
    if scale == target then
        self:SetScript("OnUpdate", nil)
        self.hoverScaleTarget = nil
    end
end

---@param hovered boolean
function MapPinEnhancedWorldmapPinMixin:SetHoverScale(hovered)
    local target = hovered and self.hoverScaleEnabled and HOVER_SCALE or 1
    if self:GetScale() == target then return end

    self.hoverScaleTarget = target
    self:SetScript("OnUpdate", self.OnHoverScaleUpdate)
end

function MapPinEnhancedWorldmapPinMixin:OnEnter()
    self:SetHovered(true)
    self:SetHoverScale(true)
    if not self.pin then return end
    self.pin:ShowTooltip(self)
end

function MapPinEnhancedWorldmapPinMixin:OnLeave()
    self:SetHovered(false)
    self:SetHoverScale(false)
    GameTooltip:Hide()
end

function MapPinEnhancedWorldmapPinMixin:ApplyHoverStyle()
    MapPinEnhancedBasePinMixin.ApplyHoverStyle(self)
    self:SetAlpha(Options:GetOptionValue("Pins.Appearance.FadeUntracked") and
        not self.tracked and not self.hovered and 0.4 or 1)
end

function MapPinEnhancedWorldmapPinMixin:RefreshTrackingPulse()
    self:HidePulse()
    if self.tracked and self:IsVisible() and Options:GetOptionValue("Pins.Appearance.AlwaysPingTracked") then
        local fadeIn, scale, fadeOut = self.pulseHighlight.pulse:GetAnimations()
        fadeIn:SetDuration(0.5)
        scale:SetDuration(1.5)
        fadeOut:SetDuration(0.5)
        MapPinEnhancedBasePinMixin.ShowPulse(self)
    end
end

-- Explicit Show on Map pulses keep their original timing and then resume the preference.
function MapPinEnhancedWorldmapPinMixin:ShowPulseLoops(repeats)
    self:HidePulse()
    local fadeIn, scale, fadeOut = self.pulseHighlight.pulse:GetAnimations()
    fadeIn:SetDuration(0.2)
    scale:SetDuration(0.5)
    fadeOut:SetDuration(0.2)
    MapPinEnhancedBasePinMixin.ShowPulse(self)
    self.pulseTimer = C_Timer.NewTimer(repeats * 0.85, function()
        self.pulseTimer = nil
        self:RefreshTrackingPulse()
    end)
end

function MapPinEnhancedWorldmapPinMixin:SetTracked(skipAnimation)
    MapPinEnhancedBasePinMixin.SetTracked(self, skipAnimation)
    if Options:GetOptionValue("Pins.Appearance.AlwaysPingTracked") then self:RefreshTrackingPulse() end
end
