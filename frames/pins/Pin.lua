---@class MapPinEnhancedBasePinMixin : Frame
---@field icon Texture
---@field highlight Texture
---@field title FontString
---@field pinData pinData | nil
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
MapPinEnhancedBasePinMixin = {}


function MapPinEnhancedBasePinMixin:OverrideTexture()
    ---@type pinData
    local pinData = self.pinData
    if (pinData.texture) then
        if (pinData.usesAtlas) then
            self.icon:SetAtlas(pinData.texture)
            return
        end
        self.icon:SetTexture(pinData.texture)
    end
end

---Set the position of the title text
---@param position 'TOP' | 'BOTTOM' | 'LEFT' | 'RIGHT' | 'CENTER'
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
end

function MapPinEnhancedBasePinMixin:SetTracked()
    self:SetAlpha(1)
end

function MapPinEnhancedBasePinMixin:SetUntracked()
    self:SetAlpha(0.5)
end

function MapPinEnhancedBasePinMixin:UpdatePin()
    if not self.pinData then
        return
    end
    self:OverrideTexture()
    self:SetTitle()
end

function MapPinEnhancedBasePinMixin:SetPinData(pinData)
    self.pinData = pinData
    self:UpdatePin()
end
