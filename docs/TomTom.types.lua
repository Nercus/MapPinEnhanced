---@meta

---@class TomTom
---@field db? { profile: { arrow: { stickycorpse: boolean } } }
local TomTomAPI = {}

---@class TomTomUID : table
---@field [1] number map
---@field [2] number x
---@field [3] number y
---@field title? string
---@field minimap_icon? string|number
---@field corpse? boolean

---@class TomTomCallbacks
---@field distance table<number, function>
---@field minimap { onclick: fun(event, uid: TomTomUID, self, button), tooltip_show: fun(event, tooltip, uid: TomTomUID, dist), tooltip_update: fun(event, tooltip, uid: TomTomUID, dist) }
---@field world { onclick: fun(event, uid: TomTomUID, self, button), tooltip_show: fun(event, tooltip, uid: TomTomUID, dist), tooltip_update: fun(event, tooltip, uid: TomTomUID, dist) }

---@class TomTomWaypointOptions
---@field title? string
---@field source? string
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
---MapPinEnhanced's stand-in returns a session-local handle on success.
---It supports title, minimap_icon and crazy; native callbacks/display settings are not emulated.
---@param map number
---@param x number
---@param y number
---@param options TomTomWaypointOptions?
---@return TomTomUID?
function TomTomAPI:AddWaypoint(map, x, y, options) end

---Generate the default callback tables using the given options table.
---@param opts table
---@return TomTomCallbacks
function TomTomAPI:DefaultCallbacks(opts) end

---Add a waypoint to the current zone.
---@param x number
---@param y number
---@param desc string?
---@return TomTomUID?
function TomTomAPI:AddWaypointToCurrentZone(x, y, desc) end

---Remove a waypoint.
---@param uid TomTomUID
function TomTomAPI:RemoveWaypoint(uid) end

---Hide a waypoint on minimap or worldmap.
---@param uid TomTomUID
---@param minimap? boolean
---@param worldmap? boolean
function TomTomAPI:HideWaypoint(uid, minimap, worldmap) end

---Show a waypoint.
---@param uid TomTomUID
function TomTomAPI:ShowWaypoint(uid) end

---Clear (deactivate) a waypoint.
---@param uid TomTomUID
function TomTomAPI:ClearWaypoint(uid) end

---Get distance to a waypoint in yards.
---@param uid TomTomUID
---@return number?
function TomTomAPI:GetDistanceToWaypoint(uid) end

---Get direction (in radians) to a waypoint.
---@param uid TomTomUID
---@return number
function TomTomAPI:GetDirectionToWaypoint(uid) end

---Set the arrow to the closest waypoint.
---@param verbose? boolean
---@return TomTomUID?
function TomTomAPI:SetClosestWaypoint(verbose) end

---Get the current player position.
---@return number? mapID, number? x, number? y
function TomTomAPI:GetCurrentPlayerPosition() end

---@param uid TomTomUID
---@param distance? number
---@param title? string
function TomTomAPI:SetCrazyArrow(uid, distance, title) end

---@param remove? boolean
function TomTomAPI:ClearCrazyArrowPoint(remove) end

---@return boolean
function TomTomAPI:IsCrazyArrowEmpty() end

---@param uid TomTomUID
---@return boolean
function TomTomAPI:IsValidWaypoint(uid) end

---@param mapID number
---@param x number
---@param y number
---@param title? string
---@return boolean
function TomTomAPI:WaypointExists(mapID, x, y, title) end

---@return TomTomUID?
function TomTomAPI:GetClosestWaypoint() end

---MapPinEnhanced stand-in convenience method; not part of native TomTom's API.
function TomTomAPI:ClearAllWaypoints() end

---@type TomTom?
TomTom = nil
