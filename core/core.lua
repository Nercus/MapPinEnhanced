---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class PinManager : Module
local PinManager = MapPinEnhanced:CreateModule("PinManager")

---@class PinFactory : Module
local PinFactory = MapPinEnhanced:CreateModule("PinFactory")

---@diagnostic disable-next-line: no-unknown
local CreateUIMapPointFromCoordinates = UiMapPoint.CreateFromCoordinates
local SetUserWaypoint = C_Map.SetUserWaypoint
local CanSetUserWaypointOnMap = C_Map.CanSetUserWaypointOnMap
local TimerAfter = C_Timer.After
local SuperTrackSetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint

---toggle the pin tracker
---@param forceShow? boolean if true, the tracker will be shown, if false, the tracker will be hidden, if nil, the tracker will be toggled
function MapPinEnhanced:TogglePinTracker(forceShow)
    if not self.pinTracker then
        self.pinTracker = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate") --[[@as MapPinEnhancedTrackerMixin]]
    end
    if forceShow == true then
        self.pinTracker:Open()
    elseif forceShow == false then
        self.pinTracker:Close()
    else
        self.pinTracker:Toggle()
    end
end

local function RestorePinTrackerVisibility()
    local trackerVisibility = MapPinEnhanced:GetVar("trackerVisible") --[[@as boolean]]
    if trackerVisibility == nil then
        trackerVisibility = MapPinEnhanced:GetDefault("trackerVisible") --[[@as boolean]]
    end
    MapPinEnhanced:TogglePinTracker(trackerVisibility)
end


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    RestorePinTrackerVisibility()
end)

---Hide all elements of the default blizzard world map waypoint
---@diagnostic disable-next-line: no-unknown
hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self) -- hide default blizzard waypoint
    self:SetAlpha(0)
    self:EnableMouse(false)
end)


-- TODO: Wrap this in a function and add an option
---@diagnostic disable-next-line: no-unknown
SuperTrackedFrameMixin:SetTargetAlphaForState(0, 1)
---@diagnostic disable-next-line: no-unknown
SuperTrackedFrameMixin:SetTargetAlphaForState(1, 1)


function MapPinEnhanced:SetBlizzardWaypoint(x, y, mapID)
    if not CanSetUserWaypointOnMap(mapID) then
        --TODO: show proper error message to the user
        error("Cannot set waypoint on map " .. mapID)
        return
    end
    ---@diagnostic disable-next-line: no-unknown
    local uiMapPoint = CreateUIMapPointFromCoordinates(mapID, x, y, 0)
    SetUserWaypoint(uiMapPoint)
    TimerAfter(0.1, function()
        SuperTrackSetSuperTrackedUserWaypoint(true)
    end)
end

MapPinEnhanced.PIN_COLORS = {
    ["Yellow"] = CreateColor(0.8745, 0.6627, 0.0196),
    ["Pale"] = CreateColor(0.9137, 0.6078, 0.3569),
    ["Red"] = CreateColor(0.9137, 0.0706, 0.0078),
    ["Pink"] = CreateColor(1.0000, 0.3961, 0.7804),
    ["Green"] = CreateColor(0.3176, 0.9137, 0.0745),
    ["DarkBlue"] = CreateColor(0.3176, 0.9137, 0.0745),
    ["Purple"] = CreateColor(0.6941, 0.5020, 0.9137),
    ["LightBlue"] = CreateColor(0.4745, 0.5020, 0.9137),
    ["Orange"] = CreateColor(0.9137, 0.3882, 0.1882),
}
