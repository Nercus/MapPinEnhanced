---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedEditorWindowMixin : Frame
---@field SetTitle function
---@field sideBar Frame
---@field body Frame
---@field setView viewObject<MapPinEnhancedSetEditorViewBodyMixin, MapPinEnhancedSetEditorViewSidebarMixin> | nil
---@field optionView viewObject<MapPinEnhancedOptionEditorViewBodyMixin, MapPinEnhancedOptionEditorViewSidebarMixin> | nil
MapPinEnhancedEditorWindowMixin = {}

---@class viewObject<B, S>: {body: B, sideBar: S}

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
        end
        return self.setView, self.optionView
    end,
    [AVAILABLE_VIEWS.optionView] = function(self)
        if not self.optionView then
            self.optionView = {
                body = CreateFrame("Frame", nil, self.body, "MapPinEnhancedOptionEditorViewBodyTemplate"),
                sideBar = CreateFrame("Frame", nil, self.sideBar, "MapPinEnhancedOptionEditorViewSidebarTemplate"),
            }
            self.optionView.sideBar.switchViewButton:SetScript("OnClick", function()
                self:SetActiveView(AVAILABLE_VIEWS.setView)
            end)
        end
        return self.optionView, self.setView
    end,
}




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

function MapPinEnhancedEditorWindowMixin:OnLoad()
    self:SetScript("OnMouseDown", function()
        if (not self:IsMovable()) then
            return
        end
        -- TODO: use header here to move window
        -- if (not self.TitleContainer:IsMouseOver()) then
        --     return
        -- end
        self:StartMoving()
    end)

    self:SetScript("OnMouseUp", function()
        self:StopMovingOrSizing()
    end)
    self:SetActiveView(AVAILABLE_VIEWS.setView)
end

function MapPinEnhancedEditorWindowMixin:Close()
    self:Hide()
end

function MapPinEnhancedEditorWindowMixin:Open()
    self:Show()
end

function MapPinEnhancedEditorWindowMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end
