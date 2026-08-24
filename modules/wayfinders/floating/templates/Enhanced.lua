---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedFloatingEnhancedNeedle : Texture
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedFloatingEnhancedTitleContainer : Frame
---@field title FontString
---@field titleBackground Texture
---@field titleGradient Texture

---@class MapPinEnhancedWayfinderFloatingEnhancedTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin
---@field pin MapPinEnhancedBasePinTemplate
---@field distance FontString
---@field eta FontString
---@field titleContainer MapPinEnhancedFloatingEnhancedTitleContainer
---@field beam Texture
---@field needle MapPinEnhancedFloatingEnhancedNeedle
---@field needsBlizzardReset boolean?
---@field lastDistanceText string?
---@field lastEtaText string?
MapPinEnhancedWayfinderFloatingEnhancedMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin,
    MapPinEnhancedWayfinderDirectionMixin)

-- TODO: the distant floating marker should scale based on distance
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local mathSqrt = math.sqrt
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local mathCeil = math.ceil
local mathMin = math.min
local stringByte = string.byte
local stringSub = string.sub
local DeltaLerp = DeltaLerp
local MAX_TITLE_WIDTH = 450
local TITLE_ELLIPSIS = "..."

---@param text string
---@param endIndex number
---@return string
local function GetUTF8Prefix(text, endIndex)
    while endIndex > 0 do
        local nextByte = stringByte(text, endIndex + 1)
        if not nextByte or nextByte < 0x80 or nextByte >= 0xC0 then break end
        endIndex = endIndex - 1
    end
    return stringSub(text, 1, endIndex)
end

---@param fontString FontString
---@param text string
local function SetTruncatedTitle(fontString, text)
    fontString:SetWidth(0)
    fontString:SetText(text)

    local fullWidth = fontString:GetUnboundedStringWidth()
    if fullWidth <= MAX_TITLE_WIDTH then
        fontString:SetWidth(mathCeil(fullWidth))
        return
    end

    local low = 0
    local high = #text
    local truncatedText = TITLE_ELLIPSIS
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local candidate = GetUTF8Prefix(text, middle) .. TITLE_ELLIPSIS
        fontString:SetText(candidate)
        if fontString:GetUnboundedStringWidth() <= MAX_TITLE_WIDTH then
            truncatedText = candidate
            low = middle + 1
        else
            high = middle - 1
        end
    end

    fontString:SetText(truncatedText)
    fontString:SetWidth(mathMin(MAX_TITLE_WIDTH, mathCeil(fontString:GetUnboundedStringWidth())))
end

---@param frame MapPinEnhancedWayfinderFloatingEnhancedTemplate
local function ApplyWayfinderColor(frame)
    local activeColor = frame.pin:GetActiveStyleColor()
    local r, g, b, a = activeColor:GetRGBA()
    frame.needle:SetVertexColor(r, g, b, a)
    frame.titleContainer.titleBackground:SetVertexColor(r, g, b, 1)
    frame.titleContainer.titleGradient:SetVertexColor(r, g, b, a)
    frame.beam:SetGradient("VERTICAL", CreateColor(r, g, b, a), CreateColor(r, g, b, 0))
end

---@param color PinColor
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetColor(color)
    self.pin:SetColor(color)
    ApplyWayfinderColor(self)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    ApplyWayfinderColor(self)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetTitle(title)
    local titleFontString = self.titleContainer.title
    titleFontString:SetMaxLines(1)
    titleFontString:SetWordWrap(false)
    SetTruncatedTitle(titleFontString, title)
    self.titleContainer:SetSize(titleFontString:GetWidth() + 10, titleFontString:GetHeight() + 10)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetLocation(mapID, x, y)
    self:SetTargetLocation(mapID, x, y)
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

---@param displayType 'close' | 'far'
function MapPinEnhancedWayfinderFloatingEnhancedMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if displayType == "close" then
        self.needle.fadeOut:PlayHiding(self.needle.fadeIn)
        self.pin:ShowPulse()
    else
        self.needle.fadeIn:PlayShowing(self.needle.fadeOut)
        self.pin:HidePulse()
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:UpdateNeedlePosition(elapsed)
    local angle = self:SampleTargetAngle(elapsed)
    if angle == nil then return end
    self.newNeedleRotation = angle
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:AnimateNeedleRotation(elapsed)
    if not self.displayType or self.displayType == "close" then return end
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
        local intersectionX = offsetX * ratio
        local intersectionY = offsetY * ratio
        self:SetPoint("CENTER", WorldFrame, "CENTER", intersectionX, intersectionY)
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnDistanceUpdate(distance, timeToTarget)
    self.distanceValue = distance
    if distance and distance < 50 then
        self:SetDisplayType("close")
    else
        self:SetDisplayType("far")
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:UpdatePosition()
    if self.isClamped or self.clampedChanged then
        self:ClearAllPoints()

        if self.isClamped then
            self:ClampElliptical()
        else
            self:SetPoint("CENTER", self.navFrame, "CENTER")
        end
    end
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnUpdate(elapsed)
    self:EnsureNavigationFrameIsSetUp()

    if not self.navFrame then return end
    self:UpdateClampedState()
    self:UpdatePosition()

    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateNeedleRotation(elapsed)
end

function MapPinEnhancedWayfinderFloatingEnhancedMixin:OnLoad()
    self:SetEllipticalRadii(500, 200)
    self.pin:SetTracked(true)
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

    self:StartDistanceUpdates(self.distance, self.eta, function(distance, timeToTarget)
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
    self.displayType = "far"
    self.needle.fadeIn:SetParentShownInstantly(true, self.needle.fadeOut)
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needle:SetRotation(0)
    self.pin:HidePulse()
end
