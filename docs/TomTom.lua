---@meta

---@class TomTom
TomTom = {}

---@alias map integer
---@alias x number
---@alias y number
---@alias uid table
---@alias callbacks table

--- AddWaypoint creates a new waypoint.
--- @param map map The map ID.
--- @param x x The horizontal coordinate.
--- @param y y The vertical coordinate.
--- @param options table The options for the waypoint.
--- @return uid The created waypoint.
function TomTom:AddWaypoint(map, x, y, options) end

--- Generate the default callback tables using the given options table.
--- @param opts table The options for the callbacks.
--- @return callbacks The default callbacks.
function TomTom:DefaultCallbacks(opts) end

--- AddWaypointToCurrentZone creates a waypoint in the current zone with all default options except for the description.
--- @param x x The horizontal coordinate.
--- @param y y The vertical coordinate.
--- @param desc string The description of the waypoint.
--- @return uid The created waypoint.
function TomTom:AddWaypointToCurrentZone(x, y, desc) end

--- RemoveWaypoint removes the waypoint identified by the uid from the world-map, mini-map and crazy arrow.
--- @param uid uid The waypoint to remove.
function TomTom:RemoveWaypoint(uid) end

--- HideWaypoint on either the mini-map or world-map.
--- @param uid uid The waypoint to hide.
--- @param minimap boolean Whether to hide on the mini-map.
--- @param worldmap boolean Whether to hide on the world-map.
function TomTom:HideWaypoint(uid, minimap, worldmap) end

--- ShowWaypoint as per the options.
--- @param uid uid The waypoint to show.
function TomTom:ShowWaypoint(uid) end

--- ClearWaypoint deactivates the waypoint.
--- @param uid uid The waypoint to clear.
function TomTom:ClearWaypoint(uid) end

--- Return the number of yards to reach the waypoint.
--- @param uid uid The waypoint to measure distance to.
--- @return number The distance in yards.
function TomTom:GetDistanceToWaypoint(uid) end

--- Return the angle (in radians) to the waypoint.
--- @param uid uid The waypoint to measure direction to.
--- @return number The angle in radians.
function TomTom:GetDirectionToWaypoint(uid) end

--- Set the arrow to the closest waypoint.
--- @param verbose boolean Whether to announce in chat.
function TomTom:SetClosestWaypoint(verbose) end

--- Return the current map, x, and y coordinates of the player.
--- @return map, x, y The current player position.
function TomTom:GetCurrentPlayerPosition() end
