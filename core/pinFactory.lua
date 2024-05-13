---@class Wayfinder
local Wayfinder = select(2, ...)
---@class PinFactory : Module
local PinFactory = Wayfinder:CreateModule("PinFactory")
-- NOTE: Here the big pin "object" is created, deleted and managed (i.e. icon change) containing the pin data, the world pin, the minimap pin and the worldmap pin.

local HBDP = LibStub("HereBeDragons-Pins-2.0")

local WorldmapPool = CreateFramePool("Button", nil, "WayfinderWorldmapPinTemplate") ---@as Frame
local MinimapPool = CreateFramePool("Frame", nil, "WayfinderMinimapPinTemplate") ---@as Frame

---@param pinData pinData
---@return table <Frame, Frame, pinData>
function PinFactory:CreatePin(pinData)
    assert(pinData, "Pin data is required to create a pin.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")

    local worldPin = WorldmapPool:Acquire()
    local minimapPin = MinimapPool:Acquire()
    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    HBDP:AddWorldMapIconMap(Wayfinder, worldPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(Wayfinder, minimapPin, mapID, x, y, false, false)

    return {
        worldPin = worldPin,
        minimapPin = minimapPin,
        pinData = pinData
    }
end
