---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

---@alias SuperTrackingWaypointResolver fun(mapID: number): number?, number?, string?

---@type SuperTrackingWaypointResolver
local GetNextWaypointForMap = C_SuperTrack.GetNextWaypointForMap

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
---@return number? x
---@return number? y
---@return number? mapID
---@return string? waypointDescription
function Providers:GetSuperTrackingWaypoint(fallback)
    local mapIDs = self:GetSuperTrackingMapIDs()
    for _, mapID in ipairs(mapIDs) do
        local x, y, waypointDescription = GetNextWaypointForMap(mapID)
        if type(x) == "number" and type(y) == "number" then
            return x, y, mapID, waypointDescription
        end
    end

    if fallback then
        for _, mapID in ipairs(mapIDs) do
            local x, y, waypointDescription = fallback(mapID)
            if type(x) == "number" and type(y) == "number" then
                return x, y, mapID, waypointDescription
            end
        end
    end
end
