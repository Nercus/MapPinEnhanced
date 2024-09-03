---@class MapPinEnhanced
---@field modules table<string, table>
---@field GetModule fun(self, name:"Blizz"): Blizz
---@field GetModule fun(self, name:"Options"): Options
---@field GetModule fun(self, name:"PinFactory"): PinFactory
---@field GetModule fun(self, name:"PinProvider"): PinProvider
---@field GetModule fun(self, name:"SetFactory"): SetFactory
---@field GetModule fun(self, name:"SetManager"): SetManager
---@field GetModule fun(self, name:"PinManager"): PinManager
---@field GetModule fun(self, name:"EditorWindow"): EditorWindow
---@field GetModule fun(self, name:"Tests"): Tests
---@field GetModule fun(self, name:"SavedVars"): SavedVars
---@field GetModule fun(self, name:"Dialog"): Dialog
local MapPinEnhanced = select(2, ...)

---@alias ModuleName "Blizz" | "Options" | "PinFactory" | "PinProvider" | "SetFactory" | "SetManager" | "PinManager" | "EditorWindow" | "SavedVars"


---@param name string
---@return table
function MapPinEnhanced:CreateModule(name)
    local module = {}
    if (not self.modules) then
        self.modules = {}
    end
    self.modules[name] = module
    return module
end

function MapPinEnhanced:GetModule(name)
    if (not self.modules or not self.modules[name]) then
        return self:CreateModule(name)
    end
    return self.modules[name]
end
