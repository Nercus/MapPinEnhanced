---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L


---@param msg string the slash command message to parse
---@param groupName string? the name of the group to add the pin to, if nil it will be added to the uncategorized section
function Pins:ImportSlashCommand(msg, groupName)
    local title, mapID, coords = MapPinEnhanced:ParseWayCommandToData(msg)
    if mapID and coords and coords[1] and coords[2] then
        ---@type MapPinEnhancedGroupMixin?
        local group
        if not groupName then
            group = Groups:GetUngroupedGroup()
        else
            group = Groups:GetGroupByName(groupName)
        end
        if not group then
            return
        end
        local _, pinID = group:AddPin({
            mapID = mapID,
            x = coords[1] / 100,
            y = coords[2] / 100,
            title = title,
            setTracked = true,
        })
        if pinID then MapPinEnhanced:GetModule("Tracker"):OnUserPinsAdded() end
    end
end

MapPinEnhanced:SetSlashFallback(function(message) Pins:ImportSlashCommand(message) end)
