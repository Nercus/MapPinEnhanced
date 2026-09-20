---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

local CLOSE_DISTANCE = 150

---@class MapPinEnhancedWayfinderFloatingTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin
---@field content MapPinEnhancedWayfinderFloatingContentTemplate
---@field pin MapPinEnhancedBasePinTemplate
---@field needle MapPinEnhancedWayfinderFloatingNeedleTemplate
---@field titleContainer MapPinEnhancedWayfinderFloatingTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field displayType 'close' | 'far'?
---@field presentationInitialized boolean?
---@field needleRotation number?
---@field newNeedleRotation number?
---@field needsBlizzardReset boolean?
---@field navFrame ScriptRegion?
---@field isClamped boolean?
---@field clampedChanged boolean?
---@field customDirection boolean?
---@field customPositionAngle number?
---@field lastNavigationTargetCheck number?
MapPinEnhancedWayfinderFloatingMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin,
    MapPinEnhancedWayfinderDirectionMixin)

-- TODO: the distant floating marker should scale based on distance
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local mathSqrt = math.sqrt
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local mathAbs = math.abs
local DeltaLerp = DeltaLerp
local POSITION_ANGLE_EPSILON = 0.001

---@param color PinColor
function MapPinEnhancedWayfinderFloatingMixin:SetColor(color)
    self.pin:SetColor(color)
    self.content:SetColor(self.pin:GetActiveStyleColor())
end

function MapPinEnhancedWayfinderFloatingMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.content:SetColor(self.pin:GetActiveStyleColor())
end

---@param title string?
function MapPinEnhancedWayfinderFloatingMixin:SetTitle(title)
    self.content:SetTitle(title)
end

function MapPinEnhancedWayfinderFloatingMixin:PrepareForTarget()
    self:ResetDistanceReadout()
    self:ResetDirectionSampling()
    self.displayType = "far"
    self.presentationInitialized = nil
    self.content:PrepareForTarget()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
    self.customPositionAngle = nil
end

function MapPinEnhancedWayfinderFloatingMixin:SetLocation(mapID, x, y)
    self:SetTargetLocation(mapID, x, y)
    self:PrepareForTarget()
    self:RefreshNavigationTarget()
end

function MapPinEnhancedWayfinderFloatingMixin:RefreshNavigationTarget()
    self.lastNavigationTargetCheck = GetTime()
    self:SetCustomDirectionEnabled(not Providers:IsNavigationTargetDirect(self.targetMapID, self.targetX, self.targetY))
end

---@param enabled boolean
function MapPinEnhancedWayfinderFloatingMixin:SetCustomDirectionEnabled(enabled)
    if self.customDirection == enabled then return end
    self.customDirection = enabled
    self:ResetDirectionSampling()
    self.presentationInitialized = nil
    self.customPositionAngle = nil
    self:ClearAllPoints()
    if enabled then
        self:SetPoint("CENTER", WorldFrame, "CENTER", 0, self.minorAxis or 0)
        self:SetAlpha(1)
    elseif self.navFrame then
        self:SetAlpha(1)
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    else
        self:ShutdownNavigationFrame()
    end
end

---@param angle number
function MapPinEnhancedWayfinderFloatingMixin:PositionCustomTarget(angle)
    if self.customPositionAngle then
        local angleDifference = mathAtan2(mathSin(angle - self.customPositionAngle),
            mathCos(angle - self.customPositionAngle))
        if mathAbs(angleDifference) < POSITION_ANGLE_EPSILON then return end
    end
    self.customPositionAngle = angle
    self:ClearAllPoints()
    self:SetPoint("CENTER", WorldFrame, "CENTER",
        -mathSin(angle) * (self.majorAxis or 0), mathCos(angle) * (self.minorAxis or 0))
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

function MapPinEnhancedWayfinderFloatingMixin:SetUpNavigationFrame()
    if self.navFrame then return end
    self.navFrame = C_Navigation.GetFrame()
    if self.customDirection then return end
    self:SetAlpha(self.navFrame and 1 or 0)

    if self.navFrame then
        self:ClearAllPoints()
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

function MapPinEnhancedWayfinderFloatingMixin:ShutdownNavigationFrame()
    self:ClearAllPoints()
    self:SetAlpha(0)
    self.navFrame = nil
    self.isClamped = nil
    self.clampedChanged = nil
    self.presentationInitialized = nil
    self.content:Reset()
end

function MapPinEnhancedWayfinderFloatingMixin:EnsureNavigationFrameIsSetUp()
    if not self.navFrame then
        self:SetUpNavigationFrame()
    end
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
    if not self.presentationInitialized or self.isClamped then return end
    self:RefreshPresentation()
end

---@param distance number?
---@param timeToTarget number?
function MapPinEnhancedWayfinderFloatingMixin:OnDistanceUpdate(distance, timeToTarget)
    self:SetDisplayType(distance and distance < CLOSE_DISTANCE and "close" or "far")
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingMixin:UpdateNeedlePosition(elapsed)
    local angle = self:SampleTargetAngle(elapsed)
    if self.customDirection then self:SetAlpha(angle ~= nil and 1 or 0) end
    if angle ~= nil then
        self.newNeedleRotation = angle
        if self.customDirection then self:PositionCustomTarget(angle) end
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
function MapPinEnhancedWayfinderFloatingMixin:OnUpdate(elapsed)
    if not self.lastNavigationTargetCheck or GetTime() - self.lastNavigationTargetCheck >= 0.1 then
        self:RefreshNavigationTarget()
    end
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
    self:EnsureNavigationFrameIsSetUp()
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
end

function MapPinEnhancedWayfinderFloatingMixin:OnLoad()
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
        self:SetUpNavigationFrame()
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self:ShutdownNavigationFrame()
    end
end

function MapPinEnhancedWayfinderFloatingMixin:OnShow()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self:RegisterEvent("SUPER_TRACKING_PATH_UPDATED")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:ShutdownNavigationFrame()
    SuperTrackedFrame:Hide()
    self.needsBlizzardReset = true

    self:SetUpNavigationFrame()
    self:SetScript("OnUpdate", function(_, elapsed)
        self:OnUpdate(elapsed)
    end)
    self:StartDistanceUpdates(self.readout, function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end)
end

function MapPinEnhancedWayfinderFloatingMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    self:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:UnregisterEvent("SUPER_TRACKING_CHANGED")
    self:UnregisterEvent("SUPER_TRACKING_PATH_UPDATED")
    self:StopDistanceUpdates()
    self:ResetDirectionSampling()
    self:ShutdownNavigationFrame()

    if self.needsBlizzardReset then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED")
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
        SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
        SuperTrackedFrame:InitializeNavigationFrame()
        SuperTrackedFrame:Show()
    end
    self.needsBlizzardReset = nil
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingMixin:Reset()
    self.displayType = "far"
    self.presentationInitialized = nil
    self.content:Reset()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
    self.customDirection = nil
    self.customPositionAngle = nil
    self.lastNavigationTargetCheck = nil
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingMixin:SetDestinationText(title, description)
    self.content:SetDestinationText(title, description)
end
