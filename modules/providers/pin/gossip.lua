---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

---@return pinData?
function Providers:GetGuardPinData()
    if not C_GossipInfo or not C_GossipInfo.GetPoiForUiMapID or not C_GossipInfo.GetPoiInfo then return end
    -- Guard markers are gossip POIs, not supertracked map pins. Reuse the map
    -- candidates to resolve city/subzone projections without opening the map.
    for _, mapID in ipairs(self:GetSuperTrackingMapIDs()) do
        local poiID = C_GossipInfo.GetPoiForUiMapID(mapID)
        -- Dynamic guard destinations can use ID 0; it is a valid POI lookup.
        if MapPinEnhanced:IsReadableNumber(poiID) then
            local info = C_GossipInfo.GetPoiInfo(mapID, poiID)
            if info and info.position and MapPinEnhanced:IsCoordinate(info.position.x) and
                MapPinEnhanced:IsCoordinate(info.position.y) then
                return {
                    mapID = mapID,
                    x = info.position.x,
                    y = info.position.y,
                    title = self:PlainDescription(info.name),
                }
            end
        end
    end
end
