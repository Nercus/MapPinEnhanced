---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWayfinderActionButton : Button
---@field icon Texture
---@field cooldown Cooldown
---@field unsubscribeCooldown fun()?
MapPinEnhancedWayfinderActionButtonMixin = {}

function MapPinEnhancedWayfinderActionButtonMixin:Setup()
    self:GetPushedTexture():SetDrawLayer("OVERLAY")
    self:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    self:SetPropagateMouseClicks(false)
end

function MapPinEnhancedWayfinderActionButtonMixin:OnPreClick(button)
    if button ~= "LeftButton" or not self:IsVisible() or self:GetAlpha() <= 0 then return end
    local instruction = self:GetParent() --[[@as MapPinEnhancedWayfinderInstructionTemplate]]
    MapPinEnhanced:GetModule("Navigation"):BeginActionEquipmentClick(instruction.preparedAction)
end

function MapPinEnhancedWayfinderActionButtonMixin:OnPostClick()
    MapPinEnhanced:GetModule("Navigation"):EndActionEquipmentClick()
end

function MapPinEnhancedWayfinderActionButtonMixin:UpdateCooldown()
    local instruction = self:GetParent() --[[@as MapPinEnhancedWayfinderInstructionTemplate]]
    local action = self:IsVisible() and self:GetAlpha() > 0 and instruction.preparedAction
    if action then
        local remaining, startTime, duration, rate = MapPinEnhanced:GetModule("Navigation"):GetActionCooldown(
            action.type, action.id)
        if remaining and remaining > 0 then
            self.cooldown:SetCooldown(startTime, duration, rate)
            return
        end
    end
    self.cooldown:Clear()
end

function MapPinEnhancedWayfinderActionButtonMixin:OnShow()
    self.unsubscribeCooldown = MapPinEnhanced:RegisterEventBucket({
        "SPELL_UPDATE_COOLDOWN", "SPELL_UPDATE_CHARGES", "BAG_UPDATE_COOLDOWN",
    }, function() self:UpdateCooldown() end)
    self:UpdateCooldown()
end

function MapPinEnhancedWayfinderActionButtonMixin:OnHide()
    if self.unsubscribeCooldown then self.unsubscribeCooldown() end
    self.unsubscribeCooldown = nil
    self.cooldown:Clear()
end

function MapPinEnhancedWayfinderActionButtonMixin:OnEnter()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionEnter(self)
end

function MapPinEnhancedWayfinderActionButtonMixin:OnLeave()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionLeave()
end
