---@class MapPinEnhancedWayfinderFloatingEnhancedCaretsTemplate : Frame
---@field left Texture
---@field right Texture
---@field active boolean?
---@field elapsed number?
MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin = {}

local GAP = 5
local TRAVEL_DISTANCE = 8
local TRAVEL_DURATION = 0.6
local RESET_HOLD_DURATION = 0.15
local FADE_IN_DURATION = 0.15
local CYCLE_DURATION = TRAVEL_DURATION + RESET_HOLD_DURATION + FADE_IN_DURATION

---@param progress number
---@return number
local function EaseOutCubic(progress)
    local inverse = 1 - progress
    return 1 - inverse * inverse * inverse
end

function MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.left:SetVertexColor(r, g, b, a)
    self.right:SetVertexColor(r, g, b, a)
end

function MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin:Reset()
    self.elapsed = 0
    self.left:ClearAllPoints()
    self.left:SetPoint("RIGHT", self, "LEFT", -GAP, 0)
    self.left:SetAlpha(1)
    self.right:ClearAllPoints()
    self.right:SetPoint("LEFT", self, "RIGHT", GAP, 0)
    self.right:SetAlpha(1)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin:SetActive(active)
    if self.active == active then return end
    self.active = active
    self:Reset()
    self:SetShown(active)
end

---@param elapsed number
function MapPinEnhancedWayfinderFloatingEnhancedCaretsMixin:OnUpdate(elapsed)
    self.elapsed = ((self.elapsed or 0) + elapsed) % CYCLE_DURATION
    local offset = 0
    local alpha = 0

    if self.elapsed < TRAVEL_DURATION then
        local progress = self.elapsed / TRAVEL_DURATION
        offset = TRAVEL_DISTANCE * EaseOutCubic(progress)
        alpha = 1 - progress
    elseif self.elapsed >= TRAVEL_DURATION + RESET_HOLD_DURATION then
        local fadeElapsed = self.elapsed - TRAVEL_DURATION - RESET_HOLD_DURATION
        alpha = math.min(1, fadeElapsed / FADE_IN_DURATION)
    end

    self.left:SetAlpha(alpha)
    self.left:ClearAllPoints()
    self.left:SetPoint("RIGHT", self, "LEFT", -GAP - offset, 0)
    self.right:SetAlpha(alpha)
    self.right:ClearAllPoints()
    self.right:SetPoint("LEFT", self, "RIGHT", GAP + offset, 0)
end
