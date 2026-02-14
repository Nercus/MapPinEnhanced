---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local Tracker = MapPinEnhanced:GetModule("Tracker")

---@class MapPinEnhancedTrackerHeaderTemplate : Frame
---@field viewButton Button
---@field closeButton Button
---@field headerTextureLeft Texture
---@field headerTextureRight Texture
MapPinEnhancedTrackerHeaderMixin = {}

function MapPinEnhancedTrackerHeaderMixin:OnLoad()
    self.viewButton:SetScript("OnClick", function()
        local trackerFrame = self:GetParent() --[[@as MapPinEnhancedTrackerTemplate]]
        trackerFrame:ToggleActiveView()
    end)

    self.closeButton:SetScript("OnClick", function()
        Tracker:HideTracker()
    end)
end
