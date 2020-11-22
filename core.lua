local addonName, addon = ...
local MPH = addon

_G.MPH = MPH

local hbd = LibStub("HereBeDragons-2.0")
local hbdp = LibStub("HereBeDragons-Pins-2.0")

local C_Map = C_Map

local MPH_MapOverlayFrame = CreateFrame("Frame", "MPH_MapOverlayFrame", WorldMapFrame.BorderFrame)
MPH_MapOverlayFrame:SetFrameStrata("HIGH")
MPH_MapOverlayFrame:SetFrameLevel(9000)
MPH_MapOverlayFrame:SetAllPoints(true)

local MPH_Frame = CreateFrame ("frame", "MPH_ScreenPanel", UIParent, "BackdropTemplate")
MPH_Frame:SetSize (235, 500)
MPH_Frame:SetFrameStrata ("LOW")

local MPH_ObjectiveTrackerHeader = CreateFrame ("frame", "MPH_ObjectiveTrackerHeader", MPH_Frame, "ObjectiveTrackerHeaderTemplate")
MPH_ObjectiveTrackerHeader.Text:SetText ("Map Pins")

local MPH_QuestHolder = CreateFrame ("frame", "MPH_QuestHolder", MPH_Frame, "BackdropTemplate")
MPH_QuestHolder:SetAllPoints()


local pool = {}

local mapData = hbd.mapData -- Data is localized

local blockevent = false

--------------------------
------ UI Functions ------
function WaypointLocationPinMixin:OnAcquired()
    self:UseFrameLevelType("PIN_FRAME_LEVEL_WAYPOINT_LOCATION")
	if C_SuperTrack.IsSuperTrackingUserWaypoint() then
		self.Icon:SetAtlas("Waypoint-MapPin-Tracked")
	else
		self.Icon:SetAtlas("Waypoint-MapPin-Untracked")
	end
    self:SetAlpha(0)
    self:EnableMouse(false)
end

function SuperTrackedFrameMixin:GetTargetAlpha()
    local distance = C_Navigation.GetDistance()
    if distance > 10 then
        return 1
    else
        if distance < 5 then
            return 0
        else
            return distance / 10
        end
    end
end
--------------------------



local function CreatePin(x, y, mapID, emit)
    local pin = CreateFrame("Button", nil, MPH_MapOverlayFrame)
    pin:SetSize(30, 30)
    pin:EnableMouse(true)
    pin:SetMouseClickEnabled(true)

    local tracked = false

    local function Track()
        tracked = true
        pin.icon:SetAtlas("Waypoint-MapPin-Tracked", true)
        blockevent = true
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        blockevent = false
    end
    local function Untrack()
        tracked = false
        pin.icon:SetAtlas("Waypoint-MapPin-Untracked", true)
        C_SuperTrack.SetSuperTrackedUserWaypoint(false)
    end

    local function ToggleTracked()
        if tracked then Untrack() else emit("track") end
    end
    local function ShowOnMap()
        hbdp:AddWorldMapIconMap(addon, pin, mapID, x, y, 3)
    end
    local function RemoveFromMap()
        hbdp:RemoveWorldMapIcon(addon, pin)
    end
    local function IsTracked()
        return tracked
    end
    local function FormatHyperlink() -- TODO: Investigate if it's possible to change the "MAP_PIN_HYPERLINK" to include info
        return ("|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(
            mapID,
            x * 10000,
            y * 10000,
            MAP_PIN_HYPERLINK)
    end

    pin.icon = pin:CreateTexture(nil, "BORDER")
    pin.icon:SetAtlas("Waypoint-MapPin-Tracked", true)
    pin.icon:SetSize(30, 30)
    pin.icon:SetBlendMode("BLEND")
    pin.icon:SetAllPoints(pin)
    pin:SetScript("OnMouseDown", function(self, arg1)
        if arg1 == "LeftButton" then
            if IsControlKeyDown() then
                emit("remove")
            elseif IsShiftKeyDown() then
                local link = FormatHyperlink()
                ChatEdit_InsertLink(link)
            else
                ToggleTracked()
            end
        end
        self:SetPoint("CENTER", 2, -2)
    end)
    pin:SetScript("OnMouseUp", function(self, arg1)
        self:SetPoint("CENTER", 0, 0)
    end)
    pin:SetScript("OnEnter", function(self, motion)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4)
        GameTooltip_SetTitle(GameTooltip, MAP_PIN_SHARING .. " (Map Pin Enhanced)")
        GameTooltip_AddNormalLine(GameTooltip, MAP_PIN_SHARING_TOOLTIP)
        GameTooltip_AddColoredLine(GameTooltip, MAP_PIN_REMOVE, GREEN_FONT_COLOR)
        GameTooltip:Show()
    end)
    pin:SetScript("OnLeave", function(self, motion)
        GameTooltip:Hide()
    end)

    local highlightTexture = pin:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetAllPoints(true)
    highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)

    return {
        Untrack = Untrack,
        Track = Track,
        ToggleTracked = ToggleTracked,
        ShowOnMap = ShowOnMap,
        RemoveFromMap = RemoveFromMap,
        IsTracked = IsTracked,
        FormatHyperlink = FormatHyperlink,
        x = x,
        y = y,
        mapID = mapID,
    }
end

local function DistanceFromPlayer(pin)
    local PlayerZonePosition = {hbd:GetPlayerZonePosition()}
    return (hbd:GetZoneDistance(PlayerZonePosition[3], PlayerZonePosition[1], PlayerZonePosition[2], pin.mapID, pin.x, pin.y))
end

local function IsCloser(pin, ref)
    if ref and DistanceFromPlayer(pin) and DistanceFromPlayer(ref) then
        return DistanceFromPlayer(pin) < DistanceFromPlayer(ref)
    else
        return true
    end
end

local function PinManager()
    local pins = {}
    local function SupertrackClosest() -- TODO: Only track closes if on same map
        local pin = nil
        for i, p in ipairs(pins) do
            if p.IsTracked() then return end
            if IsCloser(p, pin) then
                pin = p
            end
        end
        if pin then pin.Track() end
    end
    local function RemovePin(pin)
        pin.RemoveFromMap()
        for i, p in ipairs(pins) do
            if p == pin then
                pins[i] = pins[#pins]
                pins[#pins] = nil
                C_Map.ClearUserWaypoint()
                SupertrackClosest()
            end
        end
    end

    local function UntrackPins()
        for i, p in ipairs(pins) do
            if p.IsTracked() then
                p.Untrack()
            end
        end
    end

    local function AddPin(x, y, mapID)
        for i, p in ipairs(pins) do
            if math.abs(x - p.x) < 0.01 and math.abs(y - p.y) < 0.01 and mapID == p.mapID then
                print("Pin Already exists")
                UntrackPins()
                p.Track()
                return
            end
        end

        local pin
        pin = CreatePin(x, y, mapID, function(e)
            if e == "remove" then
                RemovePin(pin)
                SupertrackClosest()
            elseif e == "track" then
                UntrackPins()
                pin.Track()
            end
        end)
        pin.ShowOnMap()
        pins[#pins + 1] = pin
        UntrackPins()
        pin.Track()
    end

    local function RestorePin()
        for i, p in ipairs(pins) do
            if p.SupertrackClosest() then
                break
            end
        end
    end

    local function RefreshTracking()
        for i, p in ipairs(pins) do
            if p.IsTracked() then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        end
    end

    local function RemoveTrackedPin()
        for i, p in ipairs(pins) do
            if p.IsTracked() then
                RemovePin(p)
                return
            end
        end
    end

    local function PinData()
        return pins
    end

    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
        RefreshTracking = RefreshTracking,
        RemoveTrackedPin = RemoveTrackedPin,
        PinData = PinData
    }
end

local pinManager = PinManager()

function CreateTrackerWidget(index)
    if pool[index] then return pool[index] end

    local w = CreateFrame("button", "MPH_Tracker" .. index, MPH_QuestHolder, "BackdropTemplate")
    w:SetSize(235, 25)
    w:EnableMouse(true)
    w:SetMouseClickEnabled(true)
    w.Icon = w:CreateTexture (nil, "BORDER")
	w.Icon:SetPoint ("right", w, "left", 20, 0)
	w.Icon:SetSize(25, 25)
    w.Title = w:CreateFontString(nil,"BORDER", "GameFontNormalMed3")
    w.Title:SetPoint ("left", w, "left", 23, 0)
    w.Icon:SetBlendMode("BLEND")
    w.Icon.highlightTexture = w:CreateTexture(nil, "HIGHLIGHT")
    w.Icon.highlightTexture:SetAllPoints(w.Icon)
    w.Icon.highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)

    pool[index] = w
    return w
end

local function MPH_ObjectiveTracker()

    local color_header = OBJECTIVE_TRACKER_COLOR["Header"]
    local color_headerhighlight = OBJECTIVE_TRACKER_COLOR["HeaderHighlight"]
    local TrackerHeight

    local function UpdateHeader()
        local tracker = ObjectiveTrackerFrame

        if (not tracker.initialized) then
            return
        end
        local y = 0
	    for i = 1, #tracker.MODULES do
            local module = tracker.MODULES [i]
            if (module.Header:IsShown()) then
                y = y + module.contentsHeight
            end
        end
        if (tracker.collapsed) then
            TrackerHeight = 20
        else
            TrackerHeight = y
        end

        MPH_ScreenPanel:ClearAllPoints()

        MPH_ObjectiveTrackerHeader:ClearAllPoints()
        MPH_ObjectiveTrackerHeader:SetPoint("bottom", MPH_Frame, "top", 0, -20)
        MPH_ObjectiveTrackerHeader:Show()
        MPH_ObjectiveTrackerHeader.MinimizeButton:Hide() -- temporary

        for i = 1, tracker:GetNumPoints() do
            local point, relativeTo, relativePoint, xOfs, yOfs = tracker:GetPoint (i)
            MPH_ScreenPanel:SetPoint(point, relativeTo, relativePoint, -10 + xOfs, yOfs - TrackerHeight - 20)
        end

        MPH_ObjectiveTrackerHeader:ClearAllPoints()
        MPH_ObjectiveTrackerHeader:SetPoint ("bottom", MPH_Frame, "top", 0, -20)
    end

    local function UpdateWidgets()
        local pins = pinManager.PinData()
        if #pins == 0 then
            MPH_QuestHolder:Hide()
            MPH_ObjectiveTrackerHeader:Hide()
            return
        end
        MPH_QuestHolder:Show()
        local nextWidget = 1
        local y = -25
        for index, pin in ipairs(pins) do -- TODO: If necessary: Don't iterate only if track is changed
            local info = C_Map.GetMapInfo(pin.mapID)
            local widget = CreateTrackerWidget(nextWidget)
            widget:ClearAllPoints()
            widget:SetPoint ("topleft", MPH_Frame, "topleft", 0, y)
            if pin.IsTracked() then
                widget.Icon:SetAtlas("Waypoint-MapPin-Tracked")
            else
                widget.Icon:SetAtlas("Waypoint-MapPin-Untracked")
            end
            widget.Icon.highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)
            widget.Title:SetText(info.name .. " (" ..  Round(pin.x*100) .. ", " .. Round(pin.y*100) .. ")")
            widget.Title:SetTextColor (color_header.r, color_header.g, color_header.b)
            widget:SetScript("OnMouseDown", function(self, arg1)
                if arg1 == "LeftButton" then
                    if IsShiftKeyDown() then
                        local link = pin.FormatHyperlink()
                        ChatEdit_InsertLink(link)
                    elseif IsControlKeyDown() then
                        pinManager.RemovePin(pin)
                        UpdateWidgets()
                    else
                        pin.ToggleTracked()
                    end
                else
                    pinManager.RemovePin(pin)
                    UpdateWidgets()
                end
            end)
            widget:SetScript("OnEnter", function(self, motion)
                widget.Title:SetTextColor(color_headerhighlight.r, color_headerhighlight.g, color_headerhighlight.b)
            end)
            widget:SetScript("OnLeave", function(self, motion)
                widget.Title:SetTextColor (color_header.r, color_header.g, color_header.b)
            end)
            widget:Show()
            y = y - 27
            nextWidget = nextWidget + 1
        end
        for i = nextWidget, #pool do
            pool[i]:Hide()
        end
        UpdateHeader()
    end

    return {
        UpdateHeader = UpdateHeader,
        UpdateWidgets = UpdateWidgets
    }
end

local MPH_ObjectiveTracker = MPH_ObjectiveTracker()

function MPH:AddWaypoint(x, y, mapID)
    if x and y and mapID then
        pinManager.AddPin(x, y, mapID)
    else
        error("x, y or mapID missing")
    end
end

local function OnEvent(self, event, ...)
    if event == "USER_WAYPOINT_UPDATED" then
        if blockevent then return end
        --print(self, event, ...)
        local userwaypoint = C_Map.GetUserWaypoint()
        if userwaypoint then
            local superTrackedQuestID = C_SuperTrack.GetSuperTrackedQuestID()
            if superTrackedQuestID ~= 0 then
                if C_QuestLog.IsWorldQuest(superTrackedQuestID) then
                    C_QuestLog.RemoveWorldQuestWatch(superTrackedQuestID)
                else
                    C_QuestLog.RemoveQuestWatch(superTrackedQuestID)
                end
            end
            blockevent = true
            C_Map.ClearUserWaypoint()
            blockevent = false
            MPH:AddWaypoint(userwaypoint.position.x, userwaypoint.position.y, userwaypoint.uiMapID)
        end
    elseif event == "SUPER_TRACKING_CHANGED" then
        --print(self, event, ...)
        if C_SuperTrack.IsSuperTrackingQuest() then
            pinManager.UntrackPins()
            C_SuperTrack.SetSuperTrackedUserWaypoint(false)
            C_Map.ClearUserWaypoint()
        else
            if not C_SuperTrack.IsSuperTrackingUserWaypoint() then
                pinManager.RefreshTracking()
            end
        end
    elseif event == "PLAYER_LOGIN" then
        print(self, event, ...)
    end
end

local ONUPDATE_INTERVAL = 0.3
local TimeSinceLastUpdate = 0

local function OnUpdate(self, elapsed)
    TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
		TimeSinceLastUpdate = 0
        local distance = C_Navigation.GetDistance()
        if distance < 5 and distance > 0 then
           pinManager.RemoveTrackedPin()
        end
    end
end




local f = CreateFrame("Frame")
f:RegisterEvent("SUPER_TRACKING_CHANGED")
f:RegisterEvent("USER_WAYPOINT_UPDATED")
f:RegisterEvent("PLAYER_LOGIN")
-- f:RegisterEvent("NAVIGATION_FRAME_CREATED")
-- f:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
f:SetScript("OnEvent", OnEvent)
f:SetScript("OnUpdate", OnUpdate)


hooksecurefunc ("ObjectiveTracker_Update", function(...) --TODO: Better update function for Objective Tracker
    MPH_ObjectiveTracker.UpdateHeader()
    MPH_ObjectiveTracker.UpdateWidgets()
end)
