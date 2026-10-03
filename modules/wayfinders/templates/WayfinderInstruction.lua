---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderInstructionTemplate : Frame
---@field text FontString
---@field onTextChanged fun()?
---@field onMenu fun(owner: Frame)?
---@field actionButton MapPinEnhancedWayfinderActionButton
---@field actionBlocker MapPinEnhancedWayfinderActionVisual
---@field reconcileAfterCombat fun()?
---@field step WayfinderStepData?
---@field preparedAction WayfinderDesiredAction?
---@field fullText string?
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

function MapPinEnhancedWayfinderInstructionMixin:OnLoad()
    self:UpdateFrameLevels()
    self.actionButton:Setup()
    self.actionBlocker:Setup()
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
    self.fullText = text
    self.text:SetText(text)
    if self.onTextChanged then self.onTextChanged() end
end

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

function MapPinEnhancedWayfinderInstructionMixin:OnShow()
    -- Combat may have covered several different Steps.
    -- Prepare only the latest action before this surface becomes interactive.
    if not InCombatLockdown() then self:SetStep(self.step) end
end

function MapPinEnhancedWayfinderInstructionMixin:OnHide()
    GameTooltip:Hide()
end
