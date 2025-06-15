local MAJOR, MINOR = "NercLib", 1
assert(LibStub, MAJOR .. " requires LibStub")

---@class NercLib
local NercLib = LibStub:NewLibrary(MAJOR, MINOR)
if not NercLib then return end

_G.NercLib = NercLib

---@alias DEFAULT_MODULES "Debug"|"Events"|"Menu"|"Options"|"SavedVars"|"SlashCommand"|"Tests"|"Text"|"Utils"|"Localization"|"Logging"
---@type table<string, NercLibAddon>
local addons = {}

---@param addonName string The name of the addon to create
---@param tableName string The saved variables to use for the addon
---@return NercLibAddon
function NercLib:CreateAddon(addonName, tableName)
    assert(addonName, "Addon name not provided")
    assert(tableName, "Saved variables table name not provided")

    ---@class NercLibAddon
    local addon = {
        name = addonName,
        tableName = tableName,
        ---@type table<string, table>
        modules = {}
    }

    ---@generic T
    ---@param name `T`|DEFAULT_MODULES
    ---@return T
    function addon:GetModule(name)
        assert(self.modules, "Modules not initialized")
        assert(name, "Module name not provided")

        if (not self.modules or not self.modules[name]) then
            local m = {}
            if (not self.modules) then
                self.modules = {}
            end
            self.modules[name] = m
            return m
        end
        return self.modules[name]
    end

    ---@cast self NercLibPrivate
    self:AddPersistenceModule(addon)
    self:AddEventsModule(addon)
    self:AddTextModule(addon)
    self:AddSlashCommandModule(addon)
    self:AddUtilsModule(addon)
    self:AddMenuModule(addon)
    self:AddTestsModule(addon)
    self:AddDebugModule(addon)
    self:AddOptionModule(addon)
    self:AddLocalizationModule(addon)
    self:AddLoggingModule(addon)

    addons[addonName] = addon
    return addon
end

---@generic T
---@param addonName T | string
---@return T
function NercLib:GetAddon(addonName)
    assert(addonName, "Addon name not provided")
    assert(addons[addonName], "Addon not found: " .. addonName)
    return addons[addonName]
end
