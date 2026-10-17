---@class MapPinEnhancedStatusbarTemplate : StatusBar
---@field mapArt MapPinEnhancedMapArtMixin
---@field fillClip Frame|{canvas: Frame|{fill: Texture, fillArt: MapPinEnhancedMapArtMixin}}
---@field labels Frame|{name: FontString, progress: FontString}
---@field name FontString
---@field progress FontString
---@field progressFormatter fun(progress: number, max: number): string
MapPinEnhancedStatusbarMixin = {}


local DeltaLerp = DeltaLerp

function MapPinEnhancedStatusbarMixin:SetValueSmooth(targetValue)
    if not self.smoothValue then
        self.smoothValue = self:GetValue() or 0
    end
    self.smoothTarget = targetValue
    if not self:GetScript("OnUpdate") then
        self:SetScript("OnUpdate", function(_, elapsed)
            self:OnUpdate(elapsed)
        end)
    end
end

function MapPinEnhancedStatusbarMixin:OnUpdate(elapsed)
    if not self.smoothTarget then
        self:SetScript("OnUpdate", nil) -- Stop updating
        return
    end
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
        self:SetScript("OnUpdate", nil)
    end
end

function MapPinEnhancedStatusbarMixin:OnValueChanged(value)
    self:UpdateFill()
    if not self.progress then
        return
    end
    if self.progressFormatter then
        local _, max = self:GetMinMaxValues()
        local progressText = self.progressFormatter(value, max)
        self.progress:SetText(progressText)
    else
        self.progress:SetText(tostring(math.floor(value)))
    end
end

function MapPinEnhancedStatusbarMixin:SetName(name)
    self.name:SetText(name)
end

---@param startColor colorRGBA
---@param endColor colorRGBA
function MapPinEnhancedStatusbarMixin:SetFillGradient(startColor, endColor)
    self.fillClip.canvas.fill:SetGradient("HORIZONTAL", startColor, endColor)
end

function MapPinEnhancedStatusbarMixin:SetProgressFormatter(formatter)
    self.progressFormatter = formatter
end

function MapPinEnhancedStatusbarMixin:OnLoad()
    self.name = self.labels.name
    self.progress = self.labels.progress
    self.labels:SetFrameLevel(self.fillClip.canvas:GetFrameLevel() + 1)
    self:UpdateLayout()
    self:OnValueChanged(self:GetValue())
end

function MapPinEnhancedStatusbarMixin:UpdateLayout()
    if not self.fillClip or not self.fillClip.canvas then
        return
    end
    local width = math.max(0, self:GetWidth() - 6)
    local height = math.max(0, self:GetHeight() - 6)
    self.fillClip.canvas:SetSize(width, height)
    -- Refresh both crops after layout, independently of texture load/show order.
    -- The two art regions have identical bounds, so progress reveals the same map.
    self.mapArt:UpdateCrop()
    self.fillClip.canvas.fillArt:UpdateCrop()
    self:UpdateFill()
end

function MapPinEnhancedStatusbarMixin:UpdateFill()
    -- Clip the fixed-size canvas geometrically so the moving edge cannot
    -- soften as it would when stretching a low-resolution reveal mask.
    if not self.fillClip or not self.fillClip.canvas then
        return
    end
    local fullWidth = math.max(0, self:GetWidth() - 6)
    local height = math.max(0, self:GetHeight() - 6)
    local min, max = self:GetMinMaxValues()
    local fraction = max > min and math.max(0, math.min(1, (self:GetValue() - min) / (max - min))) or 0
    local width = fullWidth * fraction
    self.fillClip:SetSize(math.max(0.01, width), height)
    self.fillClip:SetShown(width > 0 and height > 0)
end

function MapPinEnhancedStatusbarMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self.smoothValue = nil
    self.smoothTarget = nil
end
