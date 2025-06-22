---@class MapPinEnhancedStatusbarTemplate : StatusBar
MapPinEnhancedStatusbarMixin = {}


local DeltaLerp = DeltaLerp

function MapPinEnhancedStatusbarMixin:SetValueSmooth(targetValue)
    if not self.smoothValue then
        self.smoothValue = self:GetValue() or 0
    end
    self.smoothTarget = targetValue
end

function MapPinEnhancedStatusbarMixin:OnUpdate(elapsed)
    if not self.smoothTarget then return end
    local current = self.smoothValue or self:GetValue() or 0
    -- Use built-in Lerp function
    local target = self.smoothTarget
    local newValue = DeltaLerp(current, target, .1, elapsed)
    self.smoothValue = newValue
    self:SetValue(newValue)
    if math.abs(newValue - target) < 0.01 then
        self:SetValue(target)
        self.smoothValue = target
        self.smoothTarget = nil
    end
end
