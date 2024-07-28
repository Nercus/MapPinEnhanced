---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")

local TrackerSetEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate")
local SetEditorEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate") -- NOTE: currently the same template

---@class SetObject
---@field setID UUID
---@field name string
---@field AddPin fun(self, pinData:pinData, restore:boolean?)
---@field GetPinsByPosition fun(self, mapID:number, x:number, y:number):table<UUID, pinData>
---@field GetPinByID fun(self, setpinID:UUID):pinData
---@field RemovePinsByPostion fun(self, mapID:number, x:number, y:number)
---@field RemovePinByID fun(self, pinsetID:UUID)
---@field Delete fun()
---@field GetPins fun():table<string, pinData>
---@field GetPin fun(self, mapID:string, x:number, y:number):pinData
---@field TrackerSetEntry MapPinEnhancedTrackerSetEntryMixin
---@field SetEditorEntry MapPinEnhancedTrackerSetEntryMixin

function SetFactory:CreateSet(name)
    local TrackerSetEntry = TrackerSetEntryPool:Acquire()
    ---@cast TrackerSetEntry MapPinEnhancedTrackerSetEntryMixin

    local SetEditorEntry = SetEditorEntryPool:Acquire()
    ---@cast SetEditorEntry MapPinEnhancedTrackerSetEntryMixin

    TrackerSetEntry:SetTitle(name)
    SetEditorEntry:SetTitle(name)


    ---@type table<UUID, pinData>
    local pins = {}

    ---@param pinData pinData
    ---@param restore boolean?
    local function AddPin(_, pinData, restore)
        local setpinID = MapPinEnhanced:GenerateUUID("setpin")
        pinData.setTracked = false
        pins[setpinID] = pinData
        if restore then return end
        SetManager:PersistSets()
    end

    ---@param mapID number
    ---@param x number
    ---@param y number
    ---@return table<UUID, pinData>
    local function GetPinsByPosition(_, mapID, x, y)
        ---@type table<UUID, pinData>
        local pinsByPosition = {}
        for setpinID, pin in pairs(pins) do
            if pin.mapID == mapID and pin.x == x and pin.y == y then
                pinsByPosition[setpinID] = pin
            end
        end
        return pinsByPosition
    end


    ---@param setpinID UUID
    ---@return pinData
    local function GetPinByID(_, setpinID)
        return pins[setpinID]
    end

    ---@param mapID number
    ---@param x number
    ---@param y number
    local function RemovePinsByPostion(_, mapID, x, y)
        local pinsToRemove = GetPinsByPosition(_, mapID, x, y)
        for setpinID, _ in pairs(pinsToRemove) do
            pins[setpinID] = nil
        end
        SetManager:PersistSets()
    end

    ---@param pinsetID UUID
    local function RemovePinByID(_, pinsetID)
        pins[pinsetID] = nil
        SetManager:PersistSets()
    end

    local function Delete()
        for setpinID, _ in pairs(pins) do
            pins[setpinID] = nil
        end
        TrackerSetEntryPool:Release(TrackerSetEntry)
        SetEditorEntryPool:Release(SetEditorEntry)
    end

    ---@return table<UUID, pinData>
    local function GetPins()
        return pins
    end


    local function LoadSet(override)
        if override then
            PinManager:ClearPins()
        end
        local pins = GetPins()
        for _, pinData in pairs(pins) do
            PinManager:AddPin(pinData)
        end
        MapPinEnhanced:SetPinTrackerView('Pins')
    end



    TrackerSetEntry:SetScript("OnClick", function()
        LoadSet(IsShiftKeyDown())
    end)

    return {
        name = name,
        AddPin = AddPin,
        RemovePinsByPos = RemovePinsByPostion,
        RemovePinByID = RemovePinByID,
        GetPinsByPosition = GetPinsByPosition,
        GetPinByID = GetPinByID,
        GetPins = GetPins,
        Delete = Delete,
        TrackerSetEntry = TrackerSetEntry,
        SetEditorEntry = SetEditorEntry
    }
end
