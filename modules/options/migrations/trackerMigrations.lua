---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")

-- Tracker invokes this after its display has supplied the legacy content height.
---@param position MapPinEnhancedTrackerPositionTemplate
---@param contentHeight number
---@return boolean success
function Tracker:MigrateLegacyPosition(position, contentHeight)
    if MapPinEnhanced:GetVar("frames", "tracker", "fixedPosition") then return true end

    -- Legacy saves anchor the entire display. Reconstruct that rectangle before
    -- capturing its top edge; legacy saves do not retain collapsed content height.
    local fixedHeight = position:GetHeight()
    position:SetHeight(contentHeight)
    MapPinEnhanced:RestoreFrame(position)
    if not MapPinEnhanced:GetVar("frames", "tracker", "scale") then
        position:SetScale(1)
    end

    local left, top = position:GetLeft(), position:GetTop()
    if not left or not top then
        position:SetHeight(fixedHeight)
        return false
    end
    position:ClearAllPoints()
    position:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
    position:SetHeight(fixedHeight)
    -- Save only after conversion; LibWindow may choose any anchor for this
    -- fixed-size owner without making subsequent content resizing move it.
    MapPinEnhanced:SaveFramePosition(position)
    MapPinEnhanced:SetVar("frames", "tracker", "fixedPosition", true)
    return true
end
