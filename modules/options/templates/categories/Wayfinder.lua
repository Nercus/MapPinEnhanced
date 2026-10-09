---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderOptionsNote : Frame
---@field text FontString

---@class MapPinEnhancedWayfinderOptionsDisplay : MapPinEnhancedOptionGroupTemplate
---@field beam MapPinEnhancedFormElementTemplate
---@field textOutline MapPinEnhancedFormElementTemplate
---@field hideBlizzard MapPinEnhancedFormElementTemplate
---@field searchNote MapPinEnhancedWayfinderOptionsNote

---@class MapPinEnhancedOptionCategoryWayfinderTemplate : MapPinEnhancedOptionCategoryBaseTemplate
---@field display MapPinEnhancedWayfinderOptionsDisplay
---@field searchPresentation WayfinderSelection?
---@field unsubscribeSelection fun()?
---@field showNumber number?
MapPinEnhancedOptionCategoryWayfinderMixin = CreateFromMixins(MapPinEnhancedOptionCategoryBaseMixin)

local SELECTION_KEY = "Wayfinder.General.Selection"
---@type table<string, WayfinderSelection>
local PRESENTATION_BY_OPTION = {
    ["Wayfinder.Floating.ShowBeam"] = "floating",
    ["Wayfinder.Floating.ShowTextOutline"] = "floating",
    ["Wayfinder.General.HideBlizzardFloatingDiamond"] = "arrow",
}

function MapPinEnhancedOptionCategoryWayfinderMixin:RefreshDisplay()
    local selection = Options:GetOptionValue(SELECTION_KEY) --[[@as WayfinderSelection]]
    local display = self.display
    local showFloating = selection == "floating" or self.searchPresentation == "floating"
    display.beam:SetShown(showFloating)
    display.textOutline:SetShown(showFloating)
    local showArrow = selection == "arrow" or self.searchPresentation == "arrow"
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

function MapPinEnhancedOptionCategoryWayfinderMixin:OnShow()
    self.showNumber = (self.showNumber or 0) + 1
    local showNumber = self.showNumber
    -- Startup subscriptions can deliver their initial value after this show ends.
    self.unsubscribeSelection = Options:SubscribeToOptionChanges(SELECTION_KEY, function()
        if self.showNumber ~= showNumber then return end
        self.searchPresentation = nil
        self:RefreshDisplay()
    end)
    self:RefreshDisplay()
end

function MapPinEnhancedOptionCategoryWayfinderMixin:OnHide()
    self.showNumber = (self.showNumber or 0) + 1
    if self.unsubscribeSelection then self.unsubscribeSelection() end
    self.unsubscribeSelection = nil
    self.searchPresentation = nil
    self.display.searchNote:Hide()
end
