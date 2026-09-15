---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderOptionsNote : Frame
---@field text FontString

---@class MapPinEnhancedWayfinderOptionsDisplay : MapPinEnhancedOptionGroupTemplate
---@field beam MapPinEnhancedFormElementTemplate
---@field rotatePin MapPinEnhancedFormElementTemplate
---@field hideBlizzard MapPinEnhancedFormElementTemplate
---@field searchNote MapPinEnhancedWayfinderOptionsNote

---@class MapPinEnhancedOptionCategoryWayfinderTemplate : MapPinEnhancedOptionCategoryBaseTemplate
---@field display MapPinEnhancedWayfinderOptionsDisplay
---@field navigation MapPinEnhancedOptionGroupTemplate
---@field searchPresentation WayfinderSelection?
---@field unsubscribeSelection fun()?
---@field unsubscribeNavigation fun()?
---@field showNumber number?
MapPinEnhancedOptionCategoryWayfinderMixin = CreateFromMixins(MapPinEnhancedOptionCategoryBaseMixin)

local SELECTION_KEY = "Wayfinder.General.Selection"
local NAVIGATION_KEY = "Wayfinder.Navigation.Enable"
---@type table<string, WayfinderSelection>
local PRESENTATION_BY_OPTION = {
    ["Wayfinder.Floating.ShowBeam"] = "floating",
    ["Wayfinder.Arrow.RotatePin"] = "arrow",
    ["Wayfinder.General.HideBlizzardFloatingDiamond"] = "arrow",
}

function MapPinEnhancedOptionCategoryWayfinderMixin:RefreshDisplay()
    local selection = Options:GetOptionValue(SELECTION_KEY) --[[@as WayfinderSelection]]
    local display = self.display
    display.beam:SetShown(selection == "floating" or self.searchPresentation == "floating")
    local showArrow = selection == "arrow" or self.searchPresentation == "arrow"
    display.rotatePin:SetShown(showArrow)
    display.hideBlizzard:SetShown(showArrow)
    local note = display.searchNote
    note:SetShown(self.searchPresentation ~= nil and self.searchPresentation ~= selection)
    note.text:SetText(self.searchPresentation == "floating" and
        L["Settings for Floating; Arrow is still selected."] or
        L["Settings for Arrow; Floating is still selected."])
    note:SetWidth(math.max(1, display:GetWidth() - display.contentInsetX * 2))
    note:SetHeight(math.max(20, note.text:GetStringHeight()))
    if Options.frame then
        Options.frame:UpdateLayout()
    else
        self:LayoutChildren()
        self:UpdateHeight()
    end
end

---@param key string?
function MapPinEnhancedOptionCategoryWayfinderMixin:RevealOption(key)
    self.searchPresentation = key and PRESENTATION_BY_OPTION[key] or nil
    self:RefreshDisplay()
end

function MapPinEnhancedOptionCategoryWayfinderMixin:RefreshNavigation()
    local enabled = Options:GetOptionValue(NAVIGATION_KEY) == true
    Options:SetOptionEnabled("Wayfinder.Navigation.WorldMap", enabled)
    Options:SetOptionEnabled("Wayfinder.Navigation.Minimap", enabled)
    Options:SetOptionEnabled("Wayfinder.Navigation.TransportationGroups", enabled)
end

function MapPinEnhancedOptionCategoryWayfinderMixin:OnShow()
    self.showNumber = (self.showNumber or 0) + 1
    local showNumber = self.showNumber
    -- Startup subscriptions can deliver their initial value after this show ends.
    self.unsubscribeSelection = Options:SubscribeToOptionChanges(SELECTION_KEY, function()
        if self.showNumber ~= showNumber then return end
        self.searchPresentation = nil
        self:RefreshDisplay()
    end)
    self.unsubscribeNavigation = Options:SubscribeToOptionChanges(NAVIGATION_KEY, function()
        if self.showNumber ~= showNumber then return end
        self:RefreshNavigation()
    end)
    self:RefreshNavigation()
    self:RefreshDisplay()
end

function MapPinEnhancedOptionCategoryWayfinderMixin:OnHide()
    self.showNumber = (self.showNumber or 0) + 1
    if self.unsubscribeSelection then self.unsubscribeSelection() end
    if self.unsubscribeNavigation then self.unsubscribeNavigation() end
    self.unsubscribeSelection = nil
    self.unsubscribeNavigation = nil
    self.searchPresentation = nil
    self.display.searchNote:Hide()
end
