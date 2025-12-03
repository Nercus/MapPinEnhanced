---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- FIXME: small ui scales cause the numbers to be cut off, fix that
-- TODO: add a rightclick menu to share location, save location, add waypoint to current location for wayback, scale, close


---@class MapPinEnhancedCoordsDisplayTemplate : Frame
---@field coordsXInt FontString
---@field coordsXDec FontString
---@field coordsYInt FontString
---@field coordsYDec FontString
---@field timeSinceLastUpdate number
---@field closeButton MapPinEnhancedIconButtonTemplate
---@field lockButton MapPinEnhancedIconButtonTemplate
---@field x number
---@field y number
MapPinEnhancedCoordsDisplayMixin = {}

local L = MapPinEnhanced.L

local Providers = MapPinEnhanced:GetModule("Providers")
local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedCoordsDisplayMixin:LinkPlayerPosition()
    local playerMap = C_Map.GetBestMapForUnit("player")
    if not playerMap then
        MapPinEnhanced:Print(L["Unable to determine your current map location."])
        return
    end
    local position = C_Map.GetPlayerMapPosition(playerMap, "player")
    if not position then
        MapPinEnhanced:Print(L["Unable to determine your current position on the map."])
        return
    end
    local x, y = position:GetXY()
    Providers:LinkToChat(x, y, playerMap, string.format(L["%s's Position"], MapPinEnhanced.me))
end

function MapPinEnhancedCoordsDisplayMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    if IsShiftKeyDown() then
        self:LinkPlayerPosition()
        return
    end
    if not self:IsMovable() then return end
    self:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

function MapPinEnhancedCoordsDisplayMixin:OnMouseUp(button)
    if button ~= "LeftButton" then return end
    local _, _, _, left, top = self:GetPoint()
    MapPinEnhanced:SetVar("coordsDisplay", "position", { x = left, y = top })
    self:StopMovingOrSizing()
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    SetCursor(nil)
end

function MapPinEnhancedCoordsDisplayMixin:SetCoordsText(x, y)
    if not x or not y then
        self.coordsXInt:SetText("--")
        self.coordsXDec:SetText(".--")
        self.coordsYInt:SetText("--")
        self.coordsYDec:SetText(".--")
        return
    end

    local xPercent = math.floor(x * 10000) / 100
    local yPercent = math.floor(y * 10000) / 100

    local xInt, xDec = math.modf(xPercent)
    local yInt, yDec = math.modf(yPercent)

    self.coordsXInt:SetText(string.format("%02d", xInt))
    self.coordsXDec:SetText(string.format(".%02d", math.floor(xDec * 100)))
    self.coordsYInt:SetText(string.format("%02d", yInt))
    self.coordsYDec:SetText(string.format(".%02d", math.floor(yDec * 100)))
end

function MapPinEnhancedCoordsDisplayMixin:OnUpdate(elapsed)
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        self:SetCoordsText(nil, nil)
        return
    end
    local position = C_Map.GetPlayerMapPosition(currentMapID, "player")
    if not position then
        self:SetCoordsText(nil, nil)
        return
    end
    local x, y = position:GetXY()
    if not x or not y then
        self:SetCoordsText(nil, nil)
        return
    end

    local targetXPercent = math.floor(x * 10000) / 100
    local targetYPercent = math.floor(y * 10000) / 100

    if not self.displayX then
        self.displayX = targetXPercent
        self.displayY = targetYPercent
    end

    local newDisplayX = DeltaLerp(self.displayX, targetXPercent, .2, elapsed)
    local newDisplayY = DeltaLerp(self.displayY, targetYPercent, .2, elapsed)

    self.displayX = newDisplayX
    self.displayY = newDisplayY
    self:SetCoordsText(newDisplayX / 100, newDisplayY / 100)
end

function MapPinEnhancedCoordsDisplayMixin:RestorePosition()
    local position = MapPinEnhanced:GetVar("coordsDisplay", "position") --[[@as { x: number, y: number }?]]
    if position then
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", position.x, position.y)
    else
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER")
    end
end

function MapPinEnhancedCoordsDisplayMixin:LockPosition()
    self:SetMovable(false)
    self.lockButton.iconTexture:SetDesaturated(false)
    MapPinEnhanced:SetVar("coordsDisplay", "locked", true)
end

function MapPinEnhancedCoordsDisplayMixin:UnlockPosition()
    self:SetMovable(true)
    self.lockButton.iconTexture:SetDesaturated(true)
    MapPinEnhanced:SetVar("coordsDisplay", "locked", false)
end

function MapPinEnhancedCoordsDisplayMixin:OnLoad()
    self:RestorePosition()

    self.lockButton:SetScript("OnClick", function()
        if self:IsMovable() then
            self:LockPosition()
        else
            self:UnlockPosition()
        end
    end)

    self.closeButton:SetScript("OnClick", function()
        self:Hide()
    end)

    local isLocked = MapPinEnhanced:GetVar("coordsDisplay", "locked") --[[@as boolean?]]
    if isLocked then
        self:LockPosition()
    else
        self:UnlockPosition()
    end
end

function MapPinEnhancedCoordsDisplayMixin:OnEnter()
    self.closeButton:Show()
    self.lockButton:Show()
end

function MapPinEnhancedCoordsDisplayMixin:OnLeave()
    self.closeButton:Hide()
    self.lockButton:Hide()
end

function MapPinEnhancedCoordsDisplayMixin:OnShow()
    local visibilityOption = Options:GetOption("MISC", L["Show Coordinates Display"])
    if not visibilityOption then return end
    visibilityOption:UpdateFrame()
end

function MapPinEnhancedCoordsDisplayMixin:OnHide()
    local visibilityOption = Options:GetOption("MISC", L["Show Coordinates Display"])
    if not visibilityOption then return end
    visibilityOption:UpdateFrame()
end

function MapPinEnhancedCoordsDisplayMixin:ShowFrame()
    self:RestorePosition()
    self:Show()
end

function MapPinEnhancedCoordsDisplayMixin:HideFrame()
    self:Hide()
end

local coordsDisplayFrame = nil

local function InitCoordsDisplayFrame()
    if coordsDisplayFrame then return end
    coordsDisplayFrame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedCoordsDisplayTemplate")
end

local function ToggleCoordsDisplay()
    InitCoordsDisplayFrame()
    if not coordsDisplayFrame then return end
    if coordsDisplayFrame:IsShown() then
        coordsDisplayFrame:HideFrame()
        MapPinEnhanced:SetVar("coordsDisplay", "visible", false)
    else
        coordsDisplayFrame:ShowFrame()
        MapPinEnhanced:SetVar("coordsDisplay", "visible", true)
    end
end

local function RestoreCoordsDisplayVisibility()
    local isVisible = MapPinEnhanced:GetVar("coordsDisplay", "visible") --[[@as boolean?]]
    if isVisible then
        ToggleCoordsDisplay()
    end
end
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RestoreCoordsDisplayVisibility)

MapPinEnhanced:AddSlashCommand("coords", ToggleCoordsDisplay,
    "Toggle display of your current coordinates on the screen.")


Options:RegisterOption("checkbox", {
    category = "MISC",
    label = L["Show Coordinates Display"],
    description = L["Toggle the on-screen display of your current coordinates."],
    onChange = function(value)
        InitCoordsDisplayFrame()
        if not coordsDisplayFrame then return end
        if value then
            coordsDisplayFrame:ShowFrame()
        else
            coordsDisplayFrame:HideFrame()
        end
    end,
})
