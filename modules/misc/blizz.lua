---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Blizzard
local Blizzard = MapPinEnhanced:GetModule("Blizzard")

---Wrapper for the current map the player is on
---@return number? mapID
function Blizzard:GetPlayerMap()
    return C_Map.GetBestMapForUnit("player")
end

---Wrapper for the current map position of the player
---@return number x, number y, number currentPlayerUIMapID, Enum.UIMapType currentPlayerUIMapType
function Blizzard:GetPlayerMapPosition()
    return MapPinEnhanced.HBD:GetPlayerZonePosition()
end

---Method to override the alpha state of the super tracked frame -> create unlimited distance
---@param enable boolean
function Blizzard:OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

---Method to block the automatic removal of pins in the game
function Blizzard:OverrideSuperTrackedReachedBehavior()
    local superTrackMapPinTypesThatClearWhenDestinationReached = {
        [Enum.SuperTrackingMapPinType.AreaPOI] = true,
        [Enum.SuperTrackingMapPinType.TaxiNode] = true,
        [Enum.SuperTrackingMapPinType.DigSite] = true,
    };
    SuperTrackedFrame.ShouldClearSuperTrackWhenDestinationReached = function()
        local superTrackType = C_SuperTrack.GetHighestPrioritySuperTrackingType();
        if Enum.SuperTrackingType.Vignette == superTrackType then return true end
        if Enum.SuperTrackingType.MapPin == superTrackType then
            local pinType = C_SuperTrack.GetSuperTrackedMapPin();
            if pinType then
                return superTrackMapPinTypesThatClearWhenDestinationReached[pinType];
            end
            return false;
        end
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizzard.OverrideSuperTrackedReachedBehavior)

---------------------------------------------------------------------------

---Hide default world map Pin
function Blizzard:HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end

Blizzard:HideBlizzardPin()
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizzard.HideBlizzardPin)



---Method to handle the super tracking change event and track the last tracked pin
function Blizzard:OnSuperTrackingChanged()
    ---@type boolean
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    MapPinEnhanced:SetVar("superTrackingOther", isSuperTracking and not isSuperTrackingUserWaypoint)
    if isSuperTrackingCorpse then return end -- corpse tracking runs simultaneously with other supertracking types

    local Tracking = MapPinEnhanced:GetModule("Tracking")
    if isSuperTracking and not isSuperTrackingUserWaypoint then
        Tracking:UntrackTrackedPin()
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", function()
    Blizzard:OnSuperTrackingChanged()
end)
MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    Blizzard:OnSuperTrackingChanged()
end)
