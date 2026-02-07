---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedBasePinTemplate : Frame
---@field shadow Texture
---@field background Texture
---@field highlight Texture
---@field outline Texture
---@field foreground Texture
---@field icon Texture
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field activeColor string | nil
---@field tooltipData PinTooltip | nil
---@field pinID UUID | nil
MapPinEnhancedBasePinMixin = {}


---@enum (key) PinColors
local PIN_COLORS_BY_NAME = {
    ["Red"] = CreateColor(0.867, 0.200, 0.200, 1),
    ["Orange"] = CreateColor(0.859, 0.529, 0.129, 1),
    ["Pale"] = CreateColor(0.898, 0.659, 0.369, 1),
    ["Yellow"] = CreateColor(0.949, 0.788, 0.149, 1),
    ["Green"] = CreateColor(0.404, 0.788, 0.263, 1),
    ["LightBlue"] = CreateColor(0.318, 0.757, 0.878, 1),
    ["DarkBlue"] = CreateColor(0.239, 0.239, 0.976, 1),
    ["Purple"] = CreateColor(0.549, 0.314, 0.886, 1),
    ["Pink"] = CreateColor(0.886, 0.427, 0.843, 1),
}

local UNTRACKED_FOREGROUND = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedCenterGray.png"
local TRACKED_FOREGROUND = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedGray.png"
local ICON_FOREGROUND = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinIconTesterNoCircle.png"

function MapPinEnhancedBasePinMixin:SetPinIcon(icon, usesAtlas)
    if not icon then
        self.icon:Hide()
        return
    end
    if (usesAtlas) then
        self.icon:SetAtlas(icon)
    else
        self.icon:SetTexture(icon)
    end
    self.icon:Show()
end

function MapPinEnhancedBasePinMixin:ShowPulse()
    self.pulseHighlight.pulse:Stop()
    self.pulseHighlight:Show()
    self.pulseHighlight.pulse:Play()
end

---@param seconds number
function MapPinEnhancedBasePinMixin:ShowPulseFor(seconds)
    self:ShowPulse()
    self.pulseTimer = C_Timer.After(seconds, function()
        self:HidePulse()
    end)
end

function MapPinEnhancedBasePinMixin:ShowPulseOnce()
    self:ShowPulseFor(0.6)
end

function MapPinEnhancedBasePinMixin:HidePulse()
    self.pulseHighlight:Hide()
end

---@param skipAnimation boolean?
function MapPinEnhancedBasePinMixin:SetTracked(skipAnimation)
    if self.icon:IsShown() then
        self.foreground:SetTexture(ICON_FOREGROUND)
        self.foreground:SetVertexColor(0.949, 0.788, 0.149, 1)
        self.outline:Hide()
    else
        self.foreground:SetTexture(UNTRACKED_FOREGROUND)
        self.outline:Show()
    end
    if skipAnimation then
        self.pulseHighlight.pulse:Stop()
        self.pulseHighlight:Hide()
    else
        self:ShowPulseOnce()
    end
end

function MapPinEnhancedBasePinMixin:SetUntracked()
    if self.icon:IsShown() then
        self.foreground:SetTexture(ICON_FOREGROUND)
        self.foreground:SetVertexColor(0.4980, 0.2902, 0.1843, 1)
        self.outline:Hide()
    else
        self.foreground:SetTexture(UNTRACKED_FOREGROUND)
        self.outline:Show()
    end
end

---@return ColorMixin?
function MapPinEnhancedBasePinMixin:GetColorValue()
    if not self.activeColor then
        return nil
    end
    local pinColor = PIN_COLORS_BY_NAME[self.activeColor]
    if not pinColor then
        return nil
    end
    return pinColor
end

---@param color PinColors
function MapPinEnhancedBasePinMixin:SetPinColor(color)
    if color == 'custom' then
        return
    end
    local pinColor = PIN_COLORS_BY_NAME[color]
    ---@type number, number, number, number?
    local r, g, b, a
    if pinColor then
        r, g, b, a = pinColor:GetRGBA()
    else
        r, g, b, a = 1, 1, 1, 1
    end
    self.foreground:SetVertexColor(r, g, b, a)
    self.pulseHighlight:SetVertexColor(r, g, b, a)
    self.activeColor = color
end

---@param tooltipData PinTooltip
function MapPinEnhancedBasePinMixin:UpdateTooltip(tooltipData)
    -- pinData.tooltip is a function that sets the tooltip for the pin
    if not tooltipData then return end
    self.tooltipData = tooltipData
end
