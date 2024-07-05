---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedTrackerScrollFrame : ScrollFrame
---@field Child Frame
---@field SetPanExtent fun(self:MapPinEnhancedTrackerScrollFrame, extent:number)


---@class MapPinEnhancedTrackerMixin : Frame
---@field entries table<number, MapPinEnhancedTrackerPinEntryMixin>
---@field entryPool FramePool
---@field scrollFrame MapPinEnhancedTrackerScrollFrame
MapPinEnhancedTrackerMixin = {}



local ENTRY_GAP = 5
local ENTRY_HEIGHT = 40
function MapPinEnhancedTrackerMixin:RestorePosition()
    local trackerPosition = MapPinEnhanced:GetVar("trackerPosition") ---@as table
    if trackerPosition then
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", trackerPosition.x, trackerPosition.y)
    else
        local defaultPosition = MapPinEnhanced:GetDefault("trackerPosition")
        if not defaultPosition then
            defaultPosition = {
                ["x"] = (GetScreenWidth() / 2) - 200,
                ["y"] = (GetScreenHeight() / 2) - 200
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
    ---@type table<number, MapPinEnhancedTrackerPinEntryMixin>
    self.entries = {}
    self.entryPool = CreateFramePool("Button", nil, "MapPinEnhancedTrackerPinEntryTemplate")
    self:RestorePosition()
    self.scrollFrame:SetPanExtent(ENTRY_HEIGHT + ENTRY_GAP)
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
    local height = 0
    for i, entry in ipairs(self.entries) do
        entry:ClearAllPoints()
        if i == 1 then
            entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 0, 0)
        else
            entry:SetPoint("TOPLEFT", self.entries[i - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
        end
        height = height + ENTRY_HEIGHT + ENTRY_GAP --[[@as number]]
    end
    self.scrollFrame.Child:SetHeight(height)
end

---@param entries table<number, MapPinEnhancedTrackerPinEntryMixin>
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
    entry:SetParent(self.scrollFrame.Child)
    entry:Show()
    self:UpdateEntries()
end
