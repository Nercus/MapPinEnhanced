---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinSections
local PinSections = MapPinEnhanced:GetModule("PinSections")
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local Notify = MapPinEnhanced:GetModule("Notify")
local Events = MapPinEnhanced:GetModule("Events")
local Tracker = MapPinEnhanced:GetModule("Tracker")

local MAX_COUNT_PINS_PER_SECTION = 500
local L = MapPinEnhanced.L

---@type FramePool<MapPinEnhancedTrackerPinSectionMixin>
local SectionHeaderPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinSectionTemplate")


---@alias PositionString string the string representation of a position in the format <mapID>:<x>:<y>

---Get a string representation of a position from pinData
---@param pinData pinData
---@return PositionString
function PinSections:GetPositionStringForPin(pinData)
    -- the x and y coordinates are normalized so we cut them here to avoid to many pins on the same point
    return string.format("%s:%.4f:%.4f", pinData.mapID, pinData.x, pinData.y)
end

---@class SectionInfo
---@field name string
---@field icon string path to the icon of the section
---@field source string default is "MapPinEnhanced"

---@param sectionInfo SectionInfo
---@return PinSection
function PinSections:RegisterSection(sectionInfo)
    assert(sectionInfo.name, "Section name is required")
    assert(sectionInfo.icon, "Section icon is required")
    assert(sectionInfo.source, "Section source is required")

    if not self.Sections then
        self.Sections = {}
    end

    ---@class PinSection
    ---@field pins {[PositionString]: PinObject} the pins in the section keyed by their position
    ---@field pinOrder UUID[] the order of the pins in the section
    ---@field header MapPinEnhancedTrackerPinSectionMixin
    ---@field pinCount number
    local section = {}
    section.name = sectionInfo.name
    section.icon = sectionInfo.icon
    section.source = sectionInfo.source
    section.pins = {}
    section.pinOrder = {}
    section.pinCount = 0

    ---@param pinData pinData
    ---@param restore? boolean Restore the pin from the saved variables
    function section:AddPin(pinData, restore)
        local pinID = PinSections:GetPositionStringForPin(pinData)
        if self.pins[pinID] then return end -- cannot set a pin at the same location within a section
        if self.pinCount >= MAX_COUNT_PINS_PER_SECTION then
            Notify:Error(string.format(L["Too many pins in section %s. Please remove some pins before adding more."],
                self.name))
            return
        end

        if not pinData.order then
            pinData.order = self:GetMaxPinOrder() + 1
        end

        ---@class PinObject
        ---@field section PinSection
        local pin = PinFactory:CreatePin(pinData, pinID, self)
        self.pins[pinID] = pin
        self.pinCount = self.pinCount + 1
        table.insert(self.pinOrder, pinID)
        if not restore then
            PinSections:PersistSections(self.name)
        end
        Events:FireEvent(Events:GetEventNameWithID("UpdateSection", self.name))

        if pinData.setTracked then
            pin:Track()
        else
            pin:Untrack()
        end
        Tracker:AddEntry("Pins", pin.trackerPinEntry)
    end

    function section:GetMaxPinOrder()
        local maxOrder = 0
        for _, pin in pairs(self.pins) do
            local order = pin:GetPinData().order
            if order and order > maxOrder then
                maxOrder = order
            end
        end
        return maxOrder
    end

    ---@param a PinObject
    ---@param b PinObject
    ---@return boolean
    local function SortByOrder(a, b)
        return a:GetPinData().order < b:GetPinData().order
    end

    function section:GetPinsByOrder()
        local pins = {}
        for _, pinID in ipairs(self.pinOrder) do
            table.insert(pins, self.pins[pinID])
        end
        table.sort(pins, SortByOrder)
        return pins
    end

    function section:RemovePin(pinID)
        local pin = self.pins[pinID]
        if pin then
            pin:Remove()
            self.pins[pinID] = nil
            self.pinCount = self.pinCount - 1
            PinSections:PersistSections(self.name, pinID)
        end
        if self.pinCount == 0 then
            self.positions = {}
            self.pinOrder = {}
            self.pinCount = 0
            PinSections:PersistSections(self.name)
            SectionHeaderPool:Release(self.header)
        end
    end

    function section:ClearPins()
        SectionHeaderPool:Release(self.header)
        for pinID, _ in pairs(self.pins) do
            self.pins[pinID]:Remove()
            self.pins[pinID] = nil
        end
        self.positions = {}
        self.pinOrder = {}
        self.pinCount = 0
        PinSections:PersistSections(self.name)
    end

    function section:GetSavableData()
        ---@type {info: SectionInfo, pins: pinData[]}
        local data = {
            info = {
                name = self.name,
                icon = self.icon,
                source = self.source
            },
            pins = {}
        }
        local index = 1
        for _, pin in pairs(self.pins) do
            data.pins[index] = pin:GetPinData()
            index = index + 1
        end
        return data
    end

    function section:GetPins()
        return self.pins
    end

    function section:GetPinCount()
        return self.pinCount
    end

    function section:GetHeader()
        if not self.header then
            self.header = SectionHeaderPool:Acquire()
            self.header:SetSection(self)
        end
        return self.header
    end

    self.Sections[section.name] = section
    PinSections:PersistSections(section.name)
    return section
end
