---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local LibWindow = LibStub("LibWindow-1.1")

---@param frame Frame
---@param frameName string
---@param dragArea ScriptRegion?
---@param isLocked? fun(): boolean
function MapPinEnhanced:RegisterDraggableFrame(frame, frameName, dragArea, isLocked)
    assert(type(frameName) == "string", "Frame name must be a string")
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    local onMouseDownScript, onMouseUpScript = frame:GetScript("OnMouseDown"), frame:GetScript("OnMouseUp")
    local onMouseDownActive = onMouseDownScript ~= nil
    local onMouseUpActive = onMouseUpScript ~= nil
    if onMouseDownActive or onMouseUpActive then
        error("Cannot save position for frames with active OnMouseDown or OnMouseUp scripts.")
    end
    if not dragArea then
        dragArea = frame
    else
        dragArea:EnableMouse(true)
        dragArea:SetPropagateMouseClicks(true)
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
    dragArea:HookScript("OnEnter", function()
        if isLocked and isLocked() then
            return
        end
        if dragArea and dragArea:IsMouseOver() then
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        end
    end)

    dragArea:HookScript("OnLeave", function()
        ResetCursor()
    end)

    frame:SetScript("OnMouseDown", function(frame, button)
        if button ~= "LeftButton" then return end
        if dragArea and not dragArea:IsMouseOver() then
            return
        end
        if isLocked and isLocked() then
            return
        end
        frame:StartMoving()
        SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
    end)

    frame:SetScript("OnMouseUp", function(frame, button)
        if button ~= "LeftButton" then return end
        frame:StopMovingOrSizing()
        if dragArea and dragArea:IsMouseOver() then
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        else
            ResetCursor()
        end
        LibWindow.SavePosition(frame)
    end)
end

function MapPinEnhanced:SaveFramePosition(frame)
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    LibWindow.SavePosition(frame)
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
