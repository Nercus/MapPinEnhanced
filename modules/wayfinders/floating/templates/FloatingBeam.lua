---@class MapPinEnhancedWayfinderFloatingBeamTemplate : Frame
---@field line Texture
---@field blip MapPinEnhancedWayfinderFloatingBeamBlip
---@field active boolean?
MapPinEnhancedWayfinderFloatingBeamMixin = {}

---@class MapPinEnhancedWayfinderFloatingBeamBlip : Texture
---@field animation AnimationGroup

function MapPinEnhancedWayfinderFloatingBeamMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingBeamMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.line:SetGradient("VERTICAL", CreateColor(r, g, b, a), CreateColor(r, g, b, 0))
    self.blip:SetVertexColor(r, g, b, a)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingBeamMixin:SetActive(active)
    if self.active == active then return end
    self.active = active
    self:SetShown(active)
    if active then
        self.blip.animation:Play()
    else
        self.blip.animation:Stop()
        self.blip:SetAlpha(0)
    end
end
