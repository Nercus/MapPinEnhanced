---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local PinManager = MapPinEnhanced:GetModule("PinManager")

---------------------------------------------------------------------------

MapPinEnhanced:AddSlashCommand(L["Back"]:lower(), function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Notify(L["You Are in an Instance or a Zone Where the Map Is Not Available"])
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    PinManager:AddPin({
        title = L["My Way Back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = true,
        lock = true,
    })
end, L["Create a Pin at Your Current Location"])
