---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

---@alias SuperTrackingWaypointResolver fun(mapID: number): number?, number?, string?

---@param mapID number
---@return number? x
---@return number? y
---@return string? description
function Providers:GetNavigationWaypointForMap(mapID)
    -- Retail moved traversal waypoints to C_Navigation. Resolve at call time
    -- so neither a missing API nor delayed path construction is cached forever.
    local resolver = C_Navigation.GetNextWaypointForMap or C_SuperTrack.GetNextWaypointForMap
    if not resolver or not C_SuperTrack.IsSuperTrackingAnything() then return end
    local x, y, description = resolver(mapID)
    if MapPinEnhanced:IsSecretValue(x) or MapPinEnhanced:IsSecretValue(y) or
        type(x) ~= "number" or type(y) ~= "number" then
        return
    end
    if MapPinEnhanced:IsSecretValue(description) then description = nil end
    return x, y, description
end

---@param mapIDs number[]
---@param seenMapIDs table<number, boolean>
---@param mapID number?
local function AddMapID(mapIDs, seenMapIDs, mapID)
    if not mapID or seenMapIDs[mapID] then return end
    seenMapIDs[mapID] = true
    table.insert(mapIDs, mapID)
end

---@return number[] mapIDs
function Providers:GetSuperTrackingMapIDs()
    ---@type number[]
    local mapIDs = {}
    ---@type table<number, boolean>
    local seenMapIDs = {}
    ---@type number?
    local playerMapID = C_Map.GetBestMapForUnit("player")
    ---@type number?
    local displayMapID
    if MapUtil and MapUtil.GetDisplayableMapForPlayer then
        displayMapID = MapUtil.GetDisplayableMapForPlayer()
    end
    ---@type number?
    local visibleMapID
    if WorldMapFrame and WorldMapFrame.GetMapID then
        visibleMapID = WorldMapFrame:GetMapID()
    end

    -- The player's most specific map and Blizzard's displayable map can differ,
    -- especially in instances and subzones. Super-tracking paths may only be
    -- projected onto the displayable map. The visible world map is also needed
    -- for destinations selected from a map other than the player's current map.
    AddMapID(mapIDs, seenMapIDs, playerMapID)
    AddMapID(mapIDs, seenMapIDs, displayMapID)
    AddMapID(mapIDs, seenMapIDs, visibleMapID)

    -- Some routes are exposed only on a map adjacent to the player's, display,
    -- or visible map. Do not fan out from continents: their zone lists are too
    -- broad to be useful resolution candidates.
    ---@type number[]
    local initialMapIDs = {}
    if playerMapID then table.insert(initialMapIDs, playerMapID) end
    if displayMapID and displayMapID ~= playerMapID then table.insert(initialMapIDs, displayMapID) end
    if visibleMapID and visibleMapID ~= playerMapID and visibleMapID ~= displayMapID then
        table.insert(initialMapIDs, visibleMapID)
    end
    for _, initialMapID in ipairs(initialMapIDs) do
        local initialMapInfo = C_Map.GetMapInfo(initialMapID)
        if initialMapInfo and initialMapInfo.mapType ~= Enum.UIMapType.Continent then
            for _, childMapInfo in ipairs(C_Map.GetMapChildrenInfo(initialMapID) or {}) do
                AddMapID(mapIDs, seenMapIDs, childMapInfo.mapID)
            end
        end

        ---@type number
        local mapID = initialMapID
        for _ = 1, 4 do
            local mapInfo = C_Map.GetMapInfo(mapID)
            local parentMapID = mapInfo and mapInfo.parentMapID or nil
            if not parentMapID or parentMapID == 0 then break end
            mapID = parentMapID
            AddMapID(mapIDs, seenMapIDs, parentMapID)
        end
    end

    return mapIDs
end

---@param fallback? SuperTrackingWaypointResolver provider-specific resolver
---@param targetMapID? number source-owned map, including destinations outside the current map
---@param sourceFallback? fun(): number?, number?, number? last source-owned map/x/y before traversal
---@return number? x
---@return number? y
---@return number? mapID
---@return string? waypointDescription
---@return boolean? traversalOnly no source-owned destination was resolved
function Providers:GetSuperTrackingWaypoint(fallback, targetMapID, sourceFallback)
    -- A temporary waypoint's traversal is not a new external destination.
    if Wayfinders:IsStepSuperTracking() then return end
    if targetMapID and targetMapID <= 0 then targetMapID = nil end
    if fallback and targetMapID then
        local x, y, description = fallback(targetMapID)
        if not MapPinEnhanced:IsSecretValue(x) and not MapPinEnhanced:IsSecretValue(y) and
            type(x) == "number" and type(y) == "number" then
            return x, y, targetMapID, description, false
        end
    end
    local mapIDs = self:GetSuperTrackingMapIDs()
    -- Resolve the selected source before considering its traversal entrance.
    -- Otherwise arriving at a portal can remove a distant map pin/content target.
    if fallback then
        for _, mapID in ipairs(mapIDs) do
            ---@type number?, number?, string?
            local x, y, waypointDescription
            if mapID ~= targetMapID then x, y, waypointDescription = fallback(mapID) end
            if not MapPinEnhanced:IsSecretValue(x) and not MapPinEnhanced:IsSecretValue(y) and
                type(x) == "number" and type(y) == "number" then
                return x, y, mapID, waypointDescription, false
            end
        end
    end
    if sourceFallback then
        local mapID, x, y = sourceFallback()
        if MapPinEnhanced:IsReadablePositiveInteger(mapID) and
            MapPinEnhanced:IsCoordinate(x) and MapPinEnhanced:IsCoordinate(y) then
            return x, y, mapID, nil, false
        end
    end
    if targetMapID then
        local x, y, description = self:GetNavigationWaypointForMap(targetMapID)
        if x and y then return x, y, targetMapID, description, true end
    end
    for _, mapID in ipairs(mapIDs) do
        ---@type number?, number?, string?
        local x, y, waypointDescription
        if mapID ~= targetMapID then x, y, waypointDescription = self:GetNavigationWaypointForMap(mapID) end
        if x and y then return x, y, mapID, waypointDescription, true end
    end
end
