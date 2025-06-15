---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local Tracker = MapPinEnhanced:GetModule("Tracker")

local HBDP = MapPinEnhanced.HBDP

---@type FramePool<MapPinEnhancedWorldmapPin>
local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
---@type FramePool<MapPinEnhancedMinimapPin>
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
---@type FramePool<MapPinEnhancedTrackerPinEntry>
local TrackerPinEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")
---@type FramePool<MapPinEnhancedSuperTrackedPin>
local SuperTrackedPinPool = CreateFramePool("Frame", nil, "MapPinEnhancedSuperTrackedPinTemplate")

local CONSTANTS = MapPinEnhanced.CONSTANTS

---@class pinData
---@field mapID number
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to auto-track this pin on creation
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached
---@field order number? the order of the pin: the lower the number, the higher the pin will be displayed on the tracker -> if not set, the pin will be displayed at the end of the tracker

---@param initPinData pinData
---@param pinID UUID
---@param section PinSection
---@return PinObject
function PinFactory:CreatePin(initPinData, pinID, section)
    ---@class PinObject
    local pin = {}
    pin.worldmapPin = WorldmapPool:Acquire()
    pin.minimapPin = MinimapPool:Acquire()
    pin.trackerPinEntry = TrackerPinEntryPool:Acquire()
    pin.superTrackedPin = SuperTrackedPinPool:Acquire()
    pin.pinID = pinID
    pin.section = section

    pin.pinData = initPinData

    if (pin.pinData.x > 1) then
        pin.pinData.x = pin.pinData.x / 100
    end
    if (pin.pinData.y > 1) then
        pin.pinData.y = pin.pinData.y / 100
    end

    local x, y, mapID = initPinData.x, initPinData.y, initPinData.mapID


    if (pin.pinData.texture == nil and pin.pinData.color == nil) then
        pin.pinData.color = CONSTANTS.DEFAULT_PIN_COLOR
    end

    if pin.pinData.texture then
        pin.pinData.color = "Custom"
    end

    pin.worldmapPin:Setup(pin.pinData)
    pin.minimapPin:Setup(pin.pinData)
    pin.trackerPinEntry:Setup(pin.pinData)
    pin.superTrackedPin:Setup(pin.pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, pin.worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_BATTLEFIELD_FLAG")
    HBDP:AddMinimapIconMap(MapPinEnhanced, pin.minimapPin, mapID, x, y, false, false)

    function pin:Remove()
        pin:Untrack()
        Tracker:RemoveEntry("Pins", pin.trackerPinEntry)
        pin.worldmapPin:Hide()
        pin.minimapPin:Hide()
        pin.trackerPinEntry:Hide()
        HBDP:RemoveMinimapIcon(MapPinEnhanced, pin.minimapPin)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin.worldmapPin)
        WorldmapPool:Release(pin.worldmapPin)
        MinimapPool:Release(pin.minimapPin)
        TrackerPinEntryPool:Release(pin.trackerPinEntry)
        SuperTrackedPinPool:Release(pin.superTrackedPin)
    end

    self:HandleTracking(pin)
    self:HandleClick(pin)
    self:HandleDistanceCheck(pin)
    self:HandleLock(pin)
    self:HandleColor(pin)
    self:HandleMenu(pin)
    self:HandleMisc(pin)

    ---@return pinData
    function pin:GetPinData()
        return self.pinData
    end

    ---@return pinData
    function pin:GetSavableData()
        local pinDataToSave = self:GetPinData()
        pinDataToSave.setTracked = self:IsTracked()
        return pinDataToSave
    end

    pin:Untrack() -- untrack the pin by default
    return pin
end
