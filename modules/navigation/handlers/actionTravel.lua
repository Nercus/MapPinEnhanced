---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Travel actions can land away from the planned endpoint. Observe their
-- loading transition and replan from the actual position, including manual use.
local travelItems = {} ---@type table<number, boolean>
local itemsBySpell = {} ---@type table<number, number>
local travelSpells = {} ---@type table<number, boolean>
local travelChangeNumber = 0
local pendingTravelSpellID ---@type number?
local pendingTravelDestination ---@type NavigationDestination?
local pendingTravelLoading = false
local travelExpiry ---@type FunctionContainer?
local travelPositionTimer ---@type FunctionContainer?
local previousPosition ---@type { mapID: number, x: number, y: number, sampledAt: number }?

---@param itemID number
local function CacheItemSpell(itemID)
    if travelItems[itemID] == nil then return end
    local spellID = Navigation:GetActionSpellID({ type = "toy", id = itemID })
    if spellID and MapPinEnhanced:IsReadablePositiveInteger(spellID) then itemsBySpell[spellID] = itemID end
end

---@param items table<number, boolean> True for items or toys that summon an interaction
function Navigation:RegisterTravelItems(items)
    for itemID, summons in pairs(items) do
        travelItems[itemID] = summons
        CacheItemSpell(itemID)
        if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(itemID) end
    end
end

---@param spells table<number, boolean> True for spells that summon a destination menu
function Navigation:RegisterTravelSpells(spells)
    for spellID, summons in pairs(spells) do travelSpells[spellID] = summons end
end

function Navigation:CancelActionTravel()
    travelChangeNumber = travelChangeNumber + 1
    pendingTravelSpellID = nil
    pendingTravelDestination = nil
    pendingTravelLoading = false
    previousPosition = nil
    if travelExpiry then travelExpiry:Cancel() end
    if travelPositionTimer then travelPositionTimer:Cancel() end
    travelExpiry, travelPositionTimer = nil, nil
end

local function RecoverActionTravel(changeNumber)
    if changeNumber ~= travelChangeNumber then return end
    local destination = pendingTravelDestination
    Navigation:CancelActionTravel()
    if not destination or Navigation.activeDestination ~= destination then return end
    Navigation:DeactivatePathHandler()
    Navigation:RefreshPreparedData()
    Navigation:StartCalculation(true)
end

---@return boolean? recovered
function Navigation:ObserveActionTravelPosition()
    if not pendingTravelDestination or pendingTravelLoading or not pendingTravelSpellID or
        travelSpells[pendingTravelSpellID] ~= true then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    local now = GetTime()
    local previous = previousPosition
    previousPosition = nil
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or
        not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then return end
    previousPosition = { mapID = mapID, x = x, y = y, sampledAt = now }
    -- A summoned menu can teleport within one map without loading. Only a
    -- recent discontinuity proves travel; menu selection and proximity do not.
    if previous and mapID == previous.mapID and now - previous.sampledAt <= 1 then
        local distance = self:GetComparableDistance(previous.mapID, previous.x, previous.y, mapID, x, y)
        if distance and not MapPinEnhanced:IsSecretValue(distance) and
            distance > 100 + 100 * (now - previous.sampledAt) then
            RecoverActionTravel(travelChangeNumber)
            return true
        end
    end
end

---@param unit string
---@param spellID number
function Navigation:ObserveActionTravel(unit, spellID)
    if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" or
        not MapPinEnhanced:IsReadablePositiveInteger(spellID) then
        return
    end
    local itemID = itemsBySpell[spellID]
    local summons = itemID and travelItems[itemID] or travelSpells[spellID]
    if (summons == nil and not itemID) or not Navigation.routeNavigationEnabled or
        not Navigation.activeDestination then return end
    Navigation:CancelActionTravel()
    pendingTravelDestination = Navigation.activeDestination
    pendingTravelSpellID = spellID
    Navigation:ObserveActionTravelPosition()
    local changeNumber = travelChangeNumber
    -- Summoning is an attempt, not arrival. Keep the route while its action is
    -- on cooldown, but recover if the player never uses the summoned wormhole.
    travelExpiry = C_Timer.NewTimer(summons and 65 or 5, function() RecoverActionTravel(changeNumber) end)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    for itemID in pairs(travelItems) do CacheItemSpell(itemID) end
end)
MapPinEnhanced:RegisterEvent("ITEM_DATA_LOAD_RESULT", function(itemID, success)
    if not MapPinEnhanced:IsSecretValue(success) and success == true and
        MapPinEnhanced:IsReadablePositiveInteger(itemID) then
        CacheItemSpell(itemID)
    end
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_ENABLED", function()
    if pendingTravelDestination then
        pendingTravelLoading = true
        if travelExpiry then travelExpiry:Cancel() end
        local changeNumber = travelChangeNumber
        travelExpiry = C_Timer.NewTimer(60, function() RecoverActionTravel(changeNumber) end)
    end
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_DISABLED", function()
    if not pendingTravelDestination or not pendingTravelLoading then return end
    if travelExpiry then travelExpiry:Cancel() end
    if travelPositionTimer then travelPositionTimer:Cancel() end
    local attempts = 20
    local changeNumber = travelChangeNumber
    local function ReadPosition()
        if changeNumber ~= travelChangeNumber then return end
        if Navigation.activeDestination ~= pendingTravelDestination then
            Navigation:CancelActionTravel()
            return
        end
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        attempts = attempts - 1
        if mapID and x and y or attempts == 0 then
            RecoverActionTravel(changeNumber)
        else
            travelPositionTimer = C_Timer.NewTimer(0.1, ReadPosition)
        end
    end
    travelPositionTimer = C_Timer.NewTimer(0.1, ReadPosition)
end)
MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function() Navigation:CancelActionTravel() end)

local function OnCastFailed(unit, _, spellID)
    if not MapPinEnhanced:IsSecretValue(unit) and unit == "player" and
        MapPinEnhanced:IsReadablePositiveInteger(spellID) and spellID == pendingTravelSpellID then
        Navigation:CancelActionTravel()
    end
end
MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_FAILED", OnCastFailed)
MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", OnCastFailed)
MapPinEnhanced:RegisterEvent("GET_ITEM_INFO_RECEIVED", function(itemID, success)
    if not MapPinEnhanced:IsSecretValue(success) and success == true and
        MapPinEnhanced:IsReadablePositiveInteger(itemID) then
        CacheItemSpell(itemID)
    end
end)
