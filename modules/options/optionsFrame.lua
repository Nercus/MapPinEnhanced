---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsFrameHeader : Frame
---@field title FontString
---@field search MapPinEnhancedAutocompleteTemplate

---@class ScrollFrameTemplate : ScrollFrame
---@field ScrollBar MinimalScrollBar
---@field SetPanExtent fun(self: ScrollFrameTemplate, panExtent: number)

---@class MapPinEnhancedOptionsFrame : Frame
---@field header MapPinEnhancedOptionsFrameHeader
---@field scrollFrame ScrollFrameTemplate
MapPinEnhancedOptionsFrameMixin = {}

---@class Options
---@field frame MapPinEnhancedOptionsFrame
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L


function MapPinEnhancedOptionsFrameMixin:ToggleOptionsFrame()
    Settings.OpenToCategory(self.categoryID)
end

function MapPinEnhancedOptionsFrameMixin:SetTitle()
    self.header.title:SetText(MapPinEnhanced.displayName)
end

function MapPinEnhancedOptionsFrameMixin:SetupOptionSearch()
    if self.searchInitialized then return end
    local options = Options.options

    ---@class AutocompleteOption
    local entries = {}

    for key, option in pairs(options) do
        local optionLabel = option:GetLabelText() or ""
        local optionDescription = option:HasDescription() and option:GetDescriptionText() or ""
        local searchString = optionLabel:lower() .. " " .. optionDescription:lower()
        table.insert(entries, {
            label = optionLabel,
            searchString = searchString,
            value = key,
        })
    end

    self.header.search:Setup({
        options = entries,
        onChange = function(option)
            if not option then return end
            Options:ScrollToOption(option.value)
        end,
    })

    self.searchInitialized = true
end

function MapPinEnhancedOptionsFrameMixin:OnLoad()
    ---@type SettingsCategoryMixin
    local category = Settings.RegisterCanvasLayoutCategory(self, MapPinEnhanced.displayName)
    ---@type number
    self.categoryID = category:GetID()
    Settings.RegisterAddOnCategory(category)
    self:Show()
    self:SetTitle()

    self.scrollFrame.ScrollBar:SetInterpolateScroll(true)
    self.scrollFrame:SetPanExtent(80)
    Options.frame = self

    MapPinEnhanced:AddSlashCommand("options", function()
        self:ToggleOptionsFrame()
    end, L["Open the options frame"])
end

function MapPinEnhancedOptionsFrameMixin:OnShow()
    self:SetupOptionSearch()
end
