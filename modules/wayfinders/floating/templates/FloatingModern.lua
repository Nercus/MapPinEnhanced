---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedFloatingModernNeedle : Texture
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedFloatingModernTemplate : Frame
---@field pin MapPinEnhancedBasePinTemplate
---@field title FontString
---@field distance FontString
---@field eta FontString
---@field needle MapPinEnhancedFloatingModernNeedle
MapPinEnhancedFloatingModernMixin = {}

-- TODO: the distant diamond should scale based on distance
-- TODO: use the generic-frame-chamfered-12d-2o atlas to use as title background
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local Pins = MapPinEnhanced:GetModule("Pins")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local DEFAULT_COLOR = PIN_COLORS_BY_NAME["Yellow"]
local HBD = MapPinEnhanced.HBD

local needsReset = false
local mathSqrt = math.sqrt
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local DeltaLerp = DeltaLerp

---@param color PinColor
function MapPinEnhancedFloatingModernMixin:SetColor(color)
    local colorValue = color and PIN_COLORS_BY_NAME[color] or DEFAULT_COLOR
    self.needle:SetVertexColor(colorValue:GetRGBA())
    self.pin:SetTextureColor(colorValue)
end

function MapPinEnhancedFloatingModernMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.needle:SetVertexColor(DEFAULT_COLOR:GetRGBA())
end

function MapPinEnhancedFloatingModernMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedFloatingModernMixin:SetLocation(mapID, x, y)
    self.targetMapID = mapID
    self.targetX = x
    self.targetY = y
    self.targetWorldX, self.targetWorldY, self.targetInstance = HBD:GetWorldCoordinatesFromZone(x, y, mapID)
end

local function GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter();
    local scale = UIParent:GetEffectiveScale() or 1;
    return centerX / scale, centerY / scale;
end

---@param major number
---@param minor number
function MapPinEnhancedFloatingModernMixin:SetEllipticalRadii(major, minor)
    self.majorAxis = major
    self.minorAxis = minor
    self.majorAxisSquared = major * major
    self.minorAxisSquared = minor * minor
    self.axesMultiplied = major * minor
end

function MapPinEnhancedFloatingModernMixin:InitializeNavigationFrame()
    if self.navFrame then return end
    self.navFrame = C_Navigation.GetFrame()
    self:SetShown(self.navFrame ~= nil)

    if self.navFrame then
        self:ClearAllPoints()
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

function MapPinEnhancedFloatingModernMixin:ShutdownNavigationFrame()
    self:ClearAllPoints()
    self.navFrame = nil
    self.isClamped = nil
    self.clampedChanged = nil
end

function MapPinEnhancedFloatingModernMixin:CheckInitializeNavigationFrame()
    if not self.navFrame then
        self:InitializeNavigationFrame()
    end
end

---@param displayType 'close' | 'far'
function MapPinEnhancedFloatingModernMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if displayType == "close" then
        self.needle.fadeIn:Stop()
        self.needle.fadeOut:Play()
        self.pin:ShowPulse()
    else
        self.needle.fadeOut:Stop()
        self.needle.fadeIn:Play()
        self.pin:HidePulse()
    end
end

local UP_VECTOR = CreateVector2D(0, 1);
local RIGHT_VECTOR = CreateVector2D(1, 0);
local indicatorVec = CreateVector2D(0, 0);

local lastUpdate = 0
function MapPinEnhancedFloatingModernMixin:UpdateNeedlePosition(elapsed)
    if not self.targetWorldX or not self.targetWorldY or not self.targetInstance then return end
    if elapsed and lastUpdate + 0.1 > GetTime() then return end
    lastUpdate = GetTime()

    local playerWorldX, playerWorldY, playerInstance = HBD:GetPlayerWorldPosition()
    if not playerWorldX or not playerWorldY or playerInstance ~= self.targetInstance then return end

    local worldAngle = HBD:GetWorldVector(playerInstance, playerWorldX, playerWorldY,
        self.targetWorldX, self.targetWorldY)

    local facing = GetPlayerFacing()
    if not worldAngle or not facing then return end

    local relativeAngle = worldAngle - facing
    relativeAngle = mathAtan2(-mathSin(relativeAngle), mathCos(relativeAngle))

    self.newNeedleRotation = relativeAngle
end

function MapPinEnhancedFloatingModernMixin:AnimateNeedleRotation(elapsed)
    if not self.displayType or self.displayType == "close" then return end
    local currentRotation = self.needleRotation or 0
    local targetRotation = self.newNeedleRotation or 0

    local diff = mathAtan2(
        mathSin(targetRotation - currentRotation),
        mathCos(targetRotation - currentRotation)
    )
    local newRotation = DeltaLerp(currentRotation, currentRotation + diff, .1, elapsed)
    self.needleRotation = newRotation

    self.needle:SetRotation(-newRotation)
end

function MapPinEnhancedFloatingModernMixin:UpdateClampedState()
    local clamped = C_Navigation.WasClampedToScreen()
    self.clampedChanged = clamped ~= self.isClamped
    self.isClamped = clamped
end

function MapPinEnhancedFloatingModernMixin:ClampElliptical()
    local centerX, centerY = GetCenterScreenPoint()
    local navX, navY = self.navFrame:GetCenter()

    if type(navX) ~= "number" or type(navY) ~= "number" then return end

    local majorAxisSquared = self.majorAxisSquared or 0
    local minorAxisSquared = self.minorAxisSquared or 0
    local axesMultiplied = self.axesMultiplied or 0

    local pX = navX - centerX
    local pY = navY - centerY
    local denominator = mathSqrt(majorAxisSquared * pY * pY + minorAxisSquared * pX * pX)

    if denominator ~= 0 then
        local ratio = axesMultiplied / denominator
        local intersectionX = pX * ratio
        local intersectionY = pY * ratio
        self:SetPoint("CENTER", WorldFrame, "CENTER", intersectionX, intersectionY)
    end
end

function MapPinEnhancedFloatingModernMixin:OnDistanceUpdate(distance, timeToTarget)
    if distance and timeToTarget then
        self.distance:SetText(MapPinEnhanced:FormatDistance(distance))
        self.eta:SetText(MapPinEnhanced:FormatETA(timeToTarget))
    else
        self.distance:SetText("")
        self.eta:SetText("")
    end
    self.distanceValue = distance
    if distance and distance < 50 then
        self:SetDisplayType("close")
    else
        self:SetDisplayType("far")
    end
end

function MapPinEnhancedFloatingModernMixin:UpdatePosition()
    if self.isClamped or self.clampedChanged then
        self:ClearAllPoints()

        if self.isClamped then
            self:ClampElliptical()
        else
            self:SetPoint("CENTER", self.navFrame, "CENTER")
        end
    end
end

function MapPinEnhancedFloatingModernMixin:OnUpdate(elapsed)
    self:CheckInitializeNavigationFrame()

    if not self.navFrame then return end
    self:UpdateClampedState()
    self:UpdatePosition()

    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateNeedleRotation(elapsed)
end

function MapPinEnhancedFloatingModernMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:SetEllipticalRadii(500, 200)
end

function MapPinEnhancedFloatingModernMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self:InitializeNavigationFrame()
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self:ShutdownNavigationFrame()
    end
end

function MapPinEnhancedFloatingModernMixin:OnShow()
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED");
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED");
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED");
    SuperTrackedFrame:ShutdownNavigationFrame();
    SuperTrackedFrame:Hide();
    needsReset = true

    self:InitializeNavigationFrame()
    self:SetScript("OnUpdate", function(_, elapsed)
        self:OnUpdate(elapsed)
    end)

    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
end

function MapPinEnhancedFloatingModernMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:ShutdownNavigationFrame()

    if needsReset then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED");
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
        SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED");
        SuperTrackedFrame:InitializeNavigationFrame();
        SuperTrackedFrame:Show();
    end

    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
end

function MapPinEnhancedFloatingModernMixin:Reset()
    self:Hide()
    needsReset = false
end
