---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@param mapID number?
---@return boolean
function MapPinEnhanced:IsZoneMap(mapID)
    if not self:IsReadablePositiveInteger(mapID) then return false end
    local info = C_Map.GetMapInfo(mapID)
    return info ~= nil and info.mapType > Enum.UIMapType.Continent
end

---@param mapID number
---@param x number
---@param y number
---@return number mapID
---@return number x
---@return number y
function MapPinEnhanced:ResolveZonePosition(mapID, x, y)
    local hbd = self.HBD
    if not hbd or not C_Map.GetMapInfoAtPosition or
        not self:IsReadablePositiveInteger(mapID) or not self:IsCoordinate(x) or not self:IsCoordinate(y) then
        return mapID, x, y
    end
    local visited = {} ---@type table<number, boolean>
    local mapInfo = C_Map.GetMapInfo(mapID)
    while mapInfo and mapInfo.mapType <= Enum.UIMapType.Zone do
        visited[mapID] = true
        local child = C_Map.GetMapInfoAtPosition(mapID, x, y)
        if not child or visited[child.mapID] or child.mapType < mapInfo.mapType then break end
        if child.mapType == mapInfo.mapType then
            if child.mapType <= Enum.UIMapType.Continent then
                if child.parentMapID ~= mapID then break end
            elseif child.mapType == Enum.UIMapType.Zone then
                -- Cities may share their surrounding zone's map type. Overlap
                -- alone cannot prove a connection into a different zone.
                local minX, minY = hbd:TranslateZoneCoordinates(0, 0, child.mapID, mapID)
                local maxX, maxY = hbd:TranslateZoneCoordinates(1, 1, child.mapID, mapID)
                if not self:IsCoordinate(minX) or not self:IsCoordinate(minY) or
                    not self:IsCoordinate(maxX) or not self:IsCoordinate(maxY) or
                    not (minX < maxX and minY < maxY) or
                    not (minX > 0 or minY > 0 or maxX < 1 or maxY < 1) then
                    break
                end
            else
                break
            end
        end
        local childX, childY = hbd:TranslateZoneCoordinates(x, y, mapID, child.mapID)
        -- Overview artwork can contain zones in another world instance. Only
        -- use the native rectangle for the child identified at this position.
        if mapInfo.mapType <= Enum.UIMapType.Continent and
            (not self:IsCoordinate(childX) or not self:IsCoordinate(childY)) and C_Map.GetMapRectOnMap then
            local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(child.mapID, mapID)
            if self:IsReadableNumber(minX) and self:IsReadableNumber(maxX) and
                self:IsReadableNumber(minY) and self:IsReadableNumber(maxY) and minX < maxX and minY < maxY then
                childX, childY = (x - minX) / (maxX - minX), (y - minY) / (maxY - minY)
            end
        end
        if not self:IsCoordinate(childX) or not self:IsCoordinate(childY) then break end
        mapID, x, y = child.mapID, childX, childY
        mapInfo = child
    end
    return mapID, x, y
end
