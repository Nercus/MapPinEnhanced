---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")


---@class PinManager
local PinManager = MapPinEnhanced:GetModule("PinManager")


local GetUserWaypoint = C_Map.GetUserWaypoint

local blockEvent = false
--- USER_WAYPOINT_UPDATED event handler
function PinProvider:USER_WAYPOINT_UPDATED()
    if blockEvent then return end -- as super tracking a pin triggers this event we need to block it so we don't get into an infinite loop

    local wp = GetUserWaypoint()
    if not wp then return end
    blockEvent = true

    local title, texture, usesAtlas = PinProvider:DetectMouseFocusPinInfo()
    PinManager:AddPin({
        mapID = wp.uiMapID,
        x = wp.position.x,
        y = wp.position.y,
        title = title,
        texture = texture,
        usesAtlas = usesAtlas,
        setTracked = true
    })

    blockEvent = false
end

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", function()
    PinProvider:USER_WAYPOINT_UPDATED()
end)
