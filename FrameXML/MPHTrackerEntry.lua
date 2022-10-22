MPHTrackerEntryMixin = {}


local tracked = false
function MPHTrackerEntryMixin:Track()
    tracked = true
    self.button.normal:SetAtlas("Waypoint-MapPin-Tracked")
    self.name:SetAlpha(1)
    self.info:SetAlpha(1)
end

function MPHTrackerEntryMixin:Untrack()
    tracked = false
    self.button.normal:SetAtlas("Waypoint-MapPin-Untracked")
    self.name:SetAlpha(0.7)
    self.info:SetAlpha(0.7)
end

function MPHTrackerEntryMixin:OnEnter()
    self.highlightBorder:Show()
    self.name:SetAlpha(1)
    self.info:SetAlpha(1)
    self.navStart:Show()
    self.button.highlight:Show()
    if (tracked) then
        self.highlightBorder:SetAlpha(1)
    else
        self.highlightBorder:SetAlpha(0.4)
    end
end

function MPHTrackerEntryMixin:OnLeave()
    if not self.navStart:IsMouseOver() then
        self.navStart:Hide()
        self.highlightBorder:Hide()
        self.button.highlight:Hide()
        if (not tracked) then
            self.name:SetAlpha(0.7)
            self.info:SetAlpha(0.7)
        end
    end
end

function MPHTrackerEntryMixin:SetTitle(title)
    self.name:SetText(title)
    self.name:Show()
end
