---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local LibWindow = LibStub("LibWindow-1.1")

---@param frame Frame
---@param frameName string
---@param isLocked? fun(): boolean
function MapPinEnhanced:RegisterDraggableFrame(frame, frameName, isLocked)
    assert(type(frameName) == "string", "Frame name must be a string")
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    local onMouseDownActive, onMouseUpActive = frame:HasScript("OnMouseDown"), frame:HasScript("OnMouseUp")
    if onMouseDownActive or onMouseUpActive then
        error("Cannot save position for frames with active OnMouseDown or OnMouseUp scripts.")
    end

    if not self:GetVar("frames") then
        self:SetVar("frames", {})
    end

    if not self:GetVar("frames", frameName) then
        self:SetVar("frames", frameName, {})
    end
    ---@type table<string, table>
    local framesTable = self:GetVar("frames")
    LibWindow.RegisterConfig(frame, framesTable[frameName])

    frame:SetMovable(true)

    frame:SetScript("OnMouseDown", function(frame, button)
        if button ~= "LeftButton" then return end
        if isLocked and isLocked() then
            return
        end
        frame:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end)

    frame:SetScript("OnMouseUp", function(frame, button)
        if button ~= "LeftButton" then return end
        frame:StopMovingOrSizing()
        ResetCursor()
        LibWindow.SavePosition(frame)
    end)
end

---Restores position and scale of the frame
---@param frame Frame
function MapPinEnhanced:RestoreFrame(frame)
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    LibWindow.RestorePosition(frame)
end

---Set the frame scale through LibWindow
---@param frame Frame
---@param scale number
function MapPinEnhanced:SetFrameScale(frame, scale)
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    assert(type(scale) == "number", "Scale must be a number")
    LibWindow.SetScale(frame, scale)
end
