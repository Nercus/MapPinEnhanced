MPHMinimapPinMixin = {}

MPHMinimapPinMixin.textureTracked = "Waypoint-MapPin-Tracked"
MPHMinimapPinMixin.textureUntracked = "Waypoint-MapPin-Untracked"

function MPHMinimapPinMixin:Track()
    if type(self.textureTracked) == "string" then
        self.Icon:SetAtlas(self.textureTracked)
    else
        self.Icon:SetTexture(self.textureTracked)
    end
    self.Icon:SetAlpha(1)
end

function MPHMinimapPinMixin:Untrack()
    if (not self.textureUntracked) then
        self.Icon:SetAlpha(0.4)
    else
        if type(self.textureUntracked) == "string" then
            self.Icon:SetAtlas(self.textureUntracked)
        else
            self.Icon:SetTexture(self.textureUntracked)
        end
    end
end

function MPHMinimapPinMixin:OnLeave()
    GameTooltip:Hide()
end
