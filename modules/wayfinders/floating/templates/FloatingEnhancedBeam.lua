---@class MapPinEnhancedWayfinderFloatingEnhancedBeamTemplate : Frame
---@field line Texture
---@field glow Texture
---@field active boolean?
---@field elapsed number?
MapPinEnhancedWayfinderFloatingEnhancedBeamMixin = {}

local TRAVEL_DURATION = 1.25
local FADE_DURATION = 0.15
local PAUSE_DURATION = 0.4
local CYCLE_DURATION = TRAVEL_DURATION + PAUSE_DURATION
local HEIGHT = 250

---@param value number
---@return number
local function Clamp01(value)
    if value < 0 then return 0 end
    if value > 1 then return 1 end
    return value
end

function MapPinEnhancedWayfinderFloatingEnhancedBeamMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedBeamMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.line:SetGradient("VERTICAL", CreateColor(r, g, b, a), CreateColor(r, g, b, 0))
    self.glow:SetVertexColor(r, g, b, a)
end

function MapPinEnhancedWayfinderFloatingEnhancedBeamMixin:Reset()
    self.elapsed = 0
    self.glow:SetAlpha(0)
    self.glow:ClearAllPoints()
    self.glow:SetPoint("CENTER", self, "BOTTOM", 0, 0)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingEnhancedBeamMixin:SetActive(active)
    if self.active == active then return end
    self.active = active
    self:Reset()
    self:SetShown(active)
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedBeamMixin:OnUpdate(elapsed)
    self.elapsed = ((self.elapsed or 0) + elapsed) % CYCLE_DURATION
    if self.elapsed >= TRAVEL_DURATION then
        self.glow:SetAlpha(0)
        return
    end

    local progress = self.elapsed / TRAVEL_DURATION
    ---@type number
    local alpha
    if self.elapsed < FADE_DURATION then
        alpha = self.elapsed / FADE_DURATION
    elseif self.elapsed > TRAVEL_DURATION - FADE_DURATION then
        alpha = (TRAVEL_DURATION - self.elapsed) / FADE_DURATION
    else
        alpha = 1
    end

    self.glow:SetAlpha(Clamp01(alpha))
    self.glow:ClearAllPoints()
    self.glow:SetPoint("CENTER", self, "BOTTOM", 0, HEIGHT * progress)
end
