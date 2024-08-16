---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local PinManager = MapPinEnhanced:GetModule("PinManager")

---------------------------------------------------------------------------

MapPinEnhanced:AddSlashCommand(L["Back"]:lower(), function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Notify(L["You are in an instance or a zone where the map is not available"])
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    PinManager:AddPin({
        title = L["My way back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = true,
        persistent = true,
    })
end, L["Create a pin at your current location"])
