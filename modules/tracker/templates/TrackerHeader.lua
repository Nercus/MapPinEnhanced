---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local Tracker = MapPinEnhanced:GetModule("Tracker")

---@class MapPinEnhancedTrackerHeaderTemplate : Frame
---@field viewButton Button
---@field closeButton Button
---@field headerTexture Texture
MapPinEnhancedTrackerHeaderMixin = {}

---@param button mouseButton
function MapPinEnhancedTrackerHeaderMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    local isLocked = MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    if isLocked then
        MapPinEnhanced:Print("Tracker is locked. Unlock it in the options.")
        return
    end
    local trackerFrame = self:GetParent() --[[@as MapPinEnhancedTrackerTemplate]]
    trackerFrame:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

---@param button mouseButton
function MapPinEnhancedTrackerHeaderMixin:OnMouseUp(button)
    if button ~= "LeftButton" then return end
    local trackerFrame = self:GetParent() --[[@as MapPinEnhancedTrackerTemplate]]
    local _, _, _, left, top = trackerFrame:GetPoint()
    trackerFrame:StopMovingOrSizing()
    trackerFrame:SetPosition(left, top)
    SetCursor(nil)
end

function MapPinEnhancedTrackerHeaderMixin:OnLoad()
    self.viewButton:SetScript("OnClick", function()
        local trackerFrame = self:GetParent() --[[@as MapPinEnhancedTrackerTemplate]]
        trackerFrame:ToggleActiveView()
    end)

    self.closeButton:SetScript("OnClick", function()
        Tracker:HideTracker()
    end)
end
