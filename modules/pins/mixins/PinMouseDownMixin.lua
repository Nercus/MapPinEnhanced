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
            self.group:MarkPinReached(self.pinID)
            return
        end
        if shift then
            self:SharePin()
            return
        end
        self:ToggleTracked()
    elseif button == "RightButton" then
        self:ShowMenu(frame)
    elseif button == "MiddleButton" then
        self:ToggleLock()
    end
end
