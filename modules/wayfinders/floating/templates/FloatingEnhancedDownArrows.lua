---@class MapPinEnhancedWayfinderFloatingEnhancedDownArrowsTemplate : Frame
---@field one Texture
---@field two Texture
---@field three Texture
---@field active boolean?
---@field elapsed number?
MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin = {}

local CYCLE_DURATION = 0.9
local STAGGER = 0.15
local FADE_IN_DURATION = 0.15
local FADE_OUT_DURATION = 0.3

---@param elapsed number
---@param delay number
---@return number
local function GetPulseAlpha(elapsed, delay)
    local pulseElapsed = (elapsed - delay) % CYCLE_DURATION
    if pulseElapsed < FADE_IN_DURATION then
        return pulseElapsed / FADE_IN_DURATION
    end

    local fadeOutEnd = FADE_IN_DURATION + FADE_OUT_DURATION
    if pulseElapsed < fadeOutEnd then
        return 1 - ((pulseElapsed - FADE_IN_DURATION) / FADE_OUT_DURATION)
    end
    return 0
end

function MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.one:SetVertexColor(r, g, b, a)
    self.two:SetVertexColor(r, g, b, a)
    self.three:SetVertexColor(r, g, b, a)
end

function MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin:Reset()
    self.elapsed = 0
    self.one:SetAlpha(0)
    self.two:SetAlpha(0)
    self.three:SetAlpha(0)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin:SetActive(active)
    if self.active == active then return end
    self.active = active
    self:Reset()
    self:SetShown(active)
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedDownArrowsMixin:OnUpdate(elapsed)
    self.elapsed = ((self.elapsed or 0) + elapsed) % CYCLE_DURATION
    self.one:SetAlpha(GetPulseAlpha(self.elapsed, 0))
    self.two:SetAlpha(GetPulseAlpha(self.elapsed, STAGGER))
    self.three:SetAlpha(GetPulseAlpha(self.elapsed, STAGGER * 2))
end
