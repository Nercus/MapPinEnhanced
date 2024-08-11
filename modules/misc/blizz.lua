---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Blizz : Module
local Blizz = MapPinEnhanced:GetModule("Blizz")


local CreateUIMapPointFromCoordinates = UiMapPoint.CreateFromCoordinates
local SetUserWaypoint = C_Map.SetUserWaypoint
local CanSetUserWaypointOnMap = C_Map.CanSetUserWaypointOnMap
local TimerAfter = C_Timer.After
local SuperTrackSetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint


function Blizz:HideBlizzardPin()
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self) -- hide default blizzard waypoint
        self:SetAlpha(0)
        self:EnableMouse(false)
    end)
end

function Blizz:OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

local function HandleOnPlayerLogin()
    Blizz:HideBlizzardPin()
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterCheckbox({
        category = "Floating Pin",
        label = "Enable Unlimited Distance",
        default = MapPinEnhanced:GetDefault("Floating Pin", "unlimitedDistance") --[[@as boolean]],
        init = MapPinEnhanced:GetVar("Floating Pin", "unlimitedDistance") --[[@as boolean]],
        onChange = function(value)
            MapPinEnhanced:SaveVar("Floating Pin", "unlimitedDistance", value)
            Blizz:OverrideSuperTrackedAlphaState(value)
        end
    })
end


-- FIXME: save last supertracked type and block setTracked on pin restore

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HandleOnPlayerLogin)

function Blizz:SetBlizzardWaypoint(x, y, mapID)
    if not CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        MapPinEnhanced:Notify("Cannot set waypoint on " .. mapInfo.name, "ERROR")
        return
    end
    local uiMapPoint = CreateUIMapPointFromCoordinates(mapID, x, y, 0)
    SetUserWaypoint(uiMapPoint)
    TimerAfter(0.1, function()
        SuperTrackSetSuperTrackedUserWaypoint(true)
    end)
end

function Blizz:GetPlayerMap()
    return C_Map.GetBestMapForUnit("player")
end

function Blizz:GetPlayerMapPosition()
    return MapPinEnhanced.HBD:GetPlayerZonePosition()
end

local countSinceLastTrackedPin = 0
function Blizz:OnSuperTrackingChanged()
    ---@type boolean
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    if not isSuperTracking then
        if countSinceLastTrackedPin <= 2 then
            local PinManager = MapPinEnhanced:GetModule("PinManager")
            PinManager:TrackLastTrackedPin()
        end
        return
    end
    if not isSuperTrackingUserWaypoint then
        countSinceLastTrackedPin = countSinceLastTrackedPin + 1
        local PinManager = MapPinEnhanced:GetModule("PinManager")
        PinManager:UntrackTrackedPin()
    else
        countSinceLastTrackedPin = 0
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", function()
    Blizz:OnSuperTrackingChanged()
end)

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    Blizz:OnSuperTrackingChanged()
end)
