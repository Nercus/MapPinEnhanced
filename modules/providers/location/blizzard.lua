---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

---@param mapID number
---@param poiID number
---@return AreaPOIInfo?
function Providers:ReadLocationAreaPOI(mapID, poiID)
    if not C_AreaPoiInfo or not C_AreaPoiInfo.GetAreaPOIInfo or not MapPinEnhanced:IsZoneMap(mapID) then return end
    if not C_AreaPoiInfo.GetAreaPOIForMap or
        not tContains(C_AreaPoiInfo.GetAreaPOIForMap(mapID) or {}, poiID) then
        return
    end
    local info = C_AreaPoiInfo.GetAreaPOIInfo(mapID, poiID)
    if info and info.position and MapPinEnhanced:IsCoordinate(info.position.x) and
        MapPinEnhanced:IsCoordinate(info.position.y) then
        return info
    end
end
