---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

---@param dataString string the string to import, either a Map Pin Enhanced export string or a slash command
function Providers:ImportTemporary(dataString)
    local hasPrefix = MapPinEnhanced:IsSerializedData(dataString)
    if hasPrefix then

    else
        local groupName = Groups:GetAvailableImportGroupName()
        local group = Groups:RegisterGroup({
            name = groupName,
            source = MapPinEnhanced.name,
            order = GetTime(),
            icon = "Interface\\Icons\\achievement_guildperk_workingovertime_rank2",
        })
        if not group then return end
        for line in dataString:gmatch("[^\n]+") do
            self:ImportSlashCommand(line, groupName)
        end
    end
end
