---@diagnostic disable: global-element The slash command definition has to be global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

local commandList = {} ---@type table<string, function>
local commandHelpStrings = {} ---@type table<string, string>

SLASH_MapPinEnhanced1, SLASH_MapPinEnhanced2 = "/mph", "/mpe"


local normalColor = CreateColor(1, 0.82, 0)
local SlashCmdList = getglobal("SlashCmdList") ---@as table<string, function>
local helpPattern = "|A:gearupdate-arrow-bullet-point:12:12:2:-2|a %s - %s"
function MapPinEnhanced:PrintHelp()
    print(self:WrapTextInColor(self.nameVersionString, normalColor))
    for command, help in pairs(commandHelpStrings) do
        help = self:WrapTextInColor(help, normalColor)
        local helpString = helpPattern:format(command, help)
        print(helpString)
    end
end

---parse the full msg and split into the different arguments
---@param msg string
local function SlashCommandHandler(msg)
    local args = {} ---@type table<number, string>
    for word in string.gmatch(msg, "[^%s]+") do
        table.insert(args, word)
    end
    local command = args[1]
    if commandList[command] then
        pcall(commandList[command], unpack(args))
    else
        MapPinEnhanced:PrintHelp()
    end
end

SlashCmdList["MapPinEnhanced"] = SlashCommandHandler

---Add a slash command to the list
---@param command string
---@param func function
---@param help string
function MapPinEnhanced:AddSlashCommand(command, func, help)
    commandList[command] = func
    commandHelpStrings[command] = help
end

MapPinEnhanced:AddSlashCommand(L["Help"]:lower(), function()
    MapPinEnhanced:PrintHelp()
end, L["Show this help message"])
