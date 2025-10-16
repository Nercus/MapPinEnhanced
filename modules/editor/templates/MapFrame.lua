---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedMapTemplate : Frame, MapCanvasMixin
MapPinEnhancedMapMixin = {}


local TEST_MAP_ID = 2274
function MapPinEnhancedMapMixin:OnLoad()
    MapCanvasMixin.OnLoad(self);
    -- self:SetShouldZoomInOnClick(true);
    -- self:SetShouldPanOnClick(true);

    MapPinEnhanced:Debug(self)
    self:Show()
    print("OnLoad")
end

function MapPinEnhancedMapMixin:OnShow()
    self:SetMapID(TEST_MAP_ID);
    MapCanvasMixin.OnShow(self);
    print("OnShow")
end

function MapPinEnhancedMapMixin:OnHide()
    MapCanvasMixin.OnHide(self);
    print("OnHide")
end

function MapPinEnhancedMapMixin:OnUpdate()
    MapCanvasMixin.OnUpdate(self);
    print("OnUpdate")
end

function MapPinEnhancedMapMixin:OnEvent(event, ...)
    MapCanvasMixin.OnEvent(self, event, ...);
    print("OnEvent", event, ...)
end
