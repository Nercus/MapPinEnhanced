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

    local fixedHeight = self:GetHeight()
    local migrated = MapPinEnhanced:GetVar("frames", "tracker", "fixedPosition")
    if not migrated then
        -- Legacy saves anchor the entire display. Reconstruct that rectangle before
        -- capturing its top edge; legacy saves do not retain collapsed content height.
        self:SetHeight(contentHeight)
    end
    MapPinEnhanced:RestoreFrame(self)
    if not MapPinEnhanced:GetVar("frames", "tracker", "scale") then
        self:SetScale(1)
    end

    if not migrated then
        local left, top = self:GetLeft(), self:GetTop()
        if not left or not top then
            self:SetHeight(fixedHeight)
            return
        end
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
        self:SetHeight(fixedHeight)
        -- Save only after conversion; LibWindow may choose any anchor for this
        -- fixed-size owner without making subsequent content resizing move it.
        MapPinEnhanced:SaveFramePosition(self)
        MapPinEnhanced:SetVar("frames", "tracker", "fixedPosition", true)
    end
    self.restored = true
end
