---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")

---@param target WayfinderData
---@return WayfinderData?
function Wayfinders:GetNavigationTraversal(target)
    local matches = self:IsSuperTrackingDestination(target.mapID, target.x, target.y)
    if not matches and C_SuperTrack.IsSuperTrackingUserWaypoint() then
        local waypoint = C_Map.GetUserWaypoint()
        local distance = waypoint and MapPinEnhanced.HBD:GetZoneDistance(waypoint.uiMapID,
            waypoint.position.x, waypoint.position.y, target.mapID, target.x, target.y)
        matches = type(distance) == "number" and distance <= 5
    end
    if not matches then return end
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return end
    local x, y, description = Providers:GetNavigationWaypointForMap(mapID)
    if not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) or
        type(description) ~= "string" or description == "" then return end
    local distance = MapPinEnhanced.HBD:GetZoneDistance(mapID, x, y, target.mapID, target.x, target.y)
    if type(distance) ~= "number" or distance <= 5 then return end
    return { mapID = mapID, x = x, y = y, title = description }
end

---@param mapID number?
---@param x number?
---@param y number?
---@return boolean
function Wayfinders:CanFollowNavigationTarget(mapID, x, y)
    if not mapID or not x or not y then return false end
    if not C_Navigation.GetFrame() or not C_Navigation.HasValidScreenPosition() then return false end
    -- Blizzard owns traversal for its selected destination. Its native guide may
    -- point to an entrance on another map rather than the destination itself.
    if self:IsSuperTrackingDestination(mapID, x, y) then return true end
    local playerMapID = C_Map.GetBestMapForUnit("player")
    if not playerMapID then return false end
    local targetIsLocal = mapID == playerMapID
    local nextX, nextY = Providers:GetNavigationWaypointForMap(playerMapID)
    if issecretvalue and (issecretvalue(nextX) or issecretvalue(nextY)) then return false end
    if nextX == nil or nextY == nil then
        local displayMapID = MapUtil and MapUtil.GetDisplayableMapForPlayer and
            MapUtil.GetDisplayableMapForPlayer()
        if displayMapID then targetIsLocal = targetIsLocal or mapID == displayMapID end
        if displayMapID and displayMapID ~= playerMapID then
            playerMapID = displayMapID
            nextX, nextY = Providers:GetNavigationWaypointForMap(playerMapID)
        end
    end
    if issecretvalue and (issecretvalue(nextX) or issecretvalue(nextY)) then return false end
    if nextX == nil and nextY == nil then
        -- This API supplies intermediate waypoints. A direct local target can
        -- have a valid native frame without any intermediate waypoint at all.
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

---@type UiMapPoint?
local ownedWaypoint

---@param waypoint UiMapPoint?
function Wayfinders:SetOwnedUserWaypoint(waypoint)
    if not waypoint then return end
    local previous = ownedWaypoint
    ownedWaypoint = waypoint
    C_Map.SetUserWaypoint(waypoint)
    ownedWaypoint = previous
end

---@param waypoint UiMapPoint
---@return boolean
function Wayfinders:IsOwnedUserWaypoint(waypoint)
    return waypoint == ownedWaypoint
end
