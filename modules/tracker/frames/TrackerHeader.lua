---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")

local L = MapPinEnhanced.L

---@class MapPinEnhancedTrackerFrameHeader : Frame
---@field closebutton MapPinEnhancedIconButton
---@field viewToggle MapPinEnhancedIconButton
---@field editorToggle MapPinEnhancedIconButton
---@field headerTexture Texture
---@field title FontString
MapPinEnhancedTrackerFrameHeaderMixin = {}

local PIN_VIEW_ICON = "Interface/AddOns/MapPinEnhanced/assets/pins/PinTrackedYellow.png"
local SET_VIEW_ICON = "Interface/AddOns/MapPinEnhanced/assets/icons/IconSets_Yellow.png"


function MapPinEnhancedTrackerFrameHeaderMixin:OnLoad()
    self.viewToggle:SetScript("OnClick", function()
        if Tracker:GetActiveView() == "Pins" then
            Tracker:SetView("Sets")
        else
            Tracker:SetView("Pins")
        end
    end)
end

function MapPinEnhancedTrackerFrameHeaderMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerFrameHeaderMixin:UpdateViewToggleForView(view)
    if view == "Pins" then
        self.viewToggle:SetNormalTexture(PIN_VIEW_ICON)
        self.viewToggle:SetPushedTexture(PIN_VIEW_ICON)
        self.viewToggle.tooltip = L["View Pins"]
    elseif view == "Sets" then
        self.viewToggle:SetNormalTexture(SET_VIEW_ICON)
        self.viewToggle:SetPushedTexture(SET_VIEW_ICON)
        self.viewToggle.tooltip = L["View Sets"]
    end
end
