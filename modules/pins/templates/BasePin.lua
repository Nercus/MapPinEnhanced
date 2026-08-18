---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedBasePinKeyValues
---@field hideShadow boolean
---@field hideHighlight boolean

---@class MapPinEnhancedBasePinTemplate : Frame, MapPinEnhancedBasePinKeyValues
---@field shadow Texture -- static shadow
---@field background Texture -- static blackbackground
---@field highlight Texture -- hover highlight
---@field outline Texture -- the pin outline texture
---@field foreground Texture -- the colored pin foreground texture
---@field icon Texture -- the icon texture that is shown when an icon is set
---@field lock Texture -- the lock texture that is shown when the pin is locked
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field tooltipData PinTooltip | nil
---@field pin MapPinEnhancedPinMixin | nil
---@field pinID UUID | nil
---@field standardColor ColorMixin
---@field iconConfig PinIcon | nil
---@field styleMode BasePinStyleMode
---@field tracked boolean
MapPinEnhancedBasePinMixin = {}

local assetsPath = MapPinEnhanced.assetsPath

local DEFAULT_TRACKED_COLOR = CreateColor(0.949, 0.788, 0.149, 1)
local DEFAULT_UNTRACKED_COLOR = CreateColor(0.482, 0.314, 0.075, 1)

local BACKGROUND_STANDARD = assetsPath .. "\\pins\\PinBackground.png"
local FOREGROUND_ICON = assetsPath .. "\\pins\\PinForegroundIcon.png"
local FOREGROUND_TRACKED = assetsPath .. "\\pins\\PinForegroundTracked.png"
local FOREGROUND_UNTRACKED = assetsPath .. "\\pins\\PinForegroundUntracked.png"
local OUTLINE_CONFIGURED_ICON = assetsPath .. "\\pins\\PinOutlineConfiguredIcon.png"
local OUTLINE_UNTRACKED = assetsPath .. "\\pins\\PinOutlineUntracked.png"
local GENERIC_ICON_SIZE = 20

---@alias BasePinStyleMode "standard" | "configuredIcon" | "genericIcon"
local STYLE_STANDARD = "standard"
local STYLE_CONFIGURED_ICON = "configuredIcon"
local STYLE_GENERIC_ICON = "genericIcon"

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICONS = Pins.PIN_ICONS

---@param texture Texture
---@param color ColorMixin
local function SetVertexColor(texture, color)
    texture:SetVertexColor(color:GetRGBA())
end

---@param color any
---@return boolean
local function IsColor(color)
    return type(color) == "table" and type(color.GetRGBA) == "function"
end

function MapPinEnhancedBasePinMixin:ResetIconGeometry()
    self.icon:ClearAllPoints()
    self.icon:SetPoint("CENTER", 0, 0)
    self.icon:SetSize(GENERIC_ICON_SIZE, GENERIC_ICON_SIZE)
    self.icon:SetScale(1)
    self.icon:SetTexCoord(0, 1, 0, 1)
    self.icon:SetVertexColor(1, 1, 1, 1)
end

function MapPinEnhancedBasePinMixin:ClearIconTexture()
    self:ResetIconGeometry()
    self.icon:SetTexture(nil)
    self.icon:Hide()
    self.iconConfig = nil
end

---@return ColorMixin
function MapPinEnhancedBasePinMixin:GetActiveStyleColor()
    if self.styleMode == STYLE_STANDARD then
        return self.standardColor or DEFAULT_TRACKED_COLOR
    end

    if not self.tracked then
        return DEFAULT_UNTRACKED_COLOR
    end

    local configuredColor = self.iconConfig and self.iconConfig.color
    if self.styleMode == STYLE_CONFIGURED_ICON and IsColor(configuredColor) then
        return configuredColor
    end

    return DEFAULT_TRACKED_COLOR
end

function MapPinEnhancedBasePinMixin:ApplyStandardStyle()
    local activeColor = self:GetActiveStyleColor()
    self.background:SetTexture(BACKGROUND_STANDARD)
    self.background:Show()
    self.outline:SetTexture(OUTLINE_UNTRACKED)
    self.outline:SetShown(not self.tracked)
    SetVertexColor(self.outline, DEFAULT_UNTRACKED_COLOR)
    self.foreground:SetTexture(self.tracked and FOREGROUND_TRACKED or FOREGROUND_UNTRACKED)
    self.foreground:Show()
    SetVertexColor(self.foreground, activeColor)
    self.icon:Hide()
end

function MapPinEnhancedBasePinMixin:ApplyConfiguredIconStyle()
    local activeColor = self:GetActiveStyleColor()
    self.background:SetTexture(nil)
    self.background:Hide()
    self.outline:SetTexture(OUTLINE_CONFIGURED_ICON)
    self.outline:Show()
    SetVertexColor(self.outline, activeColor)
    self.foreground:SetTexture(nil)
    self.foreground:Hide()
    self.icon:SetSize(19, 19)
    self.icon:Show()
end

function MapPinEnhancedBasePinMixin:ApplyGenericIconStyle()
    local activeColor = self:GetActiveStyleColor()
    self.background:SetTexture(BACKGROUND_STANDARD)
    self.background:Show()
    self.outline:SetTexture(OUTLINE_UNTRACKED)
    self.outline:SetShown(not self.tracked)
    SetVertexColor(self.outline, DEFAULT_UNTRACKED_COLOR)
    self.foreground:SetTexture(FOREGROUND_ICON)
    self.foreground:Show()
    SetVertexColor(self.foreground, activeColor)
    self.icon:Show()
end

function MapPinEnhancedBasePinMixin:ApplyStyle()
    if self.styleMode == STYLE_CONFIGURED_ICON then
        self:ApplyConfiguredIconStyle()
    elseif self.styleMode == STYLE_GENERIC_ICON then
        self:ApplyGenericIconStyle()
    else
        self:ApplyStandardStyle()
    end

    local activeColor = self:GetActiveStyleColor()
    SetVertexColor(self.pulseHighlight, activeColor)
    SetVertexColor(self.highlight, activeColor)
end

---@param icon string|number? texture path or atlas name
---@param usesAtlas boolean? if true, the icon parameter is an atlas name, otherwise it is a texture path
---@param offset {x: number, y: number}? optional offset for the icon, if not set, it will be 0,0
---@param scale number? optional scale for the icon, if not set, it will be 1
function MapPinEnhancedBasePinMixin:SetIconTexture(icon, usesAtlas, offset, scale)
    local pinConfig = PIN_ICONS[icon]
    if pinConfig then
        usesAtlas = pinConfig.usesAtlas
        offset = pinConfig.offset
        scale = pinConfig.scale
    end

    if not icon then
        self.styleMode = STYLE_STANDARD
        self:ClearIconTexture()
        self:ApplyStyle()
        return
    end

    self:ResetIconGeometry()
    if usesAtlas then
        self.icon:SetAtlas(icon, pinConfig ~= nil)
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
    self.iconConfig = pinConfig
    self.styleMode = pinConfig and STYLE_CONFIGURED_ICON or STYLE_GENERIC_ICON
    self:ApplyStyle()
end

function MapPinEnhancedBasePinMixin:ShowPulse()
    self.pulseHighlight.pulse:Stop()
    self.pulseHighlight:Show()
    self.pulseHighlight.pulse:Play()
end

local loopDuration = 0.85

---@param repeats number
function MapPinEnhancedBasePinMixin:ShowPulseLoops(repeats)
    self:ShowPulse()
    local seconds = repeats * loopDuration
    self.pulseTimer = C_Timer.After(seconds, function()
        self:HidePulse()
    end)
end

function MapPinEnhancedBasePinMixin:ShowPulseOnce()
    self:ShowPulseLoops(1)
end

function MapPinEnhancedBasePinMixin:HidePulse()
    self.pulseHighlight.pulse:Stop()
    self.pulseHighlight:Hide()
end

---@param skipAnimation boolean?
function MapPinEnhancedBasePinMixin:SetTracked(skipAnimation)
    self.tracked = true
    self:ApplyStyle()
    if skipAnimation then
        self.pulseHighlight.pulse:Stop()
        self.pulseHighlight:Hide()
    else
        self:ShowPulseOnce()
    end
end

function MapPinEnhancedBasePinMixin:SetUntracked()
    self.tracked = false
    self:HidePulse()
    self:ApplyStyle()
end

---@param color PinColor?
function MapPinEnhancedBasePinMixin:SetColor(color)
    if not color then
        color = Pins.DEFAULT_COLOR
    end
    local colorValue = PIN_COLORS_BY_NAME[color] or DEFAULT_TRACKED_COLOR
    self.standardColor = colorValue
    self:SetIconTexture(nil)
end

---@param tooltipData PinTooltip
function MapPinEnhancedBasePinMixin:UpdateTooltip(tooltipData)
    -- pinData.tooltip is a function that sets the tooltip for the pin
    if not tooltipData then return end
    self.tooltipData = tooltipData
end

function MapPinEnhancedBasePinMixin:SetLock(lock)
    self.lock:SetShown(lock)
end

function MapPinEnhancedBasePinMixin:OnLoad()
    self.standardColor = PIN_COLORS_BY_NAME[Pins.DEFAULT_COLOR] or DEFAULT_TRACKED_COLOR
    self.styleMode = STYLE_STANDARD
    self.tracked = false
    self:ClearIconTexture()
    self:ApplyStyle()
    self:HidePulse()

    if self.hideShadow then
        self.shadow:Hide()
    end

    if self.hideHighlight then
        self.highlight:Hide()
    end
end
