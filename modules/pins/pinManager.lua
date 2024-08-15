---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
---@class Blizz : Module
local Blizz = MapPinEnhanced:GetModule("Blizz")
local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

---@type table<string, PinObject>
PinManager.Pins = {}

---@type table<string, boolean>
PinManager.Positions = {}

---@type PinObject | nil
PinManager.lastTrackedPin = nil

local MAX_COUNT_PINS = 1000

---Get a string representation of a position from pinData
---@param pinData pinData
---@return string
function PinManager:GetPositionStringForPin(pinData)
    -- the x and y coordinates are normalized so we cut them here to avoid to many pins on the same point
    return string.format("%s:%.4f:%.4f", pinData.mapID, pinData.x, pinData.y)
end

function PinManager:TrackNearestPin()
    local nearestPin = nil
    local playerX, playerY, playerMap = Blizz:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then
        return
    end
    for _, pin in pairs(self.Pins) do
        local pinData = pin:GetPinData()
        local distance = MapPinEnhanced.HBD:GetZoneDistance(playerMap, playerX, playerY, pinData.mapID, pinData.x,
            pinData.y)
        if not nearestPin or distance < nearestPin.distance then
            nearestPin = {
                pin = pin,
                distance = distance
            }
        end
    end
    if nearestPin then
        nearestPin.pin:Track()
    end
end

---@param lastPinOrder number?
function PinManager:TrackNextPin(lastPinOrder)
    if not lastPinOrder then
        lastPinOrder = 0 -- start from the beginning
    end
    for _, pin in pairs(self.Pins) do
        local pinData = pin:GetPinData()
        local order = pinData.order
        if order > lastPinOrder then
            pin:Track()
            return
        end
    end
end

function PinManager:GetMaxPinOrder()
    local maxOrder = 0
    local numPins = 0
    for _, pin in pairs(self.Pins) do
        if pin:GetPinData().order > maxOrder then
            maxOrder = pin:GetPinData().order
        end
        numPins = numPins + 1
    end
    if maxOrder == 0 then
        ---@type number
        maxOrder = numPins
    end
    return maxOrder
end

function PinManager:GetPins()
    return self.Pins
end

---@param a PinObject
---@param b PinObject
---@return boolean
local function SortByOrder(a, b)
    return a:GetPinData().order < b:GetPinData().order
end

---@return PinObject[]
function PinManager:GetPinsByOrder()
    local pins = {}
    for _, pin in pairs(self.Pins) do
        table.insert(pins, pin)
    end
    table.sort(pins, SortByOrder)
    return pins
end

function PinManager:GetPinByID(pinID)
    return self.Pins[pinID]
end

function PinManager:SetLastTrackedPin(pinID)
    self.lastTrackedPin = self.Pins[pinID]
end

function PinManager:TrackPinByID(pinID)
    local pin = self.Pins[pinID]
    if not pin then
        return false
    end
    PinManager:UntrackTrackedPin()
    local pinData = pin.pinData
    Blizz:SetBlizzardWaypoint(pinData.x, pinData.y, pinData.mapID)
    return true
end

function PinManager:TrackLastTrackedPin()
    if not self.lastTrackedPin then
        return
    end
    self.lastTrackedPin:Track()
end

function PinManager:UntrackTrackedPin()
    local trackedPin = self:GetTrackedPin()
    if not trackedPin then
        return
    end
    trackedPin:Untrack()
end

function PinManager:ClearPins()
    for _, pin in pairs(self.Pins) do
        pin:Remove()
    end
    self.Pins = {}
    self.Positions = {}
    self:PersistPins()
end

function PinManager:RemovePinByID(pinID)
    local pin = self.Pins[pinID]
    if not pin then
        return
    end
    pin:Remove()
    local pinData = self.Pins[pinID]:GetPinData()
    local lastPinOrder = pinData.order
    local pinPositionString = self:GetPositionStringForPin(pinData)
    self.Positions[pinPositionString] = nil
    self.Pins[pinID] = nil

    self:PersistPins()
    local optionTrackNearestPin = MapPinEnhanced:GetVar("general", "autoTrackNearestPin")
    if optionTrackNearestPin then
        self:TrackNearestPin()
    else
        self:TrackNextPin(lastPinOrder)
    end
end

function PinManager:GetTrackedPin()
    for _, pin in pairs(self.Pins) do
        if pin:IsTracked() then
            return pin
        end
    end
    return nil
end

function PinManager:PersistPins()
    ---@type pinData[]
    local reducedPins = {}
    local trackedPin = self:GetTrackedPin()
    if not trackedPin then
        ---@type table<string, nil>
        trackedPin = {}
        trackedPin.pinID = nil
    end
    for _, pin in pairs(self.Pins) do
        local p = pin:GetPinData()
        p.setTracked = pin.pinID == trackedPin.pinID
        table.insert(reducedPins, p)
    end
    MapPinEnhanced:SaveVar("storedPins", reducedPins)
end

function PinManager:RestorePins()
    self.wasSuperTrackingOther = MapPinEnhanced:GetVar("SuperTrackingOther") --[[@as boolean]]
    local storedPins = MapPinEnhanced:GetVar("storedPins") --[[@as table<string, pinData> | nil]]
    if storedPins then
        for _, pinData in pairs(storedPins) do
            self:AddPin(pinData, true)
        end
    end
end

---add a pin
---@param pinData pinData
---@param restored boolean?
function PinManager:AddPin(pinData, restored)
    assert(pinData, "Pin data is required to create a pin.")
    assert(type(pinData) == "table", "Pin data must be a table.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")
    assert(
        (pinData.color and CONSTANTS.PIN_COLORS_BY_NAME[pinData.color] or pinData.color == 'Custom') or
        not pinData.color,
        "Pin data must contain a valid color.")

    if (pinData.x > 1) then
        pinData.x = pinData.x / 100
    end
    if (pinData.y > 1) then
        pinData.y = pinData.y / 100
    end

    if #PinManager.Pins >= MAX_COUNT_PINS then
        -- too many pins
        MapPinEnhanced:Notify("Too many pins. Please remove some pins before adding more.", "ERROR")
        return
    end


    local pinPositionString = self:GetPositionStringForPin(pinData)
    if PinManager.Positions[pinPositionString] then
        return
    end

    -- set defaults
    if (pinData.texture == nil and pinData.color == nil) then
        pinData.color = CONSTANTS.DEFAULT_PIN_COLOR
    end

    if (pinData.title == nil) then
        pinData.title = L[CONSTANTS.DEFAULT_PIN_NAME]
    end

    if pinData.texture then
        pinData.color = "Custom"
    end

    local pinID = MapPinEnhanced:GenerateUUID("pin")
    pinData.order = self:GetMaxPinOrder() + (pinData.order or 1) -- default order is 1
    local pinObject = PinFactory:CreatePin(pinData, pinID)
    PinManager.Pins[pinID] = pinObject
    PinManager.Positions[pinPositionString] = true


    if pinData.setTracked and not self.wasSuperTrackingOther then
        pinObject:Track()
    else
        pinObject:Untrack()
    end

    if not restored then
        self:PersistPins()
    end
    if MapPinEnhanced.pinTracker then
        if MapPinEnhanced.pinTracker:GetActiveView() == "Pins" then
            MapPinEnhanced.pinTracker:AddEntry(pinObject.trackerPinEntry)
        end
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function(isLogin, isReload)
    if isLogin then
        PinManager:RestorePins()
    end
    if isReload then
        local Options = MapPinEnhanced:GetModule("Options")
        Options:RegisterCheckbox({
            category = L["General"],
            label = L["Auto Track Nearest Pin"],
            description = "Automatically track the nearest pin when a tracked pin is removed.",
            default = MapPinEnhanced:GetDefault("general", "autoTrackNearestPin") --[[@as boolean]],
            init = MapPinEnhanced:GetVar("general", "autoTrackNearestPin") --[[@as boolean]],
            onChange = function(value)
                MapPinEnhanced:SaveVar("general", "autoTrackNearestPin", value)
            end
        })
    end
end)
