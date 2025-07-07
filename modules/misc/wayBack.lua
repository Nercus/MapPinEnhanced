---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")

---------------------------------------------------------------------------

MapPinEnhanced:AddSlashCommand(L["Back"]:lower(), function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Print(L["You Are in an Instance or a Zone Where the Map Is Not Available"])
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    local uncategorizedGroup = Groups:GetGroupByName(L["Uncategorized Pins"])
    assert(uncategorizedGroup, L["Uncategorized Pins group not found. Please create it first."])
    uncategorizedGroup:AddPin({
        title = L["My Way Back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = true,
    })
end, L["Create a Pin at Your Current Location"])
