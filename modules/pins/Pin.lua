-- Template: file://./Pin.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SwirlTexture : Texture
---@field swirl AnimationGroup
---@field show AnimationGroup
---@field hide AnimationGroup


---@class MapPinEnhancedBasePinMixin : Frame, PropagateMouseMotion, PropagateMouseClicks
---@field background Texture
---@field highlight Texture
---@field shadow Texture
---@field lockIcon Texture
---@field texture Texture
---@field icon Texture
---@field iconMask MaskTexture
---@field title FontString
---@field pinData pinData | nil
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field titleFont string | nil
---@field trackedTexture string
---@field untrackedTexture string
---@field swirlTexture SwirlTexture
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
    self:SetPinColor(self.pinData.color) -- set default color
    self:SetTitle()
    self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    self:SetTitleFont(self.titleFont or "GameFontNormal")
    self:SetPinIcon()
    self:SetUntrackedTexture()
    self:SetLockState(self.pinData.lock)
    self.swirlTexture:Hide()
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

function MapPinEnhancedBasePinMixin:ShowSwirlForSeconds(seconds)
    self:ShowSwirl()
    C_Timer.After(seconds, function()
        self:HideSwirl()
    end)
end

function MapPinEnhancedBasePinMixin:ShowSwirl()
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
    local untrackedTexture = MapPinEnhanced:GetTexture("PinUntracked" .. color)
    local trackedTexture = MapPinEnhanced:GetTexture("PinTracked" .. color)
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
    self.swirlTexture:SetVertexColor(r, g, b, a)
end
