---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")


function SetFactory:CreateSet(name)
    local pins = {}

    local function AddPin(pinData)
        table.insert(pins, pinData)
        SetManager:PersistSets()
    end

    local function GetPins()
        return pins
    end

    return {
        name = name,
        AddPin = AddPin,
        GetPins = GetPins,
    }
end
