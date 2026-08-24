---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "corpse"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Corpse

---@return string
local function GetCorpseTargetID()
    return "corpse"
end

local function RefreshCorpse()
    local targetID = GetCorpseTargetID()
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    local isTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    if not isTrackingCorpse or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID, L["Corpse"], {
            hasCoordinates = x ~= nil and y ~= nil,
            isSuperTrackingCorpse = isTrackingCorpse,
            mapID = mapID,
        })
        return
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = L["Corpse"],
        texture = "poi-graveyard-neutral",
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetCorpseTargetID,
    refresh = RefreshCorpse,
    events = { "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST" },
})
