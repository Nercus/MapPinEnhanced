---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@param pinData pinData
---@return WayfinderData
function Providers:GetAddonPinWayfinderData(pinData)
    return {
        mapID = pinData.mapID,
        x = pinData.x,
        y = pinData.y,
        title = pinData.title,
        description = pinData.description,
        texture = pinData.texture,
        usesAtlas = pinData.usesAtlas,
        color = pinData.color,
        lock = pinData.lock,
        targetType = Wayfinders.TARGET_TYPE_PIN,
    }
end
