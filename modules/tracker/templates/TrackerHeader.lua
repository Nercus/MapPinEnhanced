---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local Tracker = MapPinEnhanced:GetModule("Tracker")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

---@class MapPinEnhancedTrackerHeaderTemplate : Frame
---@field viewButton MapPinEnhancedIconButtonTemplate
---@field closeButton MapPinEnhancedIconButtonTemplate
---@field importButton MapPinEnhancedIconButtonTemplate
---@field headerTextureLeft Texture
---@field headerTextureRight Texture
---@field title FontString
---@field icon MapPinEnhancedIconMixin
MapPinEnhancedTrackerHeaderMixin = {}

function MapPinEnhancedTrackerHeaderMixin:OnLoad()
    self.importButton:SetScript("OnClick", function()
        Dialogs:ShowDialog("IMPORT")
    end)

    self.viewButton:SetScript("OnClick", function()
        local trackerFrame = self:GetParent() --[[@as MapPinEnhancedTrackerTemplate]]
        trackerFrame:ToggleActiveView()
    end)

    self.closeButton:SetScript("OnClick", function()
        Tracker:HideTracker()
    end)
end

function MapPinEnhancedTrackerHeaderMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerHeaderMixin:SetIcon(icon)
    self.icon:SetIconTexture(icon)
end
