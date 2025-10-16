---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Blizzard
local Blizzard = MapPinEnhanced:GetModule("Blizzard")

---Wrapper for the current map the player is on
---@return number? mapID
function Blizzard:GetPlayerMap()
    return C_Map.GetBestMapForUnit("player")
end

---Wrapper for the current map position of the player
---@return number x, number y, number currentPlayerUIMapID, Enum.UIMapType currentPlayerUIMapType
function Blizzard:GetPlayerMapPosition()
    return MapPinEnhanced.HBD:GetPlayerZonePosition()
end

function Blizzard:GetGlobalSuperTrackedFrame()
    if not self.superTrackedFrame and SuperTrackedFrame then
        self.superTrackedFrame = CreateFrame("Frame", "MapPinEnhancedGlobalSuperTrackedFrame", SuperTrackedFrame,
            "MapPinEnhancedSuperTrackedPinTemplate")
    end
    return self.superTrackedFrame
end

function Blizzard:UpdateGlobalSuperTrackedFrame()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    local globalSuperTrackedFrame = self:GetGlobalSuperTrackedFrame()
    if not superTrackingType or superTrackingType ~= Enum.SuperTrackingType.UserWaypoint then
        globalSuperTrackedFrame:Hide()
        return
    end
    -- TODO: set the correct icon here Providers:GetSuperTrackingInfo(mapID)
    --globalSuperTrackedFrame:Show()
end

---Method to handle the super tracking change event and track the last tracked pin
function Blizzard:OnSuperTrackingChanged()
    ---@type boolean
    local isSuperTracking = C_SuperTrack.IsSuperTrackingAnything()
    local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isSuperTrackingMapPin = C_SuperTrack.IsSuperTrackingMapPin()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()

    local isSuperTrackingOther = isSuperTracking and not isSuperTrackingUserWaypoint and not isSuperTrackingMapPin
    MapPinEnhanced:SetVar("superTrackingOther", isSuperTrackingOther)
    if isSuperTrackingCorpse then return end -- corpse tracking runs simultaneously with other supertracking types

    local Tracking = MapPinEnhanced:GetModule("Tracking")
    if isSuperTrackingOther then
        Tracking:UntrackTrackedPin()
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", function()
    Blizzard:OnSuperTrackingChanged()
    Blizzard:UpdateGlobalSuperTrackedFrame()
end)
MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    Blizzard:OnSuperTrackingChanged()
    Blizzard:UpdateGlobalSuperTrackedFrame()
end)
