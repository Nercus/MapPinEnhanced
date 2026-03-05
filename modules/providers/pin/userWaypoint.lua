---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

-- block SetUserWaypoint calls from other addons which should not trigger the pin provider
-- MapPinEenhanced is in here as well to prevent infinite loops when the pin provider is used to set a waypoint
local BLOCKED_ADDON_LIST = {
    "WorldQuestTracker",
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


---@enum PIN_TEXTURE_OVERRIDES
local PIN_TEXTURE_OVERRIDES = {
    ["worldquest-questmarker-questbang"] = "worldquest-tracker-questmarker",
}

---Parses the blizzard map pin info from the mouse focus. This happens when ctrl clicking on the map
---@param mouseFocus table
---@return {name: string, texture: string?, isAtlas: boolean, x: number?, y: number?}
local function ParseBlizzardMapPinInfo(mouseFocus)
    assert(mouseFocus, "mouseFocus is required to parse the map pin info.")

    local name = mouseFocus.name ---@type string?
    if mouseFocus.questID then -- has a quest id so we can get the quest name
        local questTitle = C_QuestLog.GetTitleForQuestID(mouseFocus.questID)
        name = questTitle or nil
    end


    local isAtlas = false
    local texture = mouseFocus.texture ---@type string?
    ---@type AreaPOIInfo
    local poiInfo = mouseFocus.poiInfo
    if poiInfo and poiInfo.atlasName then
        texture = poiInfo.atlasName
        if PIN_TEXTURE_OVERRIDES[texture] then
            texture = PIN_TEXTURE_OVERRIDES[texture]
        end
        isAtlas = true
    end
    if mouseFocus.Display and mouseFocus.Display.Icon then
        ---@type string?
        texture = mouseFocus.Display.Icon:GetAtlas()
        isAtlas = true
    end

    local x, y = nil, nil
    if mouseFocus.normalizedX and mouseFocus.normalizedY then
        ---@type number
        x = mouseFocus.normalizedX
        ---@type number
        y = mouseFocus.normalizedY
    end
    return {
        name = name,
        texture = texture,
        isAtlas = isAtlas,
        x = x,
        y = y,
    }
end

---@class ScripRegionWithPinInfo : ScriptRegion
---@field pinTemplate string

---Detects the pin info of the mouse focus. This is used to get the name and texture of the pin.
---@return {name: string, texture: string?, isAtlas: boolean, x: number?, y: number?}|nil
local function DetectMouseFocusPinInfo()
    ---@type ScripRegionWithPinInfo[]? we use that the mouse is actually over a pin element even though we don't know the the exact type here
    local mouseFocus = GetMouseFoci()
    if not mouseFocus then return end
    local pinTemplate = nil ---@type string?
    for _, mouseFocusTable in ipairs(mouseFocus) do
        pinTemplate = mouseFocusTable.pinTemplate
        if pinTemplate and (string.find(pinTemplate, "%a+PinTemplate")) then
            return ParseBlizzardMapPinInfo(mouseFocusTable)
        end
    end
    if not pinTemplate then return nil end
    return nil
end


---@param uiMapPoint {uiMapID: number, position: {x: number, y: number}}
local function OnUserWaypoint(uiMapPoint)
    if not uiMapPoint then return end
    local stack = debugstack(2) ---@type string
    if isBlockedAddon(stack) then return end -- ignore calls from this function

    local mouseFocusInfo = DetectMouseFocusPinInfo()
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
        x = mouseFocusInfo and mouseFocusInfo.x or uiMapPoint.position.x,
        y = mouseFocusInfo and mouseFocusInfo.y or uiMapPoint.position.y,
        title = mouseFocusInfo and mouseFocusInfo.name or nil,
        texture = mouseFocusInfo and mouseFocusInfo.texture or nil,
        usesAtlas = mouseFocusInfo and mouseFocusInfo.isAtlas or false,
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

---Hide default world map Pin
local function HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HookSetUserWaypoint)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HideBlizzardPin)
