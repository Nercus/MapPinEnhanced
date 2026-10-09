---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type table<string, function> a list of commands and their associated functions
local commandList = {}

---@type table<string, function> locale and secondary aliases; canonical commands take precedence
local commandAliases = {}

---@type table<string, string> a list of commands and their associated help strings
local commandHelpStrings = {}

local Providers = MapPinEnhanced:GetModule("Providers")

---Set a slash command trigger for the addon
---@param trigger string the slash command trigger
---@param triggerIndex number a contineous number that is used to identify the trigger
function MapPinEnhanced:SetSlashTrigger(trigger, triggerIndex)
    assert(type(trigger) == "string", "Slash command trigger not provided")
    assert(trigger:sub(1, 1) == "/", "Slash command trigger must start with /")

    local SLASH_PREFIX = string.format("SLASH_%s", self.name:upper())
    local GLOBAL_NAME = string.format("%s%d", SLASH_PREFIX, triggerIndex)
    ---@diagnostic disable-next-line: no-unknown
    _G[GLOBAL_NAME] = trigger
    ---@type function
    SlashCmdList[self.name:upper()] = function(msg)
        local args = {} ---@type table<number, string>
        for word in string.gmatch(msg, "[^%s]+") do
            table.insert(args, word)
        end
        local command = args[1]
        local secondArg = args[2]
        local handler = commandList[command] or commandAliases[command]
        if handler then
            handler(unpack(args))
        elseif secondArg == nil then
            self:PrintHelp()
        else
            Providers:ImportSlashCommand(msg)
        end
    end
end

local bulletColor = CreateColor(1, 0.82, 0)
local helpColor = CreateColor(1, 0.82, 0)
local r, g, b = bulletColor:GetRGBAsBytes()
local helpPattern = string.format(
    "|T%s\\shared\\SlashHelpBulletPoint.png:8:8:2:-2:1:1:0:1:0:1:%d:%d:%d|t |cffffffff%%s|r - %%s",
    MapPinEnhanced.assetsPath, r, g, b)

---Print the help message for the addon
function MapPinEnhanced:PrintHelp()
    local addonVersion = C_AddOns.GetAddOnMetadata(self.name, "Version")
    local titleString = string.format("|T%s\\shared\\SlashHelpLogo.png:16:36:0:-2|t %s %s",
        self.assetsPath, self.name, addonVersion)
    self:PrintUnformatted(self:WrapTextInColor(titleString, helpColor))
    local commands = {} ---@type string[]
    for command in pairs(commandHelpStrings) do
        commands[#commands + 1] = command
    end
    table.sort(commands)
    for _, command in ipairs(commands) do
        local help = commandHelpStrings[command]
        local helpString = helpPattern:format("/mph " .. command, self:WrapTextInColor(help, helpColor))
        self:PrintUnformatted(helpString)
    end
    self:PrintUnformatted(helpPattern:format("/mph " .. self.L["<x> <y> [title]"],
        self:WrapTextInColor(self.L["Create and track a pin at percentage coordinates. Example: /mph 50 50 My pin"],
            helpColor)))
    local aliases = self.isTomTomLoaded and self.L["You can also use /mpe instead of /mph."] or
        self.L["You can also use /mpe or /way instead of /mph."]
    self:PrintUnformatted(self:WrapTextInColor(aliases, helpColor))
end

---@alias SlashCommand string|string[]

---Add a slash command to the list
---@param command SlashCommand the command or command aliases to add
---@param func function the function to call when the command is used
---@param help string the help message to display when the command is used
---@param showInHelp boolean? whether to list the command in help (defaults to true)
function MapPinEnhanced:AddSlashCommand(command, func, help, showInHelp)
    assert(type(command) == "string" or type(command) == "table", "Command not provided")
    assert(type(func) == "function", "Function not provided")
    assert(type(help) == "string", "Help not provided")
    local commands = type(command) == "table" and command or { command }
    local mainCommand = commands[1]
    assert(type(mainCommand) == "string", "Command not provided")
    assert(not commandList[mainCommand] or commandList[mainCommand] == func,
        "MapPinEnhanced:AddSlashCommand: duplicate command " .. mainCommand)

    -- Validate before publishing. Canonical names win regardless of registration order.
    for _, alias in ipairs(commands) do
        assert(type(alias) == "string", "Command alias must be a string")
        assert(alias == mainCommand or commandList[alias] or not commandAliases[alias] or
            commandAliases[alias] == func,
            "MapPinEnhanced:AddSlashCommand: conflicting alias " .. alias)
    end
    commandList[mainCommand] = func
    for _, alias in ipairs(commands) do
        if alias ~= mainCommand and not commandList[alias] then
            commandAliases[alias] = func
        end
    end
    commandHelpStrings[mainCommand] = showInHelp ~= false and help or nil

    self:AddDebugCustomDebugAction({
        type = "button",
        label = "/" .. mainCommand,
        onClick = func,
    })
end

---Remove a slash command from the list
---@param command string the command to remove
function MapPinEnhanced:RemoveSlashCommand(command)
    assert(type(command) == "string", "Command not provided")
    commandList[command] = nil
    commandAliases[command] = nil
    commandHelpStrings[command] = nil
end

---Enable the help command for the addon
function MapPinEnhanced:EnableHelpCommand()
    ---@diagnostic disable-next-line: undefined-global
    local helpString = HELP_LABEL --[[@as string]]

    self:AddSlashCommand({ "help", self.L["Help"]:lower(), helpString:lower() }, function()
        self:PrintHelp()
        ---@diagnostic disable-next-line: undefined-global
    end, helpString, false)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:EnableHelpCommand()
    local isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    MapPinEnhanced:SetSlashTrigger("/mph", 1)
    MapPinEnhanced:SetSlashTrigger("/mpe", 2)
    if not isTomTomLoaded then
        MapPinEnhanced:SetSlashTrigger("/way", 3)
    end
    MapPinEnhanced.isTomTomLoaded = isTomTomLoaded
end)
