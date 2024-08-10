-- Template: file://./TrackerFrame.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerScrollBar : Frame
---@field Update fun(self:MapPinEnhancedTrackerScrollBar)

---@class MapPinEnhancedTrackerScrollFrame : ScrollFrame
---@field Child Frame
---@field SetPanExtent fun(self:MapPinEnhancedTrackerScrollFrame, extent:number)
---@field ScrollBar MapPinEnhancedTrackerScrollBar


---@class MapPinEnhancedTrackerHeader : Frame
---@field title FontString
---@field viewToggle Button
---@field editorToggle Button
---@field closebutton Button
---@field headerTexture Texture


---@alias TrackerView 'Pins' | 'Sets' | 'Import'

---@class MapPinEnhancedTrackerFrameMixin : Frame
---@field entries table<number, MapPinEnhancedTrackerSetEntryMixin> | table<number, MapPinEnhancedTrackerPinEntryMixin>
---@field scrollFrame MapPinEnhancedTrackerScrollFrame
---@field activeView TrackerView
---@field header MapPinEnhancedTrackerHeader
---@field importButton MousePropagatableButton
---@field importEditBox ScrollableTextarea
---@field cancelButton MousePropagatableButton
MapPinEnhancedTrackerFrameMixin = {}
MapPinEnhancedTrackerFrameMixin.entries = {}



local ENTRY_GAP = 5
local DEFAULT_ENTRY_HEIGHT = 37
function MapPinEnhancedTrackerFrameMixin:RestorePosition()
    local trackerPosition = MapPinEnhanced:GetVar("trackerPosition") ---@as table
    if trackerPosition then
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", trackerPosition.x, trackerPosition.y)
    else
        local defaultPosition = MapPinEnhanced:GetDefault("trackerPosition")
        if not defaultPosition then
            defaultPosition = {
                ["x"] = (GetScreenWidth() / 2) - self:GetWidth() / 2,
                ["y"] = -(GetScreenHeight() / 2) - self:GetHeight() / 2
            }
        end
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", defaultPosition.x, defaultPosition.y)
        MapPinEnhanced:SaveVar("trackerPosition", defaultPosition)
    end
end

function MapPinEnhancedTrackerFrameMixin:SetTrackerTitle(title)
    self.header.title:SetText(title)
end

function MapPinEnhancedTrackerFrameMixin:ClearEntries()
    for _, entry in ipairs(self.entries) do
        entry:Hide()
        entry:ClearAllPoints()
        entry:SetParent(nil)
    end
    self.entries = {}
end

function MapPinEnhancedTrackerFrameMixin:GetActiveView()
    return self.activeView
end

---comment
---@param viewType TrackerView
---@param forceUpdate? boolean
function MapPinEnhancedTrackerFrameMixin:SetActiveView(viewType, forceUpdate)
    if self.activeView == viewType and not forceUpdate then
        return
    end
    self:ClearEntries()
    if viewType == "Pins" then
        MapPinEnhanced.UnregisterCallback(self, 'UpdateSetList')
        ---@class PinManager : Module
        local PinManager = MapPinEnhanced:GetModule("PinManager")
        local pins = PinManager:GetPins()
        ---@type number
        for _, pin in pairs(pins) do
            table.insert(self.entries, pin.trackerPinEntry)
        end
    elseif viewType == "Sets" then
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        if not self.importButton then
            self.importButton = CreateFrame("Button", nil, self.scrollFrame.Child,
                "MapPinEnhancedButtonYellowTemplate") --[[@as MousePropagatableButton]]
            self.importButton:SetSize(300, 30)
            self.importButton:SetText("Import")
            self.importButton:SetPropagateMouseMotion(true)
        end
        self.importButton:Enable()
        self.importButton:SetScript("OnClick", function()
            self:SetActiveView("Import")
        end)
        table.insert(self.entries, self.importButton)
        local sets = SetManager:GetSets() ---@type table<string, SetObject | Button>
        --MapPinEnhanced.SetManager:GetAllSetEntries()
        for _, set in pairs(sets) do
            table.insert(self.entries, set.trackerSetEntry)
        end
        MapPinEnhanced.RegisterCallback(self, 'UpdateSetList', function()
            if self.activeView ~= "Sets" then return end
            self:SetActiveView(self.activeView, true)
        end)
    elseif viewType == "Import" then
        -- TODO: implement import view
        -- take the max height from the set option and create two entry elements
        -- 1. a text box for the import string and scroll frame
        -- 2. a button to import the string
        -- 3. a button to cancel and go back to sets
        if not self.cancelButton then
            self.cancelButton = CreateFrame("Button", nil, self.scrollFrame.Child,
                "MapPinEnhancedButtonRedTemplate") --[[@as MousePropagatableButton]]
            self.cancelButton:SetSize(300, 30)
            self.cancelButton:SetText("Cancel")
            self.cancelButton:SetScript("OnClick", function()
                self:SetActiveView("Sets")
            end)
            self.cancelButton:SetPropagateMouseMotion(true)
        end
        table.insert(self.entries, self.cancelButton)
        if not self.importEditBox then
            self.importEditBox = CreateFrame("ScrollFrame", nil, self.scrollFrame.Child,
                "MapPinEnhancedScrollableTextareaTemplate") --[[@as ScrollableTextarea]]
            self.importEditBox:SetSize(300, 300)
        end
        table.insert(self.entries, self.importEditBox)

        self.importEditBox.editBox:SetScript("OnTextChanged", function()
            local text = self.importEditBox.editBox:GetText()
            if text and text ~= "" then
                self.importButton:Enable()
            else
                self.importButton:Disable()
            end
        end)

        if not self.importButton then
            self.importButton = CreateFrame("Button", nil, self.scrollFrame.Child,
                "MapPinEnhancedButtonYellowTemplate") --[[@as MousePropagatableButton]]
            self.importButton:SetSize(300, 30)
            self.importButton:SetText("Import")
            self.importButton:SetPropagateMouseMotion(true)
        end
        self.importButton:SetScript("OnClick", function()
            local PinProvider = MapPinEnhanced:GetModule("PinProvider")
            local wayString = self.importEditBox.editBox:GetText()
            PinProvider:ImportFromWayString(wayString)
            self:SetActiveView("Pins")
        end)
        table.insert(self.entries, self.importButton)
    end
    self.activeView = viewType
    self:UpdateEntriesPosition()
end

function MapPinEnhancedTrackerFrameMixin:Close()
    self:Hide()
    MapPinEnhanced:SaveVar("trackerVisible", false)
end

function MapPinEnhancedTrackerFrameMixin:Open()
    self:Show()
    MapPinEnhanced:SaveVar("trackerVisible", true)
end

function MapPinEnhancedTrackerFrameMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

function MapPinEnhancedTrackerFrameMixin:OnLoad()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RestorePosition()
    self.scrollFrame:SetPanExtent(DEFAULT_ENTRY_HEIGHT + ENTRY_GAP)

    self.header.viewToggle:SetScript("OnClick", function()
        if self.activeView == "Pins" then
            self:SetActiveView("Sets")
        else
            self:SetActiveView("Pins")
        end
    end)
    -- set default view
    self:SetActiveView("Pins")

    self.header.editorToggle:SetScript("OnClick", function()
        MapPinEnhanced:ToggleEditorWindow()
    end)
    self.scrollFrame.ScrollBar:SetAlpha(0)
end

function MapPinEnhancedTrackerFrameMixin:GetEntryCount()
    local currentView = self:GetActiveView()
    if currentView == "Pins" then
        return #self.entries
    elseif currentView == "Sets" then
        return #self.entries - 1
    end
end

function MapPinEnhancedTrackerFrameMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    if not self.header.title:IsMouseOver() then return end
    self:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

function MapPinEnhancedTrackerFrameMixin:OnMouseUp()
    self:StopMovingOrSizing()
    local left, top = self:GetLeft(), self:GetTop()
    top = top - GetScreenHeight() -- relative from bottom left
    MapPinEnhanced:SaveVar("trackerPosition", { x = left, y = top })
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    SetCursor(nil)
end

local MAX_HEIGHT = 500
---@param scrollFrameHeight number
function MapPinEnhancedTrackerFrameMixin:UpdateFrameHeight(scrollFrameHeight)
    local headerHeight = self.header:GetHeight()
    local newHeight = scrollFrameHeight + headerHeight
    if newHeight > MAX_HEIGHT then
        newHeight = MAX_HEIGHT
    end
    self:SetHeight(newHeight)
    self.scrollFrame.ScrollBar:Update()
end

function MapPinEnhancedTrackerFrameMixin:UpdateEntriesPosition()
    if not self:IsVisible() then return end
    local height = ENTRY_GAP
    for i, entry in ipairs(self.entries) do
        entry:ClearAllPoints()
        entry:SetParent(self.scrollFrame.Child)
        if i == 1 then
            entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 30, -ENTRY_GAP)
        else
            entry:SetPoint("TOPLEFT", self.entries[i - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
        end
        height = height + entry:GetHeight() + ENTRY_GAP --[[@as number]]
        entry:Show()
        if entry.SetEntryIndex then
            entry:SetEntryIndex(i)
        end
    end
    -- set the height of the scroll child so the scroll bar gets resized correctly
    if height < 1 then
        height = 1
    end
    self.scrollFrame.Child:SetHeight(height)
    self:SetTrackerTitle(string.format("%s %s", self.activeView,
        self:GetEntryCount() and string.format("(%d)", self:GetEntryCount()) or ""))
    self:UpdateFrameHeight(height)
end

---@param entry MapPinEnhancedTrackerSetEntryMixin | MapPinEnhancedTrackerPinEntryMixin
function MapPinEnhancedTrackerFrameMixin:AddEntry(entry)
    table.insert(self.entries, entry)
    local scollChildHeight = self.scrollFrame.Child:GetHeight()
    entry:ClearAllPoints()
    if #self.entries == 1 then
        entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 20, -ENTRY_GAP)
    else
        entry:SetPoint("TOPLEFT", self.entries[#self.entries - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
    end
    entry:SetParent(self.scrollFrame.Child)
    entry:Show()
    local newHeight = scollChildHeight + entry:GetHeight() + ENTRY_GAP
    self.scrollFrame.Child:SetHeight(newHeight)
    self:SetTrackerTitle(string.format("%s (%d)", self.activeView, self:GetEntryCount()))
    self:UpdateFrameHeight(newHeight)
    if entry.SetEntryIndex then
        entry:SetEntryIndex(#self.entries)
    end
end

function MapPinEnhancedTrackerFrameMixin:RemoveEntry(entry)
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

function MapPinEnhancedTrackerFrameMixin:OnEnter()
    self.scrollFrame.ScrollBar:SetAlpha(1)
    self.header.closebutton:Show()
    self.header.viewToggle:Show()
    self.header.editorToggle:Show()
end

function MapPinEnhancedTrackerFrameMixin:OnLeave()
    self.scrollFrame.ScrollBar:SetAlpha(0)
    self.header.closebutton:Hide()
    self.header.viewToggle:Hide()
    self.header.editorToggle:Hide()
end

local function RestorePinTrackerVisibility()
    local trackerVisibility = MapPinEnhanced:GetVar("trackerVisible") --[[@as boolean]]
    if trackerVisibility == nil then
        trackerVisibility = MapPinEnhanced:GetDefault("trackerVisible") --[[@as boolean]]
    end
    MapPinEnhanced:TogglePinTracker(trackerVisibility)
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", RestorePinTrackerVisibility)
