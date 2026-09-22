---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local LibWindow = LibStub("LibWindow-1.1")

---@class MapPinEnhancedDragRegistration
---@field active boolean
---@field moving boolean?
---@field dragArea ScriptRegion
---@field isLocked fun(): boolean

---@type table<Frame, MapPinEnhancedDragRegistration>
local draggableFrames = {}

local function StopDragging(frame, registration)
    if not registration.moving then return end
    registration.moving = false
    frame:StopMovingOrSizing()
    LibWindow.SavePosition(frame)
    ResetCursor()
end

---@param frame Frame
function MapPinEnhanced:UnregisterDraggableFrame(frame)
    local registration = draggableFrames[frame]
    if not registration then return end
    registration.active = false
    StopDragging(frame, registration)
    if registration.dragArea:IsMouseOver() then ResetCursor() end
end

---@param frame Frame
---@param frameName string
---@param dragArea ScriptRegion?
---@param isLocked? fun(): boolean
function MapPinEnhanced:RegisterDraggableFrame(frame, frameName, dragArea, isLocked)
    assert(type(frameName) == "string", "Frame name must be a string")
    assert(type(frame) == "table", "Frame must be a valid Frame object")
    dragArea = dragArea or frame
    local registration = draggableFrames[frame]
    if registration then
        assert(registration.dragArea == dragArea,
            "RegisterDraggableFrame requires the original drag area when registering again")
        registration.isLocked = isLocked or function() return false end
        registration.active = true
        return
    end
    registration = { active = true, dragArea = dragArea, isLocked = isLocked or function() return false end }
    draggableFrames[frame] = registration
    if dragArea ~= frame then
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
    -- Hooks are installed once; registration gates them without replacing callers' scripts.
    dragArea:HookScript("OnEnter", function()
        if not registration.active or registration.isLocked() then return end
        SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
    end)
    dragArea:HookScript("OnLeave", function()
        if registration.active then ResetCursor() end
    end)
    dragArea:HookScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" or not registration.active or registration.isLocked() then return end
        if not dragArea:IsVisible() or not dragArea:IsMouseOver() then return end
        registration.moving = true
        frame:StartMoving()
        SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
    end)
    dragArea:HookScript("OnMouseUp", function(_, button)
        if button ~= "LeftButton" or not registration.moving then return end
        StopDragging(frame, registration)
        if registration.active and dragArea:IsMouseOver() and not registration.isLocked() then
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        end
    end)
    dragArea:HookScript("OnHide", function()
        StopDragging(frame, registration)
        if registration.active then ResetCursor() end
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

---WorldFrame center in UIParent coordinate units.
---@return number x
---@return number y
function MapPinEnhanced:GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter()
    local scale = UIParent:GetEffectiveScale() or 1
    return centerX / scale, centerY / scale
end
