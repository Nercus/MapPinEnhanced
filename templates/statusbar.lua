---@class MapPinEnhancedStatusbarTemplate : StatusBar
---@field name FontString
---@field progress FontString
---@field progressFormatter fun(progress: number, max: number): string
---@field pip Texture
MapPinEnhancedStatusbarMixin = {}


local DeltaLerp = DeltaLerp

function MapPinEnhancedStatusbarMixin:SetValueSmooth(targetValue)
    if not self.smoothValue then
        self.smoothValue = self:GetValue() or 0
    end
    self.smoothTarget = targetValue
end

function MapPinEnhancedStatusbarMixin:UpdatePipVisibility()
    local min, max = self:GetMinMaxValues()
    local value = self:GetValue() or 0
    if value == min or value == max then
        self.pip:Hide()
        return
    end
    self.pip:Show()
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
    self:UpdatePipVisibility()
end

function MapPinEnhancedStatusbarMixin:OnValueChanged(value)
    if self.progressFormatter then
        local _, max = self:GetMinMaxValues()
        local progressText = self.progressFormatter(value, max)
        self.progress:SetText(progressText)
    else
        self.progress:SetText(tostring(math.floor(value)))
    end
    self:UpdatePipVisibility()
end

function MapPinEnhancedStatusbarMixin:SetName(name)
    self.name:SetText(name)
end

function MapPinEnhancedStatusbarMixin:SetProgressFormatter(formatter)
    self.progressFormatter = formatter
end

function MapPinEnhancedStatusbarMixin:OnLoad()
    local width, height = self:GetSize()
    self.pip:SetSize(width * 0.01, height)
    self.pip:ClearAllPoints()
    self.pip:SetPoint("TOP", self:GetStatusBarTexture(), "TOPRIGHT", 0, 10);
    self.pip:SetPoint("BOTTOM", self:GetStatusBarTexture(), "BOTTOMRIGHT", 0, -10);
    self:UpdatePipVisibility()
end
