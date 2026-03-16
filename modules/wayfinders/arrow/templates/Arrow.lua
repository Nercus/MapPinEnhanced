---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingArrowNeedle : Texture
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedFloatingArrowTemplate : Frame
---@field needle MapPinEnhancedFloatingArrowNeedle
---@field pin MapPinEnhancedBasePinTemplate
---@field title FontString
---@field distance FontString
---@field eta FontString
---@field fadeIn Animation
---@field fadeOut Animation
---@field needleRotation number | nil
---@field newNeedleRotation number | nil
---@field displayType 'close' | 'far' | nil
MapPinEnhancedFloatingArrowMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local DEFAULT_COLOR = PIN_COLORS_BY_NAME["Yellow"]

local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local mathAbs = math.abs
local DeltaLerp = DeltaLerp

---@param color PinColor
function MapPinEnhancedFloatingArrowMixin:SetColor(color)
    local colorValue = color and PIN_COLORS_BY_NAME[color] or DEFAULT_COLOR
    self.needle:SetVertexColor(colorValue:GetRGBA())
    self.pin:SetTextureColor(colorValue)
end

function MapPinEnhancedFloatingArrowMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.needle:SetVertexColor(DEFAULT_COLOR:GetRGBA())
end

function MapPinEnhancedFloatingArrowMixin:SetTitle(title)
    self.title:SetText(title)
end

local ORBIT_RADIUS = 30
function MapPinEnhancedFloatingArrowMixin:SetLocation(mapID, x, y)
    self.targetMapID = mapID
    self.targetX = x
    self.targetY = y
end

---@param displayType 'close' | 'far'
function MapPinEnhancedFloatingArrowMixin:SetDisplayType(displayType)
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

local lastUpdate = 0
function MapPinEnhancedFloatingArrowMixin:UpdateNeedlePosition(elapsed)
    if not self.targetMapID or not self.targetX or not self.targetY then return end
    if elapsed and lastUpdate + 0.1 > GetTime() then return end
    lastUpdate = GetTime()
    local x, y, mapID = self.targetX, self.targetY, self.targetMapID
    if not mapID or not x or not y then return end

    local worldAngle = MapPinEnhanced:GetWorldVectorForTarget(mapID, x, y)
    if not worldAngle then return end

    local facing = GetPlayerFacing()
    if not facing then return end

    local relativeAngle = worldAngle - facing
    relativeAngle = mathAtan2(-mathSin(relativeAngle), mathCos(relativeAngle))

    self.newNeedleRotation = relativeAngle
    self:UpdateNeedleAlpha()
end

function MapPinEnhancedFloatingArrowMixin:AnimateNeedleRotation(elapsed)
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

function MapPinEnhancedFloatingArrowMixin:UpdateNeedleAlpha()
    if not self.displayType or self.displayType == "close" then return end
    local relativeAngle = self.newNeedleRotation or 0
    if mathAbs(relativeAngle) < 0.2 then
        self.needle:SetAlpha(1)
    else
        self.needle:SetAlpha(0.4)
    end
end

---@param elapsed number
function MapPinEnhancedFloatingArrowMixin:OnUpdate(elapsed)
    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateNeedleRotation(elapsed)
end

function MapPinEnhancedFloatingArrowMixin:OnDistanceUpdate(distance, timeToTarget)
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

---@param mouseButton MouseButton
function MapPinEnhancedFloatingArrowMixin:OnMouseDown(mouseButton)
    if mouseButton ~= "RightButton" then return end
    -- TODO: add a menu here
end

function MapPinEnhancedFloatingArrowMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "floatingArrow", nil)
    self.pin:SetTracked(true)
end

function MapPinEnhancedFloatingArrowMixin:OnShow()
    self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
    self:UpdateNeedlePosition()
    self:UpdateNeedleAlpha()
    self:SetDisplayType("far")
end

function MapPinEnhancedFloatingArrowMixin:Reset()
    self:SetDisplayType("far")
    self.needleRotation = nil
    self.newNeedleRotation = nil
end

function MapPinEnhancedFloatingArrowMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:Reset()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
end
