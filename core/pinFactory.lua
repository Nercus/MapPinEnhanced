---@class Wayfinder
local Wayfinder = select(2, ...)
---@class PinFactory : Module
local PinFactory = Wayfinder:CreateModule("PinFactory")
-- NOTE: Here the big pin "object" is created, deleted and managed (i.e. icon change) containing the pin data, the world pin, the minimap pin and the worldmap pin. (a singular pin object)

local HBDP = LibStub("HereBeDragons-Pins-2.0")

local WorldmapPool = CreateFramePool("Button", nil, "WayfinderWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "WayfinderMinimapPinTemplate")
-- local WorldPool = CreateFramePool("Frame", nil, "WayfinderWorldPinTemplate")




---@param pinData pinData
---@param pinID string
---@return PinObject
function PinFactory:CreatePin(pinData, pinID)
    local worldmapPin = WorldmapPool:Acquire()
    ---@cast worldmapPin WayfinderWorldMapPinMixin
    local minimapPin = MinimapPool:Acquire()
    ---@cast minimapPin WayfinderMinimapPinMixin
    -- local worldPin = WorldPool:Acquire()

    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    worldmapPin:Setup(pinData)
    minimapPin:Setup(pinData)
    -- worldPin:Setup(pinData)

    HBDP:AddWorldMapIconMap(Wayfinder, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(Wayfinder, minimapPin, mapID, x, y, false, false)

    return {
        pinID = pinID,
        -- worldPin = worldPin,
        minimapPin = minimapPin,
        pinData = pinData
    }
end
