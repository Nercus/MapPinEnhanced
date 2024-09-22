-- Template: file://./TrackerFrame.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
local Utils = MapPinEnhanced:GetModule("Utils")


---@enum (key) TrackerViewType
local TRACKER_VIEW_TEMPLATES = {
    Pins = { frameType = "ScrollFrame", template = "MapPinEnhancedTrackerPinViewTemplate" },
    Sets = { frameType = "ScrollFrame", template = "MapPinEnhancedTrackerSetViewTemplate" },
    Export = { frameType = "Frame", template = "MapPinEnhancedTrackerExportViewTemplate" },
    Import = { frameType = "Frame", template = "MapPinEnhancedTrackerImportViewTemplate" }
}

---@alias TrackerView  MapPinEnhancedTrackerPinViewTemplate | MapPinEnhancedTrackerSetViewTemplate | MapPinEnhancedTrackerExportViewTemplate | MapPinEnhancedTrackerImportViewTemplate

---@class MapPinEnhancedTrackerFrame : Frame
---@field header MapPinEnhancedTrackerFrameHeader
---@field frameHolder Frame
---@field blackBackground Texture
---@field availableViews table<TrackerViewType, TrackerView>
MapPinEnhancedTrackerFrameMixin = {}

function MapPinEnhancedTrackerFrameMixin:UpdateHeight()
    if self.activeView then
        local viewHeight = self.activeView:GetViewHeight()
        self.frameHolder:SetHeight(viewHeight)
        self.activeView:UpdateHeight()
    end
    local header = self.header:GetHeight()
    local frameHolder = self.frameHolder:GetHeight()
    local height = header + frameHolder
    self:SetHeight(height)
end

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
    self.header:SetTitle(title)
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

function MapPinEnhancedTrackerFrameMixin:GetViewFrameForType(view)
    if not self.availableViews then
        self.availableViews = {}
    end
    if not self.availableViews[view] then
        local template = TRACKER_VIEW_TEMPLATES[view]
        self.availableViews[view] = CreateFrame(template.frameType, nil, self, template.template) --[[@as TrackerView]]
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
    if self.activeView and self.activeView.type == view and (not force) then return end
    if self.activeView then
        self.activeView:Hide()
    end
    self.activeView = self:GetViewFrameForType(view)
    MapPinEnhanced:Debug(self.activeView)
    self.activeView:SetPoint("TOPLEFT", self.frameHolder, "TOPLEFT", 10, 0)
    self.activeView:SetPoint("BOTTOMRIGHT", self.frameHolder, "BOTTOMRIGHT", -5, 0)
    self.activeView:Show()
    self.activeView:Update()
    self:UpdateHeight()
end

---@return TrackerViewType?
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
    if self.activeView and self.activeView.ScrollBar then
        self.activeView.ScrollBar:SetAlpha(1)
    end
    self.header.closebutton:Show()
    self.header.viewToggle:Show()
    self.header.editorToggle:Show()
end

function MapPinEnhancedTrackerFrameMixin:OnLeave()
    -- if self.activeView and self.activeView.ScrollBar then
    --     self.activeView.ScrollBar:SetAlpha(0)
    -- end
    -- self.header.closebutton:Hide()
    -- self.header.viewToggle:Hide()
    -- self.header.editorToggle:Hide()
end
