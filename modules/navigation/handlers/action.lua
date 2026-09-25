---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local ACTION_TYPES = { "toy", "spell", "item" }
local ACTION_PENALTY_SECONDS = 10
local EQUIPMENT_CHANGE_PENALTY_SECONDS = 30

---@param startTime any
---@param duration any
---@param modRate any
---@return boolean?
local function IsCooldownFinished(startTime, duration, modRate)
    if MapPinEnhanced:IsSecretValue(startTime) or MapPinEnhanced:IsSecretValue(duration) or
        MapPinEnhanced:IsSecretValue(modRate) then
        return nil
    end
    if type(startTime) ~= "number" or type(duration) ~= "number" then return nil end
    if startTime <= 0 or duration <= 0 then return true end
    local rate = type(modRate) == "number" and modRate > 0 and modRate or 1
    return startTime + duration / rate <= GetTime()
end

---@param actionType "spell"|"item"|"toy"
---@param actionID number
---@return boolean?
---@return string? failure
local function IsActionReady(actionType, actionID)
    if actionType == "spell" then
        if not C_Spell or not C_Spell.GetSpellCooldown then return nil, "spell cooldown unavailable" end
        if C_Spell.GetSpellCharges then
            local chargeInfo = C_Spell.GetSpellCharges(actionID)
            if chargeInfo and not MapPinEnhanced:IsSecretTable(chargeInfo) then
                local currentCharges = chargeInfo.currentCharges
                local maxCharges = chargeInfo.maxCharges
                if not MapPinEnhanced:IsSecretValue(currentCharges) and not MapPinEnhanced:IsSecretValue(maxCharges) and
                    type(currentCharges) == "number" and type(maxCharges) == "number" and maxCharges > 0 then
                    if currentCharges > 0 then return true end
                    return false, "spell is on cooldown"
                end
            end
        end

        local cooldownInfo = C_Spell.GetSpellCooldown(actionID)
        if not cooldownInfo or MapPinEnhanced:IsSecretTable(cooldownInfo) then
            return nil, "spell cooldown unavailable"
        end
        if MapPinEnhanced:IsSecretValue(cooldownInfo.isOnGCD) or MapPinEnhanced:IsSecretValue(cooldownInfo.isEnabled) then
            return nil, "spell cooldown unavailable"
        end
        if cooldownInfo.isEnabled == false then return false, "spell is unavailable" end
        if cooldownInfo.isOnGCD then return true end
        local ready = IsCooldownFinished(cooldownInfo.startTime, cooldownInfo.duration, cooldownInfo.modRate)
        if ready == nil then return nil, "spell cooldown unavailable" end
        if ready then return true end
        return false, "spell is on cooldown"
    end

    if not C_Item or not C_Item.GetItemCooldown then return nil, "item cooldown unavailable" end
    local startTime, duration = C_Item.GetItemCooldown(actionID)
    local ready = IsCooldownFinished(startTime, duration, 1)
    if ready == nil then return nil, "item cooldown unavailable" end
    if ready then return true end
    return false, actionType .. " is on cooldown"
end

---@param pathType string
---@param requirement NavigationRequirement?
---@return WayfinderDesiredAction?
function Navigation:GetPathAction(pathType, requirement)
    if pathType == "dhearth" or pathType == "unboundteleport" then
        for _, candidateType in ipairs(ACTION_TYPES) do
            local candidateID = Navigation:GetRequirementResource(requirement, candidateType)
            if candidateID then return { type = candidateType, id = candidateID } end
        end
        return nil
    end
    if pathType == "dungeonteleport" then pathType = "spell" end
    if pathType ~= "spell" and pathType ~= "item" and pathType ~= "toy" then return nil end
    local resourceID = self:GetRequirementResource(requirement, pathType)
    if not resourceID then return nil end
    return { type = pathType, id = resourceID }
end

---@param action WayfinderDesiredAction?
---@return number?
local function GetActionSpellID(action)
    if not action then return nil end
    if action.type == "spell" then return action.id end
    if C_Item and C_Item.GetItemSpell then return select(2, C_Item.GetItemSpell(action.id)) end
    if GetItemSpell then return select(2, GetItemSpell(action.id)) end
end

---@param action WayfinderDesiredAction
---@return number
local function GetActionCastSeconds(action)
    local spellID = GetActionSpellID(action)
    if not spellID then return 1 end
    if C_Spell and C_Spell.GetSpellInfo then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if spellInfo and type(spellInfo.castTime) == "number" then
            return math.max(1, spellInfo.castTime / 1000)
        end
    end
    return 1
end

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?

---@param context NavigationActivePathContext
---@param report NavigationPathReport
local function ActionActivator(context, report)
    activeContext = context
    activeReport = report
end

local function ActionDeactivator()
    activeContext = nil
    activeReport = nil
end

---@param result "attempted"|"failed"
---@param unit string
---@param _ string
---@param spellID number
local function ReportActionEvent(result, unit, _, spellID)
    local context = activeContext
    local report = activeReport
    if not context or not report then return end
    if unit ~= "player" then return end
    local expectedSpellID = GetActionSpellID(Navigation:GetPathAction(context.pathType, context.requirement))
    if expectedSpellID ~= spellID then return end
    report(result)
end

local function OnSpellcastSucceeded(...)
    ReportActionEvent("attempted", ...)
end

local function OnSpellcastFailed(...)
    ReportActionEvent("failed", ...)
end

MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", OnSpellcastSucceeded)
MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_FAILED", OnSpellcastFailed)

---@param pathType string
---@param icon string
---@param method string
---@param instruction string
local function RegisterAction(pathType, icon, method, instruction)
    local function Presentation()
        return icon, method, instruction
    end

    ---@param graph NavigationGraph
    ---@param _preparedData NavigationPreparedData
    ---@param pathReference integer
    ---@return NavigationCalculatedPathCost?
    ---@return string? failure
    local function CostCalculator(graph, _preparedData, pathReference)
        local requirement = graph.pathRequirements[pathReference]
        local action = Navigation:GetPathAction(pathType, requirement)
        if not action then return nil, "action unavailable" end
        local actionReady, actionFailure = IsActionReady(action.type, action.id)
        if not actionReady then return nil, actionFailure or "action cooldown unavailable" end
        local castSeconds = GetActionCastSeconds(action)
        -- Equipment travel also requires swapping gear and waiting for its
        -- equip cooldown. Keep that conservative estimate out of cast duration.
        local equipmentPenalty = action.type == "item" and C_Item.IsEquippableItem(action.id) and
            not C_Item.IsEquippedItem(action.id) and EQUIPMENT_CHANGE_PENALTY_SECONDS or 0
        local penaltySeconds = ACTION_PENALTY_SECONDS + equipmentPenalty
        return {
            expectedSeconds = castSeconds,
            uncertaintySeconds = 0,
            -- Prefer ordinary movement for short trips without delaying action execution.
            comparisonSeconds = castSeconds + penaltySeconds,
            explanation = {
                kind = "cast",
                pathType = pathType,
                seconds = castSeconds,
                penaltySeconds = penaltySeconds,
                equipmentChangeSeconds = equipmentPenalty,
            },
        }
    end

    Navigation:RegisterPathHandler(pathType, Presentation, nil, CostCalculator, ActionActivator, ActionDeactivator)
end

RegisterAction("spell", "MagePortalAlliance", L["Navigation Method Spell"], L["Navigation Use Spell"])
RegisterAction("dungeonteleport", "PortalRed", L["Navigation Method Teleport"], L["Navigation Use Teleport"])
RegisterAction("item", "Object", L["Navigation Method Item"], L["Navigation Use Item"])
RegisterAction("toy", "Gear", L["Navigation Method Toy"], L["Navigation Use Toy"])
RegisterAction("dhearth", "Innkeeper", L["Navigation Method Dalaran Hearthstone"],
    L["Navigation Use Dalaran Hearthstone"])
RegisterAction("unboundteleport", "PortalRed", L["Navigation Method Teleport"], L["Navigation Use Teleport"])

-- Session-long cooldown observations recover only recorded action failures.
-- Navigation's eligibility bucket handles inventory, collection, and spell changes.
MapPinEnhanced:RegisterEventBucket({
    "SPELL_UPDATE_COOLDOWN",
    "SPELL_UPDATE_CHARGES",
    "BAG_UPDATE_COOLDOWN",
}, function()
    Navigation:RecheckFailedPaths("action")
end, 0.5)
