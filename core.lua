local _G = _G
local MapPinEnhanced = LibStub("AceAddon-3.0"):NewAddon("MapPinEnhanced",
                                                        "AceConsole-3.0",
                                                        "AceEvent-3.0")

local HBD = LibStub("HereBeDragons-2.0")
local HBDP = LibStub("HereBeDragons-Pins-2.0")
local LDBIcon = LibStub("LibDBIcon-1.0")

_G.MPH = MapPinEnhanced

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

local C_Map, C_SuperTrack, C_QuestLog = _G.C_Map, _G.C_SuperTrack, _G.C_QuestLog
local Enum = _G.Enum
local UiMapPoint = _G.UiMapPoint

local mapDataID = {}
local HBDmapData = HBD.mapData -- Data is localized

-- Broker
MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject(
                           "MapPinEnhanced", {
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
            tt:AddLine("MapPinEnhanced")
            tt:AddLine(" ")
            tt:AddLine("Left-Click to open Pin Tracker")
            tt:AddLine("Right-Click to open Import Frame")
        end
    })

local defaults = {
    profile = {
        minimap = {hide = false},
        savedpins = {},
        pintrackerpositon = {x = 0, y = 0}
    }
}

function MapPinEnhanced:OnInitialize()

    -- Saved Vars
    self.db = LibStub("AceDB-3.0"):New("MapPinEnhancedDB", defaults, true)

    -- Minimap Icon
    LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker,
                     self.db.profile.minimap)
    MapPinEnhanced:UpdateMinimapButton()

    -- Objective Tracker Frame
    local MPH_Frame = CreateFrame("Frame", nil, UIParent)
    MPH_Frame:SetFrameStrata("BACKGROUND")
    MPH_Frame:SetWidth(235)
    MPH_Frame:SetHeight(500)
    local x = MapPinEnhanced.db.profile.pintrackerpositon.x
    local y = MapPinEnhanced.db.profile.pintrackerpositon.y - 500
    MPH_Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
    MPH_Frame:SetClampedToScreen(true)
    MPH_Frame:Hide()
    self.TrackerFrame = MPH_Frame

    local tex = MPH_Frame:CreateTexture("ARTWORK")
    tex:SetAllPoints()
    tex:SetColorTexture(0, 0, 0, 0.5)
    MPH_Frame.movetexture = tex
    MPH_Frame.movetexture:Hide()

    local MPH_ObjectiveTrackerHeader = CreateFrame("frame",
                                                   "MPH_ObjectiveTrackerHeader",
                                                   MPH_Frame,
                                                   "ObjectiveTrackerHeaderTemplate")
    MPH_ObjectiveTrackerHeader.Text:SetText("Map Pins")

    local minimizeButton = CreateFrame("button",
                                       "MPH_QuestsHeaderMinimizeButton",
                                       MPH_Frame, "BackdropTemplate")
    local minimizeButtonText = minimizeButton:CreateFontString(nil, "overlay",
                                                               "GameFontNormal")
    minimizeButtonText:SetText("Map Pins")
    minimizeButtonText:SetPoint("right", minimizeButton, "left", -3, 1)
    minimizeButtonText:Hide()
    MPH_ObjectiveTrackerHeader.MinimizeButton:Hide()
    minimizeButton:SetSize(25, 25)
    minimizeButton:SetPoint("topright", MPH_ObjectiveTrackerHeader, "topright",
                            0, 0)
    minimizeButton:SetScript("OnClick", function() MPH_Frame:Hide() end)
    minimizeButton:SetNormalTexture(
        [[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
    minimizeButton:SetPushedTexture(
        [[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
    minimizeButton:SetHighlightTexture(
        [[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
    minimizeButton:SetFrameStrata("LOW")

    local MoverButton = CreateFrame("button", "MPH_QuestsHeaderMoverButton",
                                    MPH_Frame, "BackdropTemplate")
    local MoverButtonText = MoverButton:CreateFontString(nil, "overlay",
                                                         "GameFontNormal")
    MoverButtonText:SetText("Map Pins")
    MoverButtonText:SetPoint("right", MoverButton, "left", 0, 1)
    MoverButtonText:Hide()

    MoverButton:SetSize(25, 25)
    MoverButton:SetPoint("right", minimizeButton, "left", 0, 0)
    MoverButton:SetScript("OnClick", function()
        if MPH_Frame.movetexture:IsShown() then
            x, y = MPH_Frame:GetLeft(), MPH_Frame:GetTop()
            MPH_Frame:ClearAllPoints()
            MPH_Frame:SetMovable(false)
            MPH_Frame:EnableMouse(false)
            if MapPinEnhanced.db.profile.pintrackerpositon.x ~= x then
                MapPinEnhanced.db.profile.pintrackerpositon.x = x
            end
            if MapPinEnhanced.db.profile.pintrackerpositon.y ~= y then
                MapPinEnhanced.db.profile.pintrackerpositon.y = y
            end
            x = MapPinEnhanced.db.profile.pintrackerpositon.x
            y = MapPinEnhanced.db.profile.pintrackerpositon.y - 500
            MPH_Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
            MPH_Frame.movetexture:Hide()
        else
            MPH_Frame:SetMovable(true)
            MPH_Frame:EnableMouse(true)
            MPH_Frame:RegisterForDrag("LeftButton")
            MPH_Frame:SetScript("OnDragStart", MPH_Frame.StartMoving)
            MPH_Frame:SetScript("OnDragStop", MPH_Frame.StopMovingOrSizing)
            MPH_Frame.movetexture:Show()
        end
    end)
    MoverButton:SetNormalTexture([[Interface\Buttons\UI-Panel-SmallerButton-Up]])
    MoverButton:SetPushedTexture(
        [[Interface\Buttons\UI-Panel-SmallerButton-Down]])
    MoverButton:SetHighlightTexture(
        [[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
    MoverButton:SetFrameStrata("LOW")

    MPH_ObjectiveTrackerHeader:ClearAllPoints()
    MPH_ObjectiveTrackerHeader:SetPoint("bottom", MPH_Frame, "top", 0, -20)
    MPH_ObjectiveTrackerHeader:Show()

    function self:TogglePinTrackerWindow()
        if MPH_Frame:IsShown() then
            MPH_Frame:Hide()
        else
            MPH_Frame:Show()
        end
    end

    -- Restructure Map Data
    for mapID in pairs(HBDmapData) do
        local mapType = HBDmapData[mapID].mapType
        if mapType == Enum.UIMapType.Zone or mapType == Enum.UIMapType.Continent or
            mapType == Enum.UIMapType.Micro then
            local name = HBDmapData[mapID].name
            if name and mapDataID[name] then
                if type(mapDataID[name]) ~= "table" then
                    mapDataID[name] = {mapDataID[name]}
                end
                tinsert(mapDataID[name], mapID)
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
                local parentName = (parent and (parent > 0) and
                                       HBDmapData[parent].name)
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
    for name, mapID in pairs(newEntries) do mapDataID[name] = mapID end
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
    local titleColor = OBJECTIVE_TRACKER_COLOR["Header"]
    local titleColorH = OBJECTIVE_TRACKER_COLOR["HeaderHighlight"]
    local textColor = OBJECTIVE_TRACKER_COLOR["Normal"]
    local textColorH = OBJECTIVE_TRACKER_COLOR["NormalHighlight"]

    local pin = CreateFrame("Button", nil)
    pin:SetSize(30, 30)
    pin:EnableMouse(true)
    pin:SetMouseClickEnabled(true)

    local objective = CreateFrame("Button", nil, MapPinEnhanced.TrackerFrame,
                                  "BackdropTemplate")
    objective:SetSize(235, 25)
    objective:EnableMouse(true)
    objective:SetMouseClickEnabled(true)
    objective.Icon = objective:CreateTexture(nil, "OVERLAY")

    local tracked = false

    local function Track(x, y, mapID)
        tracked = true
        pin.icon:SetAtlas("Waypoint-MapPin-Tracked", true)
        objective.Icon:SetAtlas("Waypoint-MapPin-Tracked")
        blockWAYPOINTevent = true
        if C_Map.CanSetUserWaypointOnMap(mapID) then
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y,
                                                                   0))
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        end
        blockWAYPOINTevent = false
    end
    local function Untrack()
        tracked = false
        pin.icon:SetAtlas("Waypoint-MapPin-Untracked", true)
        objective.Icon:SetAtlas("Waypoint-MapPin-Untracked")
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
    end
    local function RemoveFromMap()
        objective:Hide()
        objective:ClearAllPoints()
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
    end
    local function MoveOnMap(x, y, mapID)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, pin)
        HBDP:AddWorldMapIconMap(MapPinEnhanced, pin, mapID, x, y, 3)
    end
    local function IsTracked()
        return tracked
    end
    local function FormatHyperlink()
        return ("|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(mapID,
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
        end
        self:SetPoint("CENTER", 2, -2)
    end)
    pin:SetScript("OnMouseUp", function(self) self:SetPoint("CENTER", 0, 0) end)
    local function SetTooltip(title)
        pin:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4)
            GameTooltip_SetTitle(GameTooltip, title)
            GameTooltip_AddNormalLine(GameTooltip, MAP_PIN_SHARING_TOOLTIP)
            GameTooltip_AddColoredLine(GameTooltip, MAP_PIN_REMOVE,
                                       GREEN_FONT_COLOR)
            GameTooltip:Show()
        end)
    end
    SetTooltip(title)

    pin:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local highlightTexture = pin:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetAllPoints(true)
    highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)

    objective:SetScript("OnMouseDown", function(self, arg1)
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
            emit("remove")
        end
    end)
    objective.Icon = objective:CreateTexture(nil, "OVERLAY")
    objective.Icon:SetPoint("right", objective, "left", 20, -4)
    objective.Icon:SetSize(25, 25)
    objective.Title = objective:CreateFontString(nil, "BORDER",
                                                 "GameFontNormalMed3")
    objective.Title:SetTextColor(titleColor.r, titleColor.g, titleColor.b)
    objective.Title:SetPoint("bottomleft", objective, "left", 20, 3)
    objective.Title:SetText(title)
    objective.Text = objective:CreateFontString(nil, "BORDER",
                                                "GameFontNormalMed3")
    objective.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
    objective.Text:SetPoint("topleft", objective, "left", 25, 0)
    objective.Text:SetText(
        HBDmapData[mapID]["name"] .. " (" .. Round(x * 100) .. ", " ..
            Round(y * 100) .. ")")
    objective.Icon:SetBlendMode("BLEND")
    objective.Icon.highlightTexture = objective:CreateTexture(nil, "HIGHLIGHT")
    objective.Icon.highlightTexture:SetAllPoints(objective.Icon)
    objective.Icon.highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)

    objective:SetScript("OnEnter", function()
        objective.Title:SetTextColor(titleColorH.r, titleColorH.g, titleColorH.b)
        objective.Text:SetTextColor(textColorH.r, textColorH.g, textColorH.b)
    end)

    objective:SetScript("OnLeave", function()
        objective.Title:SetTextColor(titleColor.r, titleColor.g, titleColor.b)
        objective.Text:SetTextColor(textColor.r, textColor.g, textColor.b)
    end)
    local function SetTrackerPosition(index)
        objective:ClearAllPoints()
        objective:SetPoint("topleft", MapPinEnhanced.TrackerFrame, "topleft", 0,
                           -35 * (index))
        if not objective:IsShown() then objective:Show() end
    end

    local function SetObjectiveTitle(title)
        objective.Title:SetText(title)
    end

    local function SetObjectiveText(x, y, mapID)
        objective.Text:SetText(HBDmapData[mapID]["name"] .. " (" ..
                                   Round(x * 100) .. ", " .. Round(y * 100) ..
                                   ")")
    end

    return {
        Untrack = Untrack,
        Track = Track,
        ToggleTracked = ToggleTracked,
        ShowOnMap = ShowOnMap,
        RemoveFromMap = RemoveFromMap,
        MoveOnMap = MoveOnMap,
        IsTracked = IsTracked,
        FormatHyperlink = FormatHyperlink,
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
    local PlayerZonePosition = {HBD:GetPlayerZonePosition()}
    return (HBD:GetZoneDistance(PlayerZonePosition[3], PlayerZonePosition[1],
                                PlayerZonePosition[2], pin.mapID, pin.x, pin.y))
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
    local function UpdateTrackerPositions()
        for i, p in ipairs(pins) do p.SetTrackerPosition(i) end
        if MapPinEnhanced.TrackerFrame:IsShown() and #pins == 0 then
            MapPinEnhanced:TogglePinTrackerWindow()
        elseif not MapPinEnhanced.TrackerFrame:IsShown() and #pins > 0 then
            MapPinEnhanced:TogglePinTrackerWindow()
        end
    end
    local function SupertrackClosest()
        if not C_SuperTrack.IsSuperTrackingQuest() then
            local pin = nil
            for _, p in ipairs(pins) do
                if p.IsTracked() then return end
                if IsCloser(p, pin) then pin = p end
            end
            if pin then pin.Track(pin.x, pin.y, pin.mapID) end
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
            if math.abs(x - p.x) < 0.01 and math.abs(y - p.y) < 0.01 and mapID ==
                p.mapID then
                UntrackPins()
                p.Track(x, y, mapID)
                return
            end
        end

        local title
        if not name then
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
                    pin.Track(pin.x, pin.y, pin.mapID)
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
            if p.SupertrackClosest() then break end
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

    return {
        AddPin = AddPin,
        RemovePin = RemovePin,
        RestorePin = RestorePin,
        UntrackPins = UntrackPins,
        RefreshTracking = RefreshTracking,
        RemoveTrackedPin = RemoveTrackedPin,
        RestoreAllPins = RestoreAllPins,
        RemoveAllPins = RemoveAllPins
    }
end

local pinManager = PinManager()

function MapPinEnhanced:AddWaypoint(x, y, mapID, name)
    if x and y and mapID then
        if not C_Map.CanSetUserWaypointOnMap(mapID) then
            MapPinEnhanced:Print('Arrow to Pin does not work here!')
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
    if blockWAYPOINTevent then return end
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
        MapPinEnhanced:AddWaypoint(userwaypoint.position.x,
                                   userwaypoint.position.y, userwaypoint.uiMapID)
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
        self:Print(
            "The usage of /way within MPH is not possible with TomTom enabled.") -- Localize
    else
        TomTomLoaded = false
    end
end

local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
local rightseparator = "%1" .. (tonumber("1.1") and "." or ",") .. "%2"

function MapPinEnhanced:ParseInput(msg)
    if not msg then return end
    local slashx
    local slashy
    local slashmapid
    local slashtitle
    msg = msg:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator,
                                                   rightseparator)
    local tokens = {}
    for token in msg:gmatch("%S+") do tinsert(tokens, token) end

    if tokens[1] and not tonumber(tokens[1]) then
        local zoneEnd
        for idx = 1, #tokens do
            local token = tokens[idx]
            if tonumber(token) then
                zoneEnd = idx - 1
                break
            end
        end

        if not zoneEnd then return end

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
                MapPinEnhanced:AddWaypoint(slashx, slashy, slashmapid,
                                           slashtitle)
            end
        else
            MapPinEnhanced:Print(
                'Please use the formatting "/way x y" or /way zonename x y')
        end
    else
        MapPinEnhanced:Print(
            'Please use the formatting "/way x y" or "/way zonename x y"')
    end
end

if not TomTomLoaded then SLASH_MPH1 = "/way" end
SLASH_MPH2 = "/pin"
SLASH_MPH3 = "/mph"

SlashCmdList["MPH"] = function(msg)
    if strmatch(msg, "removeall") then pinManager.RemoveAllPins() end
    if strmatch(msg, "pintracker") then
        MapPinEnhanced:TogglePinTrackerWindow()
    end
    if strmatch(msg, "import") then MapPinEnhanced:ToggleImportWindow() end
    MapPinEnhanced:ParseInput(msg)
end

---- Hooks ------

hooksecurefunc(WaypointLocationPinMixin, "OnAcquired", function(self)
    self:SetAlpha(0)
    self:EnableMouse(false)
end)
------------------------
