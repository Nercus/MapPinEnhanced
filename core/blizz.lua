---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Blizz : Module
local Blizz = MapPinEnhanced:GetModule("Blizz")

---@diagnostic disable-next-line: no-unknown
local CreateUIMapPointFromCoordinates = UiMapPoint.CreateFromCoordinates
local SetUserWaypoint = C_Map.SetUserWaypoint
local CanSetUserWaypointOnMap = C_Map.CanSetUserWaypointOnMap
local TimerAfter = C_Timer.After
local SuperTrackSetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint


function Blizz:HideBlizzardPin()
    ---@diagnostic disable-next-line: no-unknown, redefined-local
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self) -- hide default blizzard waypoint
        self:SetAlpha(0)
        self:EnableMouse(false)
    end)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizz.HideBlizzardPin)

function Blizz:OverrideSuperTrackedAlphaState()
    ---@diagnostic disable-next-line: no-unknown
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
    ---@diagnostic disable-next-line: no-unknown
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
end

function Blizz:SetBlizzardWaypoint(x, y, mapID)
    if not CanSetUserWaypointOnMap(mapID) then
        --TODO: show proper error message to the user
        error("Cannot set waypoint on map " .. mapID)
        return
    end
    ---@diagnostic disable-next-line: no-unknown
    local uiMapPoint = CreateUIMapPointFromCoordinates(mapID, x, y, 0)
    SetUserWaypoint(uiMapPoint)
    TimerAfter(0.1, function()
        SuperTrackSetSuperTrackedUserWaypoint(true)
    end)
end
