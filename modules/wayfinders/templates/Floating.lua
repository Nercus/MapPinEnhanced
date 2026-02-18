---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Map = MapPinEnhanced:GetModule("Map")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData | nil
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
end

local function onUserwaypointUpdated()
    local hasUserWaypoint = C_Map.HasUserWaypoint()
    if not hasUserWaypoint then return end
    C_Timer.After(0, function()
        if C_Map.HasUserWaypoint() == true then
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        end
    end)
end

function MapPinEnhancedWayfinderFloating:Reset()
    self.data = nil
    C_Map.ClearUserWaypoint()
end

function MapPinEnhancedWayfinderFloating:OnDistanceUpdate(distance, timeToTarget)
    MapPinEnhanced:Debug("Wayfinder distance update: " .. distance .. " yards, ETA: " .. timeToTarget .. " seconds")
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end
    self.data = wayfinderData
    if wayfinderData then
        local x, y, mapID = wayfinderData.x, wayfinderData.y, wayfinderData.mapID
        self:SetUserWaypoint(x, y, mapID)
    else
        C_Map.ClearUserWaypoint()
    end
end

function MapPinEnhancedWayfinderFloating:Enable()
    Map:RegisterContinuousDistanceCallback(self.OnDistanceUpdate)
end

function MapPinEnhancedWayfinderFloating:Disable()
    Map:UnregisterContinuousDistanceCallback(self.OnDistanceUpdate)
    self:Reset()
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating

MapPinEnhanced:OnLoad(function()
    Wayfinders:EnableWayfinder("WAYFINDER_FLOATING")
end)

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", onUserwaypointUpdated)
