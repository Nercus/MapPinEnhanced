---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---Method to block the automatic removal of pins in the game
local function OverrideSuperTrackedReachedBehavior()
    -- TODO: find a taint free way to do this
    local superTrackMapPinTypesThatClearWhenDestinationReached = {
        [Enum.SuperTrackingMapPinType.AreaPOI] = true,
        [Enum.SuperTrackingMapPinType.TaxiNode] = true,
        [Enum.SuperTrackingMapPinType.DigSite] = true,
    };
    SuperTrackedFrame.ShouldClearSuperTrackWhenDestinationReached = function()
        local superTrackType = C_SuperTrack.GetHighestPrioritySuperTrackingType();
        if Enum.SuperTrackingType.Vignette == superTrackType then return true end
        if Enum.SuperTrackingType.MapPin == superTrackType then
            local pinType = C_SuperTrack.GetSuperTrackedMapPin();
            if pinType then
                return superTrackMapPinTypesThatClearWhenDestinationReached[pinType];
            end
            return false;
        end
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", OverrideSuperTrackedReachedBehavior)

---Hide default world map Pin
local function HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HideBlizzardPin)


---Method to override the alpha state of the super tracked frame -> create unlimited distance
---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

local function SetSuperTrackedAlphaState()
    local unlimitedDistance = MapPinEnhanced:GetVar("floatingPin", "unlimitedDistance")
    OverrideSuperTrackedAlphaState(unlimitedDistance)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", SetSuperTrackedAlphaState)
