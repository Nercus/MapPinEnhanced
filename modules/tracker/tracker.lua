---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")


-- function Tracker:ShowTracker()
--     if not self.trackerFrame then
--         self.trackerFrame = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate")
--         self.trackerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 400, -100)
--         self.trackerFrame:Show()
--     end
--     self.trackerFrame:Show()
-- end

-- MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
--     Tracker:ShowTracker()
-- end)
