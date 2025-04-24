---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")
local PinManager = MapPinEnhanced:GetModule("PinManager")


-- block SetUserWaypoint calls from other addons which should not trigger the pin provider
-- MapPinEenhanced is in here as well to prevent infinite loops when the pin provider is used to set a waypoint
local BLOCKED_ADDON_LIST = {
    'WorldQuestTracker',
    MapPinEnhanced.addonName,
}


local function isBlockedAddon(stack)
    for _, blockedAddon in ipairs(BLOCKED_ADDON_LIST) do
        if stack.find(stack, blockedAddon) then
            return true
        end
    end
    return false
end

---@param uiMapPoint UiMapPoint
local function HandleSetUserWaypoint(uiMapPoint)
    if not uiMapPoint then return end
    local stack = debugstack(2) ---@type string
    if isBlockedAddon(stack) then return end -- ignore calls from this function
    local title, texture, usesAtlas = PinProvider:DetectMouseFocusPinInfo()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    PinManager:AddPin({
        mapID = uiMapPoint.uiMapID,
        x = uiMapPoint.position.x,
        y = uiMapPoint.position.y,
        title = title,
        texture = texture,
        usesAtlas = usesAtlas,
        setTracked = not isSuperTrackingCorpse
    })
end

hooksecurefunc(C_Map, "SetUserWaypoint", HandleSetUserWaypoint)
