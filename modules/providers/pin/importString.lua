---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

local L = MapPinEnhanced.L

---@param dataString string the string to import, either a Map Pin Enhanced export string or a slash command
function Providers:ImportTemporary(dataString)
    local hasPrefix = MapPinEnhanced:IsSerializedData(dataString)
    if hasPrefix then

    else
        self:ImportSlashCommand(dataString, L["Temporary Import"])
    end
end
