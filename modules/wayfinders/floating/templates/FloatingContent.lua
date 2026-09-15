---@alias FloatingPresentation "close"|"far"|"clamped"

---@class MapPinEnhancedWayfinderFloatingContentVisual : Frame
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate

---@class MapPinEnhancedWayfinderFloatingContentTemplate : Frame
---@field visual MapPinEnhancedWayfinderFloatingContentVisual
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field needle MapPinEnhancedWayfinderFloatingNeedleTemplate
---@field currentPresentation FloatingPresentation?
---@field showBeam boolean?
MapPinEnhancedWayfinderFloatingContentMixin = {}

function MapPinEnhancedWayfinderFloatingContentMixin:OnLoad()
    self.pin = self.visual.pin
    self.beam = self.visual.beam
    self.title = self.visual.title
    self.readout = self.visual.readout
    local frameLevel = self:GetFrameLevel()
    self.visual:SetFrameLevel(frameLevel)
    self.needle:SetFrameLevel(frameLevel)
    self.beam:SetFrameLevel(frameLevel + 1)
    self.pin:SetFrameLevel(frameLevel + 2)
    self.title:SetFrameLevel(frameLevel + 3)
    self.readout:SetFrameLevel(frameLevel + 3)
    self:Reset()
    self:Show()
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingContentMixin:SetColor(color)
    self.beam:SetColor(color)
    self.title:SetColor(color)
    self.needle:SetColor(color)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingContentMixin:SetTitle(title)
    self.title:SetTitle(title)
end

function MapPinEnhancedWayfinderFloatingContentMixin:UpdateBeam()
    self.beam:SetActive(self.showBeam == true and self.currentPresentation ~= nil and
        self.currentPresentation ~= "clamped" and self:IsVisible())
end

---@param showBeam boolean
function MapPinEnhancedWayfinderFloatingContentMixin:SetShowBeam(showBeam)
    self.showBeam = showBeam
    self:UpdateBeam()
end

---@param presentation FloatingPresentation
function MapPinEnhancedWayfinderFloatingContentMixin:SetPresentation(presentation)
    self.currentPresentation = presentation
    local clamped = presentation == "clamped"
    local close = presentation == "close"
    self.visual:Show()
    self.pin:Show()
    self.title:SetVisible(close)
    self.readout:SetShown(not clamped)
    self.readout:ClearAllPoints()
    self.readout:SetPoint("TOP", close and self.title or self.pin, "BOTTOM", 0, -5)
    self.needle:SetActive(clamped and self:IsVisible())
    self:UpdateBeam()
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnShow()
    if self.currentPresentation then self:SetPresentation(self.currentPresentation) end
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnHide()
    -- Direction can hide independently of the target frame during an action Step.
    self.beam:SetActive(false)
    self.needle:SetActive(false)
    self.title:SetVisible(false)
end

function MapPinEnhancedWayfinderFloatingContentMixin:PrepareForTarget()
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingContentMixin:Reset()
    self.currentPresentation = nil
    self:OnHide()
    self.readout:Hide()
    self.visual:Hide()
    self.pin:HidePulse()
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingContentMixin:SetDestinationText(title, description)
    self.title:SetDestinationText(title, description)
end
