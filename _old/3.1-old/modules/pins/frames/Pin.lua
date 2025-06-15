---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Textures = MapPinEnhanced:GetModule("Textures")


---@class MapPinEnhancedBasePinSwirlTexture : Texture
---@field swirl AnimationGroup
---@field show AnimationGroup
---@field hide AnimationGroup

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup


---@class MapPinEnhancedBasePin : Frame, PropagateMouseMotion, PropagateMouseClicks
---@field background Texture
---@field highlight Texture
---@field icon Texture
---@field iconMask MaskTexture
---@field lockIcon Texture
---@field pinData pinData | nil
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field pulseTimer FunctionContainer | nil
---@field shadow Texture
---@field swirlTexture MapPinEnhancedBasePinSwirlTexture
---@field texture Texture
---@field title FontString
---@field titleFont string | nil
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field trackedTexture string
---@field untrackedTexture string
MapPinEnhancedBasePinMixin = {}


local CONSTANTS = MapPinEnhanced.CONSTANTS
function MapPinEnhancedBasePinMixin:SetPinIcon()
    if not self.pinData then
        return
    end
    if not self.pinData.texture then
        self.icon:Hide()
        return
    end
    if type(self.pinData.texture) ~= "number" then
        self.icon:RemoveMaskTexture(self.iconMask)
    else
        self.icon:AddMaskTexture(self.iconMask)
    end

    if (self.pinData.usesAtlas) then
        self.icon:SetAtlas(self.pinData.texture)
    else
        self.icon:SetTexture(self.pinData.texture)
    end
    self.icon:Show()
end

---Set the position of the title text
---@param position 'TOP' | 'BOTTOM' | 'LEFT' | 'RIGHT' | 'CENTER' | nil
---@param xOffset number
---@param yOffset number
function MapPinEnhancedBasePinMixin:SetTitlePosition(position, xOffset, yOffset)
    self.title:ClearAllPoints()
    if not position then
        return
    end

    local inversePosition = position == 'TOP' and 'BOTTOM' or
        position == 'BOTTOM' and 'TOP' or
        position == 'LEFT' and 'RIGHT' or
        position == 'RIGHT' and 'LEFT' or 'CENTER'

    self.title:SetPoint(inversePosition, self.texture, position, xOffset or 0, yOffset or 0)
    -- justify based on position
    self.title:SetJustifyH(
        position == 'LEFT' and 'RIGHT' or
        position == 'RIGHT' and 'LEFT' or 'CENTER'
    )
    self.title:SetJustifyV(
        position == 'TOP' and 'BOTTOM' or
        position == 'BOTTOM' and 'TOP' or 'MIDDLE'
    )
end

function MapPinEnhancedBasePinMixin:SetTitleFont(font)
    self.title:SetFontObject(font)
end

function MapPinEnhancedBasePinMixin:SetTitle(overrideTitle)
    if not self.pinData then
        return
    end
    if overrideTitle then
        self.pinData.title = overrideTitle
    end
    if self.pinData.title == "" then
        self.pinData.title = nil
    end
    local title = self.pinData.title or CONSTANTS.DEFAULT_PIN_NAME
    self.title:SetText(title)
end

function MapPinEnhancedBasePinMixin:Setup(pinData)
    if pinData then
        self.pinData = pinData
    end
    if not self.pinData then
        return
    end
    self.swirlTexture:Hide()
    self:SetPinColor(self.pinData.color) -- set default color
    self:SetTitle()
    self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    self:SetTitleFont(self.titleFont or "GameFontNormal")
    self:SetPinIcon()
    self:SetUntrackedTexture()
    self:SetLockState(self.pinData.lock)
end

function MapPinEnhancedBasePinMixin:SetLockState(isLock)
    if isLock then
        self.lockIcon:Show()
        self:SetTitlePosition(self.titlePosition, (self.titleXOffset or 0) + 10, (self.titleYOffset or 0) + 0)
    else
        self.lockIcon:Hide()
        self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    end
end

function MapPinEnhancedBasePinMixin:ShowPulseForSeconds(seconds)
    if self.pulseTimer then
        self.pulseTimer:Cancel()
    end
    self:ShowPulse()
    self.pulseTimer = C_Timer.NewTicker(seconds, function()
        self:HidePulse()
    end)
end

function MapPinEnhancedBasePinMixin:ShowPulse()
    self.pulseHighlight.pulse:Stop()
    self.pulseHighlight:Show()
    self.pulseHighlight.pulse:Play()
end

function MapPinEnhancedBasePinMixin:HidePulse()
    self.pulseHighlight:Hide()
end

function MapPinEnhancedBasePinMixin:ShowSwirl()
    self.swirlTexture:Hide()
    self.swirlTexture.swirl:Stop()
    self.swirlTexture.show:Stop()
    self.swirlTexture.hide:Stop()
    self.swirlTexture:Show()
    self.swirlTexture.swirl:Play()
    self.swirlTexture.show:Play()
end

function MapPinEnhancedBasePinMixin:HideSwirl()
    self.swirlTexture.hide:Play()
end

function MapPinEnhancedBasePinMixin:SetTrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.texture:SetTexture(self.trackedTexture)
end

function MapPinEnhancedBasePinMixin:SetUntrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.texture:SetTexture(self.untrackedTexture)
end

local DEFAULT_COLOR = CONSTANTS.DEFAULT_PIN_COLOR
---@param color string?
function MapPinEnhancedBasePinMixin:SetPinColor(color)
    if not color then
        color = DEFAULT_COLOR
    end
    local untrackedTexture = Textures:GetTexture("PinUntracked" .. color)
    local trackedTexture = Textures:GetTexture("PinTracked" .. color)
    assert(untrackedTexture, "Untracked texture not found")
    assert(trackedTexture, "Tracked texture not found")
    self.untrackedTexture = untrackedTexture
    self.trackedTexture = trackedTexture
    local pinColor = CONSTANTS.PIN_COLORS_BY_NAME[color]
    ---@type number, number, number, number?
    local r, g, b, a
    if pinColor then
        r, g, b, a = pinColor:GetRGBA()
    else
        r, g, b, a = 1, 1, 1, 1
    end
    local isSwirlPlaying = self.swirlTexture.swirl:IsPlaying()
    local isPulsePlaying = self.pulseHighlight.pulse:IsPlaying()
    self.swirlTexture:SetVertexColor(r, g, b, a)
    self.pulseHighlight:SetVertexColor(r, g, b, a)
    if isSwirlPlaying then
        self:ShowSwirl()
    end
    if isPulsePlaying then
        self:ShowPulseForSeconds(3)
    end
end
