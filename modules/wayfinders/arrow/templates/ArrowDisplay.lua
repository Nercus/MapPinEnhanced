---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedArrowNeedle : Texture
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedArrowNeedleContainer : Frame
---@field needle MapPinEnhancedArrowNeedle

---@class MapPinEnhancedArrowTextContainer : Frame
---@field description MapPinEnhancedWayfinderDescriptionTemplate
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
---@field directionVisible boolean?
---@field step WayfinderStepData?
---@field clearButton Button
---@field displayType 'close' | 'far' | nil
MapPinEnhancedWayfinderArrowMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin,
    MapPinEnhancedWayfinderDirectionMixin)

local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local MIN_NEEDLE_ALPHA = 0.5
local MAX_NEEDLE_ALPHA = 1

local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local mathAbs = math.abs
local mathPi = math.pi
local DeltaLerp = DeltaLerp

---@return AnyMenuEntry[]
local function BuildArrowSettingsMenuEntries()
    return {
        {
            type = "title",
            label = MapPinEnhanced.L["Wayfinder.Arrow_GROUPLABEL"],
        },
    }
end

---@return AnyMenuEntry[]
local function BuildNavigationMenuEntries()
    return Wayfinders:BuildNavigationMenuEntries()
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
end

local FRAME_COUNT = 120
local COLUMNS = 16
local ROWS = 8
local FULL_ROTATION = 2 * math.pi

---@param rotation number Counterclockwise radians, matching Texture:SetRotation.
function MapPinEnhancedWayfinderArrowMixin:SetNeedleRotation(rotation)
    -- The sheet advances clockwise in 3-degree steps; its final eight cells are empty.
    local frame = math.floor((-rotation % FULL_ROTATION) / FULL_ROTATION * FRAME_COUNT + 0.5) % FRAME_COUNT
    local column = frame % COLUMNS
    local row = math.floor(frame / COLUMNS)
    self.needleContainer.needle:SetTexCoord(column / COLUMNS, (column + 1) / COLUMNS, row / ROWS, (row + 1) / ROWS)
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

    self:SetNeedleRotation(-newRotation)
end

---@param elapsed number
function MapPinEnhancedWayfinderArrowMixin:OnUpdate(elapsed)
    if self.directionVisible == false then return end
    self:UpdateNeedlePosition(elapsed)
    if self.displayType == "close" then return end
    self:AnimateRotation(elapsed)
end

function MapPinEnhancedWayfinderArrowMixin:OnDistanceUpdate(distance, timeToTarget)
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

    -- NOTE: no arrow wayfinder specific settings to put on the menu right now
    -- for _, entry in ipairs(BuildArrowSettingsMenuEntries()) do
    --     table.insert(menu, entry)
    -- end
    for _, entry in ipairs(BuildNavigationMenuEntries()) do
        table.insert(menu, entry)
    end

    MapPinEnhanced:GenerateMenu(self, menu)
end

function MapPinEnhancedWayfinderArrowMixin:OnLoad()
    self.textContainer.description.mouseOwner = self
    self.title = self.textContainer.title
    self.title:SetNonSpaceWrap(true)
    self.readout = self.textContainer.readout
    self.readout.text:SetNonSpaceWrap(false)

    local frameLevel = self:GetFrameLevel()
    self.needleContainer:SetFrameLevel(frameLevel + 1)
    self.pin:SetFrameLevel(frameLevel + 1)
    self.textContainer:SetFrameLevel(frameLevel)

    local position = self:GetParent()
    assert(position, "Arrow:OnLoad requires its position owner")
    MapPinEnhanced:RegisterDraggableFrame(position, "floatingArrow", self, InCombatLockdown)
    MapPinEnhanced:RestoreFrame(position)
    MapPinEnhanced:UnregisterDraggableFrame(position)
    -- The secure position owner stays shown; only the visible display accepts dragging.
    self:HookScript("OnMouseDown", function(_, mouseButton)
        self:OnMouseDown(mouseButton)
    end)
    self.pin:SetTracked(true)
end

---@param visible boolean
function MapPinEnhancedWayfinderArrowMixin:SetDirectionVisible(visible)
    if self.directionVisible == visible then return end
    self.directionVisible = visible
    if not visible then self:Reset() end
end

function MapPinEnhancedWayfinderArrowMixin:OnShow()
    MapPinEnhanced:RegisterDraggableFrame(self:GetParent(), "floatingArrow", self, InCombatLockdown)
    self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
    self:StartDistanceUpdates(self.readout, function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end)
    self:UpdateNeedlePosition()
    self:SetDisplayType("far")
end

function MapPinEnhancedWayfinderArrowMixin:Reset()
    self.displayType = "far"
    self.needleContainer.needle.fadeIn:SetParentShownInstantly(true, self.needleContainer.needle.fadeOut)
    self.pin:HidePulse()
    self:ResetDirectionSampling()
    self.needleRotation = nil
    self.newNeedleRotation = nil
    self:SetNeedleRotation(0)
    self.needleContainer.needle:SetAlpha(MAX_NEEDLE_ALPHA)
end

function MapPinEnhancedWayfinderArrowMixin:OnHide()
    MapPinEnhanced:UnregisterDraggableFrame(self:GetParent())
    self:SetScript("OnUpdate", nil)
    self:StopDistanceUpdates()
    self:Reset()
end

function MapPinEnhancedWayfinderArrowMixin:ClearTracking()
    if self.step then
        MapPinEnhanced:GetModule("Providers"):ClearNavigationTracking(self.step.changeNumber)
    end
end
