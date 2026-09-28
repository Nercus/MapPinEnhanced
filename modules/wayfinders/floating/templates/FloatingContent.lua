---@alias FloatingPresentation "close"|"far"|"clamped"|"fallback"

---@class MapPinEnhancedWayfinderFloatingChevron : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedWayfinderFloatingChevrons : Frame
---@field top MapPinEnhancedWayfinderFloatingChevron
---@field middle MapPinEnhancedWayfinderFloatingChevron
---@field bottom MapPinEnhancedWayfinderFloatingChevron

---@class MapPinEnhancedWayfinderFloatingContentVisual : Frame
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field closePinAnchor Frame
---@field fallbackTitleAnchor Frame
---@field chevrons MapPinEnhancedWayfinderFloatingChevrons
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedWayfinderFloatingContentTemplate : Frame
---@field visual MapPinEnhancedWayfinderFloatingContentVisual
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field needle MapPinEnhancedWayfinderFloatingNeedleTemplate
---@field currentPresentation FloatingPresentation?
---@field pendingPresentation FloatingPresentation?
---@field showBeam boolean?
---@field chevronTextures MapPinEnhancedWayfinderFloatingChevron[]
MapPinEnhancedWayfinderFloatingContentMixin = {}

function MapPinEnhancedWayfinderFloatingContentMixin:OnLoad()
    self.pin = self.visual.pin
    self.beam = self.visual.beam
    self.title = self.visual.title
    self.readout = self.visual.readout
    self.chevronTextures = { self.visual.chevrons.top, self.visual.chevrons.middle, self.visual.chevrons.bottom }
    local frameLevel = self:GetFrameLevel()
    self.visual:SetFrameLevel(frameLevel)
    self.needle:SetFrameLevel(frameLevel)
    self.beam:SetFrameLevel(frameLevel + 1)
    self.pin:SetFrameLevel(frameLevel + 2)
    self.title:SetFrameLevel(frameLevel + 3)
    self.readout:SetFrameLevel(frameLevel + 3)
    for _, group in ipairs({ self.visual.fadeIn, self.visual.fadeOut }) do
        for _, animation in ipairs({ group:GetAnimations() }) do
            animation:SetDuration(0.25)
        end
    end
    self:Reset()
    self:Show()
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingContentMixin:SetColor(color)
    self.beam:SetColor(color)
    self.title:SetColor(color)
    self.needle:SetColor(color)
    local r, g, b = color:GetRGB()


    local lightR, lightG, lightB = math.min(r * 1.5, 1), math.min(g * 1.5, 1), math.min(b * 1.5, 1)
    self.readout.text:SetTextColor(lightR, lightG, lightB)
    for _, chevron in ipairs(self.chevronTextures) do
        chevron:SetVertexColor(lightR, lightG, lightB)
    end
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingContentMixin:SetChevronsActive(active)
    self.visual.chevrons:SetShown(active)
    for _, chevron in ipairs(self.chevronTextures) do
        if active then
            if not chevron.pulse:IsPlaying() then chevron.pulse:Play() end
        else
            chevron.pulse:Stop()
            chevron:SetAlpha(0.05)
        end
    end
end

---@param title string?
function MapPinEnhancedWayfinderFloatingContentMixin:SetTitle(title)
    self.title:SetTitle(title)
end

function MapPinEnhancedWayfinderFloatingContentMixin:UpdateBeam()
    self.beam:SetActive(self.showBeam == true and self.currentPresentation == "far" and self:IsVisible())
end

---@param showBeam boolean
function MapPinEnhancedWayfinderFloatingContentMixin:SetShowBeam(showBeam)
    self.showBeam = showBeam
    self:UpdateBeam()
end

---@param presentation FloatingPresentation
function MapPinEnhancedWayfinderFloatingContentMixin:SetPresentation(presentation)
    local distancePresentation = presentation == "close" or presentation == "far"
    if self.pendingPresentation and distancePresentation then
        self.pendingPresentation = presentation
        return
    end
    self.pendingPresentation = nil
    if self.currentPresentation == presentation then return end
    if (self.currentPresentation == "close" or self.currentPresentation == "far") and
        distancePresentation and self:IsVisible() then
        self.pendingPresentation = presentation
        self.visual.fadeOut:PlayReplacing(self.visual.fadeIn)
        return
    end
    self:StopPresentationAnimation()
    self:ApplyPresentation(presentation)
end

function MapPinEnhancedWayfinderFloatingContentMixin:StopPresentationAnimation()
    self.visual.fadeOut:Stop()
    self.visual.fadeIn:Stop()
    self.visual:SetAlpha(1)
end

function MapPinEnhancedWayfinderFloatingContentMixin:FinishPresentation()
    local presentation = self.pendingPresentation
    self.pendingPresentation = nil
    if not presentation or not self:IsVisible() then return end
    self:ApplyPresentation(presentation)
    self.visual.fadeIn:Play()
end

---@param presentation FloatingPresentation
function MapPinEnhancedWayfinderFloatingContentMixin:ApplyPresentation(presentation)
    self.currentPresentation = presentation
    local clamped = presentation == "clamped"
    local close = presentation == "close"
    local fallback = presentation == "fallback"
    self.visual:Show()
    self.pin:SetShown(not fallback)
    self.pin:ClearAllPoints()
    self.pin:SetPoint("CENTER", close and self.visual.closePinAnchor or self.visual, "CENTER")
    self.title:ClearAllPoints()
    if fallback then
        self.title:SetPoint("TOP", self.visual.fallbackTitleAnchor, "TOP")
    else
        self.title:SetPoint("BOTTOM", self.pin, "BOTTOM", 0, 3)
    end
    self.title:SetVisible(close or fallback)
    self:SetChevronsActive(close and self:IsVisible())
    self.readout:SetShown(not clamped)
    self.readout:ClearAllPoints()
    if fallback then
        self.readout:SetPoint("TOP", self.title, "BOTTOM", 0, -5)
    else
        self.readout:SetPoint(close and "BOTTOM" or "TOP", self.pin, close and "TOP" or "BOTTOM", 0,
            close and 5 or -8)
    end
    self.needle:SetFallback(fallback)
    self.needle:SetActive((clamped or fallback) and self:IsVisible())
    self:UpdateBeam()
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnShow()
    if self.currentPresentation then self:ApplyPresentation(self.currentPresentation) end
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnHide()
    -- Direction can hide independently of the target frame during an action Step.
    self:StopPresentationAnimation()
    self:SetChevronsActive(false)
    self.currentPresentation = self.pendingPresentation or self.currentPresentation
    self.pendingPresentation = nil
    self.beam:SetActive(false)
    self.needle:SetActive(false)
    self.title:SetVisible(false)
end

function MapPinEnhancedWayfinderFloatingContentMixin:PrepareForTarget()
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingContentMixin:Reset()
    self.pendingPresentation = nil
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
