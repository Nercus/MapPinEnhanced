---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "corpse"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Corpse

---@return string
local function GetCorpseTargetID()
    return "corpse"
end

---@return WayfinderData?
---@return boolean? removable
---@return boolean? textAvailable
local function ReadCorpse()
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(function(candidateMapID)
        local position = C_DeathInfo.GetCorpseMapPosition(candidateMapID)
        if position then return position:GetXY() end
    end)
    local isTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    if not isTrackingCorpse or x == nil or y == nil or mapID == nil then
        return
    end
    return {
        mapID = mapID,
        x = x,
        y = y,
        title = L["Corpse"],
        texture = "poi-graveyard-neutral",
        usesAtlas = true,
    }
end

Wayfinders:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetCorpseTargetID,
    read = ReadCorpse,
    events = { "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST" },
})
