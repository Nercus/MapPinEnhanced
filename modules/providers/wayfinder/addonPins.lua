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


local oldPinId = nil
local function SetupPinCallbacks(pinId)
    if oldPinId and oldPinId ~= pinId then
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TRACKING", oldPinId)
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TITLE", oldPinId)
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_COLOR", oldPinId)
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_ICON", oldPinId)
    end

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_TITLE", function(_, title)
        Wayfinders:OverrideWayfinderTitle(title)
    end, pinId)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_COLOR", function(_, color)
        Wayfinders:OverrideWayfinderColor(color)
    end, pinId)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_ICON", function(_, texture, usesAtlas)
        Wayfinders:OverrideWayfinderTexture(texture, usesAtlas)
    end, pinId)
end

---@param eventName "PIN_TRACKING_CHANGED"
---@param pinID UUID
---@param isTracked boolean
local function onPinTrackingChanged(eventName, pinID, isTracked)
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin.pinID == pinID and isTracked then
        local wayfinderData = TransformPinDataToWayfinderData(trackedPin:GetPinData())
        Wayfinders:SetWayfinderData(wayfinderData)
        SetupPinCallbacks(pinID)
        oldPinId = pinID
    else
        Wayfinders:ClearWayfinderData()
    end
end

MapPinEnhanced:OnLoad(function()
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", onPinTrackingChanged)
    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end
    onPinTrackingChanged("PIN_TRACKING_CHANGED", trackedPin.pinID, trackedPin:IsTracked())
end)
