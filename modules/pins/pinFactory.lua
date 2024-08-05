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
---@field title string?
---@field texture string?
---@field usesAtlas boolean?
---@field color string?


-- TODO: add a way to order the pins in a specific order -> should be consistent for newly created pins and for pins in a set.
---field order number? used to give the pin a specific order -> lower numbers are displayed first -> nil means no order


---@class PinObject
---@field pinID UUID
---@field worldmapPin MapPinEnhancedWorldMapPinMixin
---@field minimapPin MapPinEnhancedMinimapPinMixin
---@field TrackerPinEntry MapPinEnhancedTrackerPinEntryMixin
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
    local TrackerPinEntry = TrackerPinEntryPool:Acquire()
    ---@cast TrackerPinEntry MapPinEnhancedTrackerPinEntryMixin


    local pinData = initPinData
    local x, y, mapID = pinData.x, pinData.y, pinData.mapID

    worldmapPin:Setup(pinData)
    minimapPin:Setup(pinData)
    TrackerPinEntry:Setup(pinData)

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)

    local function GetPinData()
        return pinData
    end


    local isTracked = false
    local function Track()
        local success = PinManager:TrackPinByID(pinID)
        if not success then
            return
        end
        worldmapPin:SetTrackedTexture()
        minimapPin:SetTrackedTexture()
        TrackerPinEntry:SetTrackedTexture()
        MapPinEnhanced:SetSuperTrackedPin(GetPinData())
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
        PinManager:PersistPins()
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


    if (isTracked) then
        worldmapPin:SetTrackedTexture()
        minimapPin:SetTrackedTexture()
        TrackerPinEntry:SetTrackedTexture()
    else
        worldmapPin:SetUntrackedTexture()
        minimapPin:SetUntrackedTexture()
        TrackerPinEntry:SetUntrackedTexture()
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
            MapPinEnhanced.pinTracker:RemoveEntry(TrackerPinEntry)
        end
        worldmapPin:Hide()
        minimapPin:Hide()
        TrackerPinEntry:Hide()
        HBDP:RemoveMinimapIcon(MapPinEnhanced, minimapPin)
        HBDP:RemoveWorldMapIcon(MapPinEnhanced, worldmapPin)
        WorldmapPool:Release(worldmapPin)
        MinimapPool:Release(minimapPin)
        TrackerPinEntryPool:Release(TrackerPinEntry)
    end


    local function ChangeTitle(text)
        pinData.title = text
        worldmapPin:SetTitle(text)
        minimapPin:SetTitle(text)
        TrackerPinEntry:SetTitle(text)
        PinManager:PersistPins()
    end


    local function SharePin()
        error("Not implemented: Share Pin")
    end

    local function CreateMenu(parentFrame)
        local titleString = string.format("|%s%s:20:20|%s %s",
            pinData.usesAtlas and "A:" or "T", pinData.texture or worldmapPin.texture:GetTexture(),
            pinData.usesAtlas and "a" or "t", pinData.title or "Map Pin")

        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            rootDescription:CreateTitle(titleString)
            rootDescription:CreateDivider()
            if pinData.color ~= "Custom" then
                ---@type SubMenuUtil
                local colorSubmenu = rootDescription:CreateButton("Change Color");
                for colorIndex, colorTable in ipairs(CONSTANTS.PIN_COLORS) do
                    local buttonTextureText = string.format("|A:charactercreate-customize-palette:12:64:0:0:%d:%d:%d|a",
                        colorTable.color:GetRGBAsBytes())
                    colorSubmenu:CreateRadio(
                        buttonTextureText,
                        IsColorSelected,
                        function() SetColor(colorTable.colorName) end,
                        colorIndex
                    )
                end
            end

            ---@type MenuUtil
            local setSubmenu = rootDescription:CreateButton("Add to a set");
            local sets = SetManager:GetSets()
            setSubmenu:CreateButton("Create new set", function()
                MapPinEnhanced:OpenTextModal({
                    title = "Enter Set Name",
                    autoFocus = true,
                    onAccept = function(text)
                        local set = SetManager:AddSet(text)
                        set:AddPin(pinData)
                    end,
                    onCancel = function() end
                })
            end)
            setSubmenu:CreateDivider()
            for _, set in pairs(sets) do
                setSubmenu:CreateButton(set.name, function()
                    set:AddPin(pinData)
                end)
            end
            rootDescription:CreateButton("Change Pin Title", function()
                MapPinEnhanced:OpenTextModal({
                    title = "Enter Pin Title",
                    autoFocus = true,
                    text = pinData.title,
                    onAccept = function(text) ChangeTitle(text) end,
                    onCancel = function() end
                })
            end)
            rootDescription:CreateButton("Share Pin", function() error("Not implemented: Share Pin") end)
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
    TrackerPinEntry:SetScript("OnMouseDown", HandleClicks)


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
