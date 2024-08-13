---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")

local HBDP = MapPinEnhanced.HBDP
local CONSTANTS = MapPinEnhanced.CONSTANTS

local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
local TrackerPinEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")

---@class pinData
---@field mapID number
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to autotrack this pin on creation
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field persistent boolean? if true, the pin will be not be removed automatically when it has been reached
---@field order number? the order of the pin: the lower the number, the higher the pin will be displayed on the tracker -> if not set, the pin will be displayed at the end of the tracker


---@class PinObject
---@field pinID UUID
---@field worldmapPin MapPinEnhancedWorldMapPinMixin
---@field minimapPin MapPinEnhancedMinimapPinMixin
---@field trackerPinEntry MapPinEnhancedTrackerPinEntryMixin
---@field pinData pinData
---@field Track fun()
---@field Untrack fun()
---@field IsTracked fun():boolean
---@field Remove fun()
---@field GetPinData fun():pinData


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


    local pinData = initPinData
    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    worldmapPin:Setup(pinData)
    minimapPin:Setup(pinData)
    trackerPinEntry:Setup(pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)

    local function GetPinData()
        return pinData
    end


    local function EnableDistanceCheck()
        local function UpdateDistance()
            self:UpdateDistance(pinID, pinData)
        end
        trackerPinEntry:SetScript("OnUpdate", UpdateDistance)
    end

    local function DisableDistanceCheck()
        trackerPinEntry:SetScript("OnUpdate", nil)
    end

    local isTracked = false
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

    local function Untrack()
        if isTracked then
            C_Map.ClearUserWaypoint()
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
        MapPinEnhanced:SetSuperTrackedPin(GetPinData())
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
        if isTracked then
            C_Map.ClearUserWaypoint()
        end
        if MapPinEnhanced.pinTracker and MapPinEnhanced.pinTracker:GetActiveView() == "Pins" then
            MapPinEnhanced.pinTracker:RemoveEntry(trackerPinEntry)
        end
        worldmapPin:Hide()
        minimapPin:Hide()
        trackerPinEntry:Hide()
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimapPin)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, worldmapPin)
        WorldmapPool:Release(worldmapPin)
        MinimapPool:Release(minimapPin)
        TrackerPinEntryPool:Release(trackerPinEntry)
        MapPinEnhanced:SetSuperTrackedPin(nil)
    end


    local function ChangeTitle(text)
        pinData.title = text
        worldmapPin:SetTitle(text)
        minimapPin:SetTitle(text)
        trackerPinEntry:SetTitle(text)
        PinManager:PersistPins()
        MapPinEnhanced:SetSuperTrackedPin(GetPinData())
    end


    local function SharePin()
        if x and y and mapID then
            local waypointLink = ("|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"):format(mapID, x * 10000, y * 10000,
                MAP_PIN_HYPERLINK)
            ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
            ChatEdit_InsertLink(waypointLink)
        end
    end


    local function ShowOnMap()
        if InCombatLockdown() then
            MapPinEnhanced:Notify("Can't show on map in combat", "ERROR")
            return
        end
        OpenWorldMap(mapID);
    end


    local function TogglePersistentState()
        pinData.persistent = not pinData.persistent
        trackerPinEntry.Pin:SetpersistentState(pinData.persistent)
        if MapPinEnhanced.SuperTrackedPin then
            MapPinEnhanced.SuperTrackedPin:SetpersistentState(pinData.persistent)
        end
        PinManager:PersistPins()
    end


    local function CreateMenu(parentFrame)
        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            local titleElementDescription = rootDescription:CreateTemplate("MapPinEnhancedInputTemplate") --[[@as BaseMenuDescriptionMixin]]
            titleElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedInputMixin
                frame:SetSize(150, 24)
                frame:Setup({
                    default = pinData.title or CONSTANTS.DEFAULT_PIN_NAME,
                    init = pinData.title or CONSTANTS.DEFAULT_PIN_NAME,
                    onChange = function(value)
                        ChangeTitle(value)
                    end
                })
            end);
            rootDescription:CreateDivider()
            if pinData.color ~= "Custom" then
                ---@type SubMenuUtil
                local colorSubmenu = rootDescription:CreateButton("Change Color");
                for colorIndex, colorTable in ipairs(CONSTANTS.PIN_COLORS) do
                    local label = string.format(CONSTANTS.MENU_COLOR_BUTTON_PATTERN, colorTable.color:GetRGBAsBytes())
                    colorSubmenu:CreateRadio(label, IsColorSelected, function() SetColor(colorTable.colorName) end,
                        colorIndex)
                end
            end


            ---@type fun(disabled:boolean)?
            local OverrideCreateSetButtonDisabledState

            ---@type SubMenuUtil
            local setSubmenu = rootDescription:CreateButton("Add to a set");
            local sets = SetManager:GetSets()
            setSubmenu:CreateTitle("Enter new set name")
            local cachedSetName = ""
            local newSetNameElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedInputTemplate") --[[@as BaseMenuDescriptionMixin]]
            newSetNameElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedInputMixin
                frame:SetSize(150, 20)
                frame:Setup({
                    default = "",
                    init = "",
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
            local confirmNewSetElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedButtonTemplate") --[[@as BaseMenuDescriptionMixin]]
            confirmNewSetElementDescription:SetResponder(function()
                return MenuResponse.CloseAll;
            end)
            confirmNewSetElementDescription:AddInitializer(function(frame)
                ---@cast frame MapPinEnhancedButtonMixin
                frame:SetSize(150, 20)
                frame:SetText("Create Set")
                frame:Setup({
                    buttonLabel = "Create Set",
                    onChange = function(buttonName)
                        if cachedSetName == "" then
                            return
                        end
                        local newSet = SetManager:AddSet(cachedSetName)
                        newSet:AddPin(pinData)
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
                    set:AddPin(pinData)
                end)
            end

            rootDescription:CreateButton("Show on Map", ShowOnMap)
            rootDescription:CreateButton("Toggle persistent", function()
                TogglePersistentState()
            end)

            rootDescription:CreateButton("Remove Pin", function() SharePin() end)
            rootDescription:CreateButton("Remove Pin", function() PinManager:RemovePinByID(pinID) end)
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
        else
            CreateMenu(buttonFrame)
        end
    end



    -- minimap pins dont have a click interaction
    worldmapPin:SetScript("OnMouseDown", HandleClicks)
    trackerPinEntry:SetScript("OnMouseDown", HandleClicks)



    return {
        pinID = pinID,
        worldmapPin = worldmapPin,
        minimapPin = minimapPin,
        trackerPinEntry = trackerPinEntry,
        pinData = pinData,
        Track = Track,
        Untrack = Untrack,
        IsTracked = function() return isTracked end,
        Remove = Remove,
        GetPinData = GetPinData
    }
end
