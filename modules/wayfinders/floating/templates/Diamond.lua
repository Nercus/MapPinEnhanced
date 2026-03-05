---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingDiamondTemplate : Frame
MapPinEnhancedFloatingDiamondMixin = {}

-- TODO: The diamond is actually attached to the navframe and is removing the supertrackedframe based on show hide
-- unregister NAVIGATION_FRAME_CREATED, NAVIGATION_FRAME_DESTROYED, SUPER_TRACKING_CHANGED from SuperTrackedFrame, hide it and ShutdownNavigationFrame on it
-- on hide of the MPH diamond reregister the events, InitializeNavigationFrame and show the original supertrackedframe


function MapPinEnhancedFloatingDiamondMixin:OnLoad()
end
