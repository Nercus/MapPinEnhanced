---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")

MapPinEnhanced:AddSlashCommand(L["Back"]:lower(), function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Print(L["You Are in an Instance or a Zone Where the Map Is Not Available"])
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    local pinID = Groups:SetWayBackPin({
        title = L["My Way Back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = false,
    })
    if not pinID then
        MapPinEnhanced:Print(L["My Way Back is unavailable on the map you are on right now."])
    end
end, L["Create a Pin at Your Current Location"])
