---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsFrame : Frame
---@field title FontString
MapPinEnhancedOptionsFrameMixin = {}


function MapPinEnhancedOptionsFrameMixin:ToggleOptionsFrame()
    Settings.OpenToCategory(self.categoryID)
end

local L = MapPinEnhanced.L
local assetsPath = MapPinEnhanced.assetsPath

function MapPinEnhancedOptionsFrameMixin:SetTitle()
    local titleText = string.format("%s %s", MapPinEnhanced.displayName, L["Options"])
    self.title:SetText(titleText)
end

function MapPinEnhancedOptionsFrameMixin:OnLoad()
    ---@type SettingsCategoryMixin
    local category = Settings.RegisterCanvasLayoutCategory(self, MapPinEnhanced.displayName)
    ---@type number
    self.categoryID = category:GetID()
    Settings.RegisterAddOnCategory(category)
    self:Show()
    self:SetTitle()

    MapPinEnhanced:AddSlashCommand("options", function()
        self:ToggleOptionsFrame()
    end, "Open the options frame")

    self:ToggleOptionsFrame()
end
