---@meta

---@class TomTom
TomTom = {}

---@class TomTomUID : table
---@field [1] number map
---@field [2] number x
---@field [3] number y
---@field title string

---@class TomTomCallbacks
---@field distance table<number, function>
---@field minimap { onclick: fun(event, uid: TomTomUID, self, button), tooltip_show: fun(event, tooltip, uid: TomTomUID, dist), tooltip_update: fun(event, tooltip, uid: TomTomUID, dist) }
---@field world { onclick: fun(event, uid: TomTomUID, self, button), tooltip_show: fun(event, tooltip, uid: TomTomUID, dist), tooltip_update: fun(event, tooltip, uid: TomTomUID, dist) }

---@class TomTomWaypointOptions
---@field title string
---@field source string
---@field persistent? boolean
---@field minimap? boolean
---@field minimap_icon? any
---@field minimap_icon_size? any
---@field world? boolean
---@field worldmap_icon? boolean
---@field worldmap_icon_size? boolean
---@field crazy? boolean
---@field cleardistance? number
---@field arrivaldistance? number
---@field silent? boolean
---@field callbacks? TomTomCallbacks

---Add a waypoint to the map.
---@param map number
---@param x number
---@param y number
---@param options TomTomWaypointOptions
---@return TomTomUID
function TomTom:AddWaypoint(map, x, y, options) end

---Generate the default callback tables using the given options table.
---@param opts table
---@return TomTomCallbacks
function TomTom:DefaultCallbacks(opts) end

---Add a waypoint to the current zone.
---@param x number
---@param y number
---@param desc string
---@return TomTomUID
function TomTom:AddWaypointToCurrentZone(x, y, desc) end

---Remove a waypoint.
---@param uid TomTomUID
function TomTom:RemoveWaypoint(uid) end

---Hide a waypoint on minimap or worldmap.
---@param uid TomTomUID
---@param minimap? boolean
---@param worldmap? boolean
function TomTom:HideWaypoint(uid, minimap, worldmap) end

---Show a waypoint.
---@param uid TomTomUID
function TomTom:ShowWaypoint(uid) end

---Clear (deactivate) a waypoint.
---@param uid TomTomUID
function TomTom:ClearWaypoint(uid) end

---Get distance to a waypoint in yards.
---@param uid TomTomUID
---@return number
function TomTom:GetDistanceToWaypoint(uid) end

---Get direction (in radians) to a waypoint.
---@param uid TomTomUID
---@return number
function TomTom:GetDirectionToWaypoint(uid) end

---Set the arrow to the closest waypoint.
---@param verbose? boolean
function TomTom:SetClosestWaypoint(verbose) end

---Get the current player position.
---@return number, number, number
function TomTom:GetCurrentPlayerPosition() end
