---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
---@field worldmapPin MapPinEnhancedWorldmapPinTemplate
---@field minimapPin MapPinEnhancedMinimapPinTemplate
---@field pinData pinData
---@field isTracked boolean? -- whether this pin is currently tracked
---@field pinID UUID
---@field group MapPinEnhancedPinGroupMixin? -- the group this pin belongs to, if any
MapPinEnhancedPinMixin = CreateFromMixins(
    MapPinEnhancedPinTrackingMixin,
    MapPinEnhancedPinMenuMixin,
    MapPinEnhancedPinMouseDownMixin,
    MapPinEnhancedPinColorMixin,
    MapPinEnhancedPinUtilsMixin
)

local HBDP = MapPinEnhanced.HBDP


---@type FramePool<MapPinEnhancedWorldmapPinTemplate>
local WorldmapPool = CreateFramePool("Button", nil, "MapPinEnhancedWorldmapPinTemplate")
---@type FramePool<MapPinEnhancedMinimapPinTemplate>
local MinimapPool = CreateFramePool("Frame", nil, "MapPinEnhancedMinimapPinTemplate")
-- local SuperTrackedPinPool = CreateFramePool("Frame", nil, "MapPinEnhancedSuperTrackedPinTemplate")

function MapPinEnhancedPinMixin:Init(pinID)
    self.pinID = pinID

    self.worldmapPin = WorldmapPool:Acquire()
    self.minimapPin = MinimapPool:Acquire()

    self.worldmapPin:SetPinID(pinID)
    self.minimapPin:SetPinID(pinID)

    self.worldmapPin:SetScript("OnMouseDown", function(_, button)
        self:OnMouseDown(_, button)
    end)
end

---@param pinData pinData
function MapPinEnhancedPinMixin:SetPinData(pinData)
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

    self:SetPinColor(self.pinData.color)
    self:SetPinIcon(self.pinData.texture, self.pinData.usesAtlas)

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

function MapPinEnhancedPinMixin:GetSavableData()
    local pinDataToSave = self:GetPinData()
    pinDataToSave.setTracked = self:IsTracked()
    return pinDataToSave
end

function MapPinEnhancedPinMixin:Reset()
    -- untrack first to clear the pin
    self:Untrack()

    -- remove from world and minimap
    HBDP:RemoveMinimapIcon(MapPinEnhanced, self.minimapPin)
    HBDP:RemoveWorldMapIcon(MapPinEnhanced, self.worldmapPin)
end
