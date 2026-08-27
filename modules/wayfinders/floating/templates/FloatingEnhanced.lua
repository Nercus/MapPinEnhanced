---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Constants = MapPinEnhanced.WayfinderFloatingEnhancedConstants

---@class MapPinEnhancedWayfinderFloatingEnhancedTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin
---@field content MapPinEnhancedWayfinderFloatingEnhancedContentTemplate
---@field pin MapPinEnhancedBasePinTemplate
---@field needle MapPinEnhancedWayfinderFloatingEnhancedNeedleTemplate
---@field titleContainer MapPinEnhancedWayfinderFloatingEnhancedTitleTemplate
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field targetType WayfinderTargetType?
---@field displayType 'close' | 'far'?
---@field presentationInitialized boolean?
---@field needleRotation number?
---@field newNeedleRotation number?
---@field needsBlizzardReset boolean?
---@field navFrame ScriptRegion?
---@field isClamped boolean?
---@field clampedChanged boolean?
MapPinEnhancedWayfinderFloatingEnhancedMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin,
    MapPinEnhancedWayfinderDirectionMixin)

-- TODO: the distant floating marker should scale based on distance
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local mathSqrt = math.sqrt
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local DeltaLerp = DeltaLerp

---@param color PinColor
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetColor(color)
    self.pin:SetColor(color)
    self.content:SetColor(self.pin:GetActiveStyleColor())
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.content:SetColor(self.pin:GetActiveStyleColor())
end

---@param targetType WayfinderTargetType
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetTargetType(targetType)
    self.targetType = Wayfinders:GetTargetTypeOrDefault(targetType)
    self.content:SetColor(self.pin:GetActiveStyleColor())
    if self.presentationInitialized then
        self:RefreshPresentation(true)
    end
end

---@param title string?
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetTitle(title)
    self.content:SetTitle(title)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:PrepareForTarget()
    self:ResetDistanceReadout()
    self:ResetDirectionSampling()
    self.displayType = "far"
    self.presentationInitialized = nil
    self.content:PrepareForTarget()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetLocation(mapID, x, y)
    self:SetTargetLocation(mapID, x, y)
    self:PrepareForTarget()
end

local function GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter()
    local scale = UIParent:GetEffectiveScale() or 1
    return centerX / scale, centerY / scale
end

---@param major number
---@param minor number
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetEllipticalRadii(major, minor)
    self.majorAxis = major
    self.minorAxis = minor
    self.majorAxisSquared = major * major
    self.minorAxisSquared = minor * minor
    self.axesMultiplied = major * minor
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetUpNavigationFrame()
    if self.navFrame then return end
    self.navFrame = C_Navigation.GetFrame()
    self:SetAlpha(self.navFrame and 1 or 0)

    if self.navFrame then
        self:ClearAllPoints()
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:ShutdownNavigationFrame()
    self:ClearAllPoints()
    self:SetAlpha(0)
    self.navFrame = nil
    self.isClamped = nil
    self.clampedChanged = nil
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:EnsureNavigationFrameIsSetUp()
    if not self.navFrame then
        self:SetUpNavigationFrame()
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:UpdateClampedState()
    local clamped = C_Navigation.WasClampedToScreen()
    self.clampedChanged = clamped ~= self.isClamped
    self.isClamped = clamped
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:ClampElliptical()
    local centerX, centerY = GetCenterScreenPoint()
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

function MapPinEnhancedWayfinderFloatingEnhancedMixin:UpdatePosition()
    if not self.isClamped and not self.clampedChanged then return end

    self:ClearAllPoints()
    if self.isClamped then
        self:ClampElliptical()
    else
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

---@return FloatingEnhancedPresentation
function MapPinEnhancedWayfinderFloatingEnhancedMixin:GetPresentation()
    if self.isClamped then
        return Constants.PRESENTATION_CLAMPED
    end

    local isClose = self.displayType == "close"
    if self.targetType == Wayfinders.TARGET_TYPE_BLIZZARD then
        return isClose and Constants.PRESENTATION_BLIZZARD_CLOSE or Constants.PRESENTATION_BLIZZARD_FAR
    end
    return isClose and Constants.PRESENTATION_PLANAR_CLOSE or Constants.PRESENTATION_PLANAR_FAR
end

---@param instantly boolean?
function MapPinEnhancedWayfinderFloatingEnhancedMixin:RefreshPresentation(instantly)
    self.content:SetPresentation(self:GetPresentation(), instantly)
end

---@param displayType 'close' | 'far'
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if not self.presentationInitialized or self.isClamped then return end
    self:RefreshPresentation(false)
end

---@param distance number?
---@param timeToTarget number?
function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnDistanceUpdate(distance, timeToTarget)
    self:SetDisplayType(distance and distance < Constants.CLOSE_DISTANCE and "close" or "far")
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedMixin:UpdateNeedlePosition(elapsed)
    local angle = self:SampleTargetAngle(elapsed)
    if angle ~= nil then
        self.newNeedleRotation = angle
    end
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedMixin:AnimateNeedleRotation(elapsed)
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
function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnUpdate(elapsed)
    self:EnsureNavigationFrameIsSetUp()
    if not self.navFrame then return end

    self:UpdateClampedState()
    self:UpdatePosition()

    if not self.presentationInitialized then
        self.presentationInitialized = true
        self:RefreshPresentation(true)
    elseif self.clampedChanged then
        self:RefreshPresentation(true)
    end

    if self.isClamped then
        self:UpdateNeedlePosition(elapsed)
        self:AnimateNeedleRotation(elapsed)
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnLoad()
    self.pin = self.content.pin
    self.needle = self.content.needle
    self.titleContainer = self.content.title
    self.readout = self.content.readout

    self:SetEllipticalRadii(500, 200)
    self.pin:SetTracked(true)
    self:Reset()
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self:SetUpNavigationFrame()
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self:ShutdownNavigationFrame()
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnShow()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
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

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    self:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
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

function MapPinEnhancedWayfinderFloatingEnhancedMixin:Reset()
    self.targetType = Wayfinders.TARGET_TYPE_PIN
    self.displayType = "far"
    self.presentationInitialized = nil
    self.content:Reset()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
end
