---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L


---@param msg string the slash command message to parse
---@param groupName string? the name of the group to add the pin to, if nil it will be added to the uncategorized section
function Providers:ImportSlashCommand(msg, groupName)
    local title, mapID, coords = MapPinEnhanced:ParseWayCommandToData(msg)
    if mapID and coords and coords[1] and coords[2] then
        if not groupName then
            groupName = L["Uncategorized Pins"]
        end
        local group = Groups:GetGroupByName(groupName)
        if not group then
            return
        end
        group:AddPin({
            mapID = mapID,
            x = coords[1] / 100,
            y = coords[2] / 100,
            title = title,
            setTracked = true,
        })
    end
end
