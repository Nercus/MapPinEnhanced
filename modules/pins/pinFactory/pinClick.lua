---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinSections = MapPinEnhanced:GetModule("PinSections")


---@param pin PinObject
function PinFactory:HandleClick(pin)
    assert(pin, "PinFactory:HandleClick: pin is nil")
    assert(pin.worldmapPin, "PinFactory:HandleClick: pin.worldmapPin is nil")
    assert(pin.trackerPinEntry, "PinFactory:HandleClick: pin.trackerPinEntry is nil")

    local function HandleClicks(buttonFrame, button)
        -- alt not used right now
        if button == "LeftButton" then
            local shift, ctrl = IsShiftKeyDown(), IsControlKeyDown()
            if ctrl then
                pin.section:RemovePin(pin.pinID)
                return
            end
            if shift then
                pin:SharePin()
                return
            end
            pin:ToggleTracked()
        else
            pin:ShowMenu(buttonFrame)
        end
    end
    pin.worldmapPin:SetScript("OnMouseDown", HandleClicks)
    pin.trackerPinEntry:SetScript("OnMouseDown", HandleClicks)
end
