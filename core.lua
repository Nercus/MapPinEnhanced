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

local mapData = hbd.mapData -- Data is localized

local blockevent = false

function WaypointLocationPinMixin:OnAcquired()
    self:UseFrameLevelType("PIN_FRAME_LEVEL_WAYPOINT_LOCATION");
	if C_SuperTrack.IsSuperTrackingUserWaypoint() then
		self.Icon:SetAtlas("Waypoint-MapPin-Tracked");
	else
		self.Icon:SetAtlas("Waypoint-MapPin-Untracked");
	end
    self:SetAlpha(0)
    self:EnableMouse(false)
end

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
    local function FormatHyperlink()
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
    local function SupertrackClosest()
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


    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
        RefreshTracking = RefreshTracking,
    }
end

local pinManager = PinManager()

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
        print(self, event, ...)
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
        print(self, event, ...)
        if C_SuperTrack.IsSuperTrackingQuest() then
            pinManager.UntrackPins()
            C_SuperTrack.SetSuperTrackedUserWaypoint(false)
            C_Map.ClearUserWaypoint()
        else
            if not C_SuperTrack.IsSuperTrackingUserWaypoint() then
                pinManager.RefreshTracking()
            end
        end
    end
end


local f = CreateFrame("Frame")
f:RegisterEvent("SUPER_TRACKING_CHANGED")
f:RegisterEvent("USER_WAYPOINT_UPDATED")
-- f:RegisterEvent("NAVIGATION_FRAME_CREATED")
-- f:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
f:SetScript("OnEvent", OnEvent)
