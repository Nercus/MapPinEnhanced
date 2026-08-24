---@class MapPinEnhancedWayfinderFloatingEnhancedReadoutTemplate : Frame
---@field distance FontString
---@field eta FontString
MapPinEnhancedWayfinderFloatingEnhancedReadoutMixin = {}

---@param relativeTo Region
function MapPinEnhancedWayfinderFloatingEnhancedReadoutMixin:LayoutBelow(relativeTo)
    self.distance:ClearAllPoints()
    self.distance:SetPoint("TOP", relativeTo, "BOTTOM", 0, -5)
    self.eta:ClearAllPoints()
    self.eta:SetPoint("TOP", self.distance, "BOTTOM", 0, -5)
end

---@param relativeTo Region
function MapPinEnhancedWayfinderFloatingEnhancedReadoutMixin:LayoutAbove(relativeTo)
    self.eta:ClearAllPoints()
    self.eta:SetPoint("BOTTOM", relativeTo, "TOP", 0, 5)
    self.distance:ClearAllPoints()
    self.distance:SetPoint("BOTTOM", self.eta, "TOP", 0, 5)
end
