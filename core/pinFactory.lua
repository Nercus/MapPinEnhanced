---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")

local HBDP = LibStub("HereBeDragons-Pins-2.0")

local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
local TrackerPinEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")




---@param initPinData pinData
---@param pinID string
---@return PinObject
function PinFactory:CreatePin(initPinData, pinID)
    local worldmapPin = WorldmapPool:Acquire()
    ---@cast worldmapPin MapPinEnhancedWorldMapPinMixin
    local minimapPin = MinimapPool:Acquire()
    ---@cast minimapPin MapPinEnhancedMinimapPinMixin
    local TrackerPinEntry = TrackerPinEntryPool:Acquire()
    ---@cast TrackerPinEntry MapPinEnhancedTrackerPinEntryMixin


    local pinData = initPinData

    local x, y, mapID = pinData.x, pinData.y, pinData.mapID


    worldmapPin:SetPinData(pinData)
    minimapPin:SetPinData(pinData)
    TrackerPinEntry:SetPinData(pinData)

    worldmapPin:Setup()
    minimapPin:Setup()
    TrackerPinEntry:Setup()

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)

    local isTracked = false
    local function Track()
        local success = PinManager:TrackPinByID(pinID)
        if not success then
            return
        end
        worldmapPin:SetTrackedTexture()
        minimapPin:SetTrackedTexture()
        TrackerPinEntry:SetTrackedTexture()
        isTracked = true
    end

    local function Untrack()
        if isTracked then
            C_Map.ClearUserWaypoint()
        end
        worldmapPin:SetUntrackedTexture()
        minimapPin:SetUntrackedTexture()
        TrackerPinEntry:SetUntrackedTexture()
        isTracked = false
    end

    local function ToggleTracked()
        if isTracked then
            Untrack()
        else
            Track()
        end
    end


    local function SetColor(color)
        worldmapPin:SetPinColor(color)
        minimapPin:SetPinColor(color)
        TrackerPinEntry:SetPinColor(color)
        if (isTracked) then
            worldmapPin:SetTrackedTexture()
            minimapPin:SetTrackedTexture()
            TrackerPinEntry:SetTrackedTexture()
        else
            worldmapPin:SetUntrackedTexture()
            minimapPin:SetUntrackedTexture()
            TrackerPinEntry:SetUntrackedTexture()
        end
        pinData.color = color
        PinManager:PersistPins()
    end
    SetColor(pinData.color)


    local function IsColorSelected(color)
        local colorByIndex = MapPinEnhanced.PIN_COLORS[color]
        if not colorByIndex then
            return false
        end
        local colorName = colorByIndex.colorName
        return pinData.color == colorName
    end


    local function CreateMenu(parentFrame)
        local titleString = string.format("|%s%s:20:20|%s %s",
            pinData.usesAtlas and "A:" or "T", pinData.texture or worldmapPin.icon:GetTexture(),
            pinData.usesAtlas and "a" or "t", pinData.title or "Map Pin")

        ---@diagnostic disable-next-line: no-unknown Annotation for this is not implemented into the vscode wow extension
        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            rootDescription:CreateTitle(titleString)
            rootDescription:CreateDivider()
            ---@diagnostic disable-next-line: no-unknown Annotation for this is not implemented into the vscode wow extension
            local submenu = rootDescription:CreateButton("Change Color");
            for colorIndex, colorTable in ipairs(MapPinEnhanced.PIN_COLORS) do
                local buttonTextureText = string.format("|A:charactercreate-customize-palette:12:64:0:0:%d:%d:%d|a",
                    colorTable.color:GetRGBAsBytes())
                submenu:CreateRadio(
                    buttonTextureText,
                    IsColorSelected,
                    function() SetColor(colorTable.colorName) end,
                    colorIndex
                )
            end

            rootDescription:CreateButton("Share Pin", function() error("Not implemented: Share Pin") end)
            rootDescription:CreateButton("Add to a set", function() error("Not implemented: Add to set") end)
        end)
    end



    local function GetPinData()
        return pinData
    end


    local function Remove()
        MapPinEnhanced.pinTracker:RemoveEntry(TrackerPinEntry)
        worldmapPin:Hide()
        minimapPin:Hide()
        TrackerPinEntry:Hide()
        WorldmapPool:Release(worldmapPin)
        MinimapPool:Release(minimapPin)
        TrackerPinEntryPool:Release(TrackerPinEntry)
    end



    local function SharePin()
        -- TODO: implement sharing of pins
        error("Not implemented: Share Pin")
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
    TrackerPinEntry:SetScript("OnMouseDown", HandleClicks)

    minimapPin:UpdatePin()
    worldmapPin:UpdatePin()
    TrackerPinEntry:UpdatePin()


    return {
        pinID = pinID,
        worldmapPin = worldmapPin,
        minimapPin = minimapPin,
        TrackerPinEntry = TrackerPinEntry,
        pinData = pinData,
        Track = Track,
        Untrack = Untrack,
        IsTracked = function() return isTracked end,
        Remove = Remove,
        GetPinData = GetPinData
    }
end
