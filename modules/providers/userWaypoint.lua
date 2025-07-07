---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L


---@param waypointData {uiMapID: number, position: {x: number, y: number}}
local function OnUserWaypoint(waypointData)
    if not waypointData then return end

    local title, texture, usesAtlas = Providers:DetectMouseFocusPinInfo()
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()

    if isSuperTracking and not isSuperTrackingUserWaypoint and not isSuperTrackingCorpse then
        C_SuperTrack.ClearAllSuperTracked()
    end
    local uncategorizedGroup = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedGroup then return end
    uncategorizedGroup:AddPin({
        mapID = waypointData.uiMapID,
        x = waypointData.position.x,
        y = waypointData.position.y,
        title = title,
        texture = texture,
        usesAtlas = usesAtlas,
        setTracked = not isSuperTrackingCorpse
    })
end


local isHooked = false
local function HookSetUserWaypoint()
    if isHooked then return end
    if not C_Map.SetUserWaypoint then return end
    hooksecurefunc(C_Map, "SetUserWaypoint", OnUserWaypoint)
    isHooked = true
end



MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HookSetUserWaypoint)
