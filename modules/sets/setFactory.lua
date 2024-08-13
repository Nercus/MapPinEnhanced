---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")

local TrackerSetEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate")
local setEditorEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate") -- currently the same template


---@class SetObject
---@field setID UUID
---@field name string
---@field AddPin fun(self, pinData:pinData, restore:boolean?)
---@field UpdatePin fun(self, setPinID:UUID, key:string, value:any)
---@field GetPinByID fun(self, setPinID:UUID):setPinData
---@field RemovePinByID fun(self, pinsetID:UUID)
---@field SetName fun(self, newName:string)
---@field GetPinsByOrder fun():setPinData[]
---@field Delete fun()
---@field GetPins fun():table<string, setPinData>
---@field GetAllPinData fun():table<UUID, pinData>
---@field GetPinCount fun():number
---@field GetPin fun(self, mapID:string, x:number, y:number):setPinData
---@field trackerSetEntry MapPinEnhancedTrackerSetEntryMixin
---@field setEditorEntry MapPinEnhancedTrackerSetEntryMixin

---@class setPinData
---@field setID UUID
---@field setPinID UUID
---@field pinData pinData

---Create a new set
---@param name string
---@param id UUID
---@return SetObject
function SetFactory:CreateSet(name, id)
    ---@type table<UUID, setPinData>
    local pins = {}
    local setID = id

    local trackerSetEntry = TrackerSetEntryPool:Acquire()
    ---@cast trackerSetEntry MapPinEnhancedTrackerSetEntryMixin

    local setEditorEntry = setEditorEntryPool:Acquire()
    ---@cast setEditorEntry MapPinEnhancedTrackerSetEntryMixin

    trackerSetEntry:SetTitle(name)
    setEditorEntry:SetTitle(name)

    local function GetPinCount()
        local count = 0
        for _, _ in pairs(pins) do
            count = count + 1
        end
        return count
    end

    ---@param pinData pinData
    ---@param restore boolean?
    local function AddPin(_, pinData, restore)
        local setPinID = MapPinEnhanced:GenerateUUID("setpin")
        pinData.setTracked = false
        pinData.order = GetPinCount() + 1 --> automatically set the order to the next available number
        pins[setPinID] = { pinData = pinData, setID = setID, setPinID = setPinID }
        if not restore then
            SetManager:PersistSets(setID)
        end
    end

    ---@param pinsetID UUID
    ---@param key 'mapID' | 'x' | 'y' | 'title'
    ---@param value any
    local function UpdatePin(_, pinsetID, key, value)
        local pin = pins[pinsetID]
        if not pin then
            return
        end
        ---@type string | number | boolean | nil
        pin.pinData[key] = value
        SetManager:PersistSets(setID)
    end

    ---@param setPinID UUID
    ---@return setPinData
    local function GetPinByID(_, setPinID)
        return pins[setPinID]
    end


    ---@param pinsetID UUID
    local function RemovePinByID(_, pinsetID)
        pins[pinsetID] = nil
        SetManager:PersistSets(setID)
    end

    local function Delete()
        for setPinID, _ in pairs(pins) do
            pins[setPinID] = nil
        end
        TrackerSetEntryPool:Release(trackerSetEntry)
        setEditorEntryPool:Release(setEditorEntry)
    end



    ---@return table<UUID, setPinData>
    local function GetPins()
        return pins
    end


    ---@return table<UUID, pinData>
    local function GetAllPinData()
        ---@type table<UUID, pinData>
        local pinData = {}
        for _, setPinData in pairs(pins) do
            pinData[setPinData.setPinID] = setPinData.pinData
        end
        return pinData
    end


    ---@param a setPinData
    ---@param b setPinData
    ---@return boolean
    local function SortByOrder(a, b)
        return a.pinData.order < b.pinData.order
    end

    ---@return setPinData[]
    local function GetPinsByOrder()
        local orderedPins = {}
        for _, pin in pairs(pins) do
            table.insert(orderedPins, pin)
        end
        table.sort(orderedPins, SortByOrder)
        return orderedPins
    end


    local function LoadSet(override)
        if override then
            PinManager:ClearPins()
        end
        for _, setPinData in pairs(pins) do
            PinManager:AddPin(setPinData.pinData)
        end
        MapPinEnhanced:SetPinTrackerView('Pins')
    end

    local function SetName(_, newName)
        trackerSetEntry:SetTitle(newName)
        setEditorEntry:SetTitle(newName)
    end

    trackerSetEntry:SetScript("OnClick", function()
        LoadSet(IsShiftKeyDown())
    end)

    return {
        name = name,
        SetName = SetName,
        AddPin = AddPin,
        UpdatePin = UpdatePin,
        RemovePinByID = RemovePinByID,
        GetPinByID = GetPinByID,
        GetPins = GetPins,
        GetAllPinData = GetAllPinData,
        GetPinCount = GetPinCount,
        GetPinsByOrder = GetPinsByOrder,
        Delete = Delete,
        trackerSetEntry = trackerSetEntry,
        setEditorEntry = setEditorEntry
    }
end
