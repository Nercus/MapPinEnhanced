---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

-- block SetUserWaypoint calls from other addons which should not trigger the pin provider
-- MapPinEenhanced is in here as well to prevent infinite loops when the pin provider is used to set a waypoint
local BLOCKED_ADDON_LIST = {
    'WorldQuestTracker',
    MapPinEnhanced.name,
}

local function isBlockedAddon(stack)
    for _, blockedAddon in ipairs(BLOCKED_ADDON_LIST) do
        if stack.find(stack, blockedAddon) then
            return true
        end
    end
    return false
end

---@param uiMapPoint {uiMapID: number, position: {x: number, y: number}}
local function OnUserWaypoint(uiMapPoint)
    if not uiMapPoint then return end
    local stack = debugstack(2) ---@type string
    if isBlockedAddon(stack) then return end -- ignore calls from this function

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
        mapID = uiMapPoint.uiMapID,
        x = uiMapPoint.position.x,
        y = uiMapPoint.position.y,
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
