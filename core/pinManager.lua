---@class Wayfinder
local Wayfinder = select(2, ...)


---@class PinFactory : Module
local PinFactory = Wayfinder:GetModule("PinFactory")
-- NOTE: Create, delete and manage pins here


local function CreateTestPin()
    PinFactory:CreatePin({
        mapID = 582,
        x = 0.2,
        y = 0.3,
    })
end


C_Timer.After(1, function()
    CreateTestPin()
end)
