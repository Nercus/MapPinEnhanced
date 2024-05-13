---@class Wayfinder
local Wayfinder = select(2, ...)
local commandList = {} ---@type table<string, function>


SLASH_Wayfinder1, SLASH_Wayfinder2 = "/find", "/wf"
if not Wayfinder.isTomTomLoaded then
  SLASH_Wayfinder3 = "/way"
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
    -- NOTE: here can be a default call for a slash command without arguments
  end
end

SlashCmdList["Wayfinder"] = SlashCommandHandler

function Wayfinder:AddSlashCommand(command, func)
  commandList[command] = func
end
