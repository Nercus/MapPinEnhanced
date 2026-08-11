---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- FIXME: small ui scales cause the numbers to be cut off, fix that
-- TODO: add a rightclick menu to share location, save location, add waypoint to current location for wayback, scale, close and lock

---@class MapPinEnhancedCoordsDisplayButton : MapPinEnhancedIconButtonTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin


---@class MapPinEnhancedCoordsDisplayTemplate : Frame
---@field coordsXInt FontString
---@field coordsXDec FontString
---@field coordsYInt FontString
---@field coordsYDec FontString
---@field timeSinceLastUpdate number
---@field closeButton MapPinEnhancedCoordsDisplayButton
---@field lockButton MapPinEnhancedCoordsDisplayButton
---@field dragHandle Frame
---@field buttonVisibilityTimer FunctionContainer
MapPinEnhancedCoordsDisplayMixin = {}

local L = MapPinEnhanced.L

local Providers = MapPinEnhanced:GetModule("Providers")
local Options = MapPinEnhanced:GetModule("Options")

local GetBestMapForUnit = C_Map.GetBestMapForUnit
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition
local floor = math.floor
local modf = math.modf
local format = string.format
local DeltaLerp = DeltaLerp

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
    Providers:LinkToChat(x, y, playerMap, format(L["%s's Position"], MapPinEnhanced.me))
end

function MapPinEnhancedCoordsDisplayMixin:SetUndefinedPosition()
    self.coordsXInt:SetText("--")
    self.coordsXDec:SetText(".--")
    self.coordsYInt:SetText("--")
    self.coordsYDec:SetText(".--")
end

function MapPinEnhancedCoordsDisplayMixin:SetCoordsText(x, y)
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
end

local UPDATE_RATE = 0.1
---@param elapsed number
function MapPinEnhancedCoordsDisplayMixin:OnUpdate(elapsed)
    self.lastUpdate = (self.lastUpdate or 0) + elapsed
    if self.lastUpdate < UPDATE_RATE then
        return
    end
    self.lastUpdate = 0
    local playerMap = GetBestMapForUnit("player")
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
    if not x or not y then
        self:SetUndefinedPosition()
        return
    end
    self:SetCoordsText(x, y)
end

function MapPinEnhancedCoordsDisplayMixin:LockPosition()
    self:SetMovable(false)
    self.lockButton.iconTexture:SetDesaturated(false)
end

function MapPinEnhancedCoordsDisplayMixin:UnlockPosition()
    self:SetMovable(true)
    self.lockButton.iconTexture:SetDesaturated(true)
end

function MapPinEnhancedCoordsDisplayMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "coordsDisplayFrame", self.dragHandle, function()
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
function MapPinEnhancedCoordsDisplayMixin:OnEnter()
    self.buttonVisibilityTimer = C_Timer.NewTimer(HOVER_TIME, function()
        if not self:IsMouseOver() then return end
        self.closeButton.fadeIn:PlayShowing(self.closeButton.fadeOut)
        self.lockButton.fadeIn:PlayShowing(self.lockButton.fadeOut)
    end)
end

function MapPinEnhancedCoordsDisplayMixin:OnLeave()
    if self.buttonVisibilityTimer then
        self.buttonVisibilityTimer:Cancel()
        self.buttonVisibilityTimer = nil
    end
    self.closeButton.fadeOut:PlayHiding(self.closeButton.fadeIn)
    self.lockButton.fadeOut:PlayHiding(self.lockButton.fadeIn)
end

function MapPinEnhancedCoordsDisplayMixin:ShowFrame()
    self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
    MapPinEnhanced:RestoreFrame(self)
    self:Show()
end

function MapPinEnhancedCoordsDisplayMixin:HideFrame()
    self:SetScript("OnUpdate", nil)
    self:Hide()
end

local coordsDisplayFrame = nil

local function InitCoordsDisplayFrame()
    if coordsDisplayFrame then return end
    coordsDisplayFrame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedCoordsDisplayTemplate")
end

local function ShowCoordsDisplay()
    InitCoordsDisplayFrame()
    if coordsDisplayFrame then
        coordsDisplayFrame:ShowFrame()
    end
end


local function HideCoordsDisplay()
    if coordsDisplayFrame and coordsDisplayFrame:IsShown() then
        coordsDisplayFrame:HideFrame()
    end
end



Options:SubscribeToOptionChanges("Miscellaneous.Coords.Enable", function(value)
    MapPinEnhanced:EvaluateVisibilityTarget("coordinates")
end)

MapPinEnhanced:RegisterVisibilityCondition("noCoordinates", {
    evaluate = function()
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
    conditions = { "dungeon", "raid", "scenario", "battleground", "arena", "noCoordinates" },
    isManuallyEnabled = function()
        return Options:GetOptionValue("Miscellaneous.Coords.Enable") == true
    end,
    show = ShowCoordsDisplay,
    hide = HideCoordsDisplay,
})

local function LockCoordsDisplay()
    if coordsDisplayFrame then
        coordsDisplayFrame:LockPosition()
    end
end

local function UnlockCoordsDisplay()
    if coordsDisplayFrame then
        coordsDisplayFrame:UnlockPosition()
    end
end


Options:SubscribeToOptionChanges("Miscellaneous.Coords.Lock", function(value)
    if not coordsDisplayFrame then return end
    if value then
        LockCoordsDisplay()
    else
        UnlockCoordsDisplay()
    end
end)

local function ToggleCoordsDisplay()
    Options:SetOptionValue("Miscellaneous.Coords.Enable",
        not Options:GetOptionValue("Miscellaneous.Coords.Enable"))
end

MapPinEnhanced:AddSlashCommand("coords", ToggleCoordsDisplay,
    MapPinEnhanced.L["Toggle display of your current coordinates on the screen."])
