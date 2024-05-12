MPHMapPinMixin = {};


MPHMapPinMixin.textureTracked = "Waypoint-MapPin-Tracked"
MPHMapPinMixin.textureUntracked = "Waypoint-MapPin-Untracked"


function MPHMapPinMixin:Track()
    self.Icon:SetAtlas(self.textureTracked, true)
end

function MPHMapPinMixin:Untrack()
    self.Icon:SetAtlas(self.textureUntracked, true)
end
