---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinProvider : Module
local PinProvider = Wayfinder:GetModule("PinProvider")


---@class PinManager
local PinManager = Wayfinder:GetModule("PinManager")


local GetUserWaypoint = C_Map.GetUserWaypoint
local IsSuperTrackingQuest = C_SuperTrack.IsSuperTrackingQuest
local IsSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse
local IsSuperTrackingContent = C_SuperTrack.IsSuperTrackingContent
local SetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint


local blockEvent = false
--- USER_WAYPOINT_UPDATED event handler
function PinProvider:USER_WAYPOINT_UPDATED()
    if blockEvent then return end -- as super tracking a pin triggers this event we need to block it so we don't get into an infinite loop

    local wp = GetUserWaypoint()
    if not wp then return end
    blockEvent = true

    local superTrackingQuest = IsSuperTrackingQuest()
    local superTrackingCorpse = IsSuperTrackingCorpse()
    local superTrackingContent = IsSuperTrackingContent()

    -- is not tracking anything or is tracking a waypoint
    if not superTrackingQuest and not superTrackingCorpse and not superTrackingContent then
        SetSuperTrackedUserWaypoint(true)
    end
    local title, texture = PinProvider:DetectMouseFocusPinInfo()
    PinManager:AddPin({
        mapID = wp.uiMapID,
        x = wp.position.x,
        y = wp.position.y,
        title = title,
        texture = texture
    })

    blockEvent = false
end

Wayfinder:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    PinProvider:USER_WAYPOINT_UPDATED()
end)