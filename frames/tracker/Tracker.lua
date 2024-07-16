---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollFrame : ScrollFrame
---@field Child Frame
---@field SetPanExtent fun(self:MapPinEnhancedTrackerScrollFrame, extent:number)

---@alias TrackerView 'Pins' | 'Sets'

---@class MapPinEnhancedTrackerMixin : Frame
---@field title FontString
---@field entries table<number, MapPinEnhancedTrackerSetEntryMixin> | table<number, MapPinEnhancedTrackerPinEntryMixin>
---@field scrollFrame MapPinEnhancedTrackerScrollFrame
---@field activeView TrackerView
---@field viewToggle Button
---@field editorToggle Button
MapPinEnhancedTrackerMixin = {}
MapPinEnhancedTrackerMixin.entries = {}


local ENTRY_GAP = 5
local ENTRY_HEIGHT = 37
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

function MapPinEnhancedTrackerMixin:SetTrackerTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerMixin:ClearEntries()
    for _, entry in ipairs(self.entries) do
        entry:Hide()
        entry:ClearAllPoints()
        entry:SetParent(nil)
    end
    self.entries = {}
end

function MapPinEnhancedTrackerMixin:GetActiveView()
    return self.activeView
end

---comment
---@param viewType TrackerView
function MapPinEnhancedTrackerMixin:SetActiveView(viewType)
    if self.activeView == viewType then
        return
    end
    self:ClearEntries()
    if viewType == "Pins" then
        ---@class PinManager : Module
        local PinManager = MapPinEnhanced:GetModule("PinManager")
        local pins = PinManager:GetPins()
        ---@type number
        for _, pin in pairs(pins) do
            table.insert(self.entries, pin.TrackerPinEntry)
        end
    elseif viewType == "Sets" then
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        if not self.importButton then
            self.importButton = CreateFrame("Button", nil, self.scrollFrame.Child,
                "MapPinEnhancedTrackerTextImportButtonTemplate")
        end
        local sets = SetManager:GetSets() ---@type table<string, SetObject | MapPinEnhancedTrackerTextImportButtonMixin>
        table.insert(self.entries, self.importButton)
        --MapPinEnhanced.SetManager:GetAllSetEntries()
        for _, set in pairs(sets) do
            table.insert(self.entries, set.TrackerSetEntry)
        end
    end
    self.activeView = viewType
    self:UpdateEntriesPosition()
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
    self:RestorePosition()
    self.scrollFrame:SetPanExtent(ENTRY_HEIGHT + ENTRY_GAP)

    self.viewToggle:SetScript("OnClick", function()
        if self.activeView == "Pins" then
            self:SetActiveView("Sets")
        else
            self:SetActiveView("Pins")
        end
    end)
    -- set default view
    self:SetActiveView("Pins")

    self.editorToggle:SetScript("OnClick", function()
        MapPinEnhanced:ToggleEditorWindow()
    end)
end

function MapPinEnhancedTrackerMixin:GetEntryCount()
    local currentView = self:GetActiveView()
    if currentView == "Pins" then
        return #self.entries
    elseif currentView == "Sets" then
        return #self.entries - 1
    end
end

function MapPinEnhancedTrackerMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    if not self.title:IsMouseOver() then return end
    self:StartMoving()
end

function MapPinEnhancedTrackerMixin:OnMouseUp()
    self:StopMovingOrSizing()
    local top = self:GetTop()
    local left = self:GetLeft()
    MapPinEnhanced:SaveVar("trackerPosition", { x = left, y = top })
end

function MapPinEnhancedTrackerMixin:UpdateEntriesPosition()
    local height = 0
    for i, entry in ipairs(self.entries) do
        entry:ClearAllPoints()
        entry:SetParent(self.scrollFrame.Child)
        if i == 1 then
            entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 0, 0)
        else
            entry:SetPoint("TOPLEFT", self.entries[i - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
        end
        height = height + ENTRY_HEIGHT + ENTRY_GAP --[[@as number]]
        entry:Show()
    end
    -- set the height of the scroll child so the scroll bar gets resized correctly
    if height < 1 then
        height = 1
    end
    self.scrollFrame.Child:SetHeight(height)
    self:SetTrackerTitle(string.format("%s (%d)", self.activeView, self:GetEntryCount()))
end

---@param entry Frame
function MapPinEnhancedTrackerMixin:AddEntry(entry)
    table.insert(self.entries, entry)
    local scollChildHeight = self.scrollFrame.Child:GetHeight()
    entry:ClearAllPoints()
    if #self.entries == 1 then
        entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 0, 0)
    else
        entry:SetPoint("TOPLEFT", self.entries[#self.entries - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
    end
    entry:SetParent(self.scrollFrame.Child)
    entry:Show()
    self.scrollFrame.Child:SetHeight(scollChildHeight + ENTRY_HEIGHT + ENTRY_GAP)
    self:SetTrackerTitle(string.format("%s (%d)", self.activeView, self:GetEntryCount()))
end

function MapPinEnhancedTrackerMixin:RemoveEntry(entry)
    for i, e in ipairs(self.entries) do
        if e == entry then
            table.remove(self.entries, i)
            entry:Hide()
            entry:ClearAllPoints()
            self:UpdateEntriesPosition()
            return
        end
    end
end

local function RestorePinTrackerVisibility()
    local trackerVisibility = MapPinEnhanced:GetVar("trackerVisible") --[[@as boolean]]
    if trackerVisibility == nil then
        trackerVisibility = MapPinEnhanced:GetDefault("trackerVisible") --[[@as boolean]]
    end
    MapPinEnhanced:TogglePinTracker(trackerVisibility)
end


MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    RestorePinTrackerVisibility()
end)
