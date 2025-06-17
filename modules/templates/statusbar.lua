MapPinEnhancedStatusbarMixin = {}



local SMOOTH_SPEED = 10 -- Higher is faster

function MapPinEnhancedStatusbarMixin:SetValueSmooth(targetValue)
    if not self.smoothValue then
        self.smoothValue = self:GetValue() or 0
    end
    self.smoothTarget = targetValue
end

function MapPinEnhancedStatusbarMixin:OnUpdate(elapsed)
    if not self.smoothTarget then return end
    local current = self.smoothValue or self:GetValue() or 0
    -- TODO: check if built in functions like DeltaLerp or Lerp can be used
    local target = self.smoothTarget
    local lerpAmount = math.min(elapsed * SMOOTH_SPEED, 1)
    ---@type number
    local newValue = current + (target - current) * lerpAmount
    self.smoothValue = newValue
    self:SetValue(newValue)
    if math.abs(newValue - target) < 0.01 then
        self:SetValue(target)
        self.smoothValue = target
        self.smoothTarget = nil
    end
end
