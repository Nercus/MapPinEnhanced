---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local ACTION_TYPES = { "toy", "spell", "item" }
local ACTION_PENALTY_SECONDS = 10
local LOADING_SCREEN_PENALTY_SECONDS = 10
local EQUIPMENT_CHANGE_PENALTY_SECONDS = 10
local MINIMUM_ACTION_COOLDOWN_SECONDS = 1.5

---@param startTime any
---@param duration any
---@param modRate any
---@return number? remainingSeconds
---@return number? startTime
---@return number? duration
---@return number? modRate
local function ReadCooldown(startTime, duration, modRate)
    if not MapPinEnhanced:IsReadableNumber(startTime) or not MapPinEnhanced:IsReadableNumber(duration) or
        MapPinEnhanced:IsSecretValue(modRate) then
        return nil
    end
    local rate = type(modRate) == "number" and modRate > 0 and modRate or 1
    if not (startTime < math.huge and duration >= 0 and duration < math.huge and rate < math.huge) then return nil end
    -- Ignore brief global cooldowns, not the final seconds of a longer cooldown.
    if startTime <= 0 or duration < MINIMUM_ACTION_COOLDOWN_SECONDS then return 0 end
    local remaining = math.max(0, startTime + duration / rate - GetTime())
    if remaining < math.huge then return remaining, startTime, duration, rate end
end

---@param actionType "spell"|"item"|"toy"
---@param actionID number
---@return number? remainingSeconds
---@return number? startTime
---@return number? duration
---@return number? modRate
function Navigation:GetActionCooldown(actionType, actionID)
    if actionType ~= "spell" then
        if not C_Item or not C_Item.GetItemCooldown then return nil end
        local startTime, duration = C_Item.GetItemCooldown(actionID)
        return ReadCooldown(startTime, duration, 1)
    end
    if not C_Spell or not C_Spell.GetSpellCooldown then return nil end
    local charges = C_Spell.GetSpellCharges and C_Spell.GetSpellCharges(actionID)
    if MapPinEnhanced:IsSecretValue(charges) then return nil end
    if charges then
        if not MapPinEnhanced:IsReadableTable(charges) or not MapPinEnhanced:IsReadableNumber(charges.currentCharges) or
            not MapPinEnhanced:IsReadableNumber(charges.maxCharges) then
            return nil
        end
        if charges.maxCharges > 0 then
            if charges.currentCharges > 0 then return 0 end
            return ReadCooldown(charges.cooldownStartTime, charges.cooldownDuration, charges.chargeModRate)
        end
    end
    local cooldown = C_Spell.GetSpellCooldown(actionID)
    if not MapPinEnhanced:IsReadableTable(cooldown) or MapPinEnhanced:IsSecretValue(cooldown.isEnabled) or
        MapPinEnhanced:IsSecretValue(cooldown.isOnGCD) then
        return nil
    end
    if cooldown.isEnabled == false then return nil end
    if cooldown.isOnGCD then return 0 end
    return ReadCooldown(cooldown.startTime, cooldown.duration, cooldown.modRate)
end

---@param pathType string
---@param requirement NavigationRequirement?
---@return WayfinderDesiredAction?
function Navigation:GetPathAction(pathType, requirement)
    if pathType == "hearthstone" or pathType == "unboundteleport" then
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

-- Toy uses can land away from the planned endpoint, or have no fixed endpoint
-- at all. Observe their loading transition and replan from the actual position.
local travelToys = {} ---@type table<number, boolean>
local toysBySpell = {} ---@type table<number, number>
local pendingToyDestination ---@type NavigationDestination?
local pendingToyLoading = false
local toyExpiry ---@type FunctionContainer?
local toyPositionTimer ---@type FunctionContainer?

---@param itemID number
local function CacheToySpell(itemID)
    if travelToys[itemID] == nil then return end
    local spellID = GetActionSpellID({ type = "toy", id = itemID })
    if spellID and MapPinEnhanced:IsReadablePositiveInteger(spellID) then toysBySpell[spellID] = itemID end
end

---@param items table<number, boolean> True for toys that summon an interaction
function Navigation:RegisterTravelToys(items)
    for itemID, summons in pairs(items) do
        travelToys[itemID] = summons
        CacheToySpell(itemID)
        if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(itemID) end
    end
end

function Navigation:CancelToyTravel()
    pendingToyDestination = nil
    pendingToyLoading = false
    if toyExpiry then toyExpiry:Cancel() end
    if toyPositionTimer then toyPositionTimer:Cancel() end
    toyExpiry, toyPositionTimer = nil, nil
end

local function RecoverToyTravel()
    local destination = pendingToyDestination
    Navigation:CancelToyTravel()
    if not destination or Navigation.activeDestination ~= destination then return end
    Navigation:DeactivatePathHandler()
    Navigation:RefreshPreparedData()
    Navigation:StartCalculation(true)
end

local function ObserveToyTravel(unit, spellID)
    if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" or
        not MapPinEnhanced:IsReadablePositiveInteger(spellID) then
        return
    end
    local itemID = toysBySpell[spellID]
    if not itemID or not Navigation.routeNavigationEnabled or not Navigation.activeDestination then return end
    Navigation:CancelToyTravel()
    pendingToyDestination = Navigation.activeDestination
    -- Summoning is an attempt, not arrival. Keep the route while its toy is
    -- on cooldown, but recover if the player never uses the summoned wormhole.
    toyExpiry = C_Timer.NewTimer(travelToys[itemID] and 65 or 5, RecoverToyTravel)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    for itemID in pairs(travelToys) do CacheToySpell(itemID) end
end)
MapPinEnhanced:RegisterEvent("ITEM_DATA_LOAD_RESULT", function(itemID, success)
    if not MapPinEnhanced:IsSecretValue(success) and success == true and
        MapPinEnhanced:IsReadablePositiveInteger(itemID) then
        CacheToySpell(itemID)
    end
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_ENABLED", function()
    if pendingToyDestination then
        pendingToyLoading = true
        if toyExpiry then toyExpiry:Cancel() end
        toyExpiry = C_Timer.NewTimer(60, RecoverToyTravel)
    end
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_DISABLED", function()
    if not pendingToyDestination or not pendingToyLoading then return end
    if toyExpiry then toyExpiry:Cancel() end
    if toyPositionTimer then toyPositionTimer:Cancel() end
    local attempts = 20
    local function ReadPosition()
        if Navigation.activeDestination ~= pendingToyDestination then
            Navigation:CancelToyTravel()
            return
        end
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        attempts = attempts - 1
        if mapID and x and y or attempts == 0 then
            RecoverToyTravel()
        else
            toyPositionTimer = C_Timer.NewTimer(0.1, ReadPosition)
        end
    end
    toyPositionTimer = C_Timer.NewTimer(0.1, ReadPosition)
end)
MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function() Navigation:CancelToyTravel() end)

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?

---@param context NavigationActivePathContext
---@param report NavigationPathReport
local function ActionActivator(context, report)
    activeContext = context
    activeReport = report
    if context.pathType == "toy" and context.data then
        Navigation:ActivateGossipPath(context, report)
    end
end

local function ActionDeactivator()
    activeContext = nil
    activeReport = nil
    Navigation:DeactivateGossipPath()
end

---@param action WayfinderDesiredAction
---@return string?
local function GetActionName(action)
    if action.type == "spell" then
        local info = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(action.id)
        if MapPinEnhanced:IsReadableTable(info) then return MapPinEnhanced:NormalizeText(info.name) end
    elseif C_Item and C_Item.GetItemInfo then
        -- GetItemInfo requests uncached names. The data event republishes only
        -- the current Route, so a late reply cannot revive an old Step.
        local name = C_Item.GetItemInfo(action.id)
        return MapPinEnhanced:NormalizeText(name)
    end
end

MapPinEnhanced:RegisterEvent("GET_ITEM_INFO_RECEIVED", function(itemID, success)
    if MapPinEnhanced:IsSecretValue(success) or success ~= true or
        not MapPinEnhanced:IsReadablePositiveInteger(itemID) then
        return
    end
    CacheToySpell(itemID)
    local progression = Navigation.progression
    if not progression then return end
    local graph = progression.route.graph
    for index = progression.pathIndex, #progression.route.pathReferences do
        local reference = progression.route.pathReferences[index]
        local action = Navigation:GetPathAction(graph.pathTypes[reference], graph.pathRequirements[reference])
        if action and action.type ~= "spell" and action.id == itemID then
            Navigation:PublishStep(progression)
            return
        end
    end
end)

---@param result "attempted"|"failed"
---@param unit string
---@param _ string
---@param spellID number
local function ReportActionEvent(result, unit, _, spellID)
    local context = activeContext
    local report = activeReport
    if not context or not report then return end
    if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" or
        not MapPinEnhanced:IsReadablePositiveInteger(spellID) then
        return
    end
    local expectedSpellID = GetActionSpellID(Navigation:GetPathAction(context.pathType, context.requirement))
    if expectedSpellID ~= spellID then return end
    report(result)
end

local function OnSpellcastSucceeded(unit, castGUID, spellID)
    ObserveToyTravel(unit, spellID)
    ReportActionEvent("attempted", unit, castGUID, spellID)
end

local function OnSpellcastFailed(...)
    ReportActionEvent("failed", ...)
end

MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", OnSpellcastSucceeded)
MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_FAILED", OnSpellcastFailed)

---@param pathType string
---@param icon string
---@param method string
---@param instructionKey string
local function RegisterAction(pathType, icon, method, instructionKey)
    ---@param context NavigationPathPresentationContext?
    ---@return string icon, string method, string instruction
    local function Presentation(context)
        local action = context and Navigation:GetPathAction(pathType, context.requirement)
        local name = action and GetActionName(action)
        local destination = context and context.destinationName
        if pathType == "toy" and context and context.data and destination then
            if context.phase == "in-transit" then
                return icon, method, string.format(L["Navigation Select Toy Destination"], destination)
            end
            return icon, method, string.format(L["Navigation Use Toy And Select"], name or method, destination)
        end
        if not name then
            local fallback = destination and string.format(L[instructionKey .. " To"], destination) or L[instructionKey]
            return icon, method, fallback
        end
        local isSpell = action.type == "spell"
        local key = isSpell and "Navigation Cast Named Spell" or "Navigation Use Named Item"
        -- Teleport: Stormwind already identifies Stormwind City. Match the
        -- named suffix too, without treating localized place names as patterns.
        local namedDestination = name:match(":%s*(.+)$")
        local namesDestination = destination and (name:find(destination, 1, true) or
            namedDestination and destination:find(namedDestination, 1, true))
        if destination and not namesDestination then
            key = pathType == "hearthstone" and
                (isSpell and "Navigation Cast Named Spell Return" or "Navigation Use Named Item Return") or
                (isSpell and "Navigation Cast Named Spell To" or "Navigation Use Named Item To")
            return icon, method, string.format(L[key], name, destination)
        end
        return icon, method, string.format(L[key], name)
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
        if pathType == "hearthstone" and action.type ~= "spell" then
            local preferredToyID = Navigation:GetPreferredHearthstoneToy(graph)
            if preferredToyID and action.id ~= preferredToyID then
                return nil, "preferred hearthstone toy available"
            end
        end
        if action.type == "toy" then
            local gossip = graph.pathHandlerData[pathReference]
            if gossip and not Navigation:IsToyGossipAvailable(gossip) then
                return nil, "toy gossip unavailable or unobserved"
            end
            local usable = C_ToyBox and C_ToyBox.IsToyUsable and C_ToyBox.IsToyUsable(action.id)
            if MapPinEnhanced:IsSecretValue(usable) or usable ~= true then return nil, "toy unavailable" end
        end
        local cooldownSeconds = Navigation:GetActionCooldown(action.type, action.id)
        if not cooldownSeconds then return nil, "action cooldown unavailable" end
        local castSeconds = GetActionCastSeconds(action)
        local expectedSeconds = castSeconds + cooldownSeconds
        -- Equipment travel also requires swapping gear and waiting for its
        -- equip cooldown. Keep that conservative estimate out of cast duration.
        local equipmentPenalty = action.type == "item" and C_Item.IsEquippableItem(action.id) and
            not C_Item.IsEquippedItem(action.id) and EQUIPMENT_CHANGE_PENALTY_SECONDS or 0
        local penaltySeconds = ACTION_PENALTY_SECONDS + LOADING_SCREEN_PENALTY_SECONDS + equipmentPenalty
        return {
            expectedSeconds = expectedSeconds,
            uncertaintySeconds = 0,
            -- Prefer ordinary movement for short trips without delaying action execution.
            comparisonSeconds = expectedSeconds + penaltySeconds,
            explanation = {
                kind = "cast",
                pathType = pathType,
                seconds = expectedSeconds,
                castSeconds = castSeconds,
                cooldownSeconds = cooldownSeconds,
                penaltySeconds = penaltySeconds,
                equipmentChangeSeconds = equipmentPenalty,
            },
        }
    end

    ---@param path NavigationStaticPath
    ---@return NavigationStaticGossip?
    ---@return string?
    local function ToyData(path)
        if path.gossip then return Navigation:GetGossipPathData(path) end
    end
    Navigation:RegisterPathHandler(pathType, Presentation, pathType == "toy" and ToyData or nil,
        CostCalculator, ActionActivator, ActionDeactivator)
end

RegisterAction("spell", "MagePortalAlliance", L["Navigation Method Spell"], "Navigation Use Spell")
RegisterAction("dungeonteleport", "PortalRed", L["Navigation Method Teleport"], "Navigation Use Teleport")
RegisterAction("item", "Object", L["Navigation Method Item"], "Navigation Use Item")
RegisterAction("toy", "Gear", L["Navigation Method Toy"], "Navigation Use Toy")
RegisterAction("hearthstone", "Innkeeper", L["Navigation Method Hearthstone"], "Navigation Use Hearthstone")
RegisterAction("unboundteleport", "PortalRed", L["Navigation Method Teleport"], "Navigation Use Teleport")

-- Session-long cooldown observations recover only recorded action failures.
-- Navigation's eligibility bucket handles inventory, collection, and spell changes.
MapPinEnhanced:RegisterEventBucket({
    "SPELL_UPDATE_COOLDOWN",
    "SPELL_UPDATE_CHARGES",
    "BAG_UPDATE_COOLDOWN",
}, function()
    Navigation:RecheckFailedPaths("action")
end, 1)
