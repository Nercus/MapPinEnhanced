---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- TODO: add a rightclick menu to share location, save location, add waypoint to current location for wayback, scale, close and lock

---@class MapPinEnhancedCoordinatesDisplayButton : MapPinEnhancedIconButtonTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin


---@class MapPinEnhancedCoordinatesPositionTemplate : Frame
---@field display MapPinEnhancedCoordinatesDisplayTemplate

---@class MapPinEnhancedCoordinatesDisplayTemplate : Frame, MapPinEnhancedFadingFrameTemplate
---@field zoneName FontString
---@field separator Texture
---@field position Frame
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

local Providers = MapPinEnhanced:GetModule("Providers")
local Options = MapPinEnhanced:GetModule("Options")

local GetBestMapForUnit = C_Map.GetBestMapForUnit
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition
local floor = math.floor
local modf = math.modf
local format = string.format
local DeltaLerp = DeltaLerp

function MapPinEnhancedCoordinatesDisplayMixin:LinkPlayerPosition()
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
    Providers:LinkToChat(x, y, playerMap, format(L["%s's Position"], MapPinEnhanced.me))
end

function MapPinEnhancedCoordinatesDisplayMixin:UpdateCoordinateLayout()
    local showDecimals = Options:GetOptionValue("Miscellaneous.Coords.ShowDecimals") == true
    self.coordsXDec:SetShown(showDecimals)
    self.coordsYDec:SetShown(showDecimals)
    self.zoneName:SetWidth(0)
    self.coordsXInt:SetWidth(0)
    self.coordsYInt:SetWidth(0)
    self.coordsXDec:SetWidth(0)
    self.coordsYDec:SetWidth(0)
    local zoneWidth = self.zoneName:GetStringWidth()
    self.zoneName:SetWidth(zoneWidth)
    self.separator:SetShown(zoneWidth == 0)
    local gap = zoneWidth > 0 and zoneWidth / 2 + 8 or 5
    local xWidth = self.coordsXInt:GetStringWidth()
    local yWidth = self.coordsYInt:GetStringWidth()
    local xDecWidth = showDecimals and self.coordsXDec:GetStringWidth() or 0
    local yDecWidth = showDecimals and self.coordsYDec:GetStringWidth() or 0
    self.coordsXInt:SetWidth(xWidth)
    self.coordsYInt:SetWidth(yWidth)
    self.coordsXDec:SetWidth(math.max(1, xDecWidth))
    self.coordsYDec:SetWidth(math.max(1, yDecWidth))
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
    self.cachedX, self.cachedY = nil, nil
    self.coordsXInt:SetText("--")
    self.coordsXDec:SetText(".--")
    self.coordsYInt:SetText("--")
    self.coordsYDec:SetText(".--")
    self:UpdateCoordinateLayout()
end

function MapPinEnhancedCoordinatesDisplayMixin:SetCoordinatesText(x, y)
    local xHundredths = floor(x * 10000)
    local yHundredths = floor(y * 10000)

    if self.cachedX == xHundredths and self.cachedY == yHundredths then
        return
    end

    self.cachedX = xHundredths
    self.cachedY = yHundredths

    local xInt = floor(xHundredths / 100)
    local xDec = xHundredths % 100
    local yInt = floor(yHundredths / 100)
    local yDec = yHundredths % 100

    self.coordsXInt:SetText(format("%02d", xInt))
    self.coordsXDec:SetText(format(".%02d", xDec))
    self.coordsYInt:SetText(format("%02d", yInt))
    self.coordsYDec:SetText(format(".%02d", yDec))
    self:UpdateCoordinateLayout()
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
    local mapInfo = playerMap and C_Map.GetMapInfo(playerMap)
    local name = Options:GetOptionValue("Miscellaneous.Coords.ShowZone") and mapInfo and mapInfo.name or ""
    if name ~= self.zoneName:GetText() then
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
    -- Keep the saved-position key so existing frame placement survives this rename.
    self.position = self:GetParent() -- the fixed rectangle retains the original saved center
    MapPinEnhanced:RegisterDraggableFrame(self.position, "coordsDisplayFrame", self.dragHandle, function()
        return not self:IsMovable()
    end)

    self.lockButton:SetScript("OnClick", function()
        Options:SetOptionValue("Miscellaneous.Coords.Lock", self:IsMovable())
    end)

    self.closeButton:SetScript("OnClick", function()
        Options:SetOptionValue("Miscellaneous.Coords.Enable", false)
    end)

    ---@type boolean | nil
    local isLocked = Options:GetOptionValue("Miscellaneous.Coords.Lock")
    if isLocked then
        self:LockPosition()
    else
        self:UnlockPosition()
    end
end

local HOVER_TIME = 0.5
function MapPinEnhancedCoordinatesDisplayMixin:OnEnter()
    self.buttonVisibilityTimer = C_Timer.NewTimer(HOVER_TIME, function()
        if not self:IsMouseOver() then return end
        self.closeButton.fadeIn:PlayShowing(self.closeButton.fadeOut)
        self.lockButton.fadeIn:PlayShowing(self.lockButton.fadeOut)
    end)
end

function MapPinEnhancedCoordinatesDisplayMixin:OnLeave()
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
    self.cachedX, self.cachedY = nil, nil
    self:OnUpdate(1)
    self:Show()
end

function MapPinEnhancedCoordinatesDisplayMixin:HideFrame()
    self:SetScript("OnUpdate", nil)
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



Options:SubscribeToOptionChanges("Miscellaneous.Coords.Enable", function(value)
    MapPinEnhanced:UpdateVisibilityTarget("coordinates")
end)

MapPinEnhanced:AddVisibilityRule("noCoordinates", {
    isActive = function()
        local playerMap = GetBestMapForUnit("player")
        if not playerMap then return true end
        local position = GetPlayerMapPosition(playerMap, "player")
        if not position then return true end
        local x, y = position:GetXY()
        return x == nil or y == nil
    end,
    events = { "PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA" },
    delay = 1,
    poll = true,
})

MapPinEnhanced:RegisterVisibilityTarget("coordinates", {
    optionKey = "Miscellaneous.Coords.Visibility",
    rules = { "dungeon", "raid", "scenario", "battleground", "arena", "noCoordinates" },
    isManuallyEnabled = function()
        return Options:GetOptionValue("Miscellaneous.Coords.Enable") == true
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


Options:SubscribeToOptionChanges("Miscellaneous.Coords.Lock", function(value)
    if not coordinatesDisplayFrame then return end
    if value then
        LockCoordinatesDisplay()
    else
        UnlockCoordinatesDisplay()
    end
end)

for _, key in ipairs({ "Miscellaneous.Coords.ShowZone", "Miscellaneous.Coords.ShowDecimals" }) do
    Options:SubscribeToOptionChanges(key, function()
        if not coordinatesDisplayFrame then return end
        coordinatesDisplayFrame.cachedX, coordinatesDisplayFrame.cachedY = nil, nil
        coordinatesDisplayFrame:OnUpdate(1)
    end)
end
