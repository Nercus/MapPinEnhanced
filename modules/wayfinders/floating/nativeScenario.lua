---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")
---@class MapPinEnhancedWayfinderFloatingTemplate
local Floating = MapPinEnhancedWayfinderFloatingMixin

-- Native scenario markers can have a screen position without a map waypoint.
-- These methods extend the existing Floating frame without creating a route.
---@param self MapPinEnhancedWayfinderFloatingTemplate
---@param targetID string
function Floating:SetNativeScenario(targetID)
    if self.nativeScenarioID == targetID then return end
    self:StopTracking()
    self:PrepareForTarget()
    self.readout:PrepareForTarget()
    self.nativeScenarioID = targetID
    self.content:BeginTextIntro()
    self:RefreshNavigationTarget()
end

---@param self MapPinEnhancedWayfinderFloatingTemplate
---@return boolean
function Floating:IsNativeScenarioReady()
    return C_SuperTrack.GetHighestPrioritySuperTrackingType() == Enum.SuperTrackingType.Scenario and
        C_Scenario.IsInScenario() and self.nativeScenarioID == Providers:GetScenarioTargetID() and
        C_Navigation.HasValidScreenPosition()
end

---@param self MapPinEnhancedWayfinderFloatingTemplate
function Floating:UpdateNativeScenarioDistance()
    ---@type number?
    local distance
    if self.nativePositionReady then distance = C_Navigation.GetDistance() end
    if not MapPinEnhanced:IsReadableNumber(distance) or not (distance >= 0 and distance < math.huge) then
        distance = nil
    end
    local text = distance and MapPinEnhanced:FormatDistance(distance) or ""
    if self.lastDistanceText ~= text then
        self.lastDistanceText = text
        self.readout:SetValues(text, "", false)
    end
    self:OnDistanceUpdate(distance, nil, 0, 0.1, "unknown")
end

---@param self MapPinEnhancedWayfinderFloatingTemplate
function Floating:UpdateNativeScenarioNeedle()
    if not self.navFrame or not self.nativePositionReady then return end
    local x, y = self.navFrame:GetCenter()
    if not MapPinEnhanced:IsReadableNumber(x) or not MapPinEnhanced:IsReadableNumber(y) then return end
    local centerX, centerY = MapPinEnhanced:GetCenterScreenPoint()
    -- Match Blizzard's screen-space bearing; no world coordinates are available.
    self.newNeedleRotation = math.atan2(x - centerX, y - centerY)
end
