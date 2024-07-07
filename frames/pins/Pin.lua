---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedBasePinMixin : Frame
---@field icon Texture
---@field highlight Texture
---@field customTexture Texture
---@field customTextureMask MaskTexture
---@field title FontString
---@field pinData pinData | nil
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field trackedTexture string
---@field untrackedTexture string
MapPinEnhancedBasePinMixin = {}




function MapPinEnhancedBasePinMixin:SetCustomTexture()
    if type(self.pinData.texture) ~= "number" then
        self.customTexture:RemoveMaskTexture(self.customTextureMask)
    else
        self.customTexture:AddMaskTexture(self.customTextureMask)
    end

    if (self.pinData.usesAtlas) then
        self.customTexture:SetAtlas(self.pinData.texture)
    else
        self.customTexture:SetTexture(self.pinData.texture)
    end
    self.customTexture:Show()
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
    print("MapPinEnhancedBasePinMixin:OnLoad")
    -- TODO: onload is not called for reused frames
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
    if not self.pinData or not self.pinData.color then
        self:SetPinColor(DEFAULT_COLOR)
    end
end

function MapPinEnhancedBasePinMixin:SetPinData(pinData)
    self.pinData = pinData
    self:UpdatePin()

    if self.pinData.texture then
        self:SetCustomTexture()
    end
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
