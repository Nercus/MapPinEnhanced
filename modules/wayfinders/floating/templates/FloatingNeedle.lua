---@class MapPinEnhancedWayfinderFloatingNeedleTemplate : Frame
---@field texture Texture
---@field fallbackTexture Texture
MapPinEnhancedWayfinderFloatingNeedleMixin = {}

function MapPinEnhancedWayfinderFloatingNeedleMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetColor(color)
    self.texture:SetVertexColor(color:GetRGBA())
    self.fallbackTexture:SetVertexColor(color:GetRGBA())
end

---@param fallback boolean
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetFallback(fallback)
    self.texture:SetShown(not fallback)
    self.fallbackTexture:SetShown(fallback)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetActive(active)
    if not active then
        self:SetRotation(0)
    end
    self:SetShown(active)
end

---@param rotation number
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetRotation(rotation)
    self.texture:SetRotation(rotation)
    -- Match Arrow's clockwise, 120-frame sheet while retaining continuous native clamping.
    local fullRotation = 2 * math.pi
    local frame = math.floor((-rotation % fullRotation) / fullRotation * 120 + 0.5) % 120
    local column = frame % 16
    local row = math.floor(frame / 16)
    self.fallbackTexture:SetTexCoord(column / 16, (column + 1) / 16, row / 8, (row + 1) / 8)
end
