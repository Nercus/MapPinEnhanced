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
        C_SuperTrack.ClearAllSuperTracked()
        C_Map.ClearUserWaypoint()
    end

    local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    C_Map.SetUserWaypoint(uiMapPoint)
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
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", Blizz.HideBlizzardPin)





---Method to handle the super tracking change event and track the last tracked pin
function Blizz:OnSuperTrackingChanged()
    ---@type boolean
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    MapPinEnhanced:SaveVar("SuperTrackingOther", isSuperTracking and not isSuperTrackingUserWaypoint)
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
