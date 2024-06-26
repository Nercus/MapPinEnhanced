---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerMixin : Frame
MapPinEnhancedTrackerMixin = {}

function MapPinEnhancedTrackerMixin:RestorePosition()
    local trackerPosition = MapPinEnhanced:GetVar("trackerPosition") ---@as table
    if trackerPosition then
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", trackerPosition.x, trackerPosition.y)
    else
        local defaultPosition = MapPinEnhanced:GetDefault("trackerPosition")
        if not defaultPosition then
            defaultPosition = {
                ["x"] = GetScreenWidth() / 2 - 200,
                ["y"] = GetScreenHeight() / 2 - 200
            }
        end
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", defaultPosition.x, defaultPosition.y)
    end
end

function MapPinEnhancedTrackerMixin:Close()
    self:Hide()
    MapPinEnhanced:SaveVar("trackerVisible", false)
end

function MapPinEnhancedTrackerMixin:Open()
    self:Show()
    MapPinEnhanced:SaveVar("trackerVisible", true)
end

function MapPinEnhancedTrackerMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

function MapPinEnhancedTrackerMixin:OnLoad()
    ---@type table<number, MapPinEnhancedTrackerEntryMixin>
    self.entries = {}
    self.entryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerEntryTemplate")
    self:RestorePosition()
end

function MapPinEnhancedTrackerMixin:OnMouseDown()
    self:StartMoving()
end

function MapPinEnhancedTrackerMixin:OnMouseUp()
    self:StopMovingOrSizing()
    local top = self:GetTop()
    local left = self:GetLeft()
    MapPinEnhanced:SaveVar("trackerPosition", { x = left, y = top })
end

function MapPinEnhancedTrackerMixin:UpdateEntries()
    local height = 30
    for i, entry in ipairs(self.entries) do
        entry:ClearAllPoints()
        if i == 1 then
            entry:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -20)
        else
            entry:SetPoint("TOPLEFT", self.entries[i - 1], "BOTTOMLEFT", 0, -5)
        end
        height = height + entry:GetHeight() + 5 --[[@as number]]
    end
    self:SetHeight(height)
end

---@param entries table<number, MapPinEnhancedTrackerEntryMixin>
function MapPinEnhancedTrackerMixin:AddMultipleEntries(entries)
    for _, entry in ipairs(entries) do
        table.insert(self.entries, entry)
        entry:SetParent(self)
        entry:Show()
    end
    self:UpdateEntries()
end

function MapPinEnhancedTrackerMixin:AddEntry(entry)
    table.insert(self.entries, entry)
    entry:SetParent(self)
    entry:Show()
    self:UpdateEntries()
end
