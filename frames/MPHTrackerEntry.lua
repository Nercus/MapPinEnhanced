MPHTrackerEntryMixin = {}

MPHTrackerEntryMixin.textureTracked = "Waypoint-MapPin-Tracked"
MPHTrackerEntryMixin.textureUntracked = "Waypoint-MapPin-Untracked"




function MPHTrackerEntryMixin:Track()
    if type(self.textureTracked) == "string" then
        self.button.normal:SetAtlas(self.textureTracked)
    else
        self.button.normal:SetTexture(self.textureTracked)
    end
    self.button.normal:SetAlpha(1)
    self.name:SetAlpha(1)
    self.index:SetAlpha(1)
    self.info:SetAlpha(1)
    self.distance:Show()
end

function MPHTrackerEntryMixin:Untrack()
    if (not self.textureUntracked) then
        self.button.normal:SetAlpha(0.4)
    else
        if type(self.textureUntracked) == "string" then
            self.button.normal:SetAtlas(self.textureUntracked)
        else
            self.button.normal:SetTexture(self.textureUntracked)
        end
    end
    self.name:SetAlpha(0.4)
    self.index:SetAlpha(0.4)
    self.info:SetAlpha(0.4)
    self.distance:Hide()
end

function MPHTrackerEntryMixin:OnEnter(tracked, title, description)
    self.highlightBorder:Show()
    self.name:SetAlpha(1)
    self.index:SetAlpha(1)
    self.info:SetAlpha(1)
    --self.navStart:Show()
    self.button.highlight:Show()
    if (tracked) then
        self.highlightBorder:SetAlpha(1)
    else
        self.highlightBorder:SetAlpha(0.4)
    end
    GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)

    local name = self.name:GetText()
    if title then
        name = title
    end
    local info = self.info:GetText()
    local texture = (tracked and self.textureTracked) or (self.textureUntracked or self.textureTracked)
    if name then
        local escapedTexture = type(texture) == "string" and "|A:" .. texture .. ":19:19|a " or
            "|T" .. texture .. ":19:19|t "
        name = escapedTexture .. name
        GameTooltip:AddLine(name, 1, 0.82, 0, true)
    end
    if info then
        GameTooltip:AddLine(info, 1, 1, 1, true)
    end

    if description then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(description, 1, 0.82, 0, true)
    end

    GameTooltip:Show()
end

function MPHTrackerEntryMixin:OnLeave(tracked)
    -- if not self.navStart:IsMouseOver() then
    -- self.navStart:Hide()
    self.highlightBorder:Hide()
    self.button.highlight:Hide()
    if (not tracked) then
        self.name:SetAlpha(0.4)
        self.index:SetAlpha(0.4)
        self.info:SetAlpha(0.4)
    end
    -- end
    GameTooltip:Hide()
end

function MPHTrackerEntryMixin:SetTitle(title)
    self.name:SetText(title)
    self.name:Show()
end

function MPHTrackerEntryMixin:SetIndex(i)
    self.index:SetText(i)
end
