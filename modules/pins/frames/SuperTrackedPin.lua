-- Template: file://./SuperTrackedPin.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSuperTrackedPinMixin : MapPinEnhancedBasePinMixin
---@field navFrameCreated boolean
---@field hooked boolean
---@field fadeIn AnimationGroup
---@field distantText FontString
MapPinEnhancedSuperTrackedPinMixin = {}
MapPinEnhancedSuperTrackedPinMixin.navFrameCreated = false;
---@type table?
MapPinEnhancedSuperTrackedPinMixin.queuedTracking = nil


local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

function MapPinEnhancedSuperTrackedPinMixin:OnClampedStateChanged()
    self:UpdateTextVisibility()
end

function MapPinEnhancedSuperTrackedPinMixin:SetLockState(isLock)
    if not self.pinData then return end
    local hasDefaultTitle = self.pinData.title == CONSTANTS.DEFAULT_PIN_NAME
    if isLock and not hasDefaultTitle then
        self.lockIcon:Show()
    else
        self.lockIcon:Hide()
    end
    self:UpdateTextVisibility()
end

function MapPinEnhancedSuperTrackedPinMixin:UpdateTextVisibility()
    local clamped = C_Navigation.WasClampedToScreen();
    local showTime = MapPinEnhanced:GetVar("floatingPin", "showEstimatedTime")
    local showTitle = MapPinEnhanced:GetVar("floatingPin", "showTitle")
    local hasDefaultTitle = CONSTANTS.DEFAULT_PIN_NAME == ((self.pinData and self.pinData.title) or "")
    local isLock = self.pinData and self.pinData.lock

    if clamped or (not showTime and not showTitle) then -- clamped or dont show title and time
        self.title:Hide()
        self.distantText:Hide()
        self.lockIcon:Hide()
        return
    end

    if not showTime then -- dont show time but show title
        self.distantText:Hide()
        return
    end
    if not showTitle then -- dont show title but show time
        self.title:Hide()
        self.lockIcon:Hide()
        return
    end


    self.distantText:Show()
    if hasDefaultTitle then -- options has title enabled, but the title is the default title
        self.title:Hide()
        self.lockIcon:Hide()
        return
    end

    self.lockIcon:SetShown(isLock)
    self.title:Show()
end

local SUPERTRACKEDPIN_TITLE_MAX_WIDTH = 200

---override the function in the base pin mixin to handle the title visibilty for the default title
---@param overrideTitle any
function MapPinEnhancedSuperTrackedPinMixin:SetTitle(overrideTitle)
    MapPinEnhancedBasePinMixin.SetTitle(self, overrideTitle)
    self:UpdateTextVisibility()
    -- set title width dynamically based on the title
    self.title:SetWidth(0)
    local stringWidth = self.title:GetStringWidth()
    if stringWidth > SUPERTRACKEDPIN_TITLE_MAX_WIDTH then
        stringWidth = SUPERTRACKEDPIN_TITLE_MAX_WIDTH
    end
    self.title:SetWidth(stringWidth)
end

function MapPinEnhancedSuperTrackedPinMixin:OnShow()
    -- set anchor
    local f = SuperTrackedFrame
    if not f then
        return
    end
    if not self.hooked then
        hooksecurefunc(f, "PingNavFrame", function()
            self:UpdateTextVisibility()
        end)
        self.hooked = true
    end
    self:SetParent(f)
    self:SetPoint("CENTER", f, "CENTER", 0, 0)
    self:SetFrameLevel(f:GetFrameLevel() + 1)
    self:SetFrameStrata(f:GetFrameStrata())
    self.fadeIn:Play()
    self:UpdateTextVisibility()
end

---@param timeInSeconds number? time in seconds, if nil, ??:?? will be displayed
function MapPinEnhancedSuperTrackedPinMixin:UpdateTimeText(timeInSeconds)
    if not self.distantText:IsShown() then
        return
    end
    if not timeInSeconds or timeInSeconds < 0 then
        self.distantText:SetText("??:??")
        return
    end
    local timeText = SecondsToClock(timeInSeconds)
    self.distantText:SetText(timeText)
end

local function AddOptions()
    local self = MapPinEnhanced:GetSuperTrackedPin()
    local Blizz = MapPinEnhanced:GetModule("Blizz")
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterCheckbox({
        category = L["Floating Pin"],
        label = L["Show Estimated Arrival Time"],
        default = MapPinEnhanced:GetDefault("floatingPin", "showEstimatedTime") --[[@as boolean]],
        init = function() return MapPinEnhanced:GetVar("floatingPin", "showEstimatedTime") --[[@as boolean]] end,
        onChange = function(value)
            -- even though we disable the text, we still want to update the time -> need it for automatic removal of pins
            MapPinEnhanced:SaveVar("floatingPin", "showEstimatedTime", value)
            self.distantText:SetShown(value)
        end
    })
    Options:RegisterCheckbox({
        category = L["Floating Pin"],
        label = L["Show Title"],
        default = MapPinEnhanced:GetDefault("floatingPin", "showTitle") --[[@as boolean]],
        init = function() return MapPinEnhanced:GetVar("floatingPin", "showTitle") --[[@as boolean]] end,
        onChange = function(value)
            MapPinEnhanced:SaveVar("floatingPin", "showTitle", value)
            self:UpdateTextVisibility()
        end
    })

    Options:RegisterCheckbox({
        category = L["Floating Pin"],
        label = L["Block World Quest Tracking"],
        default = MapPinEnhanced:GetDefault("floatingPin", "blockWorldQuestTracking") --[[@as boolean]],
        init = function() return MapPinEnhanced:GetVar("floatingPin", "blockWorldQuestTracking") --[[@as boolean]] end,
        description = L["Block Automatic World Quest Tracking when a Pin is Tracked"],
        onChange = function(value)
            if value then
                self:RegisterEvent("QUEST_POI_UPDATE");
            else
                self:UnregisterEvent("QUEST_POI_UPDATE");
            end
            MapPinEnhanced:SaveVar("floatingPin", "blockWorldQuestTracking", value)
        end
    })
    Options:RegisterCheckbox({
        category = L["Floating Pin"],
        label = L["Enable Unlimited Distance"],
        default = MapPinEnhanced:GetDefault("floatingPin", "unlimitedDistance") --[[@as boolean]],
        init = function() return MapPinEnhanced:GetVar("floatingPin", "unlimitedDistance") --[[@as boolean]] end,
        onChange = function(value)
            MapPinEnhanced:SaveVar("floatingPin", "unlimitedDistance", value)
            Blizz:OverrideSuperTrackedAlphaState(value)
        end,
        description = L["When enabled, the floating pin will be shown even if the tracked pin is very far away."]
    })
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    AddOptions()
end)


function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    -- screenWidthHalf = GetScreenWidth() / 2
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self.hooked = false
    C_Map.ClearUserWaypoint()
    self:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self.navFrameCreated = true;
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self.navFrameCreated = false;
    elseif event == "SUPER_TRACKING_CHANGED" then
        local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
        if isSuperTrackingCorpse then
            self:Hide()
            return
        else
            if self.queuedTracking then
                self:ShowPin(self.queuedTracking)
                self.queuedTracking = nil
            end
        end
    elseif event == "QUEST_POI_UPDATE" then
        C_Timer.After(0.1, function()
            local PinManager = MapPinEnhanced:GetModule("PinManager")
            PinManager:TrackLastTrackedPin()
        end)
    end
end

function MapPinEnhancedSuperTrackedPinMixin:ShowPin(pinData)
    if not pinData then
        self:Hide()
        return
    end
    self:UnlockHighlight()
    self:Setup(pinData)
    self:SetTrackedTexture()
    self:UpdateTimeText(nil)
    local trackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    if trackingCorpse then
        self.queuedTracking = pinData
        self:Hide()
        return
    end
    if not self:IsShown() and not trackingCorpse then
        self:Show()
    end
end

---------------------------------------------------------------------------

---@param pinData pinData | nil if nil, the super tracked pin will be hidden
function MapPinEnhanced:SetSuperTrackedPin(pinData)
    if not self.SuperTrackedPin then
        self.SuperTrackedPin = CreateFrame("Frame", "MapPinEnhancedSuperTrackedPin", UIParent,
            "MapPinEnhancedSuperTrackedPinTemplate") --[[@as MapPinEnhancedSuperTrackedPinMixin]]
    end
    self.SuperTrackedPin:ShowPin(pinData)
end

function MapPinEnhanced:GetSuperTrackedPin()
    if not self.SuperTrackedPin then
        self.SuperTrackedPin = CreateFrame("Frame", "MapPinEnhancedSuperTrackedPin", UIParent,
            "MapPinEnhancedSuperTrackedPinTemplate") --[[@as MapPinEnhancedSuperTrackedPinMixin]]
    end
    return self.SuperTrackedPin
end
