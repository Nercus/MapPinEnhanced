---@class Wayfinder
local Wayfinder = select(2, ...)











---Hide all elements of the default blizzard world map waypoint
---@diagnostic disable-next-line: no-unknown
hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self) -- hide default blizzard waypoint
    self:SetAlpha(0)
    self:EnableMouse(false)
end)
