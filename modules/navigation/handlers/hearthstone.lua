---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

---@class NavigationHearthstoneDestination
---@field mapID number
---@field x number
---@field y number
---@field bindName string?

---@class NavigationHearthstoneCast
---@field guid string
---@field succeeded boolean?
---@field loading boolean?
---@field arrived boolean?

local characterKey ---@type string?
local preferredToyID ---@type number?
local destination ---@type NavigationHearthstoneDestination?
local pendingCast ---@type NavigationHearthstoneCast?
local expiryTimer ---@type FunctionContainer?
local positionTimer ---@type FunctionContainer?
local learning = false
local setup = false
local hearthstoneSpells = {} ---@type table<number, boolean>
local toysBySpellID = {} ---@type table<number, number>
local SetLearning ---@type fun(enabled: boolean)

MapPinEnhanced:SetDefault("hearthstoneDestinations", {})
MapPinEnhanced:SetDefault("hearthstoneToys", {})

---@param graph NavigationGraph
---@return number?
function Navigation:GetPreferredHearthstoneToy(graph)
    local itemID = preferredToyID
    if not itemID or not PlayerHasToy or not C_ToyBox or not C_ToyBox.IsToyUsable then return nil end
    local owned = PlayerHasToy(itemID)
    local usable = C_ToyBox.IsToyUsable(itemID)
    if MapPinEnhanced:IsSecretValue(owned) or owned ~= true or
        MapPinEnhanced:IsSecretValue(usable) or usable ~= true or
        not self:GetActionCooldown("toy", itemID) then return nil end
    -- A failed preferred toy must not block the remaining home-bind actions.
    for reference in pairs(self.avoidedPaths) do
        if graph.pathTypes[reference] == "hearthstone" and
            self:GetRequirementResource(graph.pathRequirements[reference], "toy") == itemID then return nil end
    end
    return itemID
end

---@param unit string
---@param _ string
---@param spellID number
local function SaveUsedToy(unit, _, spellID)
    if not characterKey or MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" or
        MapPinEnhanced:IsSecretValue(spellID) then return end
    local itemID = toysBySpellID[spellID]
    if not itemID or itemID == preferredToyID then return end
    local saved = MapPinEnhanced:GetVar("hearthstoneToys")
    if type(saved) ~= "table" then saved = {} end
    ---@cast saved table<string, number>
    saved[characterKey] = itemID
    MapPinEnhanced:SetVar("hearthstoneToys", saved)
    preferredToyID = itemID
end

---@param value any
---@return boolean
local function IsDestination(value)
    return type(value) == "table" and not MapPinEnhanced:IsSecretTable(value) and
        not MapPinEnhanced:IsSecretValue(value.mapID) and type(value.mapID) == "number" and
        value.mapID > 0 and value.mapID % 1 == 0 and
        MapPinEnhanced:IsCoordinate(value.x) and MapPinEnhanced:IsCoordinate(value.y)
end

---@return NavigationHearthstoneDestination?
local function ReadPosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if MapPinEnhanced:IsSecretValue(mapID) or type(mapID) ~= "number" then return nil end
    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position or MapPinEnhanced:IsSecretTable(position) then return nil end
    local x, y = position:GetXY()
    local value = { mapID = mapID, x = x, y = y }
    if not IsDestination(value) then return nil end
    local bindName = GetBindLocation()
    if not MapPinEnhanced:IsSecretValue(bindName) and type(bindName) == "string" then
        value.bindName = bindName
    end
    return value
end

local function ClearPendingCast()
    pendingCast = nil
    if expiryTimer then expiryTimer:Cancel() end
    if positionTimer then positionTimer:Cancel() end
    expiryTimer, positionTimer = nil, nil
end

---@param value NavigationHearthstoneDestination?
local function SaveDestination(value)
    if not characterKey then return end
    local saved = MapPinEnhanced:GetVar("hearthstoneDestinations")
    if type(saved) ~= "table" then saved = {} end
    ---@cast saved table<string, NavigationHearthstoneDestination>
    saved[characterKey] = value
    MapPinEnhanced:SetVar("hearthstoneDestinations", saved)
    destination = value
    ClearPendingCast()
    SetLearning(value == nil)
    Navigation:UpdateHearthstonePath(value)
end

local function TryArrival()
    local cast = pendingCast
    if destination or not cast or not cast.succeeded or not cast.arrived or positionTimer then return end
    -- Wait until after the loading callback before reading map position. Retry
    -- briefly for unavailable maps, but never infer arrival from a delay alone.
    local attempts = 0
    positionTimer = C_Timer.NewTicker(0.1, function()
        attempts = attempts + 1
        local value = ReadPosition()
        if value then
            SaveDestination(value)
        elseif attempts >= 20 then
            ClearPendingCast()
        end
    end)
end

---@param unit string
---@param guid string
---@param spellID number
local function OnCastStart(unit, guid, spellID)
    if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" then return end
    ClearPendingCast()
    if destination or MapPinEnhanced:IsSecretValue(guid) or MapPinEnhanced:IsSecretValue(spellID) or
        type(guid) ~= "string" or not hearthstoneSpells[spellID] then
        return
    end
    pendingCast = { guid = guid }
    expiryTimer = C_Timer.NewTimer(60, ClearPendingCast)
end

---@param unit string
---@param guid string
---@return boolean?
local function IsPendingCast(unit, guid)
    return pendingCast and not MapPinEnhanced:IsSecretValue(unit) and unit == "player" and
        not MapPinEnhanced:IsSecretValue(guid) and guid == pendingCast.guid
end

local function OnCastSucceeded(unit, guid)
    if not IsPendingCast(unit, guid) or not pendingCast then return end
    pendingCast.succeeded = true
    if not pendingCast.loading then
        -- Do not attribute an unrelated loading screen much later to this cast.
        if expiryTimer then expiryTimer:Cancel() end
        expiryTimer = C_Timer.NewTimer(5, ClearPendingCast)
    end
    TryArrival()
end

local function OnCastFailed(unit, guid)
    if IsPendingCast(unit, guid) then ClearPendingCast() end
end

local function OnLoadingStarted()
    if not pendingCast then return end
    pendingCast.loading = true
    if expiryTimer then expiryTimer:Cancel() end
    expiryTimer = C_Timer.NewTimer(60, ClearPendingCast)
end

local function OnLoadingFinished()
    if not pendingCast or not pendingCast.loading then return end
    pendingCast.arrived = true
    TryArrival()
end

---@type table<WowEvent, function>
local LEARNING_EVENTS = {
    UNIT_SPELLCAST_START = OnCastStart,
    UNIT_SPELLCAST_SUCCEEDED = OnCastSucceeded,
    UNIT_SPELLCAST_FAILED = OnCastFailed,
    UNIT_SPELLCAST_INTERRUPTED = OnCastFailed,
    LOADING_SCREEN_ENABLED = OnLoadingStarted,
    LOADING_SCREEN_DISABLED = OnLoadingFinished,
    PLAYER_LOGOUT = ClearPendingCast,
}

SetLearning = function(enabled)
    if learning == enabled then return end
    learning = enabled
    for event, callback in pairs(LEARNING_EVENTS) do
        if enabled then
            MapPinEnhanced:RegisterEvent(event, callback)
        else
            MapPinEnhanced:UnregisterEventForFunction(event, callback)
        end
    end
end

local function OnBound()
    -- A same-name rebind is still a new destination. If position is missing,
    -- discard the previous inn rather than leave a stale route available.
    SaveDestination(ReadPosition())
end

function Navigation:SetupHearthstoneDestination()
    if setup then return end
    characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return end
    setup = true
    for itemID, spellID in pairs(self.hearthstoneItems) do
        hearthstoneSpells[spellID] = true
        if itemID ~= 6948 then toysBySpellID[spellID] = itemID end
    end
    for _, spellID in ipairs(self.hearthstoneSpells or {}) do hearthstoneSpells[spellID] = true end
    local savedToys = MapPinEnhanced:GetVar("hearthstoneToys")
    local toyID = type(savedToys) == "table" and savedToys[characterKey] or nil
    if type(toyID) == "number" and toyID ~= 6948 and self.hearthstoneItems[toyID] then
        preferredToyID = toyID
    end
    local saved = MapPinEnhanced:GetVar("hearthstoneDestinations")
    local value = type(saved) == "table" and saved[characterKey] or nil
    if IsDestination(value) then
        ---@cast value NavigationHearthstoneDestination
        destination = { mapID = value.mapID, x = value.x, y = value.y }
    end
    MapPinEnhanced:RegisterEvent("HEARTHSTONE_BOUND", OnBound)
    -- Toy preference continues learning after home coordinates are already known.
    MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", SaveUsedToy)
    SetLearning(destination == nil)
    self:UpdateHearthstonePath(destination)
end
