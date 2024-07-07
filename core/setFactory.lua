---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")


local TrackerSetEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate")

function SetFactory:CreateSet(name)
    local TrackerSetEntry = TrackerSetEntryPool:Acquire()
    ---@cast TrackerSetEntry MapPinEnhancedTrackerSetEntryMixin

    TrackerSetEntry:SetTitle(name)

    ---@type table<number, pinData>
    local pins = {}

    local function AddPin(_, pinData)
        table.insert(pins, pinData)
        SetManager:PersistSets()
    end
    local function RemovePin(_, mapID, x, y)
        for i, pin in ipairs(pins) do
            if pin.mapID == mapID and pin.x == x and pin.y == y then
                table.remove(pins, i)
                SetManager:PersistSets()
                return
            end
        end
    end

    local function GetPin(_, mapID, x, y)
        for _, pin in ipairs(pins) do
            if pin.mapID == mapID and pin.x == x and pin.y == y then
                return pin
            end
        end
    end

    local function GetPins()
        return pins
    end

    return {
        name = name,
        AddPin = AddPin,
        RemovePin = RemovePin,
        GetPin = GetPin,
        GetPins = GetPins,
        TrackerSetEntry = TrackerSetEntry
    }
end
