local _G = _G
local MapPinEnhanced = LibStub("AceAddon-3.0"):NewAddon("MapPinEnhanced", "AceConsole-3.0", "AceEvent-3.0",
    "AceTimer-3.0")


local HBD = LibStub("HereBeDragons-2.0")
local HBDP = LibStub("HereBeDragons-Pins-2.0")
local LDBIcon = LibStub("LibDBIcon-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("MapPinEnhanced")


-- TODO: Rebuild node data
-- TODO: finish navigation (add minipin system for navigation and lines on map, add buttons to press for spells and items [check cooldown])
-- TODO: make it possible to set pin on map even if navigation is not possible: mapCanvas:AddGlobalPinMouseActionHandler
-- TODO: Add Option window (change total scale, pin range alpha (SuperTrackedFrameMixin:SetTargetAlphaForState(0, 1) to change alpha of pins when supertracked))
-- TODO: Add Pinmanager (save presets, delete presets, overwrite presets, quick access in pintracker)
-- TODO: Use
-- FIXME: 1x MapPinEnhanced\core.lua:896: bad argument #2 to 'format' (string expected, got nil)





local strmatch = _G.string.match
local tinsert = _G.table.insert
local wipe = _G.table.wipe
local tremove = _G.table.remove

local pairs = _G.pairs
local ipairs = _G.ipairs
local select = _G.select
local tonumber = _G.tonumber
local tostring = _G.tostring
local unpack = _G.unpack
local Round = _G.Round
local IsControlKeyDown = _G.IsControlKeyDown
local IsShiftKeyDown = _G.IsShiftKeyDown

local OBJECTIVE_TRACKER_COLOR = _G.OBJECTIVE_TRACKER_COLOR
local MAP_PIN_HYPERLINK = _G.MAP_PIN_HYPERLINK

local C_Map, C_SuperTrack, C_QuestLog, C_Navigation = _G.C_Map, _G.C_SuperTrack, _G.C_QuestLog, _G.C_Navigation
local Enum = _G.Enum
local UiMapPoint = _G.UiMapPoint

local mapDataIdReverse = {}
local HBDmapData = HBD.mapData


local overrides = {
    [101] = {
        mapType = Enum.UIMapType.World
    }, -- Outland
    [125] = {
        mapType = Enum.UIMapType.Zone
    }, -- Dalaran
    [126] = {
        mapType = Enum.UIMapType.Micro
    },
    [195] = {
        suffix = "1"
    }, -- Kaja'mine
    [196] = {
        suffix = "2"
    }, -- Kaja'mine
    [197] = {
        suffix = "3"
    }, -- Kaja'mine
    [501] = {
        mapType = Enum.UIMapType.Zone
    }, -- Dalaran
    [502] = {
        mapType = Enum.UIMapType.Micro
    },
    [572] = {
        mapType = Enum.UIMapType.World
    }, -- Draenor
    [579] = {
        suffix = "1"
    }, -- Lunarfall Excavation
    [580] = {
        suffix = "2"
    }, -- Lunarfall Excavation
    [581] = {
        suffix = "3"
    }, -- Lunarfall Excavation
    [582] = {
        mapType = Enum.UIMapType.Zone
    }, -- Lunarfall
    [585] = {
        suffix = "1"
    }, -- Frostwall Mine
    [586] = {
        suffix = "2"
    }, -- Frostwall Mine
    [587] = {
        suffix = "3"
    }, -- Frostwall Mine
    [590] = {
        mapType = Enum.UIMapType.Zone
    }, -- Frostwall
    [625] = {
        mapType = Enum.UIMapType.Orphan
    }, -- Dalaran
    [626] = {
        mapType = Enum.UIMapType.Micro
    }, -- Dalaran
    [627] = {
        mapType = Enum.UIMapType.Zone
    },
    [628] = {
        mapType = Enum.UIMapType.Micro
    },
    [629] = {
        mapType = Enum.UIMapType.Micro
    },
    [943] = {
        suffix = FACTION_HORDE
    }, -- Arathi Highlands
    [1044] = {
        suffix = FACTION_ALLIANCE
    }
}

MapPinEnhanced.CZWFromMapID = {}
function MapPinEnhanced:GetCZWFromMapID(m)
    local zone, continent, world, map
    local mapInfo = nil

    if not m then
        return nil, nil, nil;
    end

    -- Return the cached CZW
    if MapPinEnhanced.CZWFromMapID[m] then
        return unpack(MapPinEnhanced.CZWFromMapID[m])
    end

    map = m -- Save the original map
    repeat
        mapInfo = C_Map.GetMapInfo(m)
        if not mapInfo then
            -- No more parents, return what we have
            MapPinEnhanced.CZWFromMapID[map] = { continent, zone, world }
            return continent, zone, world
        end
        local mapType = (overrides[m] and overrides[m].mapType) or mapInfo.mapType
        if mapType == Enum.UIMapType.Zone then
            -- Its a zone map
            zone = m
        elseif mapType == Enum.UIMapType.Continent then
            continent = m
        elseif (mapType == Enum.UIMapType.World) or (mapType == Enum.UIMapType.Cosmic) then
            world = m
            continent = continent or m -- Hack for one continent worlds
        end
        m = mapInfo.parentMapID
    until (m == 0)
    MapPinEnhanced.CZWFromMapID[map] = { continent, zone, world }
    return continent, zone, world
end

MapPinEnhanced.mapDataID = {}
local mapDataID = MapPinEnhanced.mapDataID

-- Minimap Button and Minimap Button
MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject("MapPinEnhanced", {
    type = "data source",
    text = "MapPinEnhanced",
    icon = "Interface\\MINIMAP\\Minimap-Waypoint-MapPin-Tracked",
    OnClick = function(_, button)
        if button == "LeftButton" then
            MapPinEnhanced:TogglePinTrackerWindow()
        elseif button == "RightButton" then
            MapPinEnhanced:ToggleImportWindow()
        end
    end,
    OnTooltipShow = function(tt)
        tt:AddLine(L["Left-Click LDB"])
        tt:AddLine(L["Right-Click LDB"])
    end
})


local defaults = {
    profile = {
        minimap = {
            hide = false
        },
        savedPins = {},
        pinTracker = {
            x = 0,
            y = 0,
            width = 300,
            height = 500,
        },
        options = {
            changedalpha = true
        }
    }
}

--WaypointLocationPinMixin

MapPinEntryMixin = {};



function MapPinEnhancedFrame_OnLoad(self)
    self.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetDesaturated(true)
    self.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAtlas("NPE_ArrowDown")
    self.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAtlas("NPE_ArrowDownGlow")
    self.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAtlas("NPE_ArrowDown")
    self.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAtlas("NPE_ArrowDown")
    self.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAtlas("NPE_ArrowUp")
    self.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetDesaturated(true)
    self.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAtlas("NPE_ArrowUpGlow")
    self.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAtlas("NPE_ArrowUp")
    self.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAtlas("NPE_ArrowUp")
    self.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAlpha(0.6)
    self.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.scrollFrame.ScrollBar.ThumbTexture:SetAlpha(0.6)
    self.scrollFrame.ScrollBar:Hide()
end

function MapPinEnhancedFrame_OnDragStart(self)
    if IsControlKeyDown() then
        self:StartMoving()
    end
end

function MapPinEnhancedFrame_OnDragStop(self)
    self:StopMovingOrSizing()
    local x, y = self:GetLeft(), self:GetTop()
    MapPinEnhanced.db.profile.pinTracker.x = x
    MapPinEnhanced.db.profile.pinTracker.y = y
end

function MapPinEnhanced:TogglePinTrackerWindow()
    if MapPinEnhancedFrame:IsShown() then
        MapPinEnhancedFrame:Hide()
    else
        MapPinEnhancedFrame:Show()
    end
end

function MapPinEnhanced:ToggleNavigationStepFrame()
    if MapPinEnhancedNavigationStepFrame:IsShown() then
        MapPinEnhancedNavigationStepFrame:Hide()
    else
        MapPinEnhancedNavigationStepFrame:Show()
    end
end

function MapPinEnhanced:OnInitialize()
    -- Saved Vars
    self.db = LibStub("AceDB-3.0"):New("MapPinEnhancedDB", defaults, true)

    -- Minimap Icon
    LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker, self.db.profile.minimap)
    MapPinEnhanced:UpdateMinimapButton()

    local navigationStepFrame = CreateFrame("Frame", "MapPinEnhancedNavigationStepFrame", MapPinEnhancedFrame)
    navigationStepFrame:SetSize(250, 200)
    navigationStepFrame:SetPoint("BOTTOMLEFT", MapPinEnhancedFrame, "TOPLEFT", 0, 20)
    navigationStepFrame.texture = navigationStepFrame:CreateTexture(nil, "BACKGROUND")
    navigationStepFrame.texture:SetAllPoints()
    navigationStepFrame.texture:SetAtlas("dragonflight-score-background")
    navigationStepFrame.texture:SetAlpha(0.5)

    navigationStepFrame.upperTexture = navigationStepFrame:CreateTexture(nil, "ARTWORK")
    navigationStepFrame.upperTexture:SetSize(250, 41)
    navigationStepFrame.upperTexture:SetAtlas("dragonflight-score-topper")
    navigationStepFrame.upperTexture:SetPoint("CENTER", navigationStepFrame, "TOP", 0, 0)

    navigationStepFrame.lowerTexture = navigationStepFrame:CreateTexture(nil, "ARTWORK")
    navigationStepFrame.lowerTexture:SetSize(250, 41)
    navigationStepFrame.lowerTexture:SetAtlas("dragonflight-score-footer")
    navigationStepFrame.lowerTexture:SetPoint("CENTER", navigationStepFrame, "BOTTOM", 0, 0)

    navigationStepFrame.text = navigationStepFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    navigationStepFrame.text:SetPoint("TOP", navigationStepFrame, "TOP", 0, -5)
    navigationStepFrame.text:SetText("Navigation")
    navigationStepFrame.text:SetFontObject("GameFontNormal")


    local spinnerTexture = navigationStepFrame:CreateTexture(nil, "OVERLAY")
    spinnerTexture:SetSize(100, 100)
    spinnerTexture:SetPoint("CENTER", navigationStepFrame, "CENTER", 0, 0)
    spinnerTexture:SetAtlas("auctionhouse-ui-loadingspinner")

    local spinnerGroup = spinnerTexture:CreateAnimationGroup()
    spinnerGroup:SetLooping("REPEAT")
    local spinner = spinnerGroup:CreateAnimation("Rotation")
    spinner:SetDuration(1)
    spinner:SetDegrees(360)
    spinner:SetOrder(1)
    spinner:SetOrigin("CENTER", 0, 0)
    spinner:SetSmoothing("NONE")

    spinnerGroup:Play()

    navigationStepFrame.close = CreateFrame("Button", nil, navigationStepFrame)
    navigationStepFrame.close:SetSize(15, 15)
    navigationStepFrame.close:SetNormalAtlas("UI-HUD-Minimap-Zoom-In")
    navigationStepFrame.close:SetHighlightAtlas("UI-HUD-Minimap-Zoom-In-Mouseover")
    navigationStepFrame.close:SetPushedAtlas("UI-HUD-Minimap-Zoom-In-Down")
    -- rotate the close button
    navigationStepFrame.close:GetNormalTexture():SetRotation(math.rad(45))
    navigationStepFrame.close:GetHighlightTexture():SetRotation(math.rad(45))
    navigationStepFrame.close:GetPushedTexture():SetRotation(math.rad(45))


    navigationStepFrame.close:SetPoint("TOPRIGHT", navigationStepFrame, "TOPRIGHT", -15, 0)
    navigationStepFrame.close:SetScript("OnClick", function()
        navigationStepFrame:Hide()
        spinnerGroup:Stop()
    end)

    navigationStepFrame:Hide()
    navigationStepFrame.spinnerTexture = spinnerTexture
    navigationStepFrame.spinner = spinnerGroup
    self.NavigationStepFrame = navigationStepFrame


    -- Structure mapdata like TomTom, Snippet from TomTom Addon
    for id in pairs(HBDmapData) do
        local c, z, w = MapPinEnhanced:GetCZWFromMapID(id)
        local mapType = (overrides[id] and overrides[id].mapType) or HBDmapData[id].mapType
        if (mapType == Enum.UIMapType.Zone) or (mapType == Enum.UIMapType.Continent) or
            (mapType == Enum.UIMapType.Micro) then
            local name = HBDmapData[id].name
            if (overrides[id] and overrides[id].suffix) then
                name = name .. " " .. overrides[id].suffix
            end
            if w then
                if name and mapDataID[name] then
                    if type(mapDataID[name]) ~= "table" then
                        -- convert to table
                        mapDataID[name] = { mapDataID[name] }
                    end
                    table.insert(mapDataID[name], id)
                else
                    mapDataID[name] = id
                end
            end

            mapDataID["#" .. id] = id
        end
    end

    local newEntries = {}
    for name, mapID in pairs(mapDataID) do
        if type(mapID) == "table" then
            mapDataID[name] = nil
            for idx, mapId in pairs(mapID) do
                local parent = HBDmapData[mapId].parent
                local parentName = (parent and (parent > 0) and HBDmapData[parent].name)
                if parentName then
                    -- We rely on the implicit acending order of mapID's so the lowest one wins
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
    for entry, mapID in pairs(mapDataID) do
        mapDataIdReverse[mapID] = entry
    end
    wipe(newEntries)
    collectgarbage("collect")
end

function MapPinEnhanced:UpdateMinimapButton()
    if (self.db.profile.minimap.hide) then
        LDBIcon:Hide("MapPinEnhanced")
    else
        LDBIcon:Show("MapPinEnhanced")
    end
end

function MapPinEnhanced:ToggleMinimapButton()
    if (self.db.profile.minimap.hide) then
        self.db.profile.minimap.hide = false
    else
        self.db.profile.minimap.hide = true
    end
    MapPinEnhanced:UpdateMinimapButton()
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

local function CreatePin(x, y, mapID, emit, title)

    local objective = CreateFrame("Button", nil, MapPinEnhancedFrame.scrollFrame.scrollChild,
        "MapPinEnhancedPinTrackerTemplate")

    local pin = CreateFrame("Button", nil)
    pin:SetSize(30, 30)
    pin:EnableMouse(true)
    pin:SetMouseClickEnabled()


    local tracked = false

    local minimappin = CreateFrame("Button", nil)
    minimappin:SetSize(22, 22)
    minimappin.icon = minimappin:CreateTexture(nil, "BORDER")
    minimappin.icon:SetAtlas("Waypoint-MapPin-Untracked", true)
    minimappin.icon:SetSize(22, 22)
    minimappin.icon:SetBlendMode("BLEND")
    minimappin.icon:SetAllPoints(minimappin)

    local function Track(x, y, mapID)
        tracked = true
        pin.icon:SetAtlas("Waypoint-MapPin-Tracked", true)
        objective.button.normal:SetAtlas("Waypoint-MapPin-Tracked")
        minimappin.icon:SetAtlas("Waypoint-MapPin-Tracked")
        objective.name:SetAlpha(1)
        objective.info:SetAlpha(1)
        blockWAYPOINTevent = true
        if C_Map.CanSetUserWaypointOnMap(mapID) then
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y, 0))
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            if not MapPinEnhanced.distanceTimer then
                MapPinEnhanced.distanceTimer = MapPinEnhanced:ScheduleRepeatingTimer("DistanceTimer", 0.1)
            elseif MapPinEnhanced.distanceTimer.cancelled then
                MapPinEnhanced.distanceTimer = MapPinEnhanced:ScheduleRepeatingTimer("DistanceTimer", 0.1)
            end
        end
        blockWAYPOINTevent = false
    end

    local function Untrack()
        tracked = false
        pin.icon:SetAtlas("Waypoint-MapPin-Untracked", true)
        objective.button.normal:SetAtlas("Waypoint-MapPin-Untracked")
        minimappin.icon:SetAtlas("Waypoint-MapPin-Untracked")
        objective.name:SetAlpha(0.7)
        objective.info:SetAlpha(0.7)
        C_SuperTrack.SetSuperTrackedUserWaypoint(false)
    end

    local function ToggleTracked()
        if tracked then
            Untrack()
        else
            emit("track")
        end
    end

    local function ShowOnMap()
        objective:Show()
        HBDP:AddWorldMapIconMap(MapPinEnhanced, pin, mapID, x, y, 3)
        HBDP:AddMinimapIconMap(MapPinEnhanced, minimappin, mapID, x, y, false, false)
    end

    local function RemoveFromMap()
        objective:Hide()
        objective:ClearAllPoints()
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimappin)
    end

    local function MoveOnMap(x, y, mapID)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimappin)
        HBDP:AddWorldMapIconMap(MapPinEnhanced, pin, mapID, x, y, 3)
        HBDP:AddMinimapIconMap(MapPinEnhanced, minimappin, mapID, x, y, false, false)
    end

    local function IsTracked()
        return tracked
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
                emit("hyperlink")
            else
                ToggleTracked()
            end
        end
        self:SetPoint("CENTER", 2, -2)
    end)
    pin:SetScript("OnMouseUp", function(self)
        self:SetPoint("CENTER", 0, 0)
    end)
    local function SetTooltip(title)
        pin:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4)
            GameTooltip_SetTitle(GameTooltip, title)
            GameTooltip_AddNormalLine(GameTooltip, MAP_PIN_SHARING_TOOLTIP)
            GameTooltip_AddColoredLine(GameTooltip, MAP_PIN_REMOVE, GREEN_FONT_COLOR)
            GameTooltip:Show()
        end)
    end

    SetTooltip(title)

    pin:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    local highlightTexture = pin:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetAllPoints(true)
    highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)

    objective:SetScript("OnMouseDown", function(self, arg1)
        if arg1 == "LeftButton" then
            if IsControlKeyDown() then
                emit("remove")
            elseif IsShiftKeyDown() then
                emit("hyperlink")
            else
                ToggleTracked()
            end
        elseif arg1 == "RightButton" then
            emit("remove")
        end
    end)


    objective.navStart:SetScript("OnClick", function(self)
        emit("track")
        MapPinEnhanced:navigateToPin(x, y, mapID)
        print("navigateToPin")
    end)



    objective:SetScript("OnEnter", function(self)
        objective.highlightBorder:Show()
        objective.name:SetAlpha(1)
        objective.info:SetAlpha(1)
        objective.navStart:Show()
        objective.button.highlight:Show()

        if (tracked) then
            objective.highlightBorder:SetAlpha(1)
        else
            objective.highlightBorder:SetAlpha(0.4)
        end

    end)

    objective:SetScript("OnLeave", function(self)
        if not self.navStart:IsMouseOver() then
            objective.navStart:Hide()
            objective.highlightBorder:Hide()
            objective.button.highlight:Hide()
            if (not tracked) then
                objective.name:SetAlpha(0.7)
                objective.info:SetAlpha(0.7)
            end
        end
    end)

    local function SetTrackerPosition(index)
        objective:ClearAllPoints()
        objective:SetPoint("TOPLEFT", MapPinEnhancedFrame.scrollFrame.scrollChild, "TOPLEFT", 5,
            -((index - 1) * (objective:GetHeight())))
        if not objective:IsShown() then
            objective:Show()
        end
    end

    local function SetObjectiveTitle(title)
        objective.name:SetText(title)
        objective.name:Show()
    end

    SetObjectiveTitle(title)

    local function SetObjectiveText(x, y, mapID)
        objective.info:SetText(HBDmapData[mapID]["name"] .. " (" .. Round(x * 100) .. ", " .. Round(y * 100) .. ")")
        objective.info:Show()
    end

    SetObjectiveText(x, y, mapID)


    return {
        Untrack = Untrack,
        Track = Track,
        ToggleTracked = ToggleTracked,
        ShowOnMap = ShowOnMap,
        RemoveFromMap = RemoveFromMap,
        MoveOnMap = MoveOnMap,
        IsTracked = IsTracked,
        SetTooltip = SetTooltip,
        SetTrackerPosition = SetTrackerPosition,
        SetObjectiveTitle = SetObjectiveTitle,
        SetObjectiveText = SetObjectiveText,
        x = x,
        y = y,
        mapID = mapID,
        title = title
    }
end

local function DistanceFromPlayer(pin)
    local PlayerZonePosition = { HBD:GetPlayerZonePosition() }
    return (
        HBD:GetZoneDistance(PlayerZonePosition[3], PlayerZonePosition[1], PlayerZonePosition[2], pin.mapID, pin.x,
            pin.y))
end

local function IsCloser(pin, ref)
    if ref and DistanceFromPlayer(pin) and DistanceFromPlayer(ref) then
        return DistanceFromPlayer(pin) < DistanceFromPlayer(ref)
    else
        return true
    end
end

local function FormatHyperlink(x, y, mapID)
    if x and y and mapID then
        return ("|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(mapID, x * 10000, y * 10000, MAP_PIN_HYPERLINK)
    end
end

local function PinManager()
    local pins = {}
    local function UpdateTrackerPositions()
        for i, p in ipairs(pins) do
            p.SetTrackerPosition(i)
        end

        if MapPinEnhancedFrame:IsShown() and #pins == 0 then
            MapPinEnhanced:TogglePinTrackerWindow()
        elseif not MapPinEnhancedFrame:IsShown() and #pins > 0 then
            MapPinEnhanced:TogglePinTrackerWindow()
        end
        if (#pins < 7) then
            MapPinEnhancedFrame.scrollFrame.ScrollBar:Hide()
        else
            MapPinEnhancedFrame.scrollFrame.ScrollBar:Show()
        end

        -- TODO: add function to scroll to tracked pin
    end

    local function SupertrackClosest()
        if not C_SuperTrack.IsSuperTrackingQuest() then
            local pin = nil
            for _, p in ipairs(pins) do
                p.Untrack()
                if IsCloser(p, pin) then
                    pin = p
                end
            end
            if pin then
                pin.Track(pin.x, pin.y, pin.mapID)
            end
        end
    end

    local function RemovePin(pin)
        pin.RemoveFromMap()
        for i, p in ipairs(pins) do
            if p == pin then
                pins[i] = pins[#pins]
                pins[#pins] = nil
                C_Map.ClearUserWaypoint()
                SupertrackClosest()
                tinsert(PinFramePool, pin)
                UpdateTrackerPositions()
                return
            end
        end
    end

    local function UntrackPins()
        for _, p in ipairs(pins) do
            if p.IsTracked() then
                p.Untrack()
                return
            end
        end
    end

    local function AddPin(x, y, mapID, name)
        for _, p in ipairs(pins) do
            if math.abs(x - p.x) < 0.01 and math.abs(y - p.y) < 0.01 and mapID == p.mapID then
                UntrackPins()
                p.Track(x, y, mapID)
                return
            end
        end

        local title
        if not name or name == "" then
            title = "Map Pin"
        else
            title = name
        end

        local ReusedPinFrame = tremove(PinFramePool)
        local pin
        if not ReusedPinFrame then
            pin = CreatePin(x, y, mapID, function(e)
                if e == "remove" then
                    RemovePin(pin)
                    SupertrackClosest()
                elseif e == "track" then
                    UntrackPins()
                    MapPinEnhanced.NavigationStepFrame:Hide()
                    pin.Track(pin.x, pin.y, pin.mapID)
                elseif e == "hyperlink" then
                    local link = FormatHyperlink(pin.x, pin.y, pin.mapID)
                    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
                    ChatEdit_InsertLink(link)
                end
            end, title)
            pin.ShowOnMap()
        else
            pin = ReusedPinFrame
            pin.x = x
            pin.y = y
            pin.mapID = mapID
            pin.SetTooltip(title)
            pin.MoveOnMap(x, y, mapID)
            pin.SetObjectiveTitle(title)
            pin.SetObjectiveText(x, y, mapID)
        end
        pins[#pins + 1] = pin
        UntrackPins()
        pin.Track(x, y, mapID)
        UpdateTrackerPositions()
        MapPinEnhanced.db.profile.savedpins = pins
    end

    local function RestorePin()
        for _, p in ipairs(pins) do
            if p.SupertrackClosest() then
                break
            end
        end
    end

    local function RefreshTracking()
        for _, p in ipairs(pins) do
            if p.IsTracked() then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        end
    end

    local function RemoveTrackedPin()
        for _, p in ipairs(pins) do
            if p.IsTracked() then
                RemovePin(p)
                return
            end
        end
    end

    local function RestoreAllPins()
        if (not MapPinEnhanced.db.profile.savedpins) then
            return
        end
        for _, p in ipairs(MapPinEnhanced.db.profile.savedpins) do
            AddPin(p.x, p.y, p.mapID, p.title)
        end
    end

    local function RemoveAllPins()
        for i, pin in ipairs(pins) do
            pin.RemoveFromMap()
            tinsert(PinFramePool, pin)
            pins[i] = nil
        end
        C_Map.ClearUserWaypoint()
    end

    local function GetAllPinData()
        local t = {}
        for i, pin in ipairs(pins) do
            tinsert(t, { pin.x, pin.y, pin.mapID })
        end
        return t
    end

    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
        RefreshTracking = RefreshTracking,
        RemoveTrackedPin = RemoveTrackedPin,
        RestoreAllPins = RestoreAllPins,
        RemoveAllPins = RemoveAllPins,
        GetAllPinData = GetAllPinData
    }
end

local pinManager = PinManager()

function MapPinEnhanced:AddWaypoint(x, y, mapID, name)
    if x and y and mapID then
        if not C_Map.CanSetUserWaypointOnMap(mapID) then
            MapPinEnhanced:Print(L["Arrow error"])
        end
        pinManager.AddPin(x, y, mapID, name)
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
    if blockWAYPOINTevent then
        return
    end
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

local TomTomLoaded
function MapPinEnhanced:PLAYER_ENTERING_WORLD()
    pinManager.RestoreAllPins()

    -- Check if TomTom is Loaded
    if IsAddOnLoaded("TomTom") then
        TomTomLoaded = true
        self:Print(L["TomTom enabled"]) -- Localize
    else
        TomTomLoaded = false
    end
end

local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
local rightseparator = "%1" .. (tonumber("1.1") and "." or ",") .. "%2"
local function lowergsub(s)
    return s:lower():gsub("[%s]", "")
end

function MapPinEnhanced:ParseInput(msg)
    if not msg then
        return
    end
    local slashx
    local slashy
    local slashmapid
    local slashtitle
    msg = msg:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator, rightseparator)
    local tokens = {}
    for token in msg:gmatch("%S+") do
        table.insert(tokens, token)
    end

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
        local x, y, _ = select(zoneEnd + 1, unpack(tokens))

        slashx, slashy = tonumber(x) / 100, tonumber(y) / 100
        slashmapid = mapDataID[zone]

        slashtitle = table.concat(tokens, " ", zoneEnd + 3)
        if slashx and slashy and slashmapid then
            MapPinEnhanced:AddWaypoint(slashx, slashy, slashmapid, slashtitle)
        end
    elseif tokens[1] and tonumber(tokens[1]) then
        slashmapid = HBD:GetPlayerZone()
        slashx, slashy = unpack(tokens)
        if slashx and slashy and slashmapid then
            slashx, slashy = tonumber(slashx) / 100, tonumber(slashy) / 100
            slashtitle = table.concat(tokens, " ", 3)
            if slashx and slashy and slashmapid then
                MapPinEnhanced:AddWaypoint(slashx, slashy, slashmapid, slashtitle)
            end
        else
            if not TomTomLoaded then
                MapPinEnhanced:Print(L["Formating error"])
            else
                MapPinEnhanced:Print(L["TomTom is enabled"])
            end
        end
    else
        if not TomTomLoaded then
            MapPinEnhanced:Print(L["Formating error"])
        else
            MapPinEnhanced:Print(L["TomTom is enabled"])
        end
    end
end

function MapPinEnhanced:ParseExport()
    local pinData = pinManager.GetAllPinData()
    local output = ""
    for _, pin in ipairs(pinData) do
        local slashcmd = string.format("/way %s %.2f %.2f", mapDataIdReverse[pin[3]], pin[1] * 100, pin[2] * 100)
        output = output .. slashcmd .. "\n"
    end
    return output
end

if not TomTomLoaded then
    SLASH_MPH1 = "/way"
end
SLASH_MPH2 = "/pin"
SLASH_MPH3 = "/mph"

SlashCmdList["MPH"] = function(msg)
    if strmatch(msg, "removeall") then
        pinManager.RemoveAllPins()
        return
    end
    if strmatch(msg, "pintracker") then
        MapPinEnhanced:TogglePinTrackerWindow()
        return
    end
    if strmatch(msg, "import") then
        MapPinEnhanced:ToggleImportWindow()
        return
    end
    if strmatch(msg, "minimap") then
        MapPinEnhanced:ToggleMinimapButton()
        return
    end
    MapPinEnhanced:ParseInput(msg)
end

---- Hooks ------

function MapPinEnhanced:DistanceTimer()
    local distance = C_Navigation.GetDistance()
    if distance > 0 then
        if distance <= 7 then
            pinManager.RemoveTrackedPin()
        end
        -- distance based throttle
        self.distanceTimer.delay = (0.1 * distance ^ (0.5))
    end
    if distance == 0 then
        self:CancelAllTimers()
    end
end

hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self)
    self:SetAlpha(0)
    self:EnableMouse(false)
end)
