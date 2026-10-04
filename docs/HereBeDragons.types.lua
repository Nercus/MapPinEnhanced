---@meta

---@class HereBeDragons-2.0
HereBeDragons = {}

---@class HereBeDragonMapData
---@field mapType Enum.UIMapType
---@field parent number
---@field name string
---@field instance number


--- Get the World Coordinates to the specified Zone Coordinates
---@param x number X coordinates in the Zone Coordinate system (0-1)
---@param y number Y coordinates in the Zone Coordinate system (0-1)
---@param zone number UIMapID of the zone
---@return number x X coordinate in the World Coordinate system
---@return number y Y coordinate in the World Coordinate system
---@return number instance InstanceID of the continent these coordinates belong to
function HereBeDragons:GetWorldCoordinatesFromZone(x, y, zone) end

--- Project world west/north coordinates onto a UI map in the matching instance.
---@param x number
---@param y number
---@param instance number
---@param zone number
---@param allowOutOfBounds boolean?
---@return number? x
---@return number? y
function HereBeDragons:GetZoneCoordinatesFromWorldInstance(x, y, instance, zone, allowOutOfBounds) end
