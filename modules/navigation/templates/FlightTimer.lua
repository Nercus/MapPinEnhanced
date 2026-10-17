---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

---@class NavigationSavedFlight
---@field started number Server time at confirmed takeoff.
---@field duration number? Estimated total seconds, absent when unknown.
---@field destination string?

---@class MapPinEnhancedFlightTimerButton : MapPinEnhancedIconButtonTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedFlightTimer : Frame
---@field progress MapPinEnhancedStatusbarTemplate
---@field closeButton MapPinEnhancedFlightTimerButton
---@field lockButton MapPinEnhancedFlightTimerButton
---@field buttonVisibilityTimer FunctionContainer?
---@field dragHandle Frame
---@field elapsed number
MapPinEnhancedFlightTimerMixin = {}

local frame ---@type MapPinEnhancedFlightTimer?
local flight ---@type NavigationSavedFlight?
local pending ---@type { duration: number?, destination: string?, expires: number }?
local ticker ---@type FunctionContainer?
local inWorld = true
local startedAt = 0

local function PersistFlight()
    local key = MapPinEnhanced:GetCharacterKey()
    if not key then return end
    if flight then
        MapPinEnhanced:SetVar("flightTimer", key, flight)
    else
        MapPinEnhanced:DeleteVar("flightTimer", key)
    end
end

local function FormatTime(seconds)
    seconds = math.max(0, math.ceil(seconds))
    return string.format("%d:%02d", math.floor(seconds / 60), seconds % 60)
end

function MapPinEnhancedFlightTimerMixin:Update()
    if not flight then return end
    local elapsed = math.max(0, GetTime() - startedAt)
    local duration = flight.duration
    self.progress:SetValue(duration and math.min(1, elapsed / duration) or 0)
    self.progress:SetName(flight.destination or L["Flight Timer"])
    -- Refresh the inherited text even when the bar is unchanged (unknown or
    -- expired estimates); OnValueChanged alone cannot keep that clock running.
    if duration and elapsed < duration then
        self.progress.progress:SetText(string.format(L["Flight remaining: %s"], FormatTime(duration - elapsed)))
    else
        -- An expired estimate is not evidence of landing. Keep the elapsed clock
        -- visible until the taxi state confirms the flight has actually ended.
        self.progress.progress:SetText(string.format(L["Flight elapsed: %s"], FormatTime(elapsed)))
    end
end

function MapPinEnhancedFlightTimerMixin:OnEnter()
    if self.buttonVisibilityTimer then self.buttonVisibilityTimer:Cancel() end
    self.buttonVisibilityTimer = C_Timer.NewTimer(0.5, function()
        self.buttonVisibilityTimer = nil
        if not self:IsShown() or not self:IsMouseOver() then return end
        self.closeButton.fadeIn:PlayShowing(self.closeButton.fadeOut)
        self.lockButton.fadeIn:PlayShowing(self.lockButton.fadeOut)
    end)
end

function MapPinEnhancedFlightTimerMixin:OnLeave()
    if self.buttonVisibilityTimer then
        self.buttonVisibilityTimer:Cancel()
        self.buttonVisibilityTimer = nil
    end
    self.closeButton.fadeOut:PlayHiding(self.closeButton.fadeIn)
    self.lockButton.fadeOut:PlayHiding(self.lockButton.fadeIn)
end

function MapPinEnhancedFlightTimerMixin:OnUpdate(elapsed)
    self.elapsed = self.elapsed + elapsed
    if self.elapsed < 0.1 then return end
    self.elapsed = 0
    self:Update()
end

function MapPinEnhancedFlightTimerMixin:OnShow()
    self.elapsed = 0
    self:Update()
    self:SetScript("OnUpdate", self.OnUpdate)
end

function MapPinEnhancedFlightTimerMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    if self.buttonVisibilityTimer then
        self.buttonVisibilityTimer:Cancel()
        self.buttonVisibilityTimer = nil
    end
    self.closeButton.fadeIn:SetParentShownInstantly(false, self.closeButton.fadeOut)
    self.lockButton.fadeIn:SetParentShownInstantly(false, self.lockButton.fadeOut)
end

function MapPinEnhancedFlightTimerMixin:OnLoad()
    self.progress:SetMinMaxValues(0, 1)
    self.progress:SetFillGradient(CreateColor(0.55, 0.40, 0.02), CreateColor(0.28, 0.20, 0.01))
    self.progress.progress:SetTextColor(1, 1, 1)
    MapPinEnhanced:RegisterDraggableFrame(self, "flightTimerFrame", self.dragHandle, function()
        return Options:GetOptionValue("General.FlightTimer.Lock") == true
    end)
    MapPinEnhanced:RestoreFrame(self)
    self.closeButton:SetScript("OnClick", function()
        Options:SetOptionValue("General.FlightTimer.Enable", false)
    end)
    self.lockButton:SetScript("OnClick", function()
        Options:SetOptionValue("General.FlightTimer.Lock",
            Options:GetOptionValue("General.FlightTimer.Lock") ~= true)
    end)
end

local function RefreshDisplay()
    local shown = inWorld and flight ~= nil and Options:GetOptionValue("General.FlightTimer.Enable") == true
    if shown and not frame then
        frame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFlightTimerTemplate") --[[@as MapPinEnhancedFlightTimer]]
    end
    if not frame then return end
    local scale = Options:GetOptionValue("General.FlightTimer.Scale") --[[@as number]]
    if frame:GetScale() ~= scale then
        MapPinEnhanced:SetFrameScale(frame, scale)
    end
    frame.lockButton:SetIconTexture(Options:GetOptionValue("General.FlightTimer.Lock") == true and "lock" or "unlock")
    frame:SetShown(shown)
end

local function StopTicker()
    if ticker then ticker:Cancel() end
    ticker = nil
end

local function CheckFlight()
    if not inWorld then return end
    local flying = UnitOnTaxi("player")
    if MapPinEnhanced:IsSecretValue(flying) or type(flying) ~= "boolean" then return end
    if flying then
        if not flight then
            flight = {
                started = GetServerTime(),
                duration = pending and pending.duration,
                destination = pending and pending.destination,
            }
            startedAt = GetTime()
            PersistFlight()
        end
        pending = nil
    elseif flight then
        flight = nil
        pending = nil
        PersistFlight()
    elseif pending and GetTime() >= pending.expires then
        pending = nil
    end
    RefreshDisplay()
    if not flight and not pending then StopTicker() end
end

local function WatchFlight()
    if not ticker then ticker = C_Timer.NewTicker(0.5, CheckFlight) end
end

-- The booking hook supplies a copied presentation before its taxi-map evidence
-- expires. Tracking remains independent of the selected navigation operation.
---@param duration number?
---@param destination string?
function Navigation:StartFlightTimer(duration, destination)
    pending = { duration = duration, destination = destination, expires = GetTime() + 15 }
    WatchFlight()
end

MapPinEnhanced:RegisterEvent("PLAYER_CONTROL_LOST", function()
    -- Also catches flights without a readable booking itinerary. Give taxi
    -- state time to settle; other causes of control loss stop after one check.
    WatchFlight()
end)
MapPinEnhanced:RegisterEvent("PLAYER_CONTROL_GAINED", WatchFlight)
MapPinEnhanced:RegisterEvent("PLAYER_LEAVING_WORLD", function()
    inWorld = false
    StopTicker()
    RefreshDisplay()
end)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    inWorld = true
    local key = MapPinEnhanced:GetCharacterKey()
    local saved = key and MapPinEnhanced:GetVar("flightTimer", key)
    local now = GetServerTime()
    if not flight and type(saved) == "table" and type(saved.started) == "number" and
        saved.started > now - 86400 and saved.started <= now then
        flight = {
            started = saved.started,
            duration = type(saved.duration) == "number" and saved.duration > 0 and
                saved.duration < math.huge and saved.duration or nil,
            destination = type(saved.destination) == "string" and saved.destination or nil,
        }
        startedAt = GetTime() - (now - flight.started)
    end
    -- Do not expose saved data until a live taxi check after loading.
    WatchFlight()
end)
for _, key in ipairs({ "General.FlightTimer.Enable", "General.FlightTimer.Lock", "General.FlightTimer.Scale" }) do
    Options:SubscribeToOptionChanges(key, RefreshDisplay)
end
