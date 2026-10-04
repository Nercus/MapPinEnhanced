---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")
local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")

function Tracker:GetTrackerFrame()
    if not self.trackerFrame then
        local position = CreateFrame("Frame", "MapPinEnhancedTrackerPosition", UIParent,
            "MapPinEnhancedTrackerPositionTemplate") --[[@as MapPinEnhancedTrackerPositionTemplate]]
        self.trackerFrame = position.display
    end
    return self.trackerFrame
end

function Tracker:ShowTracker()
    MapPinEnhanced:SetVar("trackerVisible", true)
    MapPinEnhanced:UpdateVisibilityTarget("tracker")
end

function Tracker:HideTracker()
    MapPinEnhanced:SetVar("trackerVisible", false)
    MapPinEnhanced:UpdateVisibilityTarget("tracker")
end

function Tracker:ToggleTracker()
    if MapPinEnhanced:GetVar("trackerVisible") then
        self:HideTracker()
    else
        self:ShowTracker()
    end
end

function Tracker:UpdateList()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:RequestListUpdate()
    end
end

function Tracker:RestoreTrackerVisibility()
    MapPinEnhanced:UpdateVisibilityTarget("tracker")
end

function Tracker:IsShown()
    local frame = self:GetTrackerFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Tracker:RestoreTrackerVisibility()
end)

MapPinEnhanced:AddVisibilityRule("noActivePins", {
    isActive = function()
        -- Blizzard tracking alone must not reopen a tracker hidden for having no addon pins.
        for group in Groups:EnumerateGroups() do
            if not group:IsHidden() then
                for _ in group:EnumeratePins() do return false end
            end
        end
        return true
    end,
    callbacks = { "PIN_ADDED", "PIN_REMOVED", "PIN_REACHED", "GROUP_UPDATED", "GROUP_DELETED" },
})

MapPinEnhanced:RegisterVisibilityTarget("tracker", {
    optionKey = "Miscellaneous.Tracker.Visibility",
    rules = { "dungeon", "raid", "scenario", "battleground", "arena", "noActivePins" },
    isManuallyEnabled = function() return MapPinEnhanced:GetVar("trackerVisible") == true end,
    show = function() Tracker:GetTrackerFrame():ShowFrame() end,
    hide = function()
        local frame = Tracker.trackerFrame
        if frame and frame:IsShown() then frame:HideFrame() end
    end,
})


MapPinEnhanced:AddSlashCommand("tracker", function()
    Tracker:ToggleTracker()
end, L["Toggle the tracker visibility."])

function Tracker:SetMinimized(minimized)
    MapPinEnhanced:SetVar("trackerMinimized", minimized == true)
    if self.trackerFrame then self.trackerFrame:ApplyMinimizedState() end
end

-- Explicit user creation/import calls this only after at least one accepted addition.
function Tracker:OnUserPinsAdded()
    if not MapPinEnhanced:GetModule("Options"):GetOptionValue("Miscellaneous.Tracker.AutoShow") then return end
    self:SetMinimized(false)
    self:ShowTracker()
end

function Tracker:ApplyCloseAction()
    if MapPinEnhanced:GetModule("Options"):GetOptionValue("Miscellaneous.Tracker.CloseAction") == true then
        self:SetMinimized(not MapPinEnhanced:GetVar("trackerMinimized"))
    else
        self:HideTracker()
    end
end
