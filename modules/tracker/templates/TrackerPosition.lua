---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPositionTemplate : Frame
---@field display MapPinEnhancedTrackerTemplate
---@field restored boolean?
MapPinEnhancedTrackerPositionMixin = {}

---The persistent position belongs to a fixed rectangle, independent of list height.
---@param contentHeight number
function MapPinEnhancedTrackerPositionMixin:RestoreTrackerPosition(contentHeight)
    if self.restored then return end

    if not MapPinEnhanced:GetModule("Tracker"):MigrateLegacyPosition(self, contentHeight) then return end
    MapPinEnhanced:RestoreFrame(self)
    if not MapPinEnhanced:GetVar("frames", "tracker", "scale") then
        self:SetScale(1)
    end
    self.restored = true
end

function MapPinEnhancedTrackerPositionMixin:ApplyTrackerScale()
    if not self.restored then return end
    local scale = MapPinEnhanced:GetModule("Options"):GetOptionValue("Miscellaneous.Tracker.Scale") --[[@as number]]
    local oldScale = self:GetScale()
    if scale == oldScale then return end
    local left, top = self:GetLeft(), self:GetTop()
    MapPinEnhanced:SetFrameScale(self, scale)
    if left and top then
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left * oldScale / scale, top * oldScale / scale)
        MapPinEnhanced:SaveFramePosition(self)
    end
    self.display:UpdateViewportHeight()
end
