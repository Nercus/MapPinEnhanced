---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedArrowNeedle : Texture
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedArrowNeedleContainer : Frame
---@field needle MapPinEnhancedArrowNeedle

---@class MapPinEnhancedArrowTextContainer : Frame
---@field title FontString
---@field readout MapPinEnhancedWayfinderReadoutTemplate

---@class MapPinEnhancedWayfinderArrowTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin
---@field needleContainer MapPinEnhancedArrowNeedleContainer
---@field textContainer MapPinEnhancedArrowTextContainer
---@field pin MapPinEnhancedBasePinTemplate
---@field title FontString
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin
---@field needleRotation number | nil
---@field newNeedleRotation number | nil
---@field rotatePin boolean | nil
---@field displayType 'close' | 'far' | nil
MapPinEnhancedWayfinderArrowMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin, MapPinEnhancedWayfinderDirectionMixin)

local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")
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
function MapPinEnhancedWayfinderArrowMixin:SetColor(color)
    self.pin:SetColor(color)
    self.needleContainer.needle:SetVertexColor(self.pin:GetActiveStyleColor():GetRGBA())
end

function MapPinEnhancedWayfinderArrowMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.needleContainer.needle:SetVertexColor(self.pin:GetActiveStyleColor():GetRGBA())
end

function MapPinEnhancedWayfinderArrowMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedWayfinderArrowMixin:SetLocation(mapID, x, y)
    self:ResetDistanceReadout()
    self:SetTargetLocation(mapID, x, y)
end

---@param displayType 'close' | 'far'
function MapPinEnhancedWayfinderArrowMixin:SetDisplayType(displayType)
    if self.displayType == displayType then return end
    self.displayType = displayType
    if displayType == "close" then
        self.needleContainer.needle.fadeOut:PlayHiding(self.needleContainer.needle.fadeIn)
        self.pin:ShowPulse()
    else
        self.needleContainer.needle.fadeIn:PlayShowing(self.needleContainer.needle.fadeOut)
        self.pin:HidePulse()
    end
end

function MapPinEnhancedWayfinderArrowMixin:UpdateNeedlePosition(elapsed)
    local angle = self:SampleTargetAngle(elapsed)
    if angle == nil then return end
    self.newNeedleRotation = angle
    self:UpdateNeedleAlpha()
end

---@param rotation number
function MapPinEnhancedWayfinderArrowMixin:SetPinRotation(rotation)
    self.pin.background:SetRotation(rotation)
    self.pin.outline:SetRotation(rotation)
    self.pin.foreground:SetRotation(rotation)
    self.pin.icon:SetRotation(rotation)
    self.pin.iconMask:SetRotation(rotation)
    self.pin.lock:SetRotation(rotation)
end

---@param rotatePin boolean
function MapPinEnhancedWayfinderArrowMixin:SetRotatePin(rotatePin)
    self.rotatePin = rotatePin
    if not rotatePin then
        self:SetPinRotation(0)
    end
end

---@param rotation number
function MapPinEnhancedWayfinderArrowMixin:UpdateNeedleScale(rotation)
    local scaleRange = MAX_NEEDLE_SCALE - MIN_NEEDLE_SCALE
    local scale = MAX_NEEDLE_SCALE - (scaleRange * GetNeedleRotationProgress(rotation))
    self.needleContainer:SetScale(scale)
end

---@param rotation number | nil
function MapPinEnhancedWayfinderArrowMixin:UpdateNeedleAlpha(rotation)
    if not self.displayType or self.displayType == "close" then return end

    local rotationProgress = GetNeedleRotationProgress(rotation or self.newNeedleRotation or 0)
    local alphaRange = MAX_NEEDLE_ALPHA - MIN_NEEDLE_ALPHA
    local alpha = MAX_NEEDLE_ALPHA - (alphaRange * rotationProgress)
    self.needleContainer.needle:SetAlpha(alpha)
end

function MapPinEnhancedWayfinderArrowMixin:AnimateRotation(elapsed)
    if not self.displayType or self.displayType == "close" then return end
    local currentRotation = self.needleRotation or 0
    local targetRotation = self.newNeedleRotation or 0

    local angleDifference = mathAtan2(
        mathSin(targetRotation - currentRotation),
        mathCos(targetRotation - currentRotation)
    )
    local newRotation = DeltaLerp(currentRotation, currentRotation + angleDifference, .2, elapsed)
    self.needleRotation = newRotation

    self.needleContainer.needle:SetRotation(-newRotation)
    self:UpdateNeedleScale(newRotation)
    self:UpdateNeedleAlpha(newRotation)
    if self.rotatePin then
        self:SetPinRotation(-newRotation)
    end
end

---@param elapsed number
function MapPinEnhancedWayfinderArrowMixin:OnUpdate(elapsed)
    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateRotation(elapsed)
end

function MapPinEnhancedWayfinderArrowMixin:OnDistanceUpdate(distance, timeToTarget)
    self.distanceValue = distance
    if distance and distance < 10 then
        self:SetDisplayType("close")
    else
        self:SetDisplayType("far")
    end
end

---@param mouseButton MouseButton
function MapPinEnhancedWayfinderArrowMixin:OnMouseDown(mouseButton)
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

function MapPinEnhancedWayfinderArrowMixin:OnLoad()
    self.title = self.textContainer.title
    self.readout = self.textContainer.readout

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

function MapPinEnhancedWayfinderArrowMixin:OnShow()
    self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
    self:StartDistanceUpdates(self.readout, function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end)
    self:UpdateNeedlePosition()
    self:UpdateNeedleAlpha()
    self:SetDisplayType("far")
end

function MapPinEnhancedWayfinderArrowMixin:Reset()
    self.displayType = "far"
    self.needleContainer.needle.fadeIn:SetParentShownInstantly(true, self.needleContainer.needle.fadeOut)
    self.pin:HidePulse()
    self:ResetDirectionSampling()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self.needleContainer:SetScale(MAX_NEEDLE_SCALE)
    self.needleContainer.needle:SetAlpha(MAX_NEEDLE_ALPHA)
    self:SetPinRotation(0)
end

function MapPinEnhancedWayfinderArrowMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:StopDistanceUpdates()
    self:Reset()
end
