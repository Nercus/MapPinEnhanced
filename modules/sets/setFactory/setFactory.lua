---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
local SetManager = MapPinEnhanced:GetModule("SetManager")
local PinSections = MapPinEnhanced:GetModule("PinSections")
local PinTracking = MapPinEnhanced:GetModule("PinTracking")
local Utils = MapPinEnhanced:GetModule("Utils")
local Menu = MapPinEnhanced:GetModule("Menu")
local Notify = MapPinEnhanced:GetModule("Notify")
local Events = MapPinEnhanced:GetModule("Events")
local Tracker = MapPinEnhanced:GetModule("Tracker")

---@type FramePool<MapPinEnhancedTrackerSetEntryMixin>
local TrackerSetEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate")
---@type FramePool<MapPinEnhancedTrackerSetEntryMixin>
local setEditorEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerSetEntryTemplate") -- currently the same template

local L = MapPinEnhanced.L

---@class SetObject
---@field setID UUID
---@field name string
---@field AddPin fun(self, pinData:pinData, restore:boolean?, override:boolean?)
---@field UpdatePin fun(self, setPinID:UUID, key:string, value:any)
---@field GetPinByID fun(self, setPinID:UUID):setPinData
---@field RemovePinByID fun(self, pinsetID:UUID)
---@field LoadSet fun(override:boolean?)
---@field CreateMenu fun(parentFrame:Frame)
---@field SetName fun(self, newName:string)
---@field GetPinsByOrder fun():setPinData[]
---@field Delete fun()
---@field GetPins fun():table<string, setPinData>
---@field GetAllPinData fun():table<UUID, pinData>
---@field GetPinCount fun():number
---@field GetPin fun(self, mapID:string, x:number, y:number):setPinData
---@field GetRawSetData fun():{name:string, pins:table<UUID, pinData>}
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
    ---@type table<string, UUID>
    local positions = {}
    local setID = id

    local trackerSetEntry = TrackerSetEntryPool:Acquire()
    local setEditorEntry = setEditorEntryPool:Acquire()

    trackerSetEntry:SetTitle(name)
    setEditorEntry:SetTitle(name)

    local function GetPinCount()
        local count = 0
        for _, _ in pairs(pins) do
            count = count + 1
        end
        return count
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


    local function UpdateSetChange()
        Events:FireEvent('UpdateSetList')
    end


    ---@param pinData pinData
    ---@param restore boolean?
    ---@param override boolean?
    local function AddPin(_, pinData, restore, override)
        local positonString = PinSections:GetPositionStringForPin(pinData)
        if positions[positonString] and not override then
            return
        end
        if override then
            local oldPin = pins[positions[positonString]]
            if oldPin then
                pins[oldPin.setPinID] = nil
                positions[positonString] = nil
                AddPin(_, pinData, true, false)
                return
            end
        end
        local setPinID = Utils:GenerateUUID("setpin")
        pinData.setTracked = false
        if not pinData.order then
            pinData.order = GetPinCount() + 1 --> automatically set the order to the next available number
        end
        pins[setPinID] = { pinData = pinData, setID = setID, setPinID = setPinID }
        if not restore then
            SetManager:PersistSets(setID)
        end
        positions[positonString] = setPinID
        Utils:DebounceChange(UpdateSetChange, 0.1)
    end



    ---@param setPinID UUID
    ---@return setPinData
    local function GetPinByID(_, setPinID)
        return pins[setPinID]
    end


    ---@param pinsetID UUID
    local function RemovePinByID(_, pinsetID)
        local pinData = pins[pinsetID].pinData
        local positionString = PinSections:GetPositionStringForPin(pinData)
        pins[pinsetID] = nil
        positions[positionString] = nil
        SetManager:PersistSets(setID)
    end

    local function Delete()
        pins = {}
        positions = {}
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


    local function LoadSet()
        local sectionSet = PinSections:RegisterSection({
            name = string.format("%s: %s", L["Loaded Set"], name),
            icon = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSets_Yellow.png",
            source = MapPinEnhanced.addonName
        })
        local orderedPins = GetPinsByOrder()
        for _, setPinData in ipairs(orderedPins) do
            sectionSet:AddPin(setPinData.pinData)
        end
        Tracker:SetView("Pins")
        Notify:Info(string.format(L["Set \"%s\" Loaded"], name))
    end

    local function SetName(_, newName)
        trackerSetEntry:SetTitle(newName)
        setEditorEntry:SetTitle(newName)
    end

    ---@type AnyMenuEntry[]
    local menuTemplate = {
        {
            type = "template",
            template = "MapPinEnhancedMenuInputTemplate",
            initializer = function(frame)
                ---@cast frame MapPinEnhancedInputMixin
                frame:Setup({
                    default = name,
                    init = function() return name end,
                    onChange = function(value)
                        SetManager:UpdateSetNameByID(setID, value)
                    end
                })
            end
        },
        {
            type = "divider"
        },
        {
            type = "button",
            label = L["Load Set"],
            onClick = function()
                LoadSet()
            end
        },
        {
            type = "button",
            label = L["Edit Set"],
            onClick = function()
                local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")
                EditorWindow:ShowEditorForSet(setID)
            end
        },
        {
            type = "button",
            label = L["Export Set"],
            onClick = function()
                local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")
                EditorWindow:ShowExportFrameForSet(setID)
            end
        },
        {
            type = "button",
            label = L["Delete Set"],
            onClick = function()
                SetManager:DeleteSet(setID)
            end
        }
    }

    local function CreateMenu(parentFrame)
        Menu:GenerateMenu(parentFrame, menuTemplate)
    end

    local function HandleClick(buttonFrame, button)
        if button == "LeftButton" then
            LoadSet()
        else
            CreateMenu(buttonFrame)
        end
    end

    trackerSetEntry:SetScript("OnClick", HandleClick)
    trackerSetEntry.tooltip = L["Click to Load Set"]


    local function GetRawSetData()
        return {
            name = name,
            pins = GetAllPinData()
        }
    end

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
        CreateMenu = CreateMenu,
        Delete = Delete,
        LoadSet = LoadSet,
        GetRawSetData = GetRawSetData,
        trackerSetEntry = trackerSetEntry,
        setEditorEntry = setEditorEntry
    }
end