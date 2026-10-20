---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

---@class NavigationCampDestination
---@field mapID number
---@field x number
---@field y number

local characterKey ---@type string?

---@param value any
---@return boolean
local function IsDestination(value)
    return MapPinEnhanced:IsReadableTable(value) and
        MapPinEnhanced:IsReadablePositiveInteger(value.mapID) and
        MapPinEnhanced:IsCoordinate(value.x) and MapPinEnhanced:IsCoordinate(value.y)
end

---@return NavigationCampDestination?
local function ReadPosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) then return nil end
    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position or MapPinEnhanced:IsSecretTable(position) then return nil end
    local x, y = position:GetXY()
    local value = { mapID = mapID, x = x, y = y }
    if IsDestination(value) then return value end
end

local function OnCastSucceeded(unit, _, spellID)
    if not characterKey or MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" or
        not MapPinEnhanced:IsReadablePositiveInteger(spellID) or spellID ~= 312370 then
        return
    end
    -- Make Camp does not move the player. Read at success, never in a delayed
    -- callback that could capture a later position. Unreadable success replaces
    -- the old camp with unknown; failed/interrupted casts never reach this path.
    local destination = ReadPosition()
    local saved = MapPinEnhanced:GetVar("campDestinations")
    if not MapPinEnhanced:IsReadableTable(saved) then saved = {} end
    ---@cast saved table<string, NavigationCampDestination>
    saved[characterKey] = destination
    MapPinEnhanced:SetVar("campDestinations", saved)
    Navigation:UpdateCampPath(destination)
end

function Navigation:SetupCampDestination()
    if MapPinEnhanced.isForever or characterKey then return end
    characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return end
    local saved = MapPinEnhanced:GetVar("campDestinations")
    local value = type(saved) == "table" and not MapPinEnhanced:IsSecretTable(saved) and saved[characterKey] or nil
    local destination ---@type NavigationCampDestination?
    if IsDestination(value) then
        ---@cast value NavigationCampDestination
        destination = { mapID = value.mapID, x = value.x, y = value.y }
    end
    self:UpdateCampPath(destination)
    -- Learning is character state, independent of whether routing is enabled.
    MapPinEnhanced:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", OnCastSucceeded)
    self:RegisterTravelSpells({ [312372] = false })
end
