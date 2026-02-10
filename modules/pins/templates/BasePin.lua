---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedBasePinTemplate : Frame
---@field shadow Texture -- static shadow
---@field background Texture -- static blackbackground
---@field highlight Texture -- hover highlight
---@field outline Texture -- an outline texture to show when the pin is untracked
---@field foreground Texture -- the main texture that is colored and changes when an icon is set
---@field icon Texture -- the icon texture that is shown when an icon is set
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field activeColor string | nil
---@field tooltipData PinTooltip | nil
---@field pinID UUID | nil
---@field color ColorMixin | nil
---@field tracked boolean
---@field iconVisible boolean
MapPinEnhancedBasePinMixin = {}

local assetsPath = MapPinEnhanced.assetsPath

local DEFAULT_TRACKED_COLOR = CreateColor(0.949, 0.788, 0.149, 1)
local DEFAULT_UNTRACKED_COLOR = CreateColor(0.482, 0.314, 0.075, 1)

local FOREGROUND_ICON = assetsPath .. "\\pins\\PinForegroundIcon.png"
local FOREGROUND_TRACKED = assetsPath .. "\\pins\\PinForegroundTracked.png"
local FOREGROUND_UNTRACKED = assetsPath .. "\\pins\\PinForegroundUntracked.png"


---@param icon string? texture path or atlas name
---@param usesAtlas boolean? if true, the icon parameter is an atlas name, otherwise it is a texture path
---@param offset {x: number, y: number}? optional offset for the icon, if not set, it will be 0,0
---@param scale number? optional scale for the icon, if not set, it will be 1
function MapPinEnhancedBasePinMixin:SetIcon(icon, usesAtlas, offset, scale)
    if not icon then
        self.icon:Hide()
        self.iconVisible = false
        return
    end
    if (usesAtlas) then
        self.icon:SetAtlas(icon)
    else
        self.icon:SetTexture(icon)
    end
    self.icon:ClearAllPoints()
    if offset then
        self.icon:SetPoint("CENTER", offset.x, offset.y)
    else
        self.icon:SetPoint("CENTER", 0, 0)
    end
    if scale then
        self.icon:SetScale(scale)
    else
        self.icon:SetScale(1)
    end

    self.icon:Show()
    self.iconVisible = true
    if self.tracked then
        self:SetTextureColor(DEFAULT_TRACKED_COLOR)
    else
        self:SetTextureColor(DEFAULT_UNTRACKED_COLOR)
    end
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

function MapPinEnhancedBasePinMixin:SetTrackedTexture()
    local iconVisible = self.iconVisible
    local foreGroundTexture = iconVisible and FOREGROUND_ICON or FOREGROUND_TRACKED

    self.foreground:SetTexture(foreGroundTexture)
    self.outline:Hide()

    if iconVisible then
        self:SetTextureColor(DEFAULT_TRACKED_COLOR)
    end
end

function MapPinEnhancedBasePinMixin:SetUntrackedTexture()
    local iconVisible = self.iconVisible
    local foreGroundTexture = iconVisible and FOREGROUND_ICON or FOREGROUND_UNTRACKED
    self.foreground:SetTexture(foreGroundTexture)
    self.outline:Show()

    if iconVisible then
        self:SetTextureColor(DEFAULT_UNTRACKED_COLOR)
    end
end

function MapPinEnhancedBasePinMixin:UpdateTextureState()
    if self.tracked then
        self:SetTrackedTexture()
    else
        self:SetUntrackedTexture()
    end
end

---@param skipAnimation boolean?
function MapPinEnhancedBasePinMixin:SetTracked(skipAnimation)
    self.tracked = true
    self:SetTrackedTexture()
    if skipAnimation then
        self.pulseHighlight.pulse:Stop()
        self.pulseHighlight:Hide()
    else
        self:ShowPulseOnce()
    end
end

function MapPinEnhancedBasePinMixin:SetUntracked()
    self.tracked = false
    self:SetUntrackedTexture()
end

---@param color ColorMixin
function MapPinEnhancedBasePinMixin:SetTextureColor(color)
    if not color then return end
    if self.color and self.color:IsEqualTo(color) then return end
    self.color = color
    local r, g, b, a = color:GetRGBA()
    self.foreground:SetVertexColor(r, g, b, a)
    self.pulseHighlight:SetVertexColor(r, g, b, a)
    self:UpdateTextureState()
end

---@param color ColorMixin
function MapPinEnhancedBasePinMixin:SetColor(color)
    self:SetIcon(nil)
    self:SetTextureColor(color)
end

---@param tooltipData PinTooltip
function MapPinEnhancedBasePinMixin:UpdateTooltip(tooltipData)
    -- pinData.tooltip is a function that sets the tooltip for the pin
    if not tooltipData then return end
    self.tooltipData = tooltipData
end
