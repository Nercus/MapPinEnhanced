---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Constants = MapPinEnhanced.WayfinderFloatingEnhancedConstants
local CLAMPED = Constants.PRESENTATION_CLAMPED
local BLIZZARD_FAR = Constants.PRESENTATION_BLIZZARD_FAR
local BLIZZARD_CLOSE = Constants.PRESENTATION_BLIZZARD_CLOSE
local PLANAR_FAR = Constants.PRESENTATION_PLANAR_FAR
local PLANAR_CLOSE = Constants.PRESENTATION_PLANAR_CLOSE
local TRANSITION_DURATION = Constants.CONTENT_TRANSITION_DURATION
local TRANSITION_SCALE = Constants.CONTENT_TRANSITION_SCALE
local CLOSE_OFFSET = Constants.CONTENT_CLOSE_OFFSET

---@alias FloatingEnhancedPresentation
---| "clamped"
---| "blizzardFar"
---| "blizzardClose"
---| "planarFar"
---| "planarClose"

---@class MapPinEnhancedWayfinderFloatingEnhancedContentVisual : Frame
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingEnhancedBeamTemplate
---@field carets MapPinEnhancedWayfinderFloatingEnhancedCaretsTemplate
---@field downArrows MapPinEnhancedWayfinderFloatingEnhancedDownArrowsTemplate
---@field title MapPinEnhancedWayfinderFloatingEnhancedTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate

---@class MapPinEnhancedWayfinderFloatingEnhancedContentTemplate : Frame
---@field visual MapPinEnhancedWayfinderFloatingEnhancedContentVisual
---@field pin MapPinEnhancedBasePinTemplate
---@field beam MapPinEnhancedWayfinderFloatingEnhancedBeamTemplate
---@field carets MapPinEnhancedWayfinderFloatingEnhancedCaretsTemplate
---@field downArrows MapPinEnhancedWayfinderFloatingEnhancedDownArrowsTemplate
---@field title MapPinEnhancedWayfinderFloatingEnhancedTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field needle MapPinEnhancedWayfinderFloatingEnhancedNeedleTemplate
---@field currentPresentation FloatingEnhancedPresentation?
---@field requestedPresentation FloatingEnhancedPresentation?
---@field transitionPhase 'in' | 'out'?
---@field transitionElapsed number?
---@field transitionStartAlpha number?
---@field transitionStartScale number?
---@field visualAlpha number?
---@field visualScale number?
MapPinEnhancedWayfinderFloatingEnhancedContentMixin = {}

---@param value number
---@return number
local function Clamp01(value)
    if value < 0 then return 0 end
    if value > 1 then return 1 end
    return value
end

---@param progress number
---@return number
local function SmoothStep(progress)
    progress = Clamp01(progress)
    return progress * progress * (3 - 2 * progress)
end

---@param fromValue number
---@param toValue number
---@param progress number
---@return number
local function Lerp(fromValue, toValue, progress)
    return fromValue + (toValue - fromValue) * progress
end

---@param presentation FloatingEnhancedPresentation?
---@return boolean
local function IsPlanarPresentation(presentation)
    return presentation == PLANAR_FAR or presentation == PLANAR_CLOSE
end

---@param presentation FloatingEnhancedPresentation?
---@return boolean
local function IsBlizzardPresentation(presentation)
    return presentation == BLIZZARD_FAR or presentation == BLIZZARD_CLOSE
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:OnLoad()
    self.pin = self.visual.pin
    self.beam = self.visual.beam
    self.carets = self.visual.carets
    self.downArrows = self.visual.downArrows
    self.title = self.visual.title
    self.readout = self.visual.readout

    local frameLevel = self:GetFrameLevel()
    self.visual:SetFrameLevel(frameLevel)
    self.needle:SetFrameLevel(frameLevel)
    self.beam:SetFrameLevel(frameLevel + 1)
    self.carets:SetFrameLevel(frameLevel + 1)
    self.downArrows:SetFrameLevel(frameLevel + 1)
    self.pin:SetFrameLevel(frameLevel + 2)
    self.title:SetFrameLevel(frameLevel + 3)
    self.readout:SetFrameLevel(frameLevel + 3)
    self:Reset()
    self:Show()
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:SetColor(color)
    self.beam:SetColor(color)
    self.carets:SetColor(color)
    self.downArrows:SetColor(color)
    self.title:SetColor(color)
    self.needle:SetColor(color)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:SetTitle(title)
    self.title:SetTitle(title)
end

---@param offsetY number
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:SetVisualOffset(offsetY)
    self.visual:ClearAllPoints()
    self.visual:SetPoint("CENTER", self, "CENTER", 0, offsetY)
end

---@param alpha number
---@param scale number
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:SetVisualTransform(alpha, scale)
    self.visualAlpha = alpha
    self.visualScale = scale
    self.visual:SetAlpha(alpha)
    self.visual:SetScale(scale)
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:DeactivateDecorations()
    self.beam:SetActive(false)
    self.carets:SetActive(false)
    self.downArrows:SetActive(false)
end

---@param point FramePoint
---@param relativeTo Region
---@param relativePoint FramePoint
---@param offsetY number
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:LayoutReadout(point, relativeTo, relativePoint, offsetY)
    self.readout:ClearAllPoints()
    self.readout:SetPoint(point, relativeTo, relativePoint, 0, offsetY)
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:ApplyClampedLayout()
    self:DeactivateDecorations()
    self.title:SetVisible(false, true)
    self.readout:Hide()
    self:SetVisualOffset(0)
    self:SetVisualTransform(1, 1)
    self.visual:Show()
    self.pin:Show()
    self.needle:SetActive(true)
    self.currentPresentation = CLAMPED
end

---@param presentation FloatingEnhancedPresentation
---@param titleInstantly boolean
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:ApplyUnclampedLayout(presentation, titleInstantly)
    self.needle:SetActive(false)
    self.visual:Show()
    self.pin:Show()
    self.readout:Show()

    if presentation == BLIZZARD_FAR or presentation == BLIZZARD_CLOSE then
        self:SetVisualOffset(0)
        self.beam:SetActive(true)
        self.carets:SetActive(false)
        self.downArrows:SetActive(false)
        self:LayoutReadout("TOP", self.pin, "BOTTOM", -5)
        self.title:SetVisible(presentation == BLIZZARD_CLOSE, titleInstantly)
    elseif presentation == PLANAR_CLOSE then
        self:SetVisualOffset(CLOSE_OFFSET)
        self.beam:SetActive(false)
        self.carets:SetActive(false)
        self.downArrows:SetActive(true)
        self:LayoutReadout("BOTTOM", self.title, "TOP", 5)
        self.title:SetVisible(true, true)
    else
        self:SetVisualOffset(0)
        self.beam:SetActive(false)
        self.carets:SetActive(true)
        self.downArrows:SetActive(false)
        self:LayoutReadout("TOP", self.carets, "BOTTOM", -5)
        self.title:SetVisible(false, true)
    end

    self.currentPresentation = presentation
end

---@param presentation FloatingEnhancedPresentation
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:ApplyPresentationInstantly(presentation)
    self.transitionPhase = nil
    self.transitionElapsed = nil
    self:SetVisualTransform(1, 1)

    if presentation == CLAMPED then
        self:ApplyClampedLayout()
    else
        self:ApplyUnclampedLayout(presentation, true)
    end
    self.requestedPresentation = presentation
end

---@param phase 'in' | 'out'
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:StartPlanarTransition(phase)
    self.transitionPhase = phase
    self.transitionElapsed = 0
    self.transitionStartAlpha = self.visualAlpha or 1
    self.transitionStartScale = self.visualScale or 1
end

---@param presentation FloatingEnhancedPresentation
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:RequestPlanarPresentation(presentation)
    local currentPresentation = self.currentPresentation or PLANAR_FAR
    if not self.transitionPhase then
        if presentation ~= currentPresentation then
            self:StartPlanarTransition("out")
        end
        return
    end

    if self.transitionPhase == "out" and presentation == currentPresentation then
        self:StartPlanarTransition("in")
    elseif self.transitionPhase == "in" and presentation ~= currentPresentation then
        self:StartPlanarTransition("out")
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:FinishPlanarTransitionPhase()
    if self.transitionPhase == "out" then
        local requestedPresentation = self.requestedPresentation or PLANAR_FAR
        if requestedPresentation ~= self.currentPresentation then
            self:ApplyUnclampedLayout(requestedPresentation, true)
        end
        self:StartPlanarTransition("in")
        return
    end

    self.transitionPhase = nil
    self.transitionElapsed = nil
    if self.requestedPresentation ~= self.currentPresentation then
        self:StartPlanarTransition("out")
    end
end

---@param presentation FloatingEnhancedPresentation
---@param instantly boolean?
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:SetPresentation(presentation, instantly)
    if not instantly and self.requestedPresentation == presentation then return end
    self.requestedPresentation = presentation

    if instantly or not self.currentPresentation or
        presentation == CLAMPED or self.currentPresentation == CLAMPED then
        self:ApplyPresentationInstantly(presentation)
    elseif IsPlanarPresentation(presentation) and IsPlanarPresentation(self.currentPresentation) then
        self:RequestPlanarPresentation(presentation)
    elseif IsBlizzardPresentation(presentation) and IsBlizzardPresentation(self.currentPresentation) then
        self:ApplyUnclampedLayout(presentation, false)
    else
        self:ApplyPresentationInstantly(presentation)
    end
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:OnUpdate(elapsed)
    local phase = self.transitionPhase
    if not phase then return end

    self.transitionElapsed = (self.transitionElapsed or 0) + elapsed
    local progress = Clamp01(self.transitionElapsed / TRANSITION_DURATION)
    local easedProgress = SmoothStep(progress)
    local targetAlpha = phase == "out" and 0 or 1
    local targetScale = phase == "out" and TRANSITION_SCALE or 1
    self:SetVisualTransform(
        Lerp(self.transitionStartAlpha or 1, targetAlpha, easedProgress),
        Lerp(self.transitionStartScale or 1, targetScale, easedProgress)
    )

    if progress >= 1 then
        self:FinishPlanarTransitionPhase()
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:PrepareForTarget()
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingEnhancedContentMixin:Reset()
    self.transitionPhase = nil
    self.transitionElapsed = nil
    self.currentPresentation = nil
    self.requestedPresentation = nil
    self:DeactivateDecorations()
    self.title:SetVisible(false, true)
    self.readout:Hide()
    self.needle:SetActive(false)
    self:SetVisualOffset(0)
    self:SetVisualTransform(1, 1)
    self.visual:Hide()
    self.pin:HidePulse()
end
