---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinMixin : Frame
---@field icon Texture
---@field highlight Texture
---@field title FontString
---@field pinData pinData | nil
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field trackedTexture string
---@field untrackedTexture string
MapPinEnhancedBasePinMixin = {}




function MapPinEnhancedBasePinMixin:SetCustomTexture()
    -- TODO: this function is for using a custom texture that is placed on top of the base pin textures
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
    self.title:SetPoint(position, self.icon, position, xOffset, yOffset)
    -- justify based on position
    self.title:SetJustifyH(
        position == 'LEFT' and 'RIGHT' or
        position == 'RIGHT' and 'LEFT' or 'CENTER'
    )
    self.title:SetJustifyV(
        position == 'TOP' and 'BOTTOM' or
        position == 'BOTTOM' and 'TOP' or 'CENTER'
    )
end

function MapPinEnhancedBasePinMixin:SetTitle()
    if not self.pinData then
        return
    end
    local title = self.pinData.title
    self.title:SetText(title)
end

function MapPinEnhancedBasePinMixin:OnLoad()
    self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    self:SetUntrackedTexture()
end

local DEFAULT_COLOR = "Yellow"
function MapPinEnhancedBasePinMixin:SetTrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.icon:SetTexture(self.trackedTexture)
end

function MapPinEnhancedBasePinMixin:SetUntrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.icon:SetTexture(self.untrackedTexture)
end

function MapPinEnhancedBasePinMixin:UpdatePin()
    if not self.pinData then
        return
    end
    self:SetTitle()
    self:SetPinColor(DEFAULT_COLOR)
end

function MapPinEnhancedBasePinMixin:SetPinData(pinData)
    self.pinData = pinData
    self:UpdatePin()
end

---comment
---@param color string
function MapPinEnhancedBasePinMixin:SetPinColor(color)
    local untrackedTexture = MapPinEnhanced:GetTexture("PinUntracked" .. color)
    local trackedTexture = MapPinEnhanced:GetTexture("PinTracked" .. color)
    assert(untrackedTexture, "Untracked texture not found")
    assert(trackedTexture, "Tracked texture not found")
    self.untrackedTexture = untrackedTexture
    self.trackedTexture = trackedTexture
end
