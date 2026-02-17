---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Pins = MapPinEnhanced:GetModule("Pins")

---@param pinData pinData
---@return WayfinderData
local function TransformPinDataToWayfinderData(pinData)
    return {
        mapID = pinData.mapID,
        x = pinData.x,
        y = pinData.y,
        title = pinData.title,
        texture = pinData.texture,
        usesAtlas = pinData.usesAtlas,
        color = pinData.color,
    }
end

---@param eventName "PIN_TRACKING_CHANGED"
---@param pinID UUID
---@param isTracked boolean
local function onPinTrackingChanged(eventName, pinID, isTracked)
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin.pinID == pinID and isTracked then
        local wayfinderData = TransformPinDataToWayfinderData(trackedPin:GetPinData())
        Wayfinders:SetWayfinderData(wayfinderData)
    else
        Wayfinders:ClearWayfinderData()
    end
end

MapPinEnhanced:OnLoad(function()
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", onPinTrackingChanged)
end)
