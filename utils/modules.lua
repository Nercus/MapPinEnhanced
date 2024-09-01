---@class MapPinEnhanced
---@field modules table<string, table>
local MapPinEnhanced = select(2, ...)


---@alias ModuleName "Blizz" | "Options" | "PinFactory" | "PinProvider"| "SetFactory" | "SetManager" |"PinManager" | "EditorWindow"

---@param name ModuleName
---@return table
function MapPinEnhanced:CreateModule(name)
    local module = {
        name = name,
    } ---@type table
    if (not self.modules) then
        self.modules = {}
    end
    self.modules[name] = module
    return module
end

---@generic T
---@param name `T`
---@return T
function MapPinEnhanced:GetModule(name)
    if (not self.modules or not self.modules[name]) then
        return self:CreateModule(name)
    end
    return self.modules[name]
end
