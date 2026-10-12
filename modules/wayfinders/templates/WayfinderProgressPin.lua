---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedWayfinderProgressPin : Button
---@field pin Texture
---@field destinationPin MapPinEnhancedBasePinTemplate
---@field active boolean?
---@field entry WayfinderProgressEntry?
MapPinEnhancedWayfinderProgressPinMixin = {}

local PIN_SIZE = 16

---@param active boolean
function MapPinEnhancedWayfinderProgressPinMixin:SetActive(active)
    self.active = active
    local icon = self.entry and Pins.PIN_ICONS[Pins:ResolveIcon(self.entry.icon)]
    self.pin:SetTexture(icon and icon.icon)
    local destination = self.entry and self.entry.destination
    self.pin:SetShown(destination == nil)
    self.destinationPin:SetShown(destination ~= nil)
    self.destinationPin:SetColor(destination and destination.color)
    self.destinationPin:SetTracked(true)
    if destination then
        local hasIcon = self.destinationPin:SetIconTexture(destination.texture, destination.usesAtlas)
        if not hasIcon and destination.targetType == "blizzard" then
            self.destinationPin:SetIconTexture("Navigation-Tracked-Icon", true)
        end
    end
    local size = active and PIN_SIZE * 1.5 or PIN_SIZE
    self.destinationPin:SetSize(size, size)
    self.destinationPin:SetAlpha(active and 1 or 0.5)
    if active then
        self.pin:SetAlpha(1)
        self.pin:SetSize(PIN_SIZE * 1.5, PIN_SIZE * 1.5)
    else
        self.pin:SetAlpha(0.5)
        self.pin:SetSize(PIN_SIZE, PIN_SIZE)
    end
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
