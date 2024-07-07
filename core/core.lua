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
        self.pinTracker:Open()
        return
    end
    if forceShow == true then
        self.pinTracker:Open()
    elseif forceShow == false then
        self.pinTracker:Close()
    else
        self.pinTracker:Toggle()
    end
end

function MapPinEnhanced:ToggleImportWindow()
    if not self.importWindow then
        self.importWindow = CreateFrame("Frame", "MapPinEnhancedImportWindow", UIParent,
            "MapPinEnhancedImportWindowTemplate") --[[@as MapPinEnhancedImportWindowMixin]]
        self.importWindow:Open()
        return
    end
    if self.importWindow:IsVisible() then
        self.importWindow:Close()
    else
        self.importWindow:Open()
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
    { color = CreateColorFromBytes(237, 179, 20, 1),  colorName = "Yellow" },
    { color = CreateColorFromBytes(96, 236, 29, 1),   colorName = "Green" },
    { color = CreateColorFromBytes(132, 196, 237, 1), colorName = "LightBlue" },
    { color = CreateColorFromBytes(42, 93, 237, 1),   colorName = "DarkBlue" },
    { color = CreateColorFromBytes(190, 139, 237, 1), colorName = "Purple" },
    { color = CreateColorFromBytes(251, 109, 197, 1), colorName = "Pink" },
    { color = CreateColorFromBytes(235, 15, 14, 1),   colorName = "Red" },
    { color = CreateColorFromBytes(237, 114, 63, 1),  colorName = "Orange" },
    { color = CreateColorFromBytes(235, 183, 139, 1), colorName = "Pale" },
}

MapPinEnhanced.PIN_COLORS_BY_NAME = {
    ["Yellow"] = CreateColorFromBytes(237, 179, 20, 1),
    ["Green"] = CreateColorFromBytes(96, 236, 29, 1),
    ["LightBlue"] = CreateColorFromBytes(132, 196, 237, 1),
    ["DarkBlue"] = CreateColorFromBytes(42, 93, 237, 1),
    ["Purple"] = CreateColorFromBytes(190, 139, 237, 1),
    ["Pink"] = CreateColorFromBytes(251, 109, 197, 1),
    ["Red"] = CreateColorFromBytes(235, 15, 14, 1),
    ["Orange"] = CreateColorFromBytes(237, 114, 63, 1),
    ["Pale"] = CreateColorFromBytes(235, 183, 139, 1),
}



---@param options ModalOptions
function MapPinEnhanced:OpenTextModal(options)
    if not self.textModal then
        self.textModal = CreateFrame("Frame", "MapPinEnhancedTextModal", UIParent, "MapPinEnhancedTextModalTemplate") --[[@as MapPinEnhancedTextModalMixin]]
    end
    self.textModal:Open(options)
end
