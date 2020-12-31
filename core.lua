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

local blockevent = false

function WaypointLocationPinMixin:OnAcquired()
    self:SetAlpha(0);
    self:EnableMouse(false);
end

local function CreatePin(x, y, mapID, emit)
    local pin = CreateFrame("Button", nil, MPH_MapOverlayFrame)
    pin:SetSize(30, 30)
    pin:EnableMouse(true)
    pin:SetMouseClickEnabled(true)

    local tracked = true

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
        if tracked then Untrack() else Track() end
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
                ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
                ChatEdit_InsertLink(link)
            else
                ToggleTracked()
            end
        elseif arg1 == "RightButton" then
            -- TODO: Open Dropdown with options: Remove this point, Remove All points
            print(arg1)
        end
        self:SetPoint("CENTER", 2, -2)
    end)
    pin:SetScript("OnMouseUp", function(self, arg1)
        self:SetPoint("CENTER", 0, 0)
    end)
    pin:SetScript("OnEnter", function(self, motion)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4);
        GameTooltip_SetTitle(GameTooltip, MAP_PIN_SHARING .. " (Map Pin Enhanced)");
        GameTooltip_AddNormalLine(GameTooltip, MAP_PIN_SHARING_TOOLTIP);
        GameTooltip_AddColoredLine(GameTooltip, MAP_PIN_REMOVE, GREEN_FONT_COLOR);
        GameTooltip:Show();
    end)
    pin:SetScript("OnLeave", function(self, motion)
        GameTooltip:Hide();
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
    }
end

local function DistanceFromPlayer(pin)
    local PlayerZonePosition = {hbd:GetPlayerZonePosition()}
    return (hbd:GetZoneDistance(PlayerZonePosition[3], PlayerZonePosition[1], PlayerZonePosition[2], pin.mapID, pin.x, pin.y))
end

local function IsCloser(pin, ref)
    if ref then
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
    local function UntrackPins(pin)
        for i, p in ipairs(pins) do
            if p.IsTracked() and p ~= pin then
                p.Untrack()
            end
        end
    end
    local function AddPin(x, y, mapID)
        local pin = CreatePin(x, y, mapID, function(e)
            if e == "remove" then
                RemovePin(pin)
                SupertrackClosest()
            end
        end)
        pin.mapID = mapID
        pin.x = x
        pin.y = y
        pin.ShowOnMap()
        pins[#pins + 1] = pin
        UntrackPins(pin)
        pin.Track()
    end
    local function RestorePin()
        for i, p in ipairs(pins) do
            if p.SupertrackClosest() then
                break
            end
        end
    end

    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
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
    --print(self, event, ...)
    if blockevent then return end
    print(self, event, ...)
    local userwaypoint = C_Map.GetUserWaypoint()
    -- TODO: Block if pin already exists
    if userwaypoint then
        blockevent = true
        C_Map.ClearUserWaypoint()
        blockevent = false
        MPH:AddWaypoint(userwaypoint.position.x, userwaypoint.position.y, userwaypoint.uiMapID)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("USER_WAYPOINT_UPDATED")
f:SetScript("OnEvent", OnEvent)
