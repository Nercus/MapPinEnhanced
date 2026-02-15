---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")
local Options = MapPinEnhanced:GetModule("Options")

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

---@param group MapPinEnhancedGroupMixin
---@return TreeNodeMixin?
function Tracker:AddGroup(group)
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        return frame:AddGroup(group)
    end
end

---@param groupTreeNode TreeNodeMixin?
function Tracker:RemoveGroup(groupTreeNode)
    if self:GetActiveView() ~= "pin" then
        return -- Cannot remove groups in set view
    end
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:RemoveGroup(groupTreeNode)
    end
end

---@return 'set' | 'pin' | nil
function Tracker:GetActiveView()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        return frame.activeView
    end
    return nil
end

function Tracker:ToggleActiveView()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:ToggleActiveView()
    end
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
end, "Toggle the tracker visibility.")
