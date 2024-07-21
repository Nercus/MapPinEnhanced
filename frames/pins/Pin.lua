---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinMixin : Frame, PropagateMouseMotion, PropagateMouseClicks
---@field background Texture
---@field highlight Texture
---@field shadow Texture
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
MapPinEnhancedBasePinMixin = {}


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
    local title = self.pinData.title
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

local DEFAULT_COLOR = "Yellow"
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
end
