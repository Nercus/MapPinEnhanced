---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupTrackingMixin = {}

---@alias GroupTrackingMode "nearest"|"ordered"
Groups.TRACKING_MODE_NEAREST = Options.TRACKING_MODE_NEAREST
Groups.TRACKING_MODE_ORDERED = Options.TRACKING_MODE_ORDERED
Groups.TRACKING_MODE_OPTIONS = Options.TRACKING_MODE_OPTIONS

---@type table<GroupTrackingMode, boolean>
local TRACKING_MODES = {
    [Groups.TRACKING_MODE_NEAREST] = true,
    [Groups.TRACKING_MODE_ORDERED] = true,
}

local DEFAULT_TRACKING_MODE_OPTION = "General.Tracking.DefaultMode"

---@param mode any
---@return boolean
function Groups:IsValidTrackingMode(mode)
    return TRACKING_MODES[mode] == true
end

---@return GroupTrackingMode
function Groups:GetDefaultTrackingMode()
    local mode = Options:GetOptionInitValue(DEFAULT_TRACKING_MODE_OPTION)
    if self:IsValidTrackingMode(mode) then
        return mode --[[@as GroupTrackingMode]]
    end
    return self.TRACKING_MODE_NEAREST
end

---@param mode any
---@return GroupTrackingMode
function Groups:GetTrackingModeOrDefault(mode)
    if self:IsValidTrackingMode(mode) then
        return mode --[[@as GroupTrackingMode]]
    end
    return self:GetDefaultTrackingMode()
end

---@param group MapPinEnhancedGroupMixin
---@param comparedPin MapPinEnhancedPinMixin
---@param bestPin MapPinEnhancedPinMixin?
---@return boolean
local function IsBetterFallbackPin(group, comparedPin, bestPin)
    if not bestPin then return true end

    local comparedOrder = group:GetPinOrder(comparedPin.pinID)
    local bestOrder = group:GetPinOrder(bestPin.pinID)
    return comparedOrder > bestOrder
end

---@param group MapPinEnhancedGroupMixin
---@param pin MapPinEnhancedPinMixin
---@param distance number?
---@param nearestPin MapPinEnhancedPinMixin?
---@param nearestDistance number?
---@return boolean
local function IsCloserPin(group, pin, distance, nearestPin, nearestDistance)
    if not distance then return false end
    if not nearestDistance then return true end
    if distance ~= nearestDistance then
        return distance < nearestDistance
    end
    return IsBetterFallbackPin(group, pin, nearestPin)
end

---@return GroupTrackingMode
function MapPinEnhancedGroupTrackingMixin:GetTrackingMode()
    if self:IsProtected() then
        return Groups.TRACKING_MODE_NEAREST
    end
    return Groups:GetTrackingModeOrDefault(self.trackingMode)
end

---@param mode GroupTrackingMode
---@return boolean
function MapPinEnhancedGroupTrackingMixin:SetTrackingMode(mode)
    assert(Groups:IsValidTrackingMode(mode), "MapPinEnhancedGroupMixin:SetTrackingMode: invalid tracking mode")
    if self:IsProtected() then return false end

    if self.trackingMode == mode then return true end

    self.trackingMode = mode
    if mode == Groups.TRACKING_MODE_ORDERED then
        local trackedPin = Pins:GetTrackedPin()
        if trackedPin and trackedPin.group == self then
            self:SetTrackingCursorPin(trackedPin)
        else
            self.trackingCursorOrder = nil
        end
    else
        self.trackingCursorOrder = nil
    end

    Groups:PersistGroup(self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param pin MapPinEnhancedPinMixin?
function MapPinEnhancedGroupTrackingMixin:SetTrackingCursorPin(pin)
    if self:GetTrackingMode() ~= Groups.TRACKING_MODE_ORDERED then
        self.trackingCursorOrder = nil
        return
    end

    if not pin or pin.group ~= self then
        self.trackingCursorOrder = nil
        return
    end

    self.trackingCursorOrder = self:GetPinOrder(pin.pinID)
end

---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupTrackingMixin:GetNearestTrackablePin()
    ---@type MapPinEnhancedPinMixin?
    local nearestPin
    ---@type number?
    local nearestDistance
    ---@type MapPinEnhancedPinMixin?
    local fallbackPin
    local playerX, playerY, playerMap = MapPinEnhanced:GetPlayerMapPosition()

    for _, pin in self:EnumeratePins() do
        if not pin:IsTracked() then
            local pinData = pin:GetPinData()
            ---@type number?
            local distance
            if pinData and playerMap and playerX and playerY then
                distance = MapPinEnhanced:GetDistanceBetweenPoints(playerMap, playerX, playerY, pinData.mapID, pinData.x,
                    pinData.y)
                if distance <= 0 then
                    distance = nil
                end
            end
            if IsCloserPin(self, pin, distance, nearestPin, nearestDistance) then
                nearestPin = pin
                nearestDistance = distance
            elseif not distance and IsBetterFallbackPin(self, pin, fallbackPin) then
                fallbackPin = pin
            end
        end
    end

    if nearestPin then
        return nearestPin
    end
    return fallbackPin
end

---@param cursorOrder number?
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupTrackingMixin:GetOrderedTrackablePin(cursorOrder)
    ---@type MapPinEnhancedPinMixin?
    local bestBelowCursor
    ---@type MapPinEnhancedPinMixin?
    local bestOverall
    cursorOrder = cursorOrder or self.trackingCursorOrder

    for _, pin in self:EnumeratePins() do
        if not pin:IsTracked() then
            local order = self:GetPinOrder(pin.pinID)
            if IsBetterFallbackPin(self, pin, bestOverall) then
                bestOverall = pin
            end
            if cursorOrder and order < cursorOrder and IsBetterFallbackPin(self, pin, bestBelowCursor) then
                bestBelowCursor = pin
            end
        end
    end

    local pin = bestBelowCursor or bestOverall
    return pin
end

---@param cursorOrder number?
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupTrackingMixin:GetNextTrackablePin(cursorOrder)
    if self:IsHidden() then return nil end

    if self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED then
        return self:GetOrderedTrackablePin(cursorOrder)
    end

    return self:GetNearestTrackablePin()
end

---@param cursorOrder number?
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupTrackingMixin:TrackNextTrackablePin(cursorOrder)
    local pin = self:GetNextTrackablePin(cursorOrder)
    if pin then
        pin:Track()
    end
    return pin
end
