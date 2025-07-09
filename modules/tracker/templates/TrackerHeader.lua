---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerHeaderMixin : Frame
MapPinEnhancedTrackerHeaderMixin = {}

---@param button mouseButton
function MapPinEnhancedTrackerHeaderMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    local isLocked = MapPinEnhanced:GetVar("tracker", "lockTracker") --[[@as boolean]]
    if isLocked then
        MapPinEnhanced:Print("Tracker is locked. Unlock it in the options.")
        return
    end
    self:GetParent():StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

---@param button mouseButton
function MapPinEnhancedTrackerHeaderMixin:OnMouseUp(button)
    if button ~= "LeftButton" then return end
    local _, _, _, left, top = self:GetPoint()
    self:GetParent():StopMovingOrSizing()
    MapPinEnhanced:SetVar("trackerPosition", { x = left, y = top })
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    SetCursor(nil)
end
