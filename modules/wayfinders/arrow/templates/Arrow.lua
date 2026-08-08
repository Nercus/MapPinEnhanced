---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingArrowNeedle : Texture
---@field fadeIn Animation
---@field fadeOut Animation

---@class MapPinEnhancedFloatingArrowNeedleContainer : Frame
---@field needle MapPinEnhancedFloatingArrowNeedle

---@class MapPinEnhancedFloatingArrowTextContainer : Frame
---@field title FontString
---@field distance FontString
---@field eta FontString

---@class MapPinEnhancedFloatingArrowTemplate : Frame
---@field needleContainer MapPinEnhancedFloatingArrowNeedleContainer
---@field textContainer MapPinEnhancedFloatingArrowTextContainer
---@field pin MapPinEnhancedBasePinTemplate
---@field title FontString
---@field distance FontString
---@field eta FontString
---@field fadeIn Animation
---@field fadeOut Animation
---@field needleRotation number | nil
---@field newNeedleRotation number | nil
---@field rotatePin boolean | nil
---@field displayType 'close' | 'far' | nil
MapPinEnhancedFloatingArrowMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local DEFAULT_COLOR = PIN_COLORS_BY_NAME[Pins.DEFAULT_COLOR]
local HBD = MapPinEnhanced.HBD
local MIN_NEEDLE_SCALE = 0.7
local MAX_NEEDLE_SCALE = 1
local MIN_NEEDLE_ALPHA = 0.5
local MAX_NEEDLE_ALPHA = 1

local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local mathAbs = math.abs
local mathPi = math.pi
local DeltaLerp = DeltaLerp

---@param rotation number
---@return number progress A value between 0 and 1, where 0 is aligned and 1 is opposite.
local function GetNeedleRotationProgress(rotation)
    local normalizedRotation = mathAtan2(mathSin(rotation), mathCos(rotation))
    return mathAbs(normalizedRotation) / mathPi
end

---@return AnyMenuEntry[]
local function BuildArrowSettingsMenuEntries()
    return {
        {
            type = "title",
            label = MapPinEnhanced.L["Wayfinder.Arrow_GROUPLABEL"],
        },
        {
            type = "checkbox",
            -- TODO: Replace the placeholder pin with a rotate icon.
            label = MapPinEnhanced:Iconize("pin", MapPinEnhanced.L["Wayfinder.Arrow.RotatePin_LABEL"]),
            isSelected = function()
                return Options:GetOptionValue("Wayfinder.Arrow.RotatePin")
            end,
            setSelected = function()
                ---@type boolean
                local rotatePin = Options:GetOptionValue("Wayfinder.Arrow.RotatePin")
                Options:SetOptionValue("Wayfinder.Arrow.RotatePin", not rotatePin)
            end,
        },
    }
end

---@param color PinColor
function MapPinEnhancedFloatingArrowMixin:SetColor(color)
    local colorValue = color and PIN_COLORS_BY_NAME[color] or DEFAULT_COLOR
    self.needleContainer.needle:SetVertexColor(colorValue:GetRGBA())
    self.pin:SetColor(color)
end

function MapPinEnhancedFloatingArrowMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.needleContainer.needle:SetVertexColor(DEFAULT_COLOR:GetRGBA())
end

function MapPinEnhancedFloatingArrowMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedFloatingArrowMixin:SetLocation(mapID, x, y)
    self.targetMapID = mapID
    self.targetX = x
    self.targetY = y
    self.targetWorldX, self.targetWorldY, self.targetInstance = HBD:GetWorldCoordinatesFromZone(x, y, mapID)
end

---@param displayType 'close' | 'far'
function MapPinEnhancedFloatingArrowMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if displayType == "close" then
        self.needleContainer.needle.fadeIn:Stop()
        self.needleContainer.needle.fadeOut:Play()
        self.pin:ShowPulse()
    else
        self.needleContainer.needle.fadeOut:Stop()
        self.needleContainer.needle.fadeIn:Play()
        self.pin:HidePulse()
    end
end

local lastUpdate = 0
function MapPinEnhancedFloatingArrowMixin:UpdateNeedlePosition(elapsed)
    if not self.targetWorldX or not self.targetWorldY or not self.targetInstance then return end
    if elapsed and lastUpdate + .1 > GetTime() then return end
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
    self:UpdateNeedleAlpha()
end

---@param rotation number
function MapPinEnhancedFloatingArrowMixin:SetPinRotation(rotation)
    self.pin.background:SetRotation(rotation)
    self.pin.outline:SetRotation(rotation)
    self.pin.foreground:SetRotation(rotation)
    self.pin.icon:SetRotation(rotation)
    self.pin.lock:SetRotation(rotation)
end

---@param rotatePin boolean
function MapPinEnhancedFloatingArrowMixin:SetRotatePin(rotatePin)
    self.rotatePin = rotatePin
    if not rotatePin then
        self:SetPinRotation(0)
    end
end

---@param rotation number
function MapPinEnhancedFloatingArrowMixin:UpdateNeedleScale(rotation)
    local scaleRange = MAX_NEEDLE_SCALE - MIN_NEEDLE_SCALE
    local scale = MAX_NEEDLE_SCALE - (scaleRange * GetNeedleRotationProgress(rotation))
    self.needleContainer:SetScale(scale)
end

---@param rotation number | nil
function MapPinEnhancedFloatingArrowMixin:UpdateNeedleAlpha(rotation)
    if not self.displayType or self.displayType == "close" then return end

    local rotationProgress = GetNeedleRotationProgress(rotation or self.newNeedleRotation or 0)
    local alphaRange = MAX_NEEDLE_ALPHA - MIN_NEEDLE_ALPHA
    local alpha = MAX_NEEDLE_ALPHA - (alphaRange * rotationProgress)
    self.needleContainer.needle:SetAlpha(alpha)
end

function MapPinEnhancedFloatingArrowMixin:AnimateRotation(elapsed)
    if not self.displayType or self.displayType == "close" then return end
    local currentRotation = self.needleRotation or 0
    local targetRotation = self.newNeedleRotation or 0

    local diff = mathAtan2(
        mathSin(targetRotation - currentRotation),
        mathCos(targetRotation - currentRotation)
    )
    local newRotation = DeltaLerp(currentRotation, currentRotation + diff, .2, elapsed)
    self.needleRotation = newRotation

    self.needleContainer.needle:SetRotation(-newRotation)
    self:UpdateNeedleScale(newRotation)
    self:UpdateNeedleAlpha(newRotation)
    if self.rotatePin then
        self:SetPinRotation(-newRotation)
    end
end

---@param elapsed number
function MapPinEnhancedFloatingArrowMixin:OnUpdate(elapsed)
    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateRotation(elapsed)
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
    if distance and distance < 10 then
        self:SetDisplayType("close")
    else
        self:SetDisplayType("far")
    end
end

---@param mouseButton MouseButton
function MapPinEnhancedFloatingArrowMixin:OnMouseDown(mouseButton)
    if mouseButton ~= "RightButton" then return end

    local trackedPin = Pins:GetTrackedPin()
    local menu = trackedPin and trackedPin:BuildPinMenuEntries() or {}

    if trackedPin then
        table.insert(menu, {
            type = "divider",
        })
    end

    for _, entry in ipairs(BuildArrowSettingsMenuEntries()) do
        table.insert(menu, entry)
    end

    MapPinEnhanced:GenerateMenu(self, menu)
end

function MapPinEnhancedFloatingArrowMixin:OnLoad()
    self.title = self.textContainer.title
    self.distance = self.textContainer.distance
    self.eta = self.textContainer.eta

    local frameLevel = self:GetFrameLevel()
    self.needleContainer:SetFrameLevel(frameLevel)
    self.pin:SetFrameLevel(frameLevel + 1)
    self.textContainer:SetFrameLevel(frameLevel + 2)

    MapPinEnhanced:RegisterDraggableFrame(self, "floatingArrow", nil)
    self:HookScript("OnMouseDown", function(_, mouseButton)
        self:OnMouseDown(mouseButton)
    end)
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
    self.needleContainer:SetScale(MAX_NEEDLE_SCALE)
    self.needleContainer.needle:SetAlpha(MAX_NEEDLE_ALPHA)
    self:SetPinRotation(0)
end

function MapPinEnhancedFloatingArrowMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:Reset()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
end
