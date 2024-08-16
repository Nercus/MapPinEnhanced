-- Template: file://./EditorWindow.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedEditorWindowMixin : Frame
---@field SetTitle function
---@field sideBar Frame
---@field versionText FontString
---@field body Frame
---@field setView viewObject<MapPinEnhancedSetEditorViewBodyMixin, MapPinEnhancedSetEditorViewSidebarMixin> | nil
---@field optionView viewObject<MapPinEnhancedOptionEditorViewBodyMixin, MapPinEnhancedOptionEditorViewSidebarMixin> | nil
MapPinEnhancedEditorWindowMixin = {}

---@class viewObject<B, S>: {body: B, sideBar: S}

local L = MapPinEnhanced.L

---@enum EditorViews
local AVAILABLE_VIEWS = {
    setView = "setView",
    optionView = "optionView",
}

local viewConfigurations = {
    [AVAILABLE_VIEWS.setView] = function(self)
        if not self.setView then
            self.setView = {
                body = CreateFrame("Frame", nil, self.body, "MapPinEnhancedSetEditorViewBodyTemplate"),
                sideBar = CreateFrame("Frame", nil, self.sideBar, "MapPinEnhancedSetEditorViewSidebarTemplate"),
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
                body = CreateFrame("Frame", nil, self.body, "MapPinEnhancedOptionEditorViewBodyTemplate"),
                sideBar = CreateFrame("Frame", nil, self.sideBar, "MapPinEnhancedOptionEditorViewSidebarTemplate"),
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


---@param viewToShow viewObject<MapPinEnhancedSetEditorViewBodyMixin, MapPinEnhancedSetEditorViewSidebarMixin> | viewObject<MapPinEnhancedOptionEditorViewBodyMixin, MapPinEnhancedOptionEditorViewSidebarMixin>   | nil
---@param viewToHide viewObject<MapPinEnhancedSetEditorViewBodyMixin, MapPinEnhancedSetEditorViewSidebarMixin> | viewObject<MapPinEnhancedOptionEditorViewBodyMixin, MapPinEnhancedOptionEditorViewSidebarMixin>   | nil
function MapPinEnhancedEditorWindowMixin:ConfigureViewVisibility(viewToShow, viewToHide)
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
function MapPinEnhancedEditorWindowMixin:SetActiveView(view)
    if not view then return end
    if not viewConfigurations[view] then return end
    local viewToShow = viewConfigurations[view](self)
    ---@type EditorViews
    local inverseView = view == AVAILABLE_VIEWS.setView and AVAILABLE_VIEWS.optionView or
        AVAILABLE_VIEWS.setView
    local viewToHide = viewConfigurations[inverseView](self)
    self:ConfigureViewVisibility(viewToShow, viewToHide)
end

function MapPinEnhancedEditorWindowMixin:AddOptions()
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterSlider({
        label = L["Editor Scale"],
        category = L["General"],
        min = 0.5,
        max = 2,
        step = 0.05,
        default = MapPinEnhanced:GetDefault("general", "editorScale") --[[@as number]],
        init = function() return MapPinEnhanced:GetVar("general", "editorScale") --[[@as number]] end,
        onChange = function(value)
            self:SetScale(value)
            MapPinEnhanced:SaveVar("general", "editorScale", value)
        end
    })
end

function MapPinEnhancedEditorWindowMixin:OnLoad()
    self:SetScript("OnMouseUp", function()
        self:StopMovingOrSizing()
    end)
    self:SetActiveView(AVAILABLE_VIEWS.setView)
    self.versionText:SetText(MapPinEnhanced.nameVersionString)
    self:AddOptions()
end

function MapPinEnhancedEditorWindowMixin:Close()
    self:Hide()
end

function MapPinEnhancedEditorWindowMixin:Open()
    self:Show()
    self:SetActiveView(AVAILABLE_VIEWS.setView)
end

function MapPinEnhancedEditorWindowMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

---------------------------------------------------------------------------

---@param viewType EditorViews
function MapPinEnhanced:SetEditorView(viewType)
    if not self.editorWindow then
        self:ToggleEditorWindow()
    end
    self.editorWindow:SetActiveView(viewType)
end

function MapPinEnhanced:ToggleEditorWindow()
    if not self.editorWindow then
        self.editorWindow = CreateFrame("Frame", "MapPinEnhancedEditorWindow", UIParent,
            "MapPinEnhancedEditorWindowTemplate") --[[@as MapPinEnhancedEditorWindowMixin]]
        self.editorWindow:Open()
        return
    end
    if self.editorWindow:IsVisible() then
        self.editorWindow:Close()
    else
        self.editorWindow:Open()
    end
end

MapPinEnhanced:AddSlashCommand(L["Editor"]:lower(), function()
    MapPinEnhanced:ToggleEditorWindow()
end, L["Toggle Editor"])

MapPinEnhanced:AddSlashCommand(L["Options"]:lower(), function()
    MapPinEnhanced:ToggleEditorWindow()
    MapPinEnhanced:SetEditorView("optionView")
end, L["Open options"])
