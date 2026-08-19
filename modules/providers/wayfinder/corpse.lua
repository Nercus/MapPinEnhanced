---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "corpse"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Corpse

local function RefreshCorpse()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local identity = "corpse"
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    local isTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    if not isTrackingCorpse or not x or not y or not mapID then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnresolvedSuperTrackingTarget(identity, L["Corpse"], {
            isSuperTrackingCorpse = isTrackingCorpse, mapID = mapID,
        })
        return
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
        mapID = mapID,
        x = x,
        y = y,
        title = L["Corpse"],
        texture = "poi-graveyard-neutral",
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingProvider(SOURCE, SUPER_TRACKING_TYPE)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshCorpse)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshCorpse)
MapPinEnhanced:RegisterEvent("PLAYER_DEAD", RefreshCorpse)
MapPinEnhanced:RegisterEvent("PLAYER_ALIVE", RefreshCorpse)
MapPinEnhanced:RegisterEvent("PLAYER_UNGHOST", RefreshCorpse)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshCorpse)
