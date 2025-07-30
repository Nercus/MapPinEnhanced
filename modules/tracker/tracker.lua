---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")

function Tracker:GetTrackerFrame()
    if not self.trackerFrame then
        self.trackerFrame = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate")
    end
    return self.trackerFrame
end

function Tracker:ShowTracker()
    local frame = self:GetTrackerFrame()
    local position = MapPinEnhanced:GetVar("trackerPosition") --[[@as { x: number, y: number }?]]
    if position then
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", position.x, position.y)
    else
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER")
    end
    frame:UpdateList()
    frame:Show()
    MapPinEnhanced:SetVar("trackerVisible", true)
end

function Tracker:HideTracker()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        frame:Hide()
    end
    MapPinEnhanced:SetVar("trackerVisible", false)
end

---@param group MapPinEnhancedPinGroupMixin
---@return TreeNodeMixin?
function Tracker:AddGroup(group)
    if self:GetActiveView() ~= "pin" then
        return nil -- Cannot add groups in set view
    end
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

---@return 'set' | 'pin'
function Tracker:GetActiveView()
    local frame = self:GetTrackerFrame()
    if frame:IsShown() then
        return frame.activeView
    end
    return "pin" -- Default to pin view if tracker is not shown
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
