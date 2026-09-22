---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

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

---@param mapID number?
---@param x number?
---@param y number?
---@return boolean
function Providers:IsNavigationTargetDirect(mapID, x, y)
    if not mapID or not x or not y then return false end
    local playerMapID = C_Map.GetBestMapForUnit("player")
    if not playerMapID then return false end
    local targetIsLocal = mapID == playerMapID
    local nextX, nextY = self:GetNavigationWaypointForMap(playerMapID)
    if issecretvalue and (issecretvalue(nextX) or issecretvalue(nextY)) then return false end
    if nextX == nil or nextY == nil then
        local displayMapID = MapUtil and MapUtil.GetDisplayableMapForPlayer and
            MapUtil.GetDisplayableMapForPlayer()
        if displayMapID then targetIsLocal = targetIsLocal or mapID == displayMapID end
        if displayMapID and displayMapID ~= playerMapID then
            playerMapID = displayMapID
            nextX, nextY = self:GetNavigationWaypointForMap(playerMapID)
        end
    end
    if issecretvalue and (issecretvalue(nextX) or issecretvalue(nextY)) then return false end
    if nextX == nil and nextY == nil then
        -- This API supplies intermediate waypoints. A direct local target can
        -- have a valid native frame without any intermediate waypoint at all.
        if not C_Navigation.GetFrame() or not C_Navigation.HasValidScreenPosition() then
            return false
        end
        if C_SuperTrack.IsSuperTrackingUserWaypoint() then
            local waypoint = C_Map.GetUserWaypoint()
            if not waypoint then return false end
            local distance = MapPinEnhanced.HBD:GetZoneDistance(waypoint.uiMapID,
                waypoint.position.x, waypoint.position.y, mapID, x, y)
            return type(distance) == "number" and distance <= 5
        end
        return targetIsLocal and C_SuperTrack.IsSuperTrackingAnything()
    end
    if type(nextX) ~= "number" or type(nextY) ~= "number" then return false end
    -- Query the player's map, not the destination map: the latter can expose
    -- the final waypoint while the native frame guides an earlier portal.
    local distance = MapPinEnhanced.HBD:GetZoneDistance(playerMapID, nextX, nextY, mapID, x, y)
    return type(distance) == "number" and distance <= 5
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
---@return number? x
---@return number? y
---@return number? mapID
---@return string? waypointDescription
---@return boolean? traversalOnly no source-owned destination was resolved
function Providers:GetSuperTrackingWaypoint(fallback, targetMapID)
    -- A temporary waypoint's traversal is not a new external destination.
    if self:IsStepSuperTracking() then return end
    local mapIDs = self:GetSuperTrackingMapIDs()
    if targetMapID and targetMapID > 0 then table.insert(mapIDs, 1, targetMapID) end
    -- Resolve the selected source before considering its traversal entrance.
    -- Otherwise arriving at a portal can remove a distant map pin/content target.
    if fallback then
        for _, mapID in ipairs(mapIDs) do
            local x, y, waypointDescription = fallback(mapID)
            if not MapPinEnhanced:IsSecretValue(x) and not MapPinEnhanced:IsSecretValue(y) and
                type(x) == "number" and type(y) == "number" then
                return x, y, mapID, waypointDescription, false
            end
        end
    end
    for _, mapID in ipairs(mapIDs) do
        local x, y, waypointDescription = self:GetNavigationWaypointForMap(mapID)
        if x and y then return x, y, mapID, waypointDescription, true end
    end
end
