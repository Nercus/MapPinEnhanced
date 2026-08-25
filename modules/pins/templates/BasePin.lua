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
---@field iconMask MaskTexture -- the diamond mask applied to unconfigured outline artwork
---@field lock Texture -- the lock texture that is shown when the pin is locked
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field tooltipData PinTooltip | nil
---@field pin MapPinEnhancedPinMixin | nil
---@field pinID UUID | nil
---@field standardColor ColorMixin
---@field iconConfig PinIcon | nil
---@field iconUsesAtlas boolean | nil
---@field renderMode BasePinRenderMode
---@field styleMode PinStyleMode
---@field iconMaskApplied boolean
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
local FALLBACK_NAVIGATION_ATLAS = "Navigation-Tracked-Icon"


---@alias BasePinRenderMode "standard" | "pinIcon" | "outlineIcon"
local STYLE_STANDARD = "standard"
local STYLE_PIN_ICON = "pinIcon"
local STYLE_OUTLINE_ICON = "outlineIcon"

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


local BASE_PIN_SIZE = 30
local ICON_SIZE_RATIO = 16 / BASE_PIN_SIZE
local OUTLINE_ICON_SIZE_RATIO = 19 / BASE_PIN_SIZE
local ICON_MASK_SIZE_RATIO = 16 / BASE_PIN_SIZE
local LOCK_SIZE_RATIO = 32 / BASE_PIN_SIZE
function MapPinEnhancedBasePinMixin:UpdateRegionSizes()
    local pinSize = math.min(self:GetWidth(), self:GetHeight())
    if pinSize <= 0 then return end

    local iconSizeRatio = self.renderMode == STYLE_OUTLINE_ICON and OUTLINE_ICON_SIZE_RATIO or ICON_SIZE_RATIO
    local iconSize = pinSize * iconSizeRatio
    local iconMaskSize = pinSize * ICON_MASK_SIZE_RATIO
    local lockSize = pinSize * LOCK_SIZE_RATIO
    self.icon:SetSize(iconSize, iconSize)
    self.iconMask:SetSize(iconMaskSize, iconMaskSize)
    self.lock:SetSize(lockSize, lockSize)
end

function MapPinEnhancedBasePinMixin:OnSizeChanged()
    self:UpdateRegionSizes()
end

function MapPinEnhancedBasePinMixin:ResetIconGeometry()
    self.icon:ClearAllPoints()
    self.icon:SetPoint("CENTER", 0, 0)
    self:UpdateRegionSizes()
    self.icon:SetScale(1)
    self.icon:SetTexCoord(0, 1, 0, 1)
    self.icon:SetVertexColor(1, 1, 1, 1)
end

function MapPinEnhancedBasePinMixin:ClearIconTexture()
    self:SetIconMaskEnabled(false)
    self:ResetIconGeometry()
    self.icon:SetTexture(nil)
    self.icon:Hide()
    self.iconConfig = nil
    self.iconUsesAtlas = nil
end

---@param enabled boolean
function MapPinEnhancedBasePinMixin:SetIconMaskEnabled(enabled)
    if enabled and not self.iconMaskApplied then
        self.icon:AddMaskTexture(self.iconMask)
        self.iconMaskApplied = true
    elseif not enabled and self.iconMaskApplied then
        self.icon:RemoveMaskTexture(self.iconMask)
        self.iconMaskApplied = false
    end
end

---@return ColorMixin
function MapPinEnhancedBasePinMixin:GetActiveStyleColor()
    if self.renderMode == STYLE_STANDARD then
        return self.standardColor or DEFAULT_TRACKED_COLOR
    end

    if not self.tracked then
        return DEFAULT_UNTRACKED_COLOR
    end

    local configuredColor = self.iconConfig and self.iconConfig.color
    if self.renderMode == STYLE_OUTLINE_ICON and IsColor(configuredColor) then
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

function MapPinEnhancedBasePinMixin:ApplyOutlineIconStyle()
    local activeColor = self:GetActiveStyleColor()
    self.background:SetTexture(nil)
    self.background:Hide()
    self.outline:SetTexture(OUTLINE_CONFIGURED_ICON)
    self.outline:Show()
    SetVertexColor(self.outline, activeColor)
    self.foreground:SetTexture(nil)
    self.foreground:Hide()
    self.icon:Show()
end

function MapPinEnhancedBasePinMixin:ApplyPinIconStyle()
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
    self:UpdateRegionSizes()
    if self.renderMode == STYLE_OUTLINE_ICON then
        self:ApplyOutlineIconStyle()
    elseif self.renderMode == STYLE_PIN_ICON then
        self:ApplyPinIconStyle()
    else
        self:ApplyStandardStyle()
    end

    local activeColor = self:GetActiveStyleColor()
    SetVertexColor(self.pulseHighlight, activeColor)
    SetVertexColor(self.highlight, activeColor)
end

---@param styleMode PinStyleMode
function MapPinEnhancedBasePinMixin:SetStyleMode(styleMode)
    assert(styleMode == Pins.STYLE_MODE_PIN or styleMode == Pins.STYLE_MODE_OUTLINE,
        "MapPinEnhancedBasePinMixin:SetStyleMode: invalid style mode")

    self.styleMode = styleMode
    if self.renderMode ~= STYLE_STANDARD then
        if styleMode == Pins.STYLE_MODE_OUTLINE then
            self.renderMode = STYLE_OUTLINE_ICON
        else
            self.renderMode = STYLE_PIN_ICON
        end
        self:SetIconMaskEnabled(not self.iconUsesAtlas)
    end
    self:ApplyStyle()
end

---@param icon string|number
---@param usesAtlas boolean?
---@param pinConfig PinIcon?
---@return boolean
local function IsValidIcon(icon, usesAtlas, pinConfig)
    if not usesAtlas then return true end
    if type(icon) ~= "string" then return false end
    if pinConfig then return true end
    if not C_Texture or not C_Texture.GetAtlasInfo then return true end
    return C_Texture.GetAtlasInfo(icon) ~= nil
end

---@param icon string|number? texture path or atlas name
---@param usesAtlas boolean? if true, the icon parameter is an atlas name, otherwise it is a texture path
---@param offset {x: number, y: number}? optional offset for the icon, if not set, it will be 0,0
---@param scale number? optional scale for the icon, if not set, it will be 1
function MapPinEnhancedBasePinMixin:SetIconTexture(icon, usesAtlas, offset, scale)
    ---@type PinIcon | nil
    local pinConfig = PIN_ICONS[icon]
    if pinConfig then
        usesAtlas = pinConfig.usesAtlas
        offset = pinConfig.offset
        scale = pinConfig.scale
    end

    if icon and not IsValidIcon(icon, usesAtlas, pinConfig) then
        icon = nil
        pinConfig = nil
    end

    if not icon and self.styleMode == Pins.STYLE_MODE_OUTLINE then
        icon = FALLBACK_NAVIGATION_ATLAS
        usesAtlas = true
        offset = nil
        scale = nil
        pinConfig = PIN_ICONS[icon]
    end

    if not icon then
        self.renderMode = STYLE_STANDARD
        self:ClearIconTexture()
        self:ApplyStyle()
        return
    end

    self:ResetIconGeometry()
    if usesAtlas then
        self.icon:SetAtlas(icon, pinConfig ~= nil)
    else
        self.icon:SetTexture(icon)
        if not self.icon:GetTexture() then
            if self.styleMode == Pins.STYLE_MODE_OUTLINE then
                self:SetIconTexture(nil)
            else
                self.renderMode = STYLE_STANDARD
                self:ClearIconTexture()
                self:ApplyStyle()
            end
            return
        end
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
    self.iconUsesAtlas = usesAtlas == true
    if self.styleMode == Pins.STYLE_MODE_OUTLINE then
        self.renderMode = STYLE_OUTLINE_ICON
    else
        self.renderMode = STYLE_PIN_ICON
    end
    self:SetIconMaskEnabled(not self.iconUsesAtlas)
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
    self.styleMode = Pins.STYLE_MODE_PIN
    self.renderMode = STYLE_STANDARD
    self.iconMaskApplied = false
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
