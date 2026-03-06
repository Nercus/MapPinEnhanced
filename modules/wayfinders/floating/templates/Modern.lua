---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingModernTemplate : Frame
MapPinEnhancedFloatingModernMixin = {}

-- TODO: The diamond is actually attached to the navframe and is removing the supertrackedframe based on show hide
-- unregister NAVIGATION_FRAME_CREATED, NAVIGATION_FRAME_DESTROYED, SUPER_TRACKING_CHANGED from SuperTrackedFrame, hide it and ShutdownNavigationFrame on it
-- on hide of the MPH diamond reregister the events, InitializeNavigationFrame and show the original supertrackedframe

local needsReset = false

function MapPinEnhancedFloatingModernMixin:OnLoad()
end

function MapPinEnhancedFloatingModernMixin:OnShow()
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED");
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED");
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED");
    SuperTrackedFrame:ShutdownNavigationFrame();
    SuperTrackedFrame:Hide();
    needsReset = true
end

function MapPinEnhancedFloatingModernMixin:OnHide()
    if needsReset then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED");
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
        SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED");
        SuperTrackedFrame:InitializeNavigationFrame();
        SuperTrackedFrame:Show();
    end
end

local minDistance = 200
local maxDistance = 2000

function MapPinEnhancedFloatingModernMixin:UpdateScaleByDistance(distance)
    local normalizedDistance = math.min(distance / maxDistance, 1)
    local scale = 1.0 - (normalizedDistance * 0.5)

    self:SetScale(scale)
end

function MapPinEnhancedFloatingModernMixin:OnDistanceUpdate(distance, timeToTarget)
    if distance then
        self:UpdateScaleByDistance(distance)
    end
end
