---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsFrameHeader : Frame
---@field title FontString
---@field search MapPinEnhancedAutocompleteTemplate

---@class ScrollFrameTemplate
---@field ScrollBar MinimalScrollBar

---@class MapPinEnhancedOptionsFrame : Frame
---@field header MapPinEnhancedOptionsFrameHeader
---@field scrollFrame ScrollFrameTemplate
MapPinEnhancedOptionsFrameMixin = {}

---@class Options
---@field frame MapPinEnhancedOptionsFrame
local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedOptionsFrameMixin:ToggleOptionsFrame()
    Settings.OpenToCategory(self.categoryID)
end

local L = MapPinEnhanced.L
local assetsPath = MapPinEnhanced.assetsPath

function MapPinEnhancedOptionsFrameMixin:SetTitle()
    local titleText = string.format("%s %s", MapPinEnhanced.displayName, L["Options"])
    self.header.title:SetText(titleText)
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
            description = optionDescription,
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
    Options.frame = self

    MapPinEnhanced:AddSlashCommand("options", function()
        self:ToggleOptionsFrame()
    end, "Open the options frame")
    self:ToggleOptionsFrame()
end

function MapPinEnhancedOptionsFrameMixin:OnShow()
    self:SetupOptionSearch()
end
