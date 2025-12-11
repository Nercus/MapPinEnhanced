---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
---@class PinManager
local PinManager = MapPinEnhanced:GetModule("PinManager")
---@class SetManager
local SetManager = MapPinEnhanced:GetModule("SetManager")
local Blizz = MapPinEnhanced:GetModule("Blizz")

local HBDP = MapPinEnhanced.HBDP
local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
local TrackerPinEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")

local distanceUpdateFrame = CreateFrame("Frame")


---@class pinData
---@field mapID number
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to autotrack this pin on creation
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached
---@field order number? the order of the pin: the lower the number, the higher the pin will be displayed on the tracker -> if not set, the pin will be displayed at the end of the tracker


---@class PinObject
---@field pinID UUID
---@field worldmapPin MapPinEnhancedWorldMapPinMixin
---@field minimapPin MapPinEnhancedMinimapPinMixin
---@field trackerPinEntry MapPinEnhancedTrackerPinEntryMixin
---@field pinData pinData
---@field Track fun()
---@field Untrack fun(restored:boolean?)
---@field IsTracked fun():boolean
---@field Remove fun()
---@field GetPinData fun():pinData
---@field GetDistanceToPin fun():number


---@param initPinData pinData
---@param pinID UUID
---@return PinObject
function PinFactory:CreatePin(initPinData, pinID)
    local worldmapPin = WorldmapPool:Acquire()
    ---@cast worldmapPin MapPinEnhancedWorldMapPinMixin
    local minimapPin = MinimapPool:Acquire()
    ---@cast minimapPin MapPinEnhancedMinimapPinMixin
    local trackerPinEntry = TrackerPinEntryPool:Acquire()
    ---@cast trackerPinEntry MapPinEnhancedTrackerPinEntryMixin

    local isClose = nil
    local isTracked = false
    local pinData = initPinData
    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    worldmapPin:Setup(pinData)
    minimapPin:Setup(pinData)
    trackerPinEntry:Setup(pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_BATTLEFIELD_FLAG")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)

    local function GetPinData()
        return pinData
    end

    local function GetDistanceToPin()
        local playerX, playerY, playerMap = Blizz:GetPlayerMapPosition()
        if not playerMap or not playerX or not playerY then return 0 end
        local distance = MapPinEnhanced.HBD:GetZoneDistance(playerMap, playerX, playerY, pinData.mapID, pinData.x,
            pinData.y)
        if not distance then return 0 end
        return distance
    end


    local function OnDistanceClose()
        if isClose then return end
        isClose = true
        MapPinEnhanced.SuperTrackedPin:ShowSwirl()
        local trackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
        if trackingCorpse then return end
        if pinData.lock then return end
        if not isTracked then return end
        PinManager:RemovePinByID(pinID)
    end

    local function OnDistanceFar()
        if not isClose then return end
        isClose = false
        MapPinEnhanced.SuperTrackedPin:HideSwirl()
    end

    local function ManualDistanceCheck()
        local distance = GetDistanceToPin()
        if distance < 20 and distance ~= 0 then
            OnDistanceClose()
        else
            OnDistanceFar()
        end
    end

    local function EnableDistanceCheck()
        local function UpdateDistance()
            self:UpdateDistance(GetDistanceToPin, isClose, OnDistanceClose, OnDistanceFar)
        end
        distanceUpdateFrame:SetScript("OnUpdate", UpdateDistance)
        ManualDistanceCheck()
    end

    local function DisableDistanceCheck()
        distanceUpdateFrame:SetScript("OnUpdate", nil)
    end


    local function Track()
        local success = PinManager:TrackPinByID(pinID)
        if not success then
            return
        end
        worldmapPin:SetTrackedTexture()
        minimapPin:SetTrackedTexture()
        trackerPinEntry:SetTrackedTexture()
        MapPinEnhanced:SetSuperTrackedPin(GetPinData())
        PinManager:SetLastTrackedPin(pinID)
        EnableDistanceCheck()
        isTracked = true
    end

    local function Untrack(restored)
        if isTracked then
            C_Map.ClearUserWaypoint()
        end
        if not restored then
            MapPinEnhanced:SetSuperTrackedPin(nil)
        end
        worldmapPin:SetUntrackedTexture()
        minimapPin:SetUntrackedTexture()
        trackerPinEntry:SetUntrackedTexture()
        DisableDistanceCheck()
        isTracked = false
    end

    local function ToggleTracked()
        if isTracked then
            Untrack()
        else
            Track()
        end
        PinManager:PersistPins()
    end


    local function SetColor(color)
        worldmapPin:SetPinColor(color)
        minimapPin:SetPinColor(color)
        trackerPinEntry:SetPinColor(color)
        if (isTracked) then
            worldmapPin:SetTrackedTexture()
            minimapPin:SetTrackedTexture()
            trackerPinEntry:SetTrackedTexture()
        else
            worldmapPin:SetUntrackedTexture()
            minimapPin:SetUntrackedTexture()
            trackerPinEntry:SetUntrackedTexture()
        end
        pinData.color = color
        PinManager:PersistPins()
        if isTracked then
            MapPinEnhanced:SetSuperTrackedPin(GetPinData())
        end
    end


    if (isTracked) then
        worldmapPin:SetTrackedTexture()
        minimapPin:SetTrackedTexture()
        trackerPinEntry:SetTrackedTexture()
    else
        worldmapPin:SetUntrackedTexture()
        minimapPin:SetUntrackedTexture()
        trackerPinEntry:SetUntrackedTexture()
    end


    local function IsColorSelected(color)
        local colorByIndex = CONSTANTS.PIN_COLORS[color]
        if not colorByIndex then
            return false
        end
        local colorName = colorByIndex.colorName
        return pinData.color == colorName
    end

    local function Remove()
        Untrack()
        if MapPinEnhanced.pinTracker then
            if MapPinEnhanced.pinTracker:GetActiveView() == "Pins" then
                MapPinEnhanced.pinTracker:RemoveEntry(trackerPinEntry)
            end
        end
        worldmapPin:Hide()
        minimapPin:Hide()
        trackerPinEntry:Hide()
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimapPin)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, worldmapPin)
        WorldmapPool:Release(worldmapPin)
        MinimapPool:Release(minimapPin)
        TrackerPinEntryPool:Release(trackerPinEntry)
    end


    local function ChangeTitle(text)
        pinData.title = text
        worldmapPin:SetTitle(text)
        minimapPin:SetTitle(text)
        trackerPinEntry:SetTitle(text)
        PinManager:PersistPins()
        if isTracked then
            MapPinEnhanced:SetSuperTrackedPin(GetPinData())
        end
    end


    local function SharePin()
        if x and y and mapID then
            local Blizz = MapPinEnhanced:GetModule("Blizz")
            Blizz:InsertWaypointLinkToChat(x, y, mapID)
        end
    end


    local function ShowOnMap()
        if InCombatLockdown() then
            MapPinEnhanced:Notify(L["Can't Show on Map in Combat"], "ERROR")
            return
        end
        OpenWorldMap(mapID);
        worldmapPin:ShowPulseForSeconds(3)
    end


    local function ToggleLockState()
        pinData.lock = not pinData.lock
        trackerPinEntry.Pin:SetLockState(pinData.lock)
        if MapPinEnhanced.SuperTrackedPin then
            MapPinEnhanced.SuperTrackedPin:SetLockState(pinData.lock)
        end
        PinManager:PersistPins()
        isClose = not isClose -- set to inverse to trigger the distance check
        ManualDistanceCheck()
    end


    local function CreateMenu(parentFrame)
        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            local titleElementDescription = rootDescription:CreateTemplate("MapPinEnhancedMenuInputTemplate") --[[@as BaseMenuDescriptionMixin]]
            titleElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedInputMixin
                frame:Setup({
                    default = pinData.title or CONSTANTS.DEFAULT_PIN_NAME,
                    init = function() return pinData.title or CONSTANTS.DEFAULT_PIN_NAME end,
                    onChange = function(value)
                        ChangeTitle(value)
                    end
                })
            end);
            rootDescription:CreateDivider()
            if pinData.color ~= "Custom" then
                ---@type SubMenuUtil
                local colorSubmenu = rootDescription:CreateButton(L["Change Color"]);
                for colorIndex, colorTable in ipairs(CONSTANTS.PIN_COLORS) do
                    local label = string.format(CONSTANTS.MENU_COLOR_BUTTON_PATTERN, colorTable.color:GetRGBAsBytes())
                    colorSubmenu:CreateRadio(label, IsColorSelected, function() SetColor(colorTable.colorName) end,
                        colorIndex)
                end
            end


            ---@type fun(disabled:boolean)?
            local OverrideCreateSetButtonDisabledState

            ---@type SubMenuUtil
            local setSubmenu = rootDescription:CreateButton(L["Add to a Set"]);
            local sets = SetManager:GetSets()
            setSubmenu:CreateTitle(L["Enter New Set Name"])
            local cachedSetName = ""
            local confirmNewSetElementDescription
            local newSetNameElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedMenuInputTemplate") --[[@as BaseMenuDescriptionMixin]]
            newSetNameElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedInputMixin
                frame:SetSize(150, 20)
                frame:SetScript("OnEnterPressed", function()
                    if cachedSetName == "" then
                        return
                    end
                    local newSet = SetManager:AddSet(cachedSetName)
                    newSet:AddPin(pinData, nil, true)
                    local inputContext = MenuInputContext.MouseButton;
                    confirmNewSetElementDescription:Pick(inputContext, "LeftButton");
                    frame:ClearFocusOnKey()
                end)
                frame:Setup({
                    default = "",
                    init = function() return "" end,
                    onChange = function(value)
                        cachedSetName = value
                        if not OverrideCreateSetButtonDisabledState then return end
                        if value == "" then
                            OverrideCreateSetButtonDisabledState(true)
                        else
                            OverrideCreateSetButtonDisabledState(false)
                        end
                    end
                })
            end)
            setSubmenu:CreateSpacer()

            confirmNewSetElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedButtonTemplate") --[[@as BaseMenuDescriptionMixin]]
            confirmNewSetElementDescription:SetResponder(function()
                return MenuResponse.CloseAll;
            end)
            confirmNewSetElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedButtonMixin
                frame:SetSize(150, 20)
                frame:SetText(L["Create Set"])
                frame:Setup({
                    buttonLabel = L["Create Set"],
                    onChange = function(buttonName)
                        if cachedSetName == "" then
                            return
                        end
                        local newSet = SetManager:AddSet(cachedSetName)
                        newSet:AddPin(pinData, nil, true)
                        local inputContext = MenuInputContext.MouseButton;
                        confirmNewSetElementDescription:Pick(inputContext, buttonName);
                    end,
                    disabledState = true
                })

                OverrideCreateSetButtonDisabledState = function(disabled)
                    frame:SetDisabled(disabled)
                end
            end)
            setSubmenu:CreateDivider()
            for _, set in pairs(sets) do
                setSubmenu:CreateButton(set.name, function()
                    set:AddPin(pinData, nil, true)
                end)
            end

            rootDescription:CreateButton(L["Show on Map"], ShowOnMap)
            local lockToggleLabel = pinData.lock and L["Unlock Pin"] or L["Lock Pin"]
            rootDescription:CreateButton(lockToggleLabel, function()
                ToggleLockState()
            end)

            rootDescription:CreateButton(L["Share to Chat"], function() SharePin() end)
            rootDescription:CreateButton(L["Remove Pin"], function() PinManager:RemovePinByID(pinID) end)
        end)
    end


    local function HandleClicks(buttonFrame, button)
        local shift, ctrl = IsShiftKeyDown(), IsControlKeyDown()
        -- alt not used right now
        if button == "LeftButton" then
            if ctrl then
                PinManager:RemovePinByID(pinID)
                return
            end
            if shift then
                SharePin()
                return
            end
            ToggleTracked()
        elseif button == "RightButton" then
            CreateMenu(buttonFrame)
        elseif button == "MiddleButton" then
            PinManager:RemovePinByID(pinID)
        end
    end



    -- minimap pins dont have a click interaction
    worldmapPin:SetScript("OnMouseDown", HandleClicks)
    trackerPinEntry:SetScript("OnMouseDown", HandleClicks)
    ManualDistanceCheck()


    return {
        pinID = pinID,
        worldmapPin = worldmapPin,
        minimapPin = minimapPin,
        trackerPinEntry = trackerPinEntry,
        pinData = pinData,
        Track = Track,
        Untrack = Untrack,
        IsTracked = function() return isTracked end,
        GetDistanceToPin = GetDistanceToPin,
        Remove = Remove,
        GetPinData = GetPinData
    }
end
