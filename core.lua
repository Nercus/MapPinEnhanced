MapPinEnhanced = LibStub("AceAddon-3.0"):NewAddon("MapPinEnhanced", "AceConsole-3.0", "AceEvent-3.0")

local HBD = LibStub("HereBeDragons-2.0")
local HBDP = LibStub("HereBeDragons-Pins-2.0")

local mapDataID = {}
function MapPinEnhanced:OnInitialize()
    -- Restructure Map Data
    local HBDmapData = HBD.mapData -- Data is localized
    for mapID in pairs(HBDmapData) do
        local mapType = HBDmapData[mapID].mapType
        if mapType == Enum.UIMapType.Zone or mapType == Enum.UIMapType.Continent or mapType == Enum.UIMapType.Micro then
            local name = HBDmapData[mapID].name
            if name and mapDataID[name] then
                if type(mapDataID[name]) ~= "table" then
                    mapDataID[name] = {mapDataID[name]}
                end
                table.insert(mapDataID[name], mapID)
            else
                mapDataID[name] = mapID
            end
            mapDataID["#" .. mapID] = mapID
        end
    end
    local newEntries = {}
    for name, mapID in pairs(mapDataID) do
        if type(mapID) == "table" then
            mapDataID[name] = nil
            for _, mapId in pairs(mapID) do
                local parent = HBDmapData[mapId].parent
                local parentName = (parent and (parent > 0) and HBDmapData[parent].name)
                if parentName then
                    if not newEntries[name .. ":" .. parentName] then
                        newEntries[name .. ":" .. parentName] = mapId
                    else
                        newEntries[name .. ":" .. tostring(mapId)] = mapId
                    end
                end
            end
        end
    end
    for name, mapID in pairs(newEntries) do
        mapDataID[name] = mapID
    end
end

local blockWAYPOINTevent = false
function MapPinEnhanced:OnEnable()
    -- Register Events
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self:RegisterEvent("USER_WAYPOINT_UPDATED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_LOGIN")
end


local PinFramePool = {}
local MPH_MapOverlayFrame = CreateFrame("Frame", "MPH_MapOverlayFrame", WorldMapFrame.BorderFrame)
MPH_MapOverlayFrame:SetFrameStrata("HIGH")
MPH_MapOverlayFrame:SetFrameLevel(9000)
MPH_MapOverlayFrame:SetAllPoints(true)

-- Check if TomTom is Loaded
local TomTomLoaded
function MapPinEnhanced:PLAYER_ENTERING_WORLD()
    if IsAddOnLoaded("TomTom") then
        TomTomLoaded = true
        self:Print("The usage of /way within MPH is not possible with TomTom enabled.") -- Localize
    else
        TomTomLoaded = false
    end
end

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
        blockWAYPOINTevent = true
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        blockWAYPOINTevent = false
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
        HBDP:AddWorldMapIconMap(MapPinEnhanced, pin, mapID, x, y, 3)
    end
    local function RemoveFromMap()
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
    end

    local function MoveOnMap(x, y, mapID)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
        HBDP:AddWorldMapIconMap(MapPinEnhanced, pin, mapID, x, y, 3)
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
        MoveOnMap = MoveOnMap,
        IsTracked = IsTracked,
        FormatHyperlink = FormatHyperlink,
        x = x,
        y = y,
        mapID = mapID,
    }
end

local function DistanceFromPlayer(pin)
    local PlayerZonePosition = {HBD:GetPlayerZonePosition()}
    return (HBD:GetZoneDistance(PlayerZonePosition[3], PlayerZonePosition[1], PlayerZonePosition[2], pin.mapID, pin.x, pin.y))
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
                table.insert(PinFramePool, pin)
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
        local ReusedPinFrame = table.remove(PinFramePool)
        local pin
        if not ReusedPinFrame then
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
        else
            pin = ReusedPinFrame
            pin.x = x
            pin.y = y
            pin.mapID = mapID
            pin.MoveOnMap(x,y,mapID)
        end
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

    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
        RefreshTracking = RefreshTracking,
        RemoveTrackedPin = RemoveTrackedPin,
    }
end

local pinManager = PinManager()


function MapPinEnhanced:AddWaypoint(x, y, mapID)
    if x and y and mapID then
        if not C_Map.CanSetUserWaypointOnMap(mapID) then
            DEFAULT_CHAT_FRAME:AddMessage('|cFFFFFF00 Arrow to Pin does not work here!|r')
        end
        pinManager.AddPin(x, y, mapID)
    else
        error("x, y or mapID missing")
    end
end

function MapPinEnhanced:SUPER_TRACKING_CHANGED()
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

function MapPinEnhanced:USER_WAYPOINT_UPDATED()
    if blockWAYPOINTevent then return end
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
            blockWAYPOINTevent = true
            C_Map.ClearUserWaypoint()
            blockWAYPOINTevent = false
            MapPinEnhanced:AddWaypoint(userwaypoint.position.x, userwaypoint.position.y, userwaypoint.uiMapID)
        end
end

function MapPinEnhanced:PLAYER_LOGIN()
    C_Map.ClearUserWaypoint()
end


if not TomTomLoaded then
    SLASH_MPH1 = "/way"
end
SLASH_MPH2 = "/pin"
SLASH_MPH3 = "/mph"

local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
local rightseparator =   "%1" .. (tonumber("1.1") and "." or ",") .. "%2"

SlashCmdList["MPH"] = function(msg)
    local slashx
    local slashy
    local slashmapid

    msg = msg:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator, rightseparator)
    local tokens = {}
    for token in msg:gmatch("%S+") do table.insert(tokens, token) end

    if tokens[1] and not tonumber(tokens[1]) then
        local zoneEnd
        for idx = 1, #tokens do
            local token = tokens[idx]
            if tonumber(token) then
                zoneEnd = idx - 1
                break
            end
        end

        if not zoneEnd then
            return
        end

        local zone = table.concat(tokens, " ", 1, zoneEnd)
        local x,y,_ = select(zoneEnd + 1, unpack(tokens))

        slashx, slashy = tonumber(x) / 100, tonumber(y) / 100
        slashmapid = mapDataID[zone]

        --if desc then desc = table.concat(tokens, " ", zoneEnd + 3) end

        if slashx and slashy and slashmapid then
            MapPinEnhanced:AddWaypoint(slashx, slashy, slashmapid)
        end
    elseif tokens[1] and tonumber(tokens[1]) then
        slashmapid = C_Map.GetBestMapForUnit("player")
        slashx, slashy = unpack(tokens)
        if slashx and slashy and slashmapid then
            slashx, slashy = tonumber(slashx) / 100, tonumber(slashy) / 100
            if slashx and slashy and slashmapid then
                MapPinEnhanced:AddWaypoint(slashx, slashy, slashmapid)
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage('|cFFFFFF00Please use the formatting "/way x y" or /way zonename x y|r')
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage('|cFFFFFF00Please use the formatting "/way x y" or /way zonename x y|r')
    end
end
