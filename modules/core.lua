---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


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

--- we run that on a independent frame as the event module doesn't exist yet
local intializeFrame = CreateFrame("Frame")
intializeFrame:RegisterEvent("PLAYER_LOGIN")
intializeFrame:SetScript("OnEvent", OnInitialize)
