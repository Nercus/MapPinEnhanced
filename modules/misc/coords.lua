---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCoordsDisplayTemplate : Frame
---@field coordsText FontString
---@field timeSinceLastUpdate number
MapPinEnhancedCoordsDisplayMixin = {}

function MapPinEnhancedCoordsDisplayMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    self:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

function MapPinEnhancedCoordsDisplayMixin:OnMouseUp(button)
    if button ~= "LeftButton" then return end
    local _, _, _, left, top = self:GetPoint()
    -- TODO: check if getpoint or getleft / gettop is more reliable
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
        self.coordsText:SetText("Coords: N/A")
        return
    end
    local position = C_Map.GetPlayerMapPosition(currentMapID, "player")
    if not position then
        self.coordsText:SetText("Coords: N/A")
        return
    end
    local x, y = position:GetXY()
    if not x or not y then
        self.coordsText:SetText("Coords: N/A")
        return
    end
    local xPercent = math.floor(x * 10000) / 100
    local yPercent = math.floor(y * 10000) / 100
    self.coordsText:SetText(string.format("Coords: %.2f, %.2f", xPercent, yPercent))
end

---

local coordsDisplayFrame = nil

local function InitCoordsDisplayFrame()
    if coordsDisplayFrame then return end
    coordsDisplayFrame = CreateFrame("Frame", "MapPinEnhancedCoordsDisplayFrame", UIParent,
        "MapPinEnhancedCoordsDisplayTemplate")
end

local function ToggleCoordsDisplay()
    InitCoordsDisplayFrame()
    if not coordsDisplayFrame then return end
    if coordsDisplayFrame:IsShown() then
        coordsDisplayFrame:Hide()
    else
        coordsDisplayFrame:Show()
    end
end

MapPinEnhanced:AddSlashCommand("coords", ToggleCoordsDisplay,
    "Toggle display of your current coordinates on the screen.")
