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
    local wayBackGroup = Groups:GetWayBackGroup()
    assert(wayBackGroup, L["My Way Back group not found. Please create it first."])
    wayBackGroup:AddPin({
        title = L["My Way Back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = false,
    })
end, L["Create a Pin at Your Current Location"])
