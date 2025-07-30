---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
---@field initialized boolean
---@field worldmapPin MapPinEnhancedWorldmapPinTemplate
---@field minimapPin MapPinEnhancedMinimapPinTemplate
---@field trackerEntry MapPinEnhancedTrackerPinMixin
---@field pinData pinData
---@field isTracked boolean? -- whether this pin is currently tracked
---@field pinID UUID
---@field group MapPinEnhancedPinGroupMixin? -- the group this pin belongs to, if any
MapPinEnhancedPinMixin = CreateFromMixins(
    MapPinEnhancedPinTrackingMixin,
    MapPinEnhancedPinMenuMixin,
    MapPinEnhancedPinMouseDownMixin,
    MapPinEnhancedPinColorMixin,
    MapPinEnhancedPinUtilsMixin,
    MapPinEnhancedPinTooltipMixin,
    MapPinEnhancedPinProxyMixin
)

local L = MapPinEnhanced.L
local HBDP = MapPinEnhanced.HBDP
local DEFAULT_PIN_NAME = L["Map Pin"]

---@class Pins
---@field trackerObjectPool ObjectPool<MapPinEnhancedTrackerPinMixin>
---@field framePool FramePoolCollection<MapPinEnhancedWorldmapPinTemplate | MapPinEnhancedMinimapPinTemplate | MapPinEnhancedTrackerPinEntryTemplate>
local Pins = MapPinEnhanced:GetModule("Pins")
local Groups = MapPinEnhanced:GetModule("Groups")


function Pins:GetFramePool()
    if not self.framePool then
        self.framePool = CreateFramePoolCollection()
        self.framePool:CreatePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
        self.framePool:CreatePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
        -- self.framePool:CreatePool("Frame", nil, "MapPinEnhancedSuperTrackedPinTemplate")
    end
    return self.framePool
end

local function CreateGroupObject()
    return CreateFromMixins(MapPinEnhancedTrackerPinMixin)
end

---@param trackerEntry MapPinEnhancedTrackerPinMixin
local function ResetGroupObject(_, trackerEntry)
    trackerEntry:Reset()
end

function Pins:GetTrackerObjectPool()
    if not self.trackerObjectPool then
        self.trackerObjectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
    end

    return self.trackerObjectPool
end

function MapPinEnhancedPinMixin:Init(pinID)
    self.initialized = true
    self.pinID = pinID

    local framePool = Pins:GetFramePool()
    self.worldmapPin = framePool:Acquire('MapPinEnhancedWorldmapPinTemplate')
    self.minimapPin = framePool:Acquire('MapPinEnhancedMinimapPinTemplate')

    local trackerObjectPool = Pins:GetTrackerObjectPool()
    self.trackerEntry = trackerObjectPool:Acquire()

    self.worldmapPin:SetScript("OnMouseDown", function(_, button)
        self:OnMouseDown(_, button)
    end)
end

function MapPinEnhancedPinMixin:OverridePinID(pinID)
    self.pinID = pinID
end

---@param pinData pinData
function MapPinEnhancedPinMixin:SetPinData(pinData)
    if not self.initialized and self.pinID then
        self:Init(self.pinID) -- we need to recall init when the pin is reused as the frames are released back when reset
    end
    self.pinData = pinData
    if (self.pinData.x > 1) then
        self.pinData.x = self.pinData.x / 100
    end
    if (self.pinData.y > 1) then
        self.pinData.y = self.pinData.y / 100
    end

    if self.pinData.texture then
        self.pinData.color = "Custom"
    end

    if not self.pinData.title or self.pinData.title == "" then
        self.pinData.title = DEFAULT_PIN_NAME
    end

    if not self.pinData.tooltip then
        ---@type string?
        local source
        local group = self.group
        if group then
            source = group:GetSource()
            if source == MapPinEnhanced.name then
                source = nil
            end
        end
        self.pinData.tooltip = { title = self.pinData.title, text = source }
    end

    self:SetPinColor(self.pinData.color)
    self:SetPinIcon(self.pinData.texture, self.pinData.usesAtlas)
    self:SetTooltip(self.pinData.tooltip)


    if self.pinData.setTracked then
        self:Track()
    else
        self:Untrack()
    end

    HBDP:AddWorldMapIconMap(MapPinEnhanced, self.worldmapPin, self.pinData.mapID, self.pinData.x, self.pinData.y, 3,
        "PIN_FRAME_LEVEL_WAYPOINT_LOCATION")
    HBDP:AddMinimapIconMap(MapPinEnhanced, self.minimapPin, self.pinData.mapID, self.pinData.x, self.pinData.y, false,
        false)
end

function MapPinEnhancedPinMixin:GetPinData()
    return self.pinData
end

---@class SaveablePinData : pinData
---@field pinID UUID

---@return SaveablePinData
function MapPinEnhancedPinMixin:GetSaveableData()
    local pinDataToSave = self:GetPinData()
    ---@cast pinDataToSave SaveablePinData
    pinDataToSave.setTracked = self:IsTracked()
    pinDataToSave.pinID = self.pinID
    return pinDataToSave
end

function MapPinEnhancedPinMixin:Reset()
    if not self.initialized then return end
    self.initialized = false
    -- untrack first to clear the pin
    self:Untrack()

    -- release the pins
    local framePool = Pins:GetFramePool()
    framePool:Release(self.worldmapPin)
    framePool:Release(self.minimapPin)

    local trackerObjectPool = Pins:GetTrackerObjectPool()
    trackerObjectPool:Release(self.trackerEntry)

    -- remove from world and minimap
    HBDP:RemoveMinimapIcon(MapPinEnhanced, self.minimapPin)
    HBDP:RemoveWorldMapIcon(MapPinEnhanced, self.worldmapPin)
end

function MapPinEnhancedPinMixin:PersistPin()
    if not self.group then return end
    Groups:PersistGroup(self.group)
end
