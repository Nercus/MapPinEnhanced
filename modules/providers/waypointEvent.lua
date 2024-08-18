---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")
local PinManager = MapPinEnhanced:GetModule("PinManager")

local GetUserWaypoint = C_Map.GetUserWaypoint

local blockEvent = false

---------------------------------------------------------------------------

--- USER_WAYPOINT_UPDATED event handler
local function OnUserWaypoint()
    if blockEvent then return end -- as super tracking a pin triggers this event we need to block it so we don't get into an infinite loop

    local wp = GetUserWaypoint()
    if not wp then return end
    blockEvent = true

    local title, texture, usesAtlas = PinProvider:DetectMouseFocusPinInfo()
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()

    if isSuperTracking and not isSuperTrackingUserWaypoint and not isSuperTrackingCorpse then
        C_SuperTrack.ClearAllSuperTracked()
    end


    PinManager:AddPin({
        mapID = wp.uiMapID,
        x = wp.position.x,
        y = wp.position.y,
        title = title,
        texture = texture,
        usesAtlas = usesAtlas,
        setTracked = not isSuperTrackingCorpse
    })
    blockEvent = false
end

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", OnUserWaypoint)
