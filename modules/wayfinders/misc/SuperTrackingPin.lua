---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedSuperTrackingPinTemplate : MapPinEnhancedBasePinTemplate
---@field data pinData?
MapPinEnhancedSuperTrackingPinMixin = {}

---@param data pinData
function MapPinEnhancedSuperTrackingPinMixin:ApplyData(data)
    self.data = data
    local scale = Options:GetOptionValue("Pins.MinimapScale") --[[@as number]]
    self:SetSize(22 * scale, 22 * scale)
    self:SetTracked(true)
    if not self:SetIconTexture(data.texture, data.usesAtlas) then
        self:SetIconTexture("Navigation-Tracked-Icon", true)
    end
    if GameTooltip:IsOwned(self) then self:OnEnter() end
end

function MapPinEnhancedSuperTrackingPinMixin:OnEnter()
    self:SetHovered(true)
    if not self.data then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine(self.data.title, 1, 1, 1, true)
    MapPinEnhanced:AddDescriptionToTooltip(self.data.description)
    GameTooltip:Show()
end

function MapPinEnhancedSuperTrackingPinMixin:OnLeave()
    self:SetHovered(false)
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedSuperTrackingPinMixin:Reset()
    MapPinEnhanced.HBDP:RemoveMinimapIcon(MapPinEnhanced, self)
    self:Hide()
    self:OnLeave()
    self:SetUntracked()
    self:SetIconTexture(nil)
    self:ClearAllPoints()
    self.data = nil
end
