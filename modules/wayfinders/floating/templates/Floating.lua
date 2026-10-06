---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

local MIN_CLOSE_DISTANCE = 50
local MAX_CLOSE_DISTANCE = 200
local FALLBACK_DELAY = 1

---@class MapPinEnhancedWayfinderFloatingTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin, MapPinEnhancedFadingFrameTemplate
---@field navigationOpacity Frame | { content: MapPinEnhancedWayfinderFloatingContentTemplate }
---@field content MapPinEnhancedWayfinderFloatingContentTemplate
---@field pin MapPinEnhancedBasePinTemplate
---@field needle MapPinEnhancedWayfinderFloatingNeedleTemplate
---@field titleContainer MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field displayType 'close' | 'far'?
---@field isFallbackClose boolean?
---@field presentationInitialized boolean?
---@field needleRotation number?
---@field newNeedleRotation number?
---@field needsBlizzardReset boolean?
---@field navFrame ScriptRegion?
---@field isClamped boolean?
---@field clampedChanged boolean?
---@field customDirection boolean?
---@field fallbackReadyAt number?
---@field lastNavigationTargetCheck number?
---@field lastNavigationReadinessCheck number?
---@field nativePositionReady boolean?
MapPinEnhancedWayfinderFloatingMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin,
    MapPinEnhancedWayfinderDirectionMixin)

-- TODO: the distant floating marker should scale based on distance
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local mathSqrt = math.sqrt
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local DeltaLerp = DeltaLerp

---@param color PinColor
function MapPinEnhancedWayfinderFloatingMixin:SetColor(color)
    self.pin:SetColor(color)
    self.content:SetColor(self.pin:GetActiveStyleColor())
end

---@param texture string|number?
---@param usesAtlas boolean?
---@return boolean? hasIcon
function MapPinEnhancedWayfinderFloatingMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    local hasIcon = self.pin:SetIconTexture(texture, usesAtlas)
    self.content:SetColor(self.pin:GetActiveStyleColor())
    return hasIcon
end

---@param title string?
function MapPinEnhancedWayfinderFloatingMixin:SetTitle(title)
    self.content:SetTitle(title)
end

function MapPinEnhancedWayfinderFloatingMixin:PrepareForTarget()
    self:ResetDistanceReadout()
    self:ResetDirectionSampling()
    self.displayType = "far"
    self.isFallbackClose = nil
    self.presentationInitialized = nil
    self.customDirection = nil
    self.fallbackReadyAt = nil
    self.content:PrepareForTarget()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
end

function MapPinEnhancedWayfinderFloatingMixin:SetLocation(mapID, x, y)
    self:SetTargetLocation(mapID, x, y)
    self:PrepareForTarget()
    self:RefreshNavigationTarget()
end

function MapPinEnhancedWayfinderFloatingMixin:RefreshNavigationTarget()
    self.lastNavigationTargetCheck = GetTime()
    self:SetCustomDirectionEnabled(not Providers:CanFollowNavigationTarget(self.targetMapID, self.targetX, self.targetY))
end

---@param enabled boolean
function MapPinEnhancedWayfinderFloatingMixin:SetCustomDirectionEnabled(enabled)
    if self.customDirection == enabled then return end
    self.customDirection = enabled
    -- Native frame/path setup can lag behind tracking. Only show a persistent fallback.
    self.fallbackReadyAt = enabled and GetTime() + FALLBACK_DELAY or nil
    self.isClamped = nil
    self:ResetDirectionSampling()
    self.presentationInitialized = nil
    self:ClearAllPoints()
    if enabled then
        self:SetPoint("CENTER", WorldFrame, "CENTER", 0, 200)
        self.navigationOpacity:SetAlpha(0)
    elseif self.navFrame then
        self.navigationOpacity:SetAlpha(1)
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    else
        self:ShutdownNavigationFrame()
    end
end

---@param major number
---@param minor number
function MapPinEnhancedWayfinderFloatingMixin:SetEllipticalRadii(major, minor)
    self.majorAxis = major
    self.minorAxis = minor
    self.majorAxisSquared = major * major
    self.minorAxisSquared = minor * minor
    self.axesMultiplied = major * minor
end

function MapPinEnhancedWayfinderFloatingMixin:SetupNavigationFrame()
    local navFrame = C_Navigation.GetFrame()
    -- Cached native frames still need opacity restored after fallback or shutdown.
    if not self.customDirection then
        local alpha = navFrame and 1 or 0
        if self.navigationOpacity:GetAlpha() ~= alpha then self.navigationOpacity:SetAlpha(alpha) end
    end
    if self.navFrame == navFrame then return end
    self.navFrame = navFrame
    self.isClamped = nil
    self.presentationInitialized = nil
    if self.customDirection then return end

    if self.navFrame then
        self:ClearAllPoints()
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

function MapPinEnhancedWayfinderFloatingMixin:ShutdownNavigationFrame()
    self:ClearAllPoints()
    self.navigationOpacity:SetAlpha(0)
    self.navFrame = nil
    self.isClamped = nil
    self.clampedChanged = nil
    self.presentationInitialized = nil
    self.content:Reset()
end

function MapPinEnhancedWayfinderFloatingMixin:EnsureNavigationFrameIsSetup()
    self:SetupNavigationFrame()
end

function MapPinEnhancedWayfinderFloatingMixin:UpdateClampedState()
    local clamped = C_Navigation.WasClampedToScreen()
    self.clampedChanged = clamped ~= self.isClamped
    self.isClamped = clamped
end

function MapPinEnhancedWayfinderFloatingMixin:ClampElliptical()
    local centerX, centerY = MapPinEnhanced:GetCenterScreenPoint()
    local navX, navY = self.navFrame:GetCenter()

    if type(navX) ~= "number" or type(navY) ~= "number" then return end

    local majorAxisSquared = self.majorAxisSquared or 0
    local minorAxisSquared = self.minorAxisSquared or 0
    local axesMultiplied = self.axesMultiplied or 0
    local offsetX = navX - centerX
    local offsetY = navY - centerY
    local denominator = mathSqrt(majorAxisSquared * offsetY * offsetY + minorAxisSquared * offsetX * offsetX)

    if denominator ~= 0 then
        local ratio = axesMultiplied / denominator
        self:SetPoint("CENTER", WorldFrame, "CENTER", offsetX * ratio, offsetY * ratio)
    end
end

function MapPinEnhancedWayfinderFloatingMixin:UpdatePosition()
    if not self.isClamped and not self.clampedChanged then return end

    self:ClearAllPoints()
    if self.isClamped then
        self:ClampElliptical()
    else
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

---@return FloatingPresentation
function MapPinEnhancedWayfinderFloatingMixin:GetPresentation()
    if self.customDirection then return self.isFallbackClose and "fallback-close" or "fallback" end
    if self.isClamped then return "clamped" end
    return self.displayType or "far"
end

function MapPinEnhancedWayfinderFloatingMixin:RefreshPresentation()
    self.content:SetPresentation(self:GetPresentation())
end

---@param displayType 'close' | 'far'
function MapPinEnhancedWayfinderFloatingMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if not self.content:IsShown() or not self.presentationInitialized or
        self.isClamped and not self.customDirection then
        return
    end
    self:RefreshPresentation()
end

---@param distance number?
---@param timeToTarget number?
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
function MapPinEnhancedWayfinderFloatingMixin:OnDistanceUpdate(distance, timeToTarget, closingSpeed, nextUpdateInterval,
                                                               movementState)
    -- The bearing fallback matches Arrow; native marker layout anticipates approach speed.
    local isFallbackClose = distance ~= nil and distance < 10
    local fallbackChanged = self.isFallbackClose ~= isFallbackClose
    self.isFallbackClose = isFallbackClose
    local closeDistance = MIN_CLOSE_DISTANCE
    if movementState == "approaching" then
        -- Like dynamic arrival, allow for travel before the next distance sample.
        closeDistance = math.min(MAX_CLOSE_DISTANCE,
            MIN_CLOSE_DISTANCE + math.max(0, closingSpeed) * nextUpdateInterval)
    end
    self:SetDisplayType(distance and distance < closeDistance and "close" or "far")
    if self.content:IsShown() and fallbackChanged and self.customDirection and self.presentationInitialized then
        self:RefreshPresentation()
    end
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingMixin:UpdateNeedlePosition(elapsed)
    local angle = self:SampleTargetAngle(elapsed)
    if self.customDirection then
        local alpha = angle ~= nil and not self.fallbackReadyAt and 1 or 0
        if self.navigationOpacity:GetAlpha() ~= alpha then self.navigationOpacity:SetAlpha(alpha) end
    end
    if angle ~= nil then
        self.newNeedleRotation = angle
    end
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingMixin:AnimateNeedleRotation(elapsed)
    if not self.isClamped then return end
    local currentRotation = self.needleRotation or 0
    local targetRotation = self.newNeedleRotation or 0
    local angleDifference = mathAtan2(
        mathSin(targetRotation - currentRotation),
        mathCos(targetRotation - currentRotation)
    )
    local newRotation = DeltaLerp(currentRotation, currentRotation + angleDifference, .1, elapsed)
    self.needleRotation = newRotation
    self.needle:SetRotation(-newRotation)
end

---@param elapsed number
---@param preparingShow boolean?
function MapPinEnhancedWayfinderFloatingMixin:OnUpdate(elapsed, preparingShow)
    if not preparingShow and not self.content:IsShown() then return end
    local now = GetTime()
    if not self.lastNavigationReadinessCheck or now - self.lastNavigationReadinessCheck >= 0.1 then
        self.lastNavigationReadinessCheck = now
        local ready = C_Navigation.GetFrame() ~= nil and C_Navigation.HasValidScreenPosition()
        if ready ~= self.nativePositionReady or self.fallbackReadyAt then self.lastNavigationTargetCheck = nil end
        self.nativePositionReady = ready
    end
    -- Events/owned target changes invalidate immediately; retain a full-match recovery poll.
    if not self.lastNavigationTargetCheck or now - self.lastNavigationTargetCheck >= 1 or
        self.fallbackReadyAt and now >= self.fallbackReadyAt then
        self:RefreshNavigationTarget()
    end
    if self.fallbackReadyAt and now >= self.fallbackReadyAt then self.fallbackReadyAt = nil end
    if self.customDirection then
        self.isClamped = true
        if not self.presentationInitialized then
            self.presentationInitialized = true
            self:RefreshPresentation()
        end
        self:UpdateNeedlePosition(elapsed)
        self:AnimateNeedleRotation(elapsed)
        return
    end
    self:EnsureNavigationFrameIsSetup()
    if not self.navFrame then return end

    self:UpdateClampedState()
    self:UpdatePosition()

    if not self.presentationInitialized then
        self.presentationInitialized = true
        self:RefreshPresentation()
    elseif self.clampedChanged then
        self:RefreshPresentation()
    end

    if self.isClamped then
        self:UpdateNeedlePosition(elapsed)
        self:AnimateNeedleRotation(elapsed)
    end
    if not self.visibilityFadeIn:IsPlaying() and not self.visibilityHiding then
        self.content:UpdateFarText(elapsed)
    end
end

---@param shown boolean
function MapPinEnhancedWayfinderFloatingMixin:SetDirectionShown(shown)
    if shown and (not self.content:IsShown() or self.content.visibilityHiding) then
        self.lastNavigationTargetCheck = nil
        self.presentationInitialized = nil
        self:OnUpdate(0, true)
    end
    self.content:SetShown(shown)
end

function MapPinEnhancedWayfinderFloatingMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    -- Navigation availability must not overwrite the root visibility fade.
    self.content = self.navigationOpacity.content
    self.pin = self.content.pin
    self.needle = self.content.needle
    self.titleContainer = self.content.title
    self.readout = self.content.readout

    self:SetEllipticalRadii(500, 200)
    self.pin:SetTracked(true)
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingMixin:OnEvent(event)
    self.lastNavigationTargetCheck = nil
    if not self.content:IsShown() then return end
    if event == "SUPER_TRACKING_CHANGED" or event == "SUPER_TRACKING_PATH_UPDATED" then
        self:RefreshNavigationTarget()
        return
    end
    if self.customDirection then
        -- Native Step tracking can disappear while the sampled fallback is active.
        -- Retain its custom anchor; only cache the native frame for a later switch.
        self.navFrame = event == "NAVIGATION_FRAME_CREATED" and C_Navigation.GetFrame() or nil
        return
    end
    if event == "NAVIGATION_FRAME_CREATED" then
        self:SetupNavigationFrame()
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self:ShutdownNavigationFrame()
    end
end

function MapPinEnhancedWayfinderFloatingMixin:OnShow()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self:RegisterEvent("SUPER_TRACKING_PATH_UPDATED")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:ShutdownNavigationFrame()
    SuperTrackedFrame:Hide()
    self.needsBlizzardReset = true

    self:SetupNavigationFrame()
    self:SetScript("OnUpdate", function(_, elapsed)
        self:OnUpdate(elapsed)
    end)
    self:StartDistanceUpdates(self.readout,
        function(distance, timeToTarget, closingSpeed, nextUpdateInterval, movementState)
            self:OnDistanceUpdate(distance, timeToTarget, closingSpeed, nextUpdateInterval, movementState)
        end)
end

-- Release Blizzard ownership when hiding starts; only the last rendered marker
-- remains for the fade. A later OnHide must not undo a new wayfinder's takeover.
function MapPinEnhancedWayfinderFloatingMixin:StopTracking()
    self:SetScript("OnUpdate", nil)
    self.content:StopTextTransition()
    self:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    self:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
    self:UnregisterEvent("SUPER_TRACKING_PATH_UPDATED")
    self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:StopDistanceUpdates()
    self:ResetDirectionSampling()
    if self.needsBlizzardReset then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED")
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
        SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
        SuperTrackedFrame:InitializeNavigationFrame()
        SuperTrackedFrame:Show()
    end
    self.needsBlizzardReset = nil
end

function MapPinEnhancedWayfinderFloatingMixin:OnHide()
    self:StopTracking()
    self:ShutdownNavigationFrame()
    self:SetDestinationText(nil, nil)
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingMixin:Reset()
    self.displayType = "far"
    self.isFallbackClose = nil
    self.presentationInitialized = nil
    self.content:Reset()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
    self.customDirection = nil
    self.fallbackReadyAt = nil
    self.lastNavigationTargetCheck = nil
    self.lastNavigationReadinessCheck = nil
    self.nativePositionReady = nil
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingMixin:SetDestinationText(title, description)
    self.content:SetDestinationText(title, description)
end
