---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Blizz
local Blizz = MapPinEnhanced:GetModule("Blizz")

---------------------------------------------------------------------------

---Wrapper for the current map the player is on
---@return number? mapID
function Blizz:GetPlayerMap()
    return C_Map.GetBestMapForUnit("player")
end

---Wrapper for the current map position of the player
---@return number x, number y, number currentPlayerUIMapID, Enum.UIMapType currentPlayerUIMapType
function Blizz:GetPlayerMapPosition()
    return MapPinEnhanced.HBD:GetPlayerZonePosition()
end

---Method to create the blizzard waypoint at a specific position
---@param x number
---@param y number
---@param mapID number
function Blizz:SetBlizzardWaypoint(x, y, mapID)
    if not C_Map.CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        MapPinEnhanced:Notify("Cannot set waypoint on " .. mapInfo.name, "ERROR")
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

---Method to override the alpha state of the super tracked frame -> create unlimited distance
---@param enable boolean
function Blizz:OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

---Method to block the automatic removal of pins in the game
function Blizz:OverrideSuperTrackedReachedBehavior()
    local superTrackMapPinTypesThatClearWhenDestinationReached = {
        [Enum.SuperTrackingMapPinType.AreaPOI] = true,
        [Enum.SuperTrackingMapPinType.TaxiNode] = true,
        [Enum.SuperTrackingMapPinType.DigSite] = true,
    };
    SuperTrackedFrame.ShouldClearSuperTrackWhenDestinationReached = function(self, isWaypoint)
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

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizz.OverrideSuperTrackedReachedBehavior)

---Method to insert a waypoint link to the chat
---@param x number
---@param y number
---@param mapID number
function Blizz:InsertWaypointLinkToChat(x, y, mapID)
    assert(x and y and mapID, "Invalid arguments")
    local waypointLink = ("|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(mapID, x * 10000, y * 10000,
        MAP_PIN_HYPERLINK)
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(waypointLink)
end

---------------------------------------------------------------------------

---Hide default world map Pin
function Blizz:HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end

Blizz:HideBlizzardPin()
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizz.HideBlizzardPin)



---Method to handle the super tracking change event and track the last tracked pin
function Blizz:OnSuperTrackingChanged()
    ---@type boolean
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    MapPinEnhanced:SaveVar("superTrackingOther", isSuperTracking and not isSuperTrackingUserWaypoint)
    if isSuperTrackingCorpse then return end -- corpse tracking runs simultaneously with other supertracking types

    local PinManager = MapPinEnhanced:GetModule("PinManager")
    if isSuperTracking and not isSuperTrackingUserWaypoint then
        PinManager:UntrackTrackedPin()
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", function()
    Blizz:OnSuperTrackingChanged()
end)
MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    Blizz:OnSuperTrackingChanged()
end)
