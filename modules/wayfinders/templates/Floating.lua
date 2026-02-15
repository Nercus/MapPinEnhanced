---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field pin MapPinEnhancedPinMixin | nil the currently tracked pin, used to update the wayfinder when the tracked pin changes
local MapPinEnhancedWayfinderFloating = {}

---@param x number
---@param y number
---@param mapID number
function MapPinEnhancedWayfinderFloating:SetUserWaypoint(x, y, mapID)
    if not C_Map.CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        MapPinEnhanced:Print("Cannot set waypoint on " .. mapInfo.name)
        return
    end

    local hasUserWaypoint = C_Map.HasUserWaypoint()
    if hasUserWaypoint then
        C_Map.ClearUserWaypoint()
    end

    if x < 0 then
        x = 0
    end
    if y < 0 then
        y = 0
    end

    local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    C_Map.SetUserWaypoint(uiMapPoint)
    C_SuperTrack.ClearAllSuperTracked()
    C_Timer.After(0.1, function()
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    end)
end

function MapPinEnhancedWayfinderFloating:Reset()
    self.pin = nil
    C_Map.ClearUserWaypoint()
end

---@param pin MapPinEnhancedPinMixin | nil
function MapPinEnhancedWayfinderFloating:Init(pin)
    if not pin then
        self:Reset()
        return
    end
    self.pin = pin
    if pin then
        local x, y, mapID = pin.pinData.x, pin.pinData.y, pin.pinData.mapID
        self:SetUserWaypoint(x, y, mapID)
    else
        C_Map.ClearUserWaypoint()
    end
end

function MapPinEnhancedWayfinderFloating:Enable()
end

function MapPinEnhancedWayfinderFloating:Disable()
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating


MapPinEnhanced:OnLoad(function()
    Wayfinders:EnableWayfinder("WAYFINDER_FLOATING")
end)
