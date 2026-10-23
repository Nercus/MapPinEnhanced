---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")

local Groups = MapPinEnhanced:GetModule("Groups")
local Tracker = MapPinEnhanced:GetModule("Tracker")

---@class MapPinEnhancedCoordinatesDisplayButton : MapPinEnhancedIconButtonTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin


---@class MapPinEnhancedCoordinatesPositionTemplate : Frame
---@field display MapPinEnhancedCoordinatesDisplayTemplate

---@class MapPinEnhancedCoordinatesDisplayTemplate : Frame, MapPinEnhancedFadingFrameTemplate
---@field zoneName FontString
---@field separator Texture
---@field position Frame
---@field positionDefined boolean?
---@field cachedDecimals boolean?
---@field cachedMapID number?
---@field cachedMapName string?
---@field cachedX number?
---@field cachedY number?
---@field coordsXInt FontString
---@field coordsXDec FontString
---@field coordsYInt FontString
---@field coordsYDec FontString
---@field timeSinceLastUpdate number
---@field closeButton MapPinEnhancedCoordinatesDisplayButton
---@field lockButton MapPinEnhancedCoordinatesDisplayButton
---@field dragHandle Frame
---@field buttonVisibilityTimer FunctionContainer
MapPinEnhancedCoordinatesDisplayMixin = {}

local L = MapPinEnhanced.L

local Options = MapPinEnhanced:GetModule("Options")

local GetBestMapForUnit = C_Map.GetBestMapForUnit
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition
local floor = math.floor
local modf = math.modf
local format = string.format
local DeltaLerp = DeltaLerp
local playerName = UnitName("player")

---@param button string
function MapPinEnhancedCoordinatesDisplayMixin:OnMouseUp(button)
    if button ~= "RightButton" then return end
    GameTooltip:Hide()
    -- Capture the menu's location once so moving while it is open does not change its actions.
    local mapID = GetBestMapForUnit("player")
    local position = MapPinEnhanced:IsReadablePositiveInteger(mapID) and GetPlayerMapPosition(mapID, "player")
    ---@type number?, number?
    local x, y
    if position then x, y = position:GetXY() end
    local hasPosition = MapPinEnhanced:IsCoordinate(x) and MapPinEnhanced:IsCoordinate(y)
    ---@type AnyMenuEntry[]
    local entries = { { type = "title", label = L["Coordinates"] } }
    if hasPosition then
        table.insert(entries, {
            type = "button",
            label = L["Share location"],
            onClick = function()
                Pins:LinkToChat(x, y, mapID, format(L["%s's Position"], playerName))
            end,
        })
        table.insert(entries, {
            type = "button",
            label = L["Place a pin here"],
            onClick = function()
                local group = Groups:GetUngroupedGroup()
                if not group then return end
                local _, pinID = group:AddPin({ x = x, y = y, mapID = mapID, setTracked = false })
                if pinID then Tracker:OnUserPinsAdded() end
            end,
        })
    else
        table.insert(entries, { type = "title", label = L["Unable to determine your current position on the map."] })
    end
    table.insert(entries, { type = "divider" })
    for _, suffix in ipairs({ "Lock", "ShowZone", "ShowDecimals" }) do
        local key = "Coordinates." .. suffix
        table.insert(entries, {
            type = "checkbox",
            label = L[key .. "_LABEL"],
            isSelected = function() return Options:GetOptionValue(key) == true end,
            setSelected = function()
                Options:SetOptionValue(key, not Options:GetOptionValue(key))
            end,
        })
    end
    MapPinEnhanced:GenerateMenu(self, entries)
end

function MapPinEnhancedCoordinatesDisplayMixin:UpdateCoordinateLayout()
    local showDecimals = Options:GetOptionValue("Coordinates.ShowDecimals") == true
    self.coordsXDec:SetShown(showDecimals)
    self.coordsYDec:SetShown(showDecimals)
    self.zoneName:SetWidth(0)
    local zoneWidth = self.zoneName:GetStringWidth()
    self.zoneName:SetWidth(zoneWidth)
    self.separator:SetShown(zoneWidth == 0)
    local gap = zoneWidth > 0 and zoneWidth / 2 + 8 or 5
    -- XML reserves fixed coordinate columns so changing digits never changes geometry.
    local xWidth = self.coordsXInt:GetWidth()
    local yWidth = self.coordsYInt:GetWidth()
    local xDecWidth = showDecimals and self.coordsXDec:GetWidth() or 0
    local yDecWidth = showDecimals and self.coordsYDec:GetWidth() or 0
    self.coordsXInt:ClearAllPoints()
    self.coordsXInt:SetPoint("RIGHT", self, "CENTER", -gap - xDecWidth, 0)
    self.coordsXDec:ClearAllPoints()
    self.coordsXDec:SetPoint("LEFT", self.coordsXInt, "RIGHT", 0, 0)
    self.coordsYInt:ClearAllPoints()
    self.coordsYInt:SetPoint("LEFT", self, "CENTER", gap, 0)
    local width = 2 * (gap + math.max(xWidth + xDecWidth, yWidth + yDecWidth) + 25)
    if width == self:GetWidth() then return end
    self:SetWidth(width)
end

function MapPinEnhancedCoordinatesDisplayMixin:SetUndefinedPosition()
    local showDecimals = Options:GetOptionValue("Coordinates.ShowDecimals") == true
    if self.positionDefined == false and self.cachedDecimals == showDecimals then return end
    self.positionDefined = false
    self.cachedDecimals = showDecimals
    self.cachedX, self.cachedY = nil, nil
    self.coordsXInt:SetText("--")
    if showDecimals then self.coordsXDec:SetText(".--") end
    self.coordsYInt:SetText("--")
    if showDecimals then self.coordsYDec:SetText(".--") end
end

function MapPinEnhancedCoordinatesDisplayMixin:SetCoordinatesText(x, y)
    local xHundredths = floor(x * 10000)
    local yHundredths = floor(y * 10000)

    local showDecimals = Options:GetOptionValue("Coordinates.ShowDecimals") == true
    local displayedX = showDecimals and xHundredths or floor(xHundredths / 100)
    local displayedY = showDecimals and yHundredths or floor(yHundredths / 100)
    if self.positionDefined and self.cachedDecimals == showDecimals and
        self.cachedX == displayedX and self.cachedY == displayedY then
        return
    end

    self.positionDefined = true
    self.cachedDecimals = showDecimals
    self.cachedX = displayedX
    self.cachedY = displayedY

    local xInt = floor(xHundredths / 100)
    local xDec = xHundredths % 100
    local yInt = floor(yHundredths / 100)
    local yDec = yHundredths % 100

    self.coordsXInt:SetText(format("%02d", xInt))
    if showDecimals then self.coordsXDec:SetText(format(".%02d", xDec)) end
    self.coordsYInt:SetText(format("%02d", yInt))
    if showDecimals then self.coordsYDec:SetText(format(".%02d", yDec)) end
end

local UPDATE_RATE = 0.1
---@param elapsed number
function MapPinEnhancedCoordinatesDisplayMixin:OnUpdate(elapsed)
    self.lastUpdate = (self.lastUpdate or 0) + elapsed
    if self.lastUpdate < UPDATE_RATE then
        return
    end
    self.lastUpdate = 0
    local playerMap = GetBestMapForUnit("player")
    if not MapPinEnhanced:IsReadablePositiveInteger(playerMap) then playerMap = nil end
    if playerMap ~= self.cachedMapID then
        self.cachedMapID, self.cachedMapName = playerMap, nil
    end
    local name = ""
    if Options:GetOptionValue("Coordinates.ShowZone") and playerMap then
        if not self.cachedMapName then
            local mapInfo = C_Map.GetMapInfo(playerMap)
            local name = mapInfo and mapInfo.name
            self.cachedMapName = name ~= "" and name or nil
        end
        name = self.cachedMapName or ""
    end
    if name ~= (self.zoneName:GetText() or "") then
        self.zoneName:SetWidth(0)
        self.zoneName:SetText(name)
        self:UpdateCoordinateLayout()
    end
    if not playerMap then
        self:SetUndefinedPosition()
        return
    end
    local position = GetPlayerMapPosition(playerMap, "player")
    if not position then
        self:SetUndefinedPosition()
        return
    end
    local x, y = position:GetXY()
    if not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then
        self:SetUndefinedPosition()
        return
    end
    self:SetCoordinatesText(x, y)
end

--@debug@
MapPinEnhancedCoordinatesDisplayMixin.OnUpdate = MapPinEnhanced.profiler:WrapScope("Misc.Coordinates.OnUpdate",
    MapPinEnhancedCoordinatesDisplayMixin.OnUpdate)
--@end-debug@

function MapPinEnhancedCoordinatesDisplayMixin:LockPosition()
    self:SetMovable(false)
    self.lockButton:SetIconTexture("lock")
end

function MapPinEnhancedCoordinatesDisplayMixin:UnlockPosition()
    self:SetMovable(true)
    self.lockButton:SetIconTexture("unlock")
end

function MapPinEnhancedCoordinatesDisplayMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self:UpdateCoordinateLayout()
    -- Keep the saved-position key so existing frame placement survives this rename.
    self.position = self:GetParent() -- the fixed rectangle retains the original saved center
    MapPinEnhanced:RegisterDraggableFrame(self.position, "coordsDisplayFrame", self.dragHandle, function()
        return not self:IsMovable()
    end)

    self.lockButton:SetScript("OnClick", function()
        Options:SetOptionValue("Coordinates.Lock", self:IsMovable())
    end)

    self.closeButton:SetScript("OnClick", function()
        Options:SetOptionValue("Coordinates.Enable", false)
    end)

    ---@type boolean | nil
    local isLocked = Options:GetOptionValue("Coordinates.Lock")
    if isLocked then
        self:LockPosition()
    else
        self:UnlockPosition()
    end
end

local HOVER_TIME = 0.5
function MapPinEnhancedCoordinatesDisplayMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    MapPinEnhanced:AddTooltipInteractions(GameTooltip, { { L["Right Click"], L["Open menu"] } })
    if GameTooltip:NumLines() > 0 then GameTooltip:Show() else GameTooltip:Hide() end
    if self.buttonVisibilityTimer then self.buttonVisibilityTimer:Cancel() end
    self.buttonVisibilityTimer = C_Timer.NewTimer(HOVER_TIME, function()
        if not self:IsMouseOver() then return end
        self.closeButton.fadeIn:PlayShowing(self.closeButton.fadeOut)
        self.lockButton.fadeIn:PlayShowing(self.lockButton.fadeOut)
    end)
end

function MapPinEnhancedCoordinatesDisplayMixin:OnLeave()
    if GameTooltip:GetOwner() == self then GameTooltip:Hide() end
    if self.buttonVisibilityTimer then
        self.buttonVisibilityTimer:Cancel()
        self.buttonVisibilityTimer = nil
    end
    self.closeButton.fadeOut:PlayHiding(self.closeButton.fadeIn)
    self.lockButton.fadeOut:PlayHiding(self.lockButton.fadeIn)
end

function MapPinEnhancedCoordinatesDisplayMixin:ShowFrame()
    self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
    MapPinEnhanced:RestoreFrame(self.position)
    self.positionDefined, self.cachedMapName = nil, nil
    self:OnUpdate(1)
    self:Show()
end

function MapPinEnhancedCoordinatesDisplayMixin:HideFrame()
    self:SetScript("OnUpdate", nil)
    self:OnLeave()
    self:Hide()
end

---@type MapPinEnhancedCoordinatesDisplayTemplate?
local coordinatesDisplayFrame = nil

local function InitCoordinatesDisplayFrame()
    if coordinatesDisplayFrame then return end
    local position = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedCoordinatesPositionTemplate") --[[@as MapPinEnhancedCoordinatesPositionTemplate]]
    coordinatesDisplayFrame = position.display
end

local function ShowCoordinatesDisplay()
    InitCoordinatesDisplayFrame()
    if coordinatesDisplayFrame then
        coordinatesDisplayFrame:ShowFrame()
    end
end


local function HideCoordinatesDisplay()
    if coordinatesDisplayFrame and coordinatesDisplayFrame:IsShown() then
        coordinatesDisplayFrame:HideFrame()
    end
end



Options:SubscribeToOptionChanges("Coordinates.Enable", function(value)
    MapPinEnhanced:UpdateVisibilityTarget("coordinates")
end)

MapPinEnhanced:AddVisibilityRule("noCoordinates", {
    isActive = function()
        local playerMap = GetBestMapForUnit("player")
        if not MapPinEnhanced:IsReadablePositiveInteger(playerMap) then return true end
        local position = GetPlayerMapPosition(playerMap, "player")
        if not position then return true end
        local x, y = position:GetXY()
        return not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y)
    end,
    events = { "PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA" },
    delay = 1,
    poll = true,
})

MapPinEnhanced:RegisterVisibilityTarget("coordinates", {
    optionKey = "Coordinates.Visibility",
    rules = { "dungeon", "raid", "scenario", "battleground", "arena", "noCoordinates" },
    isManuallyEnabled = function()
        return Options:GetOptionValue("Coordinates.Enable") == true
    end,
    show = ShowCoordinatesDisplay,
    hide = HideCoordinatesDisplay,
})

local function LockCoordinatesDisplay()
    if coordinatesDisplayFrame then
        coordinatesDisplayFrame:LockPosition()
    end
end

local function UnlockCoordinatesDisplay()
    if coordinatesDisplayFrame then
        coordinatesDisplayFrame:UnlockPosition()
    end
end


Options:SubscribeToOptionChanges("Coordinates.Lock", function(value)
    if not coordinatesDisplayFrame then return end
    if value then
        LockCoordinatesDisplay()
    else
        UnlockCoordinatesDisplay()
    end
end)

for _, key in ipairs({ "Coordinates.ShowZone", "Coordinates.ShowDecimals" }) do
    Options:SubscribeToOptionChanges(key, function()
        if not coordinatesDisplayFrame then return end
        coordinatesDisplayFrame.positionDefined, coordinatesDisplayFrame.cachedMapName = nil, nil
        coordinatesDisplayFrame:OnUpdate(1)
        if key == "Coordinates.ShowDecimals" then
            coordinatesDisplayFrame:UpdateCoordinateLayout()
        end
    end)
end
