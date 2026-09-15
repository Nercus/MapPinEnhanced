---@class MapPinEnhancedWayfinderFloatingNeedleTemplate : Frame
---@field texture Texture
MapPinEnhancedWayfinderFloatingNeedleMixin = {}

function MapPinEnhancedWayfinderFloatingNeedleMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetColor(color)
    self.texture:SetVertexColor(color:GetRGBA())
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetActive(active)
    if not active then
        self.texture:SetRotation(0)
    end
    self:SetShown(active)
end

---@param rotation number
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetRotation(rotation)
    self.texture:SetRotation(rotation)
end
