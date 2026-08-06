---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")
local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")

function Tracker:GetTrackerFrame()
    if not self.trackerFrame then
        self.trackerFrame = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate")
    end
    return self.trackerFrame
end

function Tracker:ShowTracker()
    MapPinEnhanced:SetVar("trackerVisible", true)
    MapPinEnhanced:EvaluateVisibilityTarget("tracker")
end

function Tracker:HideTracker()
    MapPinEnhanced:SetVar("trackerVisible", false)
    MapPinEnhanced:EvaluateVisibilityTarget("tracker")
end

function Tracker:UpdateList()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:UpdateList()
    end
end

function Tracker:RestoreTrackerVisibility()
    MapPinEnhanced:EvaluateVisibilityTarget("tracker")
end

-- FIXME: when some groups are collapsed the height is not updated and blocks some cursor actions

function Tracker:IsShown()
    local frame = self:GetTrackerFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Tracker:RestoreTrackerVisibility()
end)

MapPinEnhanced:RegisterVisibilityCondition("noActivePins", {
    evaluate = function()
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
    conditions = { "dungeon", "raid", "scenario", "battleground", "arena", "noActivePins" },
    isManuallyEnabled = function() return MapPinEnhanced:GetVar("trackerVisible") == true end,
    show = function() Tracker:GetTrackerFrame():ShowFrame() end,
    hide = function()
        local frame = Tracker.trackerFrame
        if frame and frame:IsShown() then frame:HideFrame() end
    end,
})


MapPinEnhanced:AddSlashCommand("tracker", function()
    if MapPinEnhanced:GetVar("trackerVisible") then
        Tracker:HideTracker()
    else
        Tracker:ShowTracker()
    end
end, L["Toggle the tracker visibility."])
