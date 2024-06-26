---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local commandList = {} ---@type table<string, function>


SLASH_MapPinEnhanced1, SLASH_MapPinEnhanced2 = "/mph", "/mpe"
if not MapPinEnhanced.isTomTomLoaded then
    SLASH_MapPinEnhanced3 = "/way"
end

local SlashCmdList = getglobal("SlashCmdList") ---@as table<string, function>

---parse the full msg and split into the different arguments
---@param msg string
function SlashCommandHandler(msg)
    local args = {} ---@type table<number, string>
    for word in string.gmatch(msg, "[^%s]+") do
        table.insert(args, word)
    end
    local command = args[1]
    if commandList[command] then
        pcall(commandList[command], unpack(args))
    else
        MapPinEnhanced:TogglePinTracker()
    end
end

SlashCmdList["MapPinEnhanced"] = SlashCommandHandler

function MapPinEnhanced:AddSlashCommand(command, func)
    commandList[command] = func
end
