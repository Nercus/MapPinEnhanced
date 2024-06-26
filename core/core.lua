---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


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
