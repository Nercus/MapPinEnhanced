---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWindowMixin : Frame
---@field SetTitle function
---@field sideBar Frame
---@field versionText FontString
---@field body Frame
---@field setView viewObject<MapPinEnhancedWindowSetBodyMixin, MapPinEnhancedWindowSetSidebarMixin> | nil
---@field optionView viewObject<MapPinEnhancedWindowOptionBodyMixin, MapPinEnhancedWindowOptionSidebarMixin> | nil
MapPinEnhancedWindowMixin = {}

---@class viewObject<B, S>: {body: B, sideBar: S}

local L = MapPinEnhanced.L


local SavedVars = MapPinEnhanced:GetModule("SavedVars")

---@enum EditorViews
local AVAILABLE_VIEWS = {
    setView = "setView",
    optionView = "optionView",
}

-- TODO: rename the window to MapPinEnhancedMainFrame

-- TODO: move set view and editor view to sub modules in editor window
local viewConfigurations = {
    [AVAILABLE_VIEWS.setView] = function(self)
        if not self.setView then
            self.setView = {
                body = CreateFrame("Frame", nil, self.body, "MapPinEnhancedWindowSetBodyTemplate"),
                sideBar = CreateFrame("Frame", nil, self.sideBar, "MapPinEnhancedWindowSetSidebarTemplate"),
            }
            self.setView.sideBar.switchViewButton:SetScript("OnClick", function()
                self:SetActiveView(AVAILABLE_VIEWS.optionView)
            end)
            self.setView.sideBar.body = self.setView.body
            self.setView.body.sideBar = self.setView.sideBar
        end
        return self.setView, self.optionView
    end,
    [AVAILABLE_VIEWS.optionView] = function(self)
        if not self.optionView then
            self.optionView = {
                body = CreateFrame("Frame", nil, self.body, "MapPinEnhancedWindowOptionBodyTemplate"),
                sideBar = CreateFrame("Frame", nil, self.sideBar, "MapPinEnhancedWindowOptionSidebarTemplate"),
            }
            self.optionView.sideBar.body = self.optionView.body
            self.optionView.body.sideBar = self.optionView.sideBar
            self.optionView.sideBar.switchViewButton:SetScript("OnClick", function()
                self:SetActiveView(AVAILABLE_VIEWS.setView)
            end)
        end
        return self.optionView, self.setView
    end,
}


---@param viewToShow viewObject<MapPinEnhancedWindowSetBodyMixin, MapPinEnhancedWindowSetSidebarMixin> | viewObject<MapPinEnhancedWindowOptionBodyMixin, MapPinEnhancedWindowOptionSidebarMixin>   | nil
---@param viewToHide viewObject<MapPinEnhancedWindowSetBodyMixin, MapPinEnhancedWindowSetSidebarMixin> | viewObject<MapPinEnhancedWindowOptionBodyMixin, MapPinEnhancedWindowOptionSidebarMixin>   | nil
function MapPinEnhancedWindowMixin:ConfigureViewVisibility(viewToShow, viewToHide)
    if viewToHide then
        viewToHide.body:ClearAllPoints()
        viewToHide.body:Hide()
        viewToHide.sideBar:ClearAllPoints()
        viewToHide.sideBar:Hide()
    end
    if viewToShow then
        viewToShow.body:Show()
        viewToShow.body:SetAllPoints(self.body)
        viewToShow.sideBar:Show()
        viewToShow.sideBar:SetAllPoints(self.sideBar)
    end
end

---@param view EditorViews
function MapPinEnhancedWindowMixin:SetActiveView(view)
    if not view then return end
    if not viewConfigurations[view] then return end
    local viewToShow = viewConfigurations[view](self)
    ---@type EditorViews
    local inverseView = view == AVAILABLE_VIEWS.setView and AVAILABLE_VIEWS.optionView or
        AVAILABLE_VIEWS.setView
    local viewToHide = viewConfigurations[inverseView](self)
    self:ConfigureViewVisibility(viewToShow, viewToHide)
end

function MapPinEnhancedWindowMixin:AddOptions()
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterSlider({
        label = L["Editor Scale"],
        category = L["General"],
        min = 0.5,
        max = 2,
        step = 0.05,
        updateOnRelease = true,
        default = SavedVars:GetDefault("general", "editorScale") --[[@as number]],
        init = function() return SavedVars:Get("general", "editorScale") --[[@as number]] end,
        onChange = function(value)
            self:SetScale(value)
            SavedVars:Save("general", "editorScale", value)
        end
    })
end

function MapPinEnhancedWindowMixin:OnLoad()
    self:SetScript("OnMouseUp", function()
        self:StopMovingOrSizing()
    end)
    self:SetActiveView(AVAILABLE_VIEWS.setView)
    self.versionText:SetText(MapPinEnhanced.nameVersionString)
    self:AddOptions()
end

function MapPinEnhancedWindowMixin:Close()
    self:Hide()
end

function MapPinEnhancedWindowMixin:Open()
    self:Show()
    self:SetActiveView(AVAILABLE_VIEWS.setView)
end

function MapPinEnhancedWindowMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

---------------------------------------------------------------------------

---@class EditorWindow
local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")

---@param viewType EditorViews
function EditorWindow:SetView(viewType)
    if not self.editorWindow then
        self:Toggle()
    end
    self.editorWindow:SetActiveView(viewType)
end

function EditorWindow:Toggle()
    if not self.editorWindow then
        self:GetWindow()
        self.editorWindow:Open()
        return
    end
    if self.editorWindow:IsVisible() then
        self.editorWindow:Close()
    else
        self.editorWindow:Open()
    end
end

function EditorWindow:GetWindow()
    if not self.editorWindow then
        self.editorWindow = CreateFrame("Frame", "MapPinEnhancedEditorWindow", UIParent,
            "MapPinEnhancedWindowTemplate") --[[@as MapPinEnhancedWindowMixin]]
    end
    return self.editorWindow
end

function EditorWindow:StartMoving()
    if not self.editorWindow then
        return
    end
    self.editorWindow:StartMoving()
    SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
end

function EditorWindow:StopMovingOrSizing()
    if not self.editorWindow then
        return
    end
    self.editorWindow:StopMovingOrSizing()
    SetCursor(nil)
end

local SlashCommand = MapPinEnhanced:GetModule("SlashCommand")

SlashCommand:AddSlashCommand(L["Editor"]:lower(), function()
    EditorWindow:Toggle()
end, L["Toggle Editor"])

SlashCommand:AddSlashCommand(L["Options"]:lower(), function()
    EditorWindow:Toggle()
    EditorWindow:SetView("optionView")
end, L["Open Options"])