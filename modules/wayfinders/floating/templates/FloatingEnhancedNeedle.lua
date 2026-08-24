---@class MapPinEnhancedWayfinderFloatingEnhancedNeedleTemplate : Frame
---@field texture Texture
MapPinEnhancedWayfinderFloatingEnhancedNeedleMixin = {}

function MapPinEnhancedWayfinderFloatingEnhancedNeedleMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedNeedleMixin:SetColor(color)
    self.texture:SetVertexColor(color:GetRGBA())
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingEnhancedNeedleMixin:SetActive(active)
    if not active then
        self.texture:SetRotation(0)
    end
    self:SetShown(active)
end

---@param rotation number
function MapPinEnhancedWayfinderFloatingEnhancedNeedleMixin:SetRotation(rotation)
    self.texture:SetRotation(rotation)
end
