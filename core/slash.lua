---@class MapPinEnhanced
---@field commandList table<string, function> a list of commands and their associated functions
---@field commandHelpStrings table<string, string> a list of commands and their associated help strings
local MapPinEnhanced = select(2, ...)

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
        if self.commandList[command] then
            pcall(self.commandList[command], unpack(args))
        else
            local defaultAction = self.commandList["default"]
            if defaultAction then
                pcall(defaultAction, unpack(args))
            else
                self:PrintHelp()
            end
        end
    end
end

local normalColor = CreateColor(1, 0.82, 0)
local helpPattern = "|A:communities-icon-notification:8:8:2:-2|a %s - %s"

---Print the help message for the addon
function MapPinEnhanced:PrintHelp()
    local addonVersion = C_AddOns.GetAddOnMetadata(self.name, "Version")
    local titleString = string.format("%s %s", self.name, addonVersion)
    self:PrintUnformatted(self:WrapTextInColor(titleString, normalColor))
    for command, help in pairs(self.commandHelpStrings) do
        local helpString = helpPattern:format(command, self:WrapTextInColor(help, normalColor))
        self:PrintUnformatted(helpString)
    end
end

---Set the default action for the addon when no command is provided
---@param func function the function to call when no command is provided
function MapPinEnhanced:SetDefaultAction(func)
    assert(type(func) == "function", "Default action not provided")
    assert(not self.commandList["default"], "Default action already set")
    if not self.commandList then
        self.commandList = {}
    end
    self.commandList["default"] = func
end

---Add a slash command to the list
---@param command string the command to add
---@param func function the function to call when the command is used
---@param help string the help message to display when the command is used
function MapPinEnhanced:AddSlashCommand(command, func, help)
    assert(type(command) == "string", "Command not provided")
    assert(type(func) == "function", "Function not provided")
    assert(type(help) == "string", "Help not provided")
    if not self.commandList then
        self.commandList = {}
    end
    if not self.commandHelpStrings then
        self.commandHelpStrings = {}
    end
    self.commandList[command] = func
    self.commandHelpStrings[command] = help
end

---Remove a slash command from the list
---@param command string the command to remove
function MapPinEnhanced:RemoveSlashCommand(command)
    assert(type(command) == "string", "Command not provided")
    self.commandList[command] = nil
    self.commandHelpStrings[command] = nil
end

---Enable the help command for the addon
function MapPinEnhanced:EnableHelpCommand()
    ---@diagnostic disable-next-line: undefined-global
    local helpString = HELP_LABEL --[[@as string]]

    self:AddSlashCommand(helpString:lower(), function()
        self:PrintHelp()
        ---@diagnostic disable-next-line: undefined-global
    end, helpString)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    local isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    MapPinEnhanced:SetSlashTrigger("/mph", 1)
    MapPinEnhanced:SetSlashTrigger("/mpe", 2)
    if not isTomTomLoaded then
        MapPinEnhanced:SetSlashTrigger("/way", 3)
    end
    MapPinEnhanced.isTomTomLoaded = isTomTomLoaded
end)
