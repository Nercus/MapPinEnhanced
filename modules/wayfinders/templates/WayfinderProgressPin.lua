---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedWayfinderProgressPin : Frame
---@field pin Texture
---@field active boolean?
---@field entry WayfinderProgressEntry?
MapPinEnhancedWayfinderProgressPinMixin = {}

local PIN_SIZE = 12
local DEFAULT_TEXTURE = MapPinEnhanced.assetsPath .. "\\navigation\\StepBlip.png"
local GLOW_TEXTURE = MapPinEnhanced.assetsPath .. "\\navigation\\StepBlipGlow.png"

---@param active boolean
function MapPinEnhancedWayfinderProgressPinMixin:SetActive(active)
    self.active = active
    if active then
        self.pin:SetAlpha(1)
        self.pin:SetTexture(GLOW_TEXTURE)
        self.pin:SetSize(PIN_SIZE * 1.5, PIN_SIZE * 1.5)
    else
        self.pin:SetAlpha(0.5)
        self.pin:SetTexture(DEFAULT_TEXTURE)
        self.pin:SetSize(PIN_SIZE, PIN_SIZE)
    end
end

function MapPinEnhancedWayfinderProgressPinMixin:OnLoad()
    self:SetMouseClickEnabled(false)
end

function MapPinEnhancedWayfinderProgressPinMixin:OnEnter()
    local entry = self.entry
    if not entry then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine(entry.title, entry.r, entry.g, entry.b)
    GameTooltip:AddLine(entry.instruction, 1, 1, 1, true)
    GameTooltip:AddLine(entry.location, 0.7, 0.7, 0.7, true)
    GameTooltip:Show()
end

function MapPinEnhancedWayfinderProgressPinMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedWayfinderProgressPinMixin:OnHide()
    self:OnLeave()
    self.pin:SetAlpha(self.active and 1 or 0.5)
end
