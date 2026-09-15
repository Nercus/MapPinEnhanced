---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderActionVisual : Frame
---@field icon Texture
---@field cooldown Cooldown

---@class MapPinEnhancedWayfinderActionButton : Button
---@field icon Texture
---@field cooldown Cooldown

---@class MapPinEnhancedWayfinderInstructionTemplate : Frame
---@field text FontString
---@field onMenu fun(owner: Frame)?
---@field actionButton MapPinEnhancedWayfinderActionButton
---@field actionBlocker MapPinEnhancedWayfinderActionVisual
---@field refreshCooldown fun()?
---@field reconcileAfterCombat fun()?
---@field step WayfinderStepData?
---@field preparedAction WayfinderDesiredAction?
MapPinEnhancedWayfinderInstructionMixin = {}

local FALLBACK_ACTION_ICON = "Interface/Icons/INV_Misc_QuestionMark"

---@param action WayfinderDesiredAction
---@return number|string
local function GetActionIcon(action)
    if action.type == "spell" then
        return C_Spell.GetSpellTexture(action.id) or FALLBACK_ACTION_ICON
    end
    return C_Item.GetItemIconByID(action.id) or FALLBACK_ACTION_ICON
end

---@param cooldown Cooldown
---@param action WayfinderDesiredAction?
local function SetActionCooldown(cooldown, action)
    cooldown:Clear()
    if not action then return end
    if action.type == "spell" and C_Spell and C_Spell.GetSpellCooldown then
        local info = C_Spell.GetSpellCooldown(action.id)
        if info and not MapPinEnhanced:IsSecretTable(info) and type(info.startTime) == "number" and
            type(info.duration) == "number" then
            cooldown:SetCooldown(info.startTime, info.duration, info.modRate)
        end
        return
    end
    if C_Item and C_Item.GetItemCooldown then
        local startTime, duration, enable = C_Item.GetItemCooldown(action.id)
        if type(startTime) == "number" and type(duration) == "number" and enable ~= 0 then
            cooldown:SetCooldown(startTime, duration)
        end
    end
end

function MapPinEnhancedWayfinderInstructionMixin:OnLoad()
    self:UpdateFrameLevels()
    self.actionButton:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    self.actionButton:SetPropagateMouseClicks(false)
    self.actionBlocker:SetPropagateMouseClicks(false)
end

function MapPinEnhancedWayfinderInstructionMixin:UpdateFrameLevels()
    local frameLevel = self:GetFrameLevel()
    self.actionButton:SetFrameLevel(frameLevel + 1)
    self.actionBlocker:SetFrameLevel(frameLevel + 2)
end

function MapPinEnhancedWayfinderInstructionMixin:OnMouseDown(button)
    if button == "RightButton" and self.onMenu then self.onMenu(self) end
end

---@param step WayfinderStepData?
function MapPinEnhancedWayfinderInstructionMixin:SetStep(step)
    self.step = step
    local visible = step and step.showInstruction ~= false
    local action = visible and step and step.desiredAction or nil
    local actionIcon = action and GetActionIcon(action) or nil
    local status = step and step.status or ""
    GameTooltip:Hide()
    self.actionButton.icon:SetTexture(actionIcon)
    self.actionBlocker.icon:SetTexture(actionIcon)
    SetActionCooldown(self.actionButton.cooldown, action)
    SetActionCooldown(self.actionBlocker.cooldown, action)

    if InCombatLockdown() then
        -- Protected attributes still describe preparedAction. Cover any obsolete
        -- control immediately; one callback reconciles the latest input after combat.
        local prepared = self.preparedAction
        local actionAvailable = action and prepared and action.type == prepared.type and
            action.id == prepared.id and self.actionButton:IsShown()
        self.actionBlocker:SetShown(not actionAvailable and (action ~= nil or self.actionButton:IsShown()))
        -- Alpha hides obsolete artwork without changing protected visibility.
        -- The unprotected shield still consumes clicks until safe reconciliation.
        self.actionButton:SetAlpha(actionAvailable and 1 or 0)
        self.actionBlocker:SetAlpha(action and 1 or 0)
        if action and not actionAvailable then status = L["Navigation Action Unavailable Combat"] end
        if not self.reconcileAfterCombat then
            self.reconcileAfterCombat = MapPinEnhanced:RegisterEventBucket({ "PLAYER_REGEN_ENABLED" }, function()
                self:SetStep(self.step)
            end)
        end
    else
        if self.reconcileAfterCombat then
            self.reconcileAfterCombat()
            self.reconcileAfterCombat = nil
        end
        self.actionButton:SetAttribute("type", nil)
        self.actionButton:SetAttribute("spell", nil)
        self.actionButton:SetAttribute("item", nil)
        self.actionButton:SetAttribute("toy", nil)
        if action then
            local actionValue = action.type == "item" and "item:" .. tostring(action.id) or action.id
            self.actionButton:SetAttribute("type", action.type)
            self.actionButton:SetAttribute(action.type, actionValue)
        end
        self.preparedAction = action and { type = action.type, id = action.id } or nil
        self.actionButton:SetShown(action ~= nil)
        self.actionButton:SetAlpha(1)
        self.actionBlocker:Hide()
    end
    local text = visible and step and step.instruction or ""
    if visible and status ~= "" then text = text .. "\n" .. status end
    self.text:SetText(text)
    self:UpdateCooldownEvents()
end

--@debug@
---@return string
function MapPinEnhancedWayfinderInstructionMixin:GetActionDebugText()
    local action, prepared = self.step and self.step.desiredAction, self.preparedAction
    local button = self.actionButton
    local x, y = button:GetCenter()
    return string.format("phase=%s; requested=%s:%s; prepared=%s:%s; pending=%s; combat=%s; frame=%s; " ..
        "buttonShown=%s; buttonVisible=%s; buttonAlpha=%s; buttonCenter=%s,%s; blocker=%s; secureType=%s",
        tostring(self.step and self.step.phase), tostring(action and action.type), tostring(action and action.id),
        tostring(prepared and prepared.type), tostring(prepared and prepared.id),
        tostring(self.reconcileAfterCombat ~= nil), tostring(InCombatLockdown()), tostring(self:IsVisible()),
        tostring(button:IsShown()), tostring(button:IsVisible()), tostring(button:GetAlpha()), tostring(x), tostring(y),
        tostring(self.actionBlocker:IsVisible()), tostring(button:GetAttribute("type")))
end

--@end-debug@

---@param owner Frame
function MapPinEnhancedWayfinderInstructionMixin:OnActionEnter(owner)
    local action = self.step and self.step.showInstruction ~= false and self.step.desiredAction
    if not action then return end
    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    if action.type == "spell" and GameTooltip.SetSpellByID then
        GameTooltip:SetSpellByID(action.id)
    elseif GameTooltip.SetItemByID then
        GameTooltip:SetItemByID(action.id)
    end
    GameTooltip:Show()
end

function MapPinEnhancedWayfinderInstructionMixin:OnActionLeave()
    GameTooltip:Hide()
end

function MapPinEnhancedWayfinderInstructionMixin:UpdateCooldownEvents()
    local action = self.step and self.step.showInstruction ~= false and self.step.desiredAction
    if self:IsVisible() and action then
        if self.refreshCooldown then return end
        self.refreshCooldown = function()
            local current = self.step and self.step.desiredAction
            SetActionCooldown(self.actionButton.cooldown, current)
            SetActionCooldown(self.actionBlocker.cooldown, current)
        end
        MapPinEnhanced:RegisterEvent("SPELL_UPDATE_COOLDOWN", self.refreshCooldown)
        MapPinEnhanced:RegisterEvent("BAG_UPDATE_COOLDOWN", self.refreshCooldown)
    elseif self.refreshCooldown then
        MapPinEnhanced:UnregisterEventForFunction("SPELL_UPDATE_COOLDOWN", self.refreshCooldown)
        MapPinEnhanced:UnregisterEventForFunction("BAG_UPDATE_COOLDOWN", self.refreshCooldown)
        self.refreshCooldown = nil
        self.actionButton.cooldown:Clear()
        self.actionBlocker.cooldown:Clear()
    end
end

function MapPinEnhancedWayfinderInstructionMixin:OnShow()
    -- Combat may have covered several different Steps.
    -- Prepare only the latest action before this surface becomes interactive.
    if not InCombatLockdown() then self:SetStep(self.step) end
    self:UpdateCooldownEvents()
    if self.refreshCooldown then self.refreshCooldown() end
end

function MapPinEnhancedWayfinderInstructionMixin:OnHide()
    GameTooltip:Hide()
    self:UpdateCooldownEvents()
end
