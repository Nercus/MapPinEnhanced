---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:CreateModule("PinFactory")
---@type PinManager
local PinManager
MapPinEnhanced:GetModuleAsync("PinManager", function(m) PinManager = m end)

local HBDP = LibStub("HereBeDragons-Pins-2.0")

local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
local TrackerEntryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerEntryTemplate")


local TEST_COLORS = {
    CreateColor(1, 0.369, 0.545),
    CreateColor(0.651, 0.067, 0.129),
    CreateColor(1, 0.647, 0.31),
    CreateColor(0.455, 0.863, 0.525),
    CreateColor(0.004, 0.373, 0.231),
    CreateColor(0, 0.831, 0.945),
    CreateColor(0.655, 0.573, 1),
    CreateColor(0.6, 0.082, 0.459),
}


---@param pinData pinData
---@param pinID string
---@return PinObject
function PinFactory:CreatePin(pinData, pinID)
    local worldmapPin = WorldmapPool:Acquire()
    ---@cast worldmapPin MapPinEnhancedWorldMapPinMixin
    local minimapPin = MinimapPool:Acquire()
    ---@cast minimapPin MapPinEnhancedMinimapPinMixin
    local trackerEntry = TrackerEntryPool:Acquire()
    ---@cast trackerEntry MapPinEnhancedTrackerEntryMixin

    local x, y, mapID = pinData.x, pinData.y, pinData.mapID


    worldmapPin:SetPinData(pinData)
    minimapPin:SetPinData(pinData)
    trackerEntry:SetPinData(pinData)

    worldmapPin:Setup()
    minimapPin:Setup()
    trackerEntry:Setup()

    HBDP:AddWorldMapIconMap(MapPinEnhanced, worldmapPin, mapID, x, y, 3, "PIN_FRAME_LEVEL_ENCOUNTER")
    HBDP:AddMinimapIconMap(MapPinEnhanced, minimapPin, mapID, x, y, false, false)
    MapPinEnhanced.pinTracker:AddEntry(trackerEntry)


    local isTracked = false
    local function Track()
        local success = PinManager:TrackPinByID(pinID)
        if not success then
            return
        end
        worldmapPin:SetTracked()
        minimapPin:SetTracked()
        trackerEntry:SetTracked()
        isTracked = true
    end

    local function Untrack()
        if isTracked then
            C_Map.ClearUserWaypoint()
        end
        worldmapPin:SetUntracked()
        minimapPin:SetUntracked()
        trackerEntry:SetUntracked()
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
        trackerEntry:SetPinColor(color)
    end



    local function CreateMenu(parentFrame)
        local titleString = string.format("|%s:%s:20:20|%s %s",
            pinData.usesAtlas and "A" or "T", pinData.texture,
            pinData.usesAtlas and "a" or "t", pinData.title or "Map Pin")

        ---@diagnostic disable-next-line: no-unknown Annotation for this is not implemented into the vscode wow extension
        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            rootDescription:CreateTitle(titleString)
            rootDescription:CreateDivider()
            ---@diagnostic disable-next-line: no-unknown Annotation for this is not implemented into the vscode wow extension
            local submenu = rootDescription:CreateButton("Change Color");
            for i = 1, #TEST_COLORS do
                local buttonTextureText = string.format("|A:charactercreate-customize-palette:12:64:0:0:%d:%d:%d|a",
                    TEST_COLORS[i]:GetRGBAsBytes())
                submenu:CreateButton(buttonTextureText, function() SetColor(TEST_COLORS[i]) end)
            end

            rootDescription:CreateButton("Share Pin", function() error("Not implemented: Share Pin") end)
            rootDescription:CreateButton("Add to a set", function() error("Not implemented: Add to set") end)
        end)
    end


    local function HandleClicks(buttonFrame, button)
        if button == "LeftButton" then
            ToggleTracked()
        else
            CreateMenu(buttonFrame)
        end
    end




    worldmapPin:SetScript("OnMouseDown", HandleClicks)
    trackerEntry:SetScript("OnMouseDown", HandleClicks)

    minimapPin:UpdatePin()
    worldmapPin:UpdatePin()
    trackerEntry:UpdatePin()
    return {
        pinID = pinID,
        worldmapPin = worldmapPin,
        minimapPin = minimapPin,
        trackerEntry = trackerEntry,
        pinData = pinData,
        Track = Track,
        Untrack = Untrack,
        IsTracked = function() return isTracked end,
    }
end
