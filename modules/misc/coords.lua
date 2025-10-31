---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCoordsDisplayTemplate : Frame
---@field coordsText FontString
---@field timeSinceLastUpdate number
---@field closeButton MapPinEnhancedIconButtonTemplate
---@field lockButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedCoordsDisplayMixin = {}

local L = MapPinEnhanced.L

local Providers = MapPinEnhanced:GetModule("Providers")


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
    Providers:LinkToChat(x, y, playerMap, "My Location")
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

function MapPinEnhancedCoordsDisplayMixin:OnUpdate(elapsed)
    self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
    if self.timeSinceLastUpdate < 0.2 then
        return
    end
    self.timeSinceLastUpdate = 0

    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        self.coordsText:SetText("N/A")
        return
    end
    local position = C_Map.GetPlayerMapPosition(currentMapID, "player")
    if not position then
        self.coordsText:SetText("N/A")
        return
    end
    local x, y = position:GetXY()
    if not x or not y then
        self.coordsText:SetText("N/A")
        return
    end
    local xPercent = math.floor(x * 10000) / 100
    local yPercent = math.floor(y * 10000) / 100
    self.coordsText:SetText(string.format("%.2f | %.2f", xPercent, yPercent))
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
    self.timeSinceLastUpdate = 0
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
    MapPinEnhanced:SetVar("coordsDisplay", "visible", true)
end

function MapPinEnhancedCoordsDisplayMixin:OnHide()
    MapPinEnhanced:SetVar("coordsDisplay", "visible", false)
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
        coordsDisplayFrame:Hide()
        MapPinEnhanced:SetVar("coordsDisplay", "visible", false)
    else
        coordsDisplayFrame:Show()
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
