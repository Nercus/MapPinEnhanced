---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedBasePinTemplate : Frame
---@field background Texture
---@field highlight Texture
---@field icon Texture
---@field iconMask MaskTexture
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field shadow Texture
---@field texture Texture
---@field trackedTexture string
---@field untrackedTexture string
---@field tooltipFunction function | nil
---@field pinID UUID | nil
MapPinEnhancedBasePinMixin = {}

local DEFAULT_PIN_COLOR = "Yellow"
local UNTRACKED_PIN_TEXTURE = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntracked%s.png"
local TRACKED_PIN_TEXTURE = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTracked%s.png"


---@enum (key) PinColors
local PIN_COLORS_BY_NAME = {
    ["Yellow"] = CreateColorFromBytes(237, 179, 20, 1),
    ["Green"] = CreateColorFromBytes(96, 236, 29, 1),
    ["LightBlue"] = CreateColorFromBytes(132, 196, 237, 1),
    ["DarkBlue"] = CreateColorFromBytes(42, 93, 237, 1),
    ["Purple"] = CreateColorFromBytes(190, 139, 237, 1),
    ["Pink"] = CreateColorFromBytes(251, 109, 197, 1),
    ["Red"] = CreateColorFromBytes(235, 15, 14, 1),
    ["Orange"] = CreateColorFromBytes(237, 114, 63, 1),
    ["Pale"] = CreateColorFromBytes(235, 183, 139, 1),
}


function MapPinEnhancedBasePinMixin:SetPinIcon(icon, usesAtlas)
    if not icon then
        self.icon:Hide()
        return
    end
    if type(icon) ~= "number" then
        self.icon:RemoveMaskTexture(self.iconMask)
    else
        self.icon:AddMaskTexture(self.iconMask)
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

function MapPinEnhancedBasePinMixin:ShowPulseOnce()
    self.pulseHighlight.pulse:Stop()
    self.pulseHighlight:Show()
    self.pulseHighlight.pulse:SetToFinalAlpha(true)
    self.pulseHighlight.pulse:Play()
    self.pulseTimer = C_Timer.NewTimer(0.5, function()
        self.pulseHighlight.pulse:SetToFinalAlpha(false)
        self.pulseHighlight:Hide()
        self.pulseTimer = nil
    end)
end

function MapPinEnhancedBasePinMixin:HidePulse()
    self.pulseHighlight:Hide()
end

function MapPinEnhancedBasePinMixin:SetTracked()
    self.texture:SetTexture(self.trackedTexture)
    self:ShowPulseOnce()
end

function MapPinEnhancedBasePinMixin:SetUntracked()
    self.texture:SetTexture(self.untrackedTexture)
end

local DEFAULT_COLOR = DEFAULT_PIN_COLOR
---@param color PinColors
function MapPinEnhancedBasePinMixin:SetPinColor(color)
    if not color then
        color = DEFAULT_COLOR
    end
    local untrackedTexture = string.format(UNTRACKED_PIN_TEXTURE, color)
    local trackedTexture = string.format(TRACKED_PIN_TEXTURE, color)
    assert(untrackedTexture, "Untracked texture not found")
    assert(trackedTexture, "Tracked texture not found")
    self.untrackedTexture = untrackedTexture
    self.trackedTexture = trackedTexture
    local pinColor = PIN_COLORS_BY_NAME[color]
    ---@type number, number, number, number?
    local r, g, b, a
    if pinColor then
        r, g, b, a = pinColor:GetRGBA()
    else
        r, g, b, a = 1, 1, 1, 1
    end
    local isPulsePlaying = self.pulseHighlight.pulse:IsPlaying()
    self.pulseHighlight:SetVertexColor(r, g, b, a)
    if isPulsePlaying then
        self:ShowPulse()
    end
end

---@param tooltipFun fun(tooltip: GameTooltip)
function MapPinEnhancedBasePinMixin:UpdateTooltip(tooltipFun)
    -- pinData.tooltip is a function that sets the tooltip for the pin
    if not tooltipFun then
        self.tooltipFunction = nil
        return
    end
    self.tooltipFunction = tooltipFun
end

---@param pinID UUID | nil
function MapPinEnhancedBasePinMixin:SetPinID(pinID)
    self.pinID = pinID
end
