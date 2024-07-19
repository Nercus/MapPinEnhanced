---@meta


---@class UiMapPoint
UiMapPoint = {}

---@param mapID number
---@param x number
---@param y number
---@param z number
---@return UiMapPoint
function UiMapPoint.CreateFromCoordinates(mapID, x, y, z) end

---@param mapID number
---@param position Vector2DMixin
---@param z number
---@return UiMapPoint
function UiMapPoint.CreateFromVector2D(mapID, position, z) end

---@param mapID number
---@param position Vector3DMixin
---@return UiMapPoint
function UiMapPoint.CreateFromVector3D(mapID, position) end
