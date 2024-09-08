-- Template: file://./TrackerFrame.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
local Tracker = MapPinEnhanced:GetModule("Tracker")
local SlashCommand = MapPinEnhanced:GetModule("SlashCommand")
local Events = MapPinEnhanced:GetModule("Events")
local Utils = MapPinEnhanced:GetModule("Utils")

---@class MapPinEnhancedTrackerScrollBar : Frame
---@field Update fun(self:MapPinEnhancedTrackerScrollBar)

---@class MapPinEnhancedTrackerScrollFrameChild : Frame
---@field importButton MousePropagatableButton
---@field importEditBox ScrollableTextarea
---@field cancelButton MousePropagatableButton

---@class MapPinEnhancedTrackerScrollFrame : ScrollFrame
---@field Child MapPinEnhancedTrackerScrollFrameChild
---@field SetPanExtent fun(self:MapPinEnhancedTrackerScrollFrame, extent:number)
---@field ScrollBar MapPinEnhancedTrackerScrollBar


---@class MapPinEnhancedTrackerHeader : Frame
---@field title FontString
---@field viewToggle MapPinEnhancedSquareButton
---@field editorToggle MapPinEnhancedSquareButton
---@field closebutton MapPinEnhancedSquareButton
---@field headerTexture Texture


---@alias TrackerView MapPinEnhancedTrackerPinViewTemplate | MapPinEnhancedTrackerSetViewTemplate | MapPinEnhancedTrackerExportViewTemplate | MapPinEnhancedTrackerImportViewTemplate

---@enum (key) TrackerViewType
local TRACKER_VIEW_TEMPLATES = {
    Pins = "MapPinEnhancedTrackerPinViewTemplate",
    Sets = "MapPinEnhancedTrackerSetViewTemplate",
    Export = "MapPinEnhancedTrackerExportViewTemplate",
    Import = "MapPinEnhancedTrackerImportViewTemplate"
}

---@class MapPinEnhancedTrackerFrameMixin : Frame
---@field scrollFrame MapPinEnhancedTrackerScrollFrame
---@field availableViews table<TrackerViewType, TrackerView>
---@field header MapPinEnhancedTrackerHeader
---@field blackBackground Texture
---@field showNumbering boolean?
MapPinEnhancedTrackerFrameMixin = {}
MapPinEnhancedTrackerFrameMixin.entries = {}

local L = MapPinEnhanced.L
local CONSTANTS = MapPinEnhanced.CONSTANTS

local ENTRY_GAP = 5
local DEFAULT_ENTRY_HEIGHT = 37
function MapPinEnhancedTrackerFrameMixin:RestorePosition()
    ---@type TrackerPosition?
    local trackerPosition = SavedVars:Get("trackerPosition") --[[@as TrackerPosition?]]
    if trackerPosition then
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", trackerPosition.x, trackerPosition.y)
    else
        local defaultPosition = SavedVars:GetDefault("trackerPosition")
        if not defaultPosition then
            defaultPosition = { x = GetScreenWidth() / 2 + 300, y = -(GetScreenHeight() / 2) }
        end
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", defaultPosition.x, defaultPosition.y)
        SavedVars:Save("trackerPosition", defaultPosition)
    end
end

function MapPinEnhancedTrackerFrameMixin:SetTrackerTitle(title)
    self.header.title:SetText(title)
end

function MapPinEnhancedTrackerFrameMixin:Close()
    if not self:IsShown() then return end
    self:Hide()
    SavedVars:Save("trackerVisible", false)
end

function MapPinEnhancedTrackerFrameMixin:Open()
    if self:IsShown() then return end
    self:Show()
    if not self.activeView or self.activeView.type ~= "Pin" then
        self:SetPinView(true)
    end
    SavedVars:Save("trackerVisible", true)
    self:UpdateEntriesPosition()
end

---@param view TrackerViewType
---@return TrackerView
function MapPinEnhancedTrackerFrameMixin:GetViewFrameForType(view)
    if not self.availableViews then
        self.availableViews = {}
    end
    if not self.availableViews[view] then
        self.availableViews[view] = CreateFrame("Frame", nil, self, TRACKER_VIEW_TEMPLATES[view]) --[[@as TrackerView]]
    end
    return self.availableViews[view]
end

function MapPinEnhancedTrackerFrameMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

-- function MapPinEnhancedTrackerFrameMixin:OnLoad()
--     self:RegisterEvent("PLAYER_ENTERING_WORLD")
--     self:RestorePosition()
--     self.scrollFrame:SetPanExtent(DEFAULT_ENTRY_HEIGHT + ENTRY_GAP)

--     self.header.viewToggle:SetScript("OnClick", function()
--         if self.activeView == "Pins" then
--             self:SetSetView()
--         else
--             self:SetPinView()
--         end
--     end)
--     -- set default view
--     self:SetPinView()

--     self.header.editorToggle:SetScript("OnClick", function()
--         local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")
--         EditorWindow:Toggle()
--     end)
--     self.scrollFrame.ScrollBar:SetAlpha(0)
--     self:AddOptions()
--     self.scrollFrame.Child.importButton:SetText(L["Temporary Import"])
--     self.scrollFrame.Child.cancelButton:SetText(L["Cancel"])
--     self.header.closebutton.tooltip = L["Close Tracker"]
--     self.header.editorToggle.tooltip = L["Toggle Editor"]
-- end

-- function MapPinEnhancedTrackerFrameMixin:GetEntryCount()
--     local currentView = self:GetActiveView()
--     if currentView == "Pins" then
--         return #self.entries
--     elseif currentView == "Sets" then
--         return #self.entries - 1
--     end
-- end

-- function MapPinEnhancedTrackerFrameMixin:OnMouseDown(button)
--     if button ~= "LeftButton" then return end
--     if not self.header:IsMouseOver() then return end
--     local isLocked = SavedVars:Get("tracker", "lockTracker") --[[@as boolean]]
--     if isLocked then
--         Utils:Print("Tracker is locked. Unlock it in the options.")
--         return
--     end
--     self:StartMoving()
--     SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
-- end

-- function MapPinEnhancedTrackerFrameMixin:OnMouseUp(button)
--     if button ~= "LeftButton" then return end
--     local _, _, _, left, top = self:GetPoint()
--     self:StopMovingOrSizing()
--     SavedVars:Save("trackerPosition", { x = left, y = top })
--     self:ClearAllPoints()
--     self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
--     SetCursor(nil)
-- end

-- ---@param scrollFrameHeight number?
-- function MapPinEnhancedTrackerFrameMixin:UpdateFrameHeight(scrollFrameHeight)
--     local headerHeight = self.header:GetHeight()
--     local newHeight = headerHeight + (scrollFrameHeight or 0)
--     if self:GetActiveView() == "Temporary Import" then
--         self:SetHeight(newHeight)
--         return
--     end
--     local maxEntryCount = SavedVars:Get("tracker", "trackerHeight")
--     if not maxEntryCount then
--         maxEntryCount = SavedVars:GetDefault("tracker", "trackerHeight")
--     end
--     local maxHeight = (DEFAULT_ENTRY_HEIGHT + ENTRY_GAP) * maxEntryCount + ENTRY_GAP + headerHeight
--     if newHeight > maxHeight then
--         newHeight = maxHeight
--     end
--     newHeight = Round(newHeight)
--     local currentHeight = self:GetHeight()
--     if currentHeight == newHeight then return end
--     self:SetHeight(newHeight)
--     self.scrollFrame.ScrollBar:Update()
-- end

-- function MapPinEnhancedTrackerFrameMixin:UpdateEntriesPosition()
--     if not self:IsVisible() then return end
--     local height = ENTRY_GAP
--     for i, entry in ipairs(self.entries) do
--         entry:ClearAllPoints()
--         entry:SetParent(self.scrollFrame.Child)
--         if i == 1 then
--             entry:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 35, -ENTRY_GAP)
--             entry:SetPoint("TOPRIGHT", self.scrollFrame.Child, "TOPRIGHT", 25, -ENTRY_GAP)
--         else
--             entry:SetPoint("TOPLEFT", self.entries[i - 1], "BOTTOMLEFT", 0, -ENTRY_GAP)
--             entry:SetPoint("TOPRIGHT", self.entries[i - 1], "BOTTOMRIGHT", 0, -ENTRY_GAP)
--         end
--         height = height + entry:GetHeight() + ENTRY_GAP --[[@as number]]
--         entry:Show()
--         if entry.SetEntryIndex then
--             entry:SetEntryIndex(i)
--         end
--     end
--     -- set the height of the scroll child so the scroll bar gets resized correctly
--     if height < 1 then
--         height = 1
--     end
--     self.scrollFrame.Child:SetHeight(height)
--     self:SetTrackerTitle(string.format("%s %s", L[self.activeView],
--         self:GetEntryCount() and string.format("(%d)", self:GetEntryCount()) or ""))
--     self:UpdateFrameHeight(height)
-- end

-- ---@param entry MapPinEnhancedTrackerSetEntryMixin | MapPinEnhancedTrackerPinEntryMixin
-- function MapPinEnhancedTrackerFrameMixin:AddEntry(entry)
--     table.insert(self.entries, entry)
--     -- REVIEW: might want to refactor this to avoid a update on all entry positions
--     self:UpdateEntriesPosition()
--     self:UpdateVisibility()
--     if self.activeView == 'Pins' then
--         self:UpdatePinNumberingVisibility()
--     end
-- end

-- function MapPinEnhancedTrackerFrameMixin:RemoveEntry(entry)
--     for i, e in ipairs(self.entries) do
--         if e == entry then
--             table.remove(self.entries, i)
--             entry:Hide()
--             entry:ClearAllPoints()
--             self:UpdateEntriesPosition()
--             break
--         end
--     end
--     self:UpdateVisibility()
-- end

-- function MapPinEnhancedTrackerFrameMixin:OnEnter()
--     self.scrollFrame.ScrollBar:SetAlpha(1)
--     self.header.closebutton:Show()
--     self.header.viewToggle:Show()
--     self.header.editorToggle:Show()
-- end

-- function MapPinEnhancedTrackerFrameMixin:OnLeave()
--     self.scrollFrame.ScrollBar:SetAlpha(0)
--     self.header.closebutton:Hide()
--     self.header.viewToggle:Hide()
--     self.header.editorToggle:Hide()
-- end

-- local function RestorePinTrackerVisibility()
--     local trackerVisibility = SavedVars:Get("trackerVisible") --[[@as boolean]]
--     if trackerVisibility == nil then
--         trackerVisibility = SavedVars:GetDefault("trackerVisible") --[[@as boolean]]
--     end
--     MapPinEnhanced:TogglePinTracker(trackerVisibility)
-- end

-- Events:RegisterEvent("PLAYER_ENTERING_WORLD", RestorePinTrackerVisibility)

-- ---------------------------------------------------------------------------

-- --- TODO: that should be on the tracker module
-- ---@param viewType TrackerView
-- function MapPinEnhanced:SetPinTrackerView(viewType)
--     if not self.pinTracker then
--         self:TogglePinTracker(true)
--     end
--     if viewType == "Temporary Import" then
--         self.pinTracker:SetImportView()
--         return
--     end
--     if viewType == "Pins" then
--         self.pinTracker:SetPinView()
--         return
--     end
--     if viewType == "Sets" then
--         self.pinTracker:SetSetView()
--         return
--     end
-- end

-- ---toggle the pin tracker
-- ---@param forceShow? boolean if true, the tracker will be shown, if false, the tracker will be hidden, if nil, the tracker will be toggled
-- function MapPinEnhanced:TogglePinTracker(forceShow)
--     -- if not self.pinTracker then
--     --     self.pinTracker = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerFrameTemplate") --[[@as MapPinEnhancedTrackerFrameMixin]]
--     -- end
--     -- if forceShow == true then
--     --     self.pinTracker:Open()
--     -- elseif forceShow == false then
--     --     self.pinTracker:Close()
--     -- else
--     --     self.pinTracker:Toggle()
--     -- end
-- end

-- SlashCommand:AddSlashCommand(L["Tracker"]:lower(), function()
--     MapPinEnhanced:TogglePinTracker()
-- end, L["Toggle Tracker"])

-- SlashCommand:AddSlashCommand(L["Import"]:lower(), function()
--     MapPinEnhanced:TogglePinTracker(true)
--     MapPinEnhanced:SetPinTrackerView("Temporary Import")
-- end, L["Import a Set"])

-- SlashCommand:AddSlashCommand(L["Clear"]:lower(), function()
--     local PinManager = MapPinEnhanced:GetModule("PinManager")
--     PinManager:ClearPins()
-- end, L["Clear All Pins"])
