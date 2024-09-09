---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Events = MapPinEnhanced:GetModule("Events")

---@param name string
---@return table
function MapPinEnhanced:CreateModule(name)
    local m = {}
    if (not self.modules) then
        self.modules = {}
    end
    self.modules[name] = m
    return m
end

function MapPinEnhanced:GetModule(name)
    if (not self.modules or not self.modules[name]) then
        return self:CreateModule(name)
    end
    return self.modules[name]
end

local function OnInitialize()
    for _, m in pairs(MapPinEnhanced.modules) do
        if m.OnInitialize then
            m.OnInitialize()
        end
    end
end

--- run all OnInitialize functions
Events:RegisterEvent("PLAYER_LOGIN", OnInitialize)
