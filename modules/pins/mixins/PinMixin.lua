---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
---@field classification 'pin'
---@field initialized boolean
---@field worldmapPin MapPinEnhancedWorldmapPinTemplate
---@field minimapPin MapPinEnhancedMinimapPinTemplate
---@field pinData pinData
---@field isTracked boolean? -- whether this pin is currently tracked
---@field pinID UUID
---@field group MapPinEnhancedGroupMixin? -- the group this pin belongs to, if any
---@field suppressChangePublication boolean? true while the group is still adding the pin
---@field suppressPersistence boolean? true when the group already saved the pin change
MapPinEnhancedPinMixin = CreateFromMixins(
    { classification = "pin" },
    MapPinEnhancedPinTrackingMixin,
    MapPinEnhancedPinMenuMixin,
    MapPinEnhancedPinMouseDownMixin,
    MapPinEnhancedPinStyleMixin,
    MapPinEnhancedPinUtilsMixin,
    MapPinEnhancedPinTooltipMixin,
    MapPinEnhancedPinProxyMixin,
    MapPinEnhancedPinLockMixin
)

local L = MapPinEnhanced.L
local HBDP = MapPinEnhanced.HBDP
local DEFAULT_PIN_NAME = L["Map Pin"]

---@class Pins
---@field framePool FramePoolCollection<MapPinEnhancedWorldmapPinTemplate | MapPinEnhancedMinimapPinTemplate>
local Pins = MapPinEnhanced:GetModule("Pins")
local Groups = MapPinEnhanced:GetModule("Groups")

function MapPinEnhancedPinMixin:UpdateGroupIcon()
    local group = self.group
    if not group or group:GetGroupID() == Groups.SYSTEM_GROUP_IDS.UNGROUPED then
        self.worldmapPin.groupBadge:SetIcon(nil)
        self.minimapPin.groupBadge:SetIcon(nil)
        return
    end

    self.worldmapPin.groupBadge:SetIcon(group:GetIcon())
    self.minimapPin.groupBadge:SetIcon(group:GetIcon())
end

---Normalizes a coordinate to a value between 0 and 1
---@param value number
---@return number
local function NormalizeCoordinate(value)
    if value > 1 then
        return value / 100
    end
    return value
end

function Pins:GetFramePool()
    if not self.framePool then
        self.framePool = CreateFramePoolCollection()
        self.framePool:CreatePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
        self.framePool:CreatePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
    end
    return self.framePool
end

function MapPinEnhancedPinMixin:Init(pinID)
    self.initialized = true
    self.pinID = pinID

    local framePool = Pins:GetFramePool()
    self.worldmapPin = framePool:Acquire("MapPinEnhancedWorldmapPinTemplate")
    self.minimapPin = framePool:Acquire("MapPinEnhancedMinimapPinTemplate")
    self.worldmapPin.pin = self
    self.minimapPin.pin = self

    self.worldmapPin:SetScript("OnMouseDown", function(_, button)
        self:OnMouseDown(_, button)
    end)
    -- RightClick doesn't seem to work on minimap pins, but I guess that's just intended. It's not a bug, it's a feature ¯\_(ツ)_/¯
    self.minimapPin:SetScript("OnMouseDown", function(_, button)
        self:OnMouseDown(_, button)
    end)
end

function MapPinEnhancedPinMixin:OverridePinID(pinID)
    self.pinID = pinID
end

---@param pinData pinData
---@param deferCommit boolean? true while the group is still adding the pin
function MapPinEnhancedPinMixin:SetPinData(pinData, deferCommit)
    if not self.initialized and self.pinID then
        self:Init(self.pinID) -- we need to recall init when the pin is reused as the frames are released back when reset
    end
    self.pinData = pinData
    self.suppressChangePublication = deferCommit and true or nil
    self.pinData.x = NormalizeCoordinate(self.pinData.x)
    self.pinData.y = NormalizeCoordinate(self.pinData.y)

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

    if self.pinData.texture then
        self:SetIcon(self.pinData.texture, self.pinData.usesAtlas)
    else
        self:SetColor(self.pinData.color)
    end
    self:SetTooltip(self.pinData.tooltip)
    self:SetTitle(self.pinData.title)
    self:SetLock(self.pinData.lock)
    self:UpdateGroupIcon()

    if not deferCommit then
        if self.pinData.setTracked then
            self:Track()
        else
            self:Untrack()
        end
    end
    self.suppressChangePublication = nil

    local worldMapSuccess = HBDP:AddWorldMapIconMap(MapPinEnhanced, self.worldmapPin, self.pinData.mapID, self.pinData.x,
        self.pinData.y, 3,
        "PIN_FRAME_LEVEL_WAYPOINT_LOCATION")
    local minimapSuccess = HBDP:AddMinimapIconMap(MapPinEnhanced, self.minimapPin, self.pinData.mapID, self.pinData.x,
        self.pinData.y, false,
        false)

    if not worldMapSuccess or not minimapSuccess then
        self:Reset()
        MapPinEnhanced:Notify(L["Failed to place pin on the map. Please check if the coordinates are correct!"], "ERROR")
    end
end

---@param mapID number
---@param x number
---@param y number
function MapPinEnhancedPinMixin:SetPinPosition(mapID, x, y)
    assert(mapID, "MapPinEnhancedPinMixin:SetPinPosition: mapID is nil")
    assert(type(mapID) == "number", "MapPinEnhancedPinMixin:SetPinPosition: mapID must be a number")
    assert(x, "MapPinEnhancedPinMixin:SetPinPosition: x is nil")
    assert(type(x) == "number", "MapPinEnhancedPinMixin:SetPinPosition: x must be a number")
    assert(y, "MapPinEnhancedPinMixin:SetPinPosition: y is nil")
    assert(type(y) == "number", "MapPinEnhancedPinMixin:SetPinPosition: y must be a number")

    x = NormalizeCoordinate(x)
    y = NormalizeCoordinate(y)

    if mapID == self.pinData.mapID and x == self.pinData.x and y == self.pinData.y then return end

    local wasTracked = self:IsTracked()
    if wasTracked then
        MapPinEnhanced:DisableContinuousDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y)
    end

    self.pinData.mapID = mapID
    self.pinData.x = x
    self.pinData.y = y
    self.pinData.setTracked = wasTracked

    HBDP:RemoveMinimapIcon(MapPinEnhanced, self.minimapPin)
    HBDP:RemoveWorldMapIcon(MapPinEnhanced, self.worldmapPin)

    self:SetPinData(self.pinData, true)
    if self.group then
        self.group:TouchOrder()
    end
    self:PersistPin()
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self.group)
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
    if self.isTracked then
        self:Untrack()
    end

    self.worldmapPin:HidePulse()
    self.minimapPin:HidePulse()
    self.worldmapPin.groupBadge:SetIcon(nil)
    self.minimapPin.groupBadge:SetIcon(nil)

    HBDP:RemoveMinimapIcon(MapPinEnhanced, self.minimapPin)
    HBDP:RemoveWorldMapIcon(MapPinEnhanced, self.worldmapPin)

    local framePool = Pins:GetFramePool()
    self.worldmapPin.pin = nil
    self.minimapPin.pin = nil
    framePool:Release(self.worldmapPin)
    framePool:Release(self.minimapPin)

    if self.pinData and self.pinData.mapID and self.pinData.x and self.pinData.y then
        MapPinEnhanced:DisableContinuousDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y)
    end

    self.group = nil
    self.pinData = nil
    self.worldmapPin = nil
    self.minimapPin = nil
    self.suppressChangePublication = nil
    self.suppressPersistence = nil
end

---@param group MapPinEnhancedGroupMixin?
MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function(_, group)
    if not group then return end
    for _, pin in group:EnumeratePins() do
        pin:UpdateGroupIcon()
    end
end)

function MapPinEnhancedPinMixin:PersistPin()
    if self.suppressChangePublication or self.suppressPersistence then return end
    if not self.group then return end
    Groups:PersistGroup(self.group)
end
