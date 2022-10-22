MPHMapPinMixin = {};


function MPHMapPinMixin:Track()
    self.Icon:SetAtlas("Waypoint-MapPin-Tracked", true)
end

function MPHMapPinMixin:Untrack()
    self.Icon:SetAtlas("Waypoint-MapPin-Untracked", true)
end

function MPHMapPinMixin:OnLeave()
    GameTooltip:Hide()
end
