---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinManager = MapPinEnhanced:GetModule("PinManager")
local SetManager = MapPinEnhanced:GetModule("SetManager")
local Blizz = MapPinEnhanced:GetModule("Blizz")
local Notify = MapPinEnhanced:GetModule("Notify")

local HBDP = MapPinEnhanced.HBDP
local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

---@class MapPinEnhancedWorldmapPinTemplate
---@field hey string


---@type FramePool<MapPinEnhancedWorldMapPinMixin>
local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
---@type FramePool<MapPinEnhancedMinimapPinMixin>
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
---@type FramePool<MapPinEnhancedTrackerPinEntryMixin>
local TrackerPinEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")
---@type FramePool<MapPinEnhancedSuperTrackedPinMixin>
local SuperTrackedPinPool = CreateFramePool("Frame", nil, "MapPinEnhancedSuperTrackedPinTemplate")


---@class pinData
---@field mapID number
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to autotrack this pin on creation
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached
---@field order number? the order of the pin: the lower the number, the higher the pin will be displayed on the tracker -> if not set, the pin will be displayed at the end of the tracker


---@param initPinData pinData
---@param pinID UUID
---@return PinObject
function PinFactory:CreatePin(initPinData, pinID)
    ---@class PinObject
    local pin = {}
    pin.worldmapPin = WorldmapPool:Acquire()
    pin.minimapPin = MinimapPool:Acquire()
    pin.trackerPinEntry = TrackerPinEntryPool:Acquire()
    pin.superTrackedPin = SuperTrackedPinPool:Acquire()
    pin.pinID = pinID

    pin.pinData = initPinData
    local x, y, mapID = initPinData.x, initPinData.y, initPinData.mapID

    pin.worldmapPin:Setup(pin.pinData)
    pin.minimapPin:Setup(pin.pinData)
    pin.trackerPinEntry:Setup(pin.pinData)
    pin.superTrackedPin:Setup(pin.pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, pin.worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_BATTLEFIELD_FLAG")
    HBDP:AddMinimapIconMap(MapPinEnhanced, pin.minimapPin, mapID, x, y, false, false)

    self:HandleTracking(pin)
    self:HandleClick(pin)
    self:HandleDistanceCheck(pin)






    local function SetColor(color)
        worldmapPin:SetPinColor(color)
        minimapPin:SetPinColor(color)
        trackerPinEntry:SetPinColor(color)
        if (isTracked) then
            worldmapPin:SetTrackedTexture()
            minimapPin:SetTrackedTexture()
            trackerPinEntry:SetTrackedTexture()
        else
            worldmapPin:SetUntrackedTexture()
            minimapPin:SetUntrackedTexture()
            trackerPinEntry:SetUntrackedTexture()
        end
        pinData.color = color
        PinManager:PersistPins()
        if isTracked then
            MapPinEnhanced:SetSuperTrackedPin(GetPinData())
        end
    end


    local function IsColorSelected(color)
        local colorByIndex = CONSTANTS.PIN_COLORS[color]
        if not colorByIndex then
            return false
        end
        local colorName = colorByIndex.colorName
        return pinData.color == colorName
    end

    local function Remove()
        Untrack()
        if MapPinEnhanced.pinTracker then
            if MapPinEnhanced.pinTracker:GetActiveView() == "Pins" then
                MapPinEnhanced.pinTracker:RemoveEntry(trackerPinEntry)
            end
        end
        worldmapPin:Hide()
        minimapPin:Hide()
        trackerPinEntry:Hide()
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimapPin)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, worldmapPin)
        WorldmapPool:Release(worldmapPin)
        MinimapPool:Release(minimapPin)
        TrackerPinEntryPool:Release(trackerPinEntry)
    end


    local function ChangeTitle(text)
        pinData.title = text
        worldmapPin:SetTitle(text)
        minimapPin:SetTitle(text)
        trackerPinEntry:SetTitle(text)
        PinManager:PersistPins()
        if isTracked then
            MapPinEnhanced:SetSuperTrackedPin(GetPinData())
        end
    end


    local function SharePin()
        if x and y and mapID then
            Blizz:InsertWaypointLinkToChat(x, y, mapID)
        end
    end


    local function ShowOnMap()
        if InCombatLockdown() then
            Notify:Error(L["Can't Show on Map in Combat"])
            return
        end
        OpenWorldMap(mapID);
        worldmapPin:ShowPulseForSeconds(3)
    end





    ---@return pinData
    function pin:GetPinData()
        return self.pinData
    end

    return pin
end
