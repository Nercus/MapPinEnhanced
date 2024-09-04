---@class MapPinEnhanced
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
