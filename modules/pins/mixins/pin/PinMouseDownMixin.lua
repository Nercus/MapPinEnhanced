---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMouseDownMixin = {}


---@param frame MapPinEnhancedWorldmapPinTemplate | MapPinEnhancedTrackerPinEntryTemplate
---@param button mouseButton
function MapPinEnhancedPinMouseDownMixin:OnMouseDown(frame, button)
    local shift, ctrl = IsShiftKeyDown(), IsControlKeyDown()
    if button == "LeftButton" then
        if ctrl then
            self.group:RemovePin(self.pinID)
            return
        end
        if shift then
            self:SharePin()
            return
        end
        self:ToggleTracked()
    else
        self:ShowMenu(frame)
    end
end
