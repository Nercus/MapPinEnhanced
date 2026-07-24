---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")
local L = MapPinEnhanced.L

function Tracker:GetTrackerFrame()
    if not self.trackerFrame then
        self.trackerFrame = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate")
    end
    return self.trackerFrame
end

function Tracker:ShowTracker()
    local frame = self:GetTrackerFrame()
    frame:ShowFrame()
    MapPinEnhanced:SetVar("trackerVisible", true)
end

function Tracker:HideTracker()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:HideFrame()
    end
    MapPinEnhanced:SetVar("trackerVisible", false)
end

function Tracker:UpdateList()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:UpdateList()
    end
end

function Tracker:RestoreTrackerVisibility()
    if MapPinEnhanced:GetVar("trackerVisible") then
        self:ShowTracker()
    else
        self:HideTracker()
    end
end

-- FIXME: when some groups are collapsed the height is not updated and blocks some cursor actions

function Tracker:IsShown()
    local frame = self:GetTrackerFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Tracker:RestoreTrackerVisibility()
end)


MapPinEnhanced:AddSlashCommand("tracker", function()
    if MapPinEnhanced:GetVar("trackerVisible") then
        Tracker:HideTracker()
    else
        Tracker:ShowTracker()
    end
end, L["Toggle the tracker visibility."])
