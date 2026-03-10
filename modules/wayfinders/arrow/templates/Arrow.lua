---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingArrowTemplate : Frame
---@field needle Texture
---@field pin MapPinEnhancedBasePinTemplate
---@field title FontString
---@field distance FontString
---@field eta FontString
MapPinEnhancedFloatingArrowMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local DEFAULT_COLOR = PIN_COLORS_BY_NAME["Yellow"]

---@param color PinColor
function MapPinEnhancedFloatingArrowMixin:SetColor(color)
    local colorValue = PIN_COLORS_BY_NAME[color] or DEFAULT_COLOR
    self.needle:SetVertexColor(colorValue:GetRGBA())
    self.pin:SetTextureColor(colorValue)
end

function MapPinEnhancedFloatingArrowMixin:SetTexture(texture, usesAtlas)
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

function MapPinEnhancedFloatingArrowMixin:OnUpdate()
    local x, y, mapID = self.targetX, self.targetY, self.targetMapID
    if not mapID or not x or not y then return end

    local worldAngle = MapPinEnhanced:GetWorldVectorForTarget(mapID, x, y)
    if not worldAngle then return end

    local facing = GetPlayerFacing()
    if not facing then return end

    local relativeAngle = worldAngle - facing
    relativeAngle = math.atan2(-math.sin(relativeAngle), math.cos(relativeAngle))

    local needleX = math.sin(relativeAngle) * ORBIT_RADIUS
    local needleY = math.cos(relativeAngle) * ORBIT_RADIUS

    self.needle:ClearAllPoints()
    self.needle:SetPoint("CENTER", self.pin, "CENTER", needleX, needleY)

    self.needle:SetRotation(-relativeAngle)

    if math.abs(relativeAngle) < 0.2 then
        self.needle:SetAlpha(1)
    else
        self.needle:SetAlpha(0.5)
    end
end

function MapPinEnhancedFloatingArrowMixin:OnDistanceUpdate(distance, timeToTarget)
    if distance and timeToTarget then
        self.distance:SetText(MapPinEnhanced:FormatDistance(distance))
        self.eta:SetText(MapPinEnhanced:FormatETA(timeToTarget))
    else
        self.distance:SetText("")
        self.eta:SetText("")
    end
end

---@param mouseButton MouseButton
function MapPinEnhancedFloatingArrowMixin:OnMouseDown(mouseButton)
    if mouseButton ~= "RightButton" then return end
    -- TODO: add a menu here
end

function MapPinEnhancedFloatingArrowMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "floatingArrow", nil)
end

function MapPinEnhancedFloatingArrowMixin:OnShow()
    self:SetScript("OnUpdate", function() self:OnUpdate() end)
    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
end

function MapPinEnhancedFloatingArrowMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
end
