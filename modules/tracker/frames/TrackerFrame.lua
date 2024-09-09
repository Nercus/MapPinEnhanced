-- Template: file://./TrackerFrame.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
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

function MapPinEnhancedTrackerFrameMixin:RestoreVisibility()
    local trackerVisibility = SavedVars:Get("trackerVisible") --[[@as boolean]]
    if trackerVisibility == nil then
        trackerVisibility = SavedVars:GetDefault("trackerVisible") --[[@as boolean]]
    end
    if trackerVisibility then
        self:Open()
    else
        self:Close()
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
        self:SetView("Pins")
    end
    SavedVars:Save("trackerVisible", true)
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

function MapPinEnhancedTrackerFrameMixin:SetView(view, force)
    if not force and self.activeView and self.activeView.type == view then return end
    if self.activeView then
        self.activeView:Hide()
    end
    self.activeView = self:GetViewFrameForType(view)
    self.activeView:Show()
    self.activeView:Update()
end

function MapPinEnhancedTrackerFrameMixin:GetActiveView()
    if not self.activeView then return end
    return self.activeView.type
end

function MapPinEnhancedTrackerFrameMixin:OnMouseDown(button)
    if button ~= "LeftButton" then return end
    if not self.header:IsMouseOver() then return end
    local isLocked = SavedVars:Get("tracker", "lockTracker") --[[@as boolean]]
    if isLocked then
        Utils:Print("Tracker is locked. Unlock it in the options.")
        return
    end
    self:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

function MapPinEnhancedTrackerFrameMixin:OnMouseUp(button)
    if button ~= "LeftButton" then return end
    local _, _, _, left, top = self:GetPoint()
    self:StopMovingOrSizing()
    SavedVars:Save("trackerPosition", { x = left, y = top })
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left, top)
    SetCursor(nil)
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
