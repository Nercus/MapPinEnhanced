MPHMinimapPinMixin = {}


function MPHMinimapPinMixin:Track()
    self.Icon:SetAtlas("Waypoint-MapPin-Tracked")
end

function MPHMinimapPinMixin:Untrack()
    self.Icon:SetAtlas("Waypoint-MapPin-Untracked")
end

function MPHMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
