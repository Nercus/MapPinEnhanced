---@alias FloatingPresentation "close"|"far"|"clamped"|"fallback"|"fallback-close"

---@class MapPinEnhancedWayfinderFloatingChevron : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedWayfinderFloatingChevrons : Frame
---@field top MapPinEnhancedWayfinderFloatingChevron
---@field middle MapPinEnhancedWayfinderFloatingChevron
---@field bottom MapPinEnhancedWayfinderFloatingChevron

---@class MapPinEnhancedWayfinderFloatingText : Frame
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedWayfinderFloatingContentVisual : Frame
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field text MapPinEnhancedWayfinderFloatingText
---@field hover Frame
---@field closePinAnchor Frame
---@field fallbackTitleAnchor Frame
---@field chevrons MapPinEnhancedWayfinderFloatingChevrons
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedWayfinderFloatingContentTemplate : Frame, MapPinEnhancedFadingFrameTemplate
---@field visual MapPinEnhancedWayfinderFloatingContentVisual
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingBeamTemplate
---@field title MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field needle MapPinEnhancedWayfinderFloatingNeedleTemplate
---@field currentPresentation FloatingPresentation?
---@field pendingPresentation FloatingPresentation?
---@field showBeam boolean?
---@field showTextOutline boolean?
---@field chevronTextures MapPinEnhancedWayfinderFloatingChevron[]
---@field textShowsTitle boolean?
---@field textHovered boolean?
---@field textElapsed number? nil once the intro ends
MapPinEnhancedWayfinderFloatingContentMixin = {}

function MapPinEnhancedWayfinderFloatingContentMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.pin = self.visual.pin
    self.beam = self.visual.beam
    self.title = self.visual.text.title
    self.readout = self.visual.text.readout
    self.chevronTextures = { self.visual.chevrons.top, self.visual.chevrons.middle, self.visual.chevrons.bottom }
    local frameLevel = self:GetFrameLevel()
    self.visual:SetFrameLevel(frameLevel)
    self.needle:SetFrameLevel(frameLevel)
    self.beam:SetFrameLevel(frameLevel + 1)
    self.pin:SetFrameLevel(frameLevel + 2)
    self.title:SetFrameLevel(frameLevel + 3)
    self.readout:SetFrameLevel(frameLevel + 3)
    self.visual.hover:SetFrameLevel(frameLevel + 4)
    self.visual.hover:SetMouseClickEnabled(false)
    for _, group in ipairs({ self.visual.fadeIn, self.visual.fadeOut }) do
        for _, animation in ipairs({ group:GetAnimations() }) do
            animation:SetDuration(0.25)
        end
    end
    for _, group in ipairs({ self.visual.text.fadeIn, self.visual.text.fadeOut }) do
        for _, animation in ipairs({ group:GetAnimations() }) do
            animation:SetDuration(0.2)
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
    if self.textShowsTitle then self.readout.text:SetTextColor(lightR, lightG, lightB) end
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
    if self.currentPresentation == "far" and self.textShowsTitle then self.readout:SetStatusText(title) end
end

function MapPinEnhancedWayfinderFloatingContentMixin:UpdateBeam()
    self.beam:SetActive(self.showBeam == true and self.currentPresentation == "far" and self:IsVisible())
end

---@param showBeam boolean
function MapPinEnhancedWayfinderFloatingContentMixin:SetShowBeam(showBeam)
    self.showBeam = showBeam
    self:UpdateBeam()
end

---@param showTextOutline boolean
function MapPinEnhancedWayfinderFloatingContentMixin:SetShowTextOutline(showTextOutline)
    self.showTextOutline = showTextOutline
    self:ApplyReadoutStyle(self.textShowsTitle == true)
    self.readout:UpdateText()
end

---@param showTitle boolean
function MapPinEnhancedWayfinderFloatingContentMixin:ApplyReadoutStyle(showTitle)
    local font, size = GameFontNormalSmall:GetFont()
    self.readout.text:SetFont(font, showTitle and size or 8, self.showTextOutline and "OUTLINE" or "")
    if showTitle then
        self.readout.text:SetTextColor(self.title.title:GetTextColor())
    else
        self.readout.text:SetTextColor(1, 1, 1)
    end
end

-- Apply the phase's style before measuring its text; the container owns the fade.
---@param showTitle boolean
function MapPinEnhancedWayfinderFloatingContentMixin:ApplyFarText(showTitle)
    self.textShowsTitle = showTitle
    self:ApplyReadoutStyle(showTitle)
    self.readout:SetStatusText(showTitle and self.title.fullTitle or nil)
    self.readout:StopVisibilityFade()
    self.readout:SetAlpha(1)
    local text = self.readout.statusText or self.readout.distanceText
    if not text or text == "" then self.readout:HideImmediately() end
end

function MapPinEnhancedWayfinderFloatingContentMixin:StopTextTransition()
    self.visual.text.fadeOut:Stop()
    self.visual.text.fadeIn:Stop()
    self.visual.text:SetAlpha(1)
    self.textHovered = nil
    if self.textElapsed then self.textElapsed = 0 end
    self.visual.hover:Hide()
    self.textShowsTitle = nil
    self:ApplyReadoutStyle(false)
    if self.readout.statusText then self.readout:SetStatusText(nil) end
end

-- Only the tracking owner starts an intro. Temporary hiding preserves its state.
function MapPinEnhancedWayfinderFloatingContentMixin:BeginTextIntro()
    self:StopTextTransition()
    self.textElapsed = 0
    if self.currentPresentation == "far" then
        self:ApplyFarText(true)
        self.visual.hover:Show()
    end
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnTextEnter()
    if self.currentPresentation ~= "far" or self.pendingPresentation or self.visibilityHiding then return end
    self.textElapsed = nil
    self.textHovered = true
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnTextLeave()
    self.textHovered = nil
end

function MapPinEnhancedWayfinderFloatingContentMixin:FinishTextTransition()
    if self.currentPresentation ~= "far" or not self:IsVisible() then return end
    self:ApplyFarText(self.textElapsed ~= nil or self.textHovered == true)
    self.visual.text.fadeIn:Play()
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingContentMixin:UpdateFarText(elapsed)
    if self.currentPresentation ~= "far" or self.pendingPresentation or not self:IsVisible() or
        self.visibilityHiding then
        return
    end

    local text = self.visual.text
    if text.fadeOut:IsPlaying() or text.fadeIn:IsPlaying() or
        self.visual.fadeOut:IsPlaying() or self.visual.fadeIn:IsPlaying() or
        self.visibilityFadeIn:IsPlaying() then
        return
    end
    local showTitle = self.textElapsed ~= nil or self.textHovered == true
    if showTitle ~= self.textShowsTitle then
        text.fadeOut:Play()
        return
    end
    if not self.textElapsed or self.readout.visibilityFadeIn:IsPlaying() then return end
    self.textElapsed = self.textElapsed + elapsed
    if self.textElapsed < 7 then return end
    self.textElapsed = nil
    text.fadeOut:Play()
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
    self:StopTextTransition()
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
    self:StopTextTransition()
    self.currentPresentation = presentation
    local clamped = presentation == "clamped"
    local close = presentation == "close"
    local fallbackClose = presentation == "fallback-close"
    local fallback = presentation == "fallback" or fallbackClose
    self.title:SetFallback(fallback)
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
    self.readout:SetDisplayVisible(not clamped and not fallback)
    self.readout:ClearAllPoints()
    if close then
        self.readout:SetPoint("BOTTOM", self.title, "TOP", 0, 0)
    else
        self.readout:SetPoint("TOP", self.pin, "BOTTOM", 0, -3)
    end
    self.needle:SetFallback(fallback, fallbackClose)
    self.needle:SetActive((clamped or fallback) and self:IsVisible())
    if presentation == "far" then
        self.title:HideImmediately()
        self:ApplyFarText(self.textElapsed ~= nil)
        self.visual.hover:Show()
    end
    self:UpdateBeam()
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnShow()
    if self.currentPresentation then self:ApplyPresentation(self.currentPresentation) end
end

function MapPinEnhancedWayfinderFloatingContentMixin:OnHide()
    -- Direction can hide independently of the target frame during an action Step.
    self:StopTextTransition()
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
    self.readout:SetDisplayVisible(false)
    self.visual:Hide()
    self.pin:HidePulse()
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingContentMixin:SetDestinationText(title, description)
    self.title:SetDestinationText(title, description)
    if self.currentPresentation == "far" and self.textShowsTitle then self.readout:SetStatusText(title) end
end
