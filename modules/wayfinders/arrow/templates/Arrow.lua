---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingArrowTemplate : Frame
---@field needle Texture
---@field pin MapPinEnhancedBasePinTemplate
MapPinEnhancedFloatingArrowMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME

function MapPinEnhancedFloatingArrowMixin:OnLoad()
    C_Timer.After(5, function()
        local Pins = MapPinEnhanced:GetModule("Pins")
        local trackedPin = Pins:GetTrackedPin()
        local pinData = trackedPin and trackedPin:GetPinData()
        if not pinData then return end
        local x, y, mapID = pinData.x, pinData.y, pinData.mapID
        if not x or not y or not mapID then return end
        self:SetLocation(mapID, x, y)
        local color = pinData.color
        local colorValue = PIN_COLORS_BY_NAME[color] or PIN_COLORS_BY_NAME["Yellow"]
        self.needle:SetVertexColor(colorValue:GetRGBA())
        self.pin:SetColor(color)
    end)
end

local ORBIT_RADIUS = 40

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

function MapPinEnhancedFloatingArrowMixin:OnShow()
    self:SetScript("OnUpdate", function() self:OnUpdate() end)
end

function MapPinEnhancedFloatingArrowMixin:OnHide()
    self:SetScript("OnUpdate", nil)
end
