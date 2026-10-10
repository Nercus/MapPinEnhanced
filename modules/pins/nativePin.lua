---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---Hide default world map Pin
local function HideBlizzardPin()
    if not WaypointLocationPinMixin then return end
    hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(waypointSelf) -- hide default blizzard waypoint
        waypointSelf:SetAlpha(0)
        waypointSelf:EnableMouse(false)
    end)
end


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", HideBlizzardPin)
