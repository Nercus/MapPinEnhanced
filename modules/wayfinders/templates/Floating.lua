---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

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

---Method to block the automatic removal of pins in the game
local function OverrideSuperTrackedReachedBehavior()
    ---@type function | nil
    local unregisterNavigationReachedEvent

    unregisterNavigationReachedEvent = function()
        if SuperTrackedFrame then
            SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
        end
        MapPinEnhanced:UnregisterEventForFunction("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end

    if SuperTrackedFrame then
        SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
    else
        MapPinEnhanced:RegisterEvent("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end
end


---Hide default world map Pin
local function HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end

---Method to override the alpha state of the super tracked frame -> create unlimited distance
---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

local function SetSuperTrackedAlphaState()
    local unlimitedDistance = MapPinEnhanced:GetVar("floatingPin", "unlimitedDistance")
    OverrideSuperTrackedAlphaState(unlimitedDistance)
end

function MapPinEnhancedWayfinderFloating:SetOverride()
    if self.overridesSet then return end
    OverrideSuperTrackedReachedBehavior()
    HideBlizzardPin()
    SetSuperTrackedAlphaState()
    self.overridesSet = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
    self:SetOverride()
end

function MapPinEnhancedWayfinderFloating:Disable()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
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
