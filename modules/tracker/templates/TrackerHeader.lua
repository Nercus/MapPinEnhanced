---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local Tracker = MapPinEnhanced:GetModule("Tracker")
local Transfer = MapPinEnhanced:GetModule("Transfer")

---@class MapPinEnhancedTrackerHeaderTemplate : Frame
---@field hiddenGroupsMenu MapPinEnhancedTrackerHiddenGroupsTemplate
---@field hiddenGroupsButton MapPinEnhancedIconButtonTemplate
---@field closeButton MapPinEnhancedIconButtonTemplate
---@field lexiconButton MapPinEnhancedIconButtonTemplate
---@field importButton MapPinEnhancedIconButtonTemplate
---@field headerTextureLeft Texture
---@field headerTextureRight Texture
---@field title FontString
---@field icon MapPinEnhancedIconMixin
MapPinEnhancedTrackerHeaderMixin = {}

function MapPinEnhancedTrackerHeaderMixin:OnLoad()
    MapPinEnhanced:GetModule("Options"):SubscribeToOptionChanges("Lexicon.Enable", function(enabled)
        self.lexiconButton:SetShown(enabled == true)
    end)

    self.importButton:SetScript("OnClick", function()
        Transfer:ShowImportWindow()
    end)

    self.hiddenGroupsButton:SetScript("OnClick", function()
        self.hiddenGroupsMenu:Toggle()
    end)

    self.closeButton:SetScript("OnClick", function()
        Tracker:ApplyCloseAction()
    end)
end

function MapPinEnhancedTrackerHeaderMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerHeaderMixin:SetIcon(icon)
    self.icon:SetIconTexture(icon)
end

function MapPinEnhancedTrackerHeaderMixin:ShowLexicon()
    MapPinEnhanced:GetModule("Lexicon"):Show()
end
