---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:CreateModule("PinFactory")

local HBDP = LibStub("HereBeDragons-Pins-2.0")

local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
local TrackerEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerEntryTemplate")


local SetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint


---@param pinData pinData
---@param pinID string
---@return PinObject
function PinFactory:CreatePin(pinData, pinID)
    local worldmapPin = WorldmapPool:Acquire()
    ---@cast worldmapPin MapPinEnhancedWorldMapPinMixin
    local minimapPin = MinimapPool:Acquire()
    ---@cast minimapPin MapPinEnhancedMinimapPinMixin
    local trackerEntry = TrackerEntryPool:Acquire()
    ---@cast trackerEntry MapPinEnhancedTrackerEntryMixin

    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    worldmapPin:Setup(pinData)
    minimapPin:Setup(pinData)
    trackerEntry:Setup(pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)
    MapPinEnhanced.pinTracker:AddEntry(trackerEntry)


    local isTracked = false
    local function Track()
        worldmapPin:Track()
        minimapPin:Track()
        SetSuperTrackedUserWaypoint(true)
        isTracked = true
    end

    local function Untrack()
        worldmapPin:Untrack()
        minimapPin:Untrack()
        isTracked = false
    end

    worldmapPin:SetClickCallback(function()
        if isTracked then
            Untrack()
        else
            Track()
        end
    end)

    if pinData.setTracked then
        Track()
    end


    return {
        pinID = pinID,
        -- worldPin = worldPin,
        minimapPin = minimapPin,
        trackerEntry = trackerEntry,
        pinData = pinData,
        Track = Track,
        Untrack = Untrack,
        IsTracked = function() return isTracked end,
    }
end
