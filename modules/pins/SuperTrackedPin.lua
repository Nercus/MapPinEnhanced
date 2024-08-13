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


local CONSTANTS = MapPinEnhanced.CONSTANTS

function MapPinEnhancedSuperTrackedPinMixin:Clear()
    self:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnClampedStateChanged()
    self:UpdateTextVisibility()
end

function MapPinEnhancedSuperTrackedPinMixin:SetpersistentState(isPersistent)
    if not self.pinData then return end
    local hasDefaultTitle = self.pinData.title == CONSTANTS.DEFAULT_PIN_NAME
    if isPersistent and not hasDefaultTitle then
        self.persistentIcon:Show()
    else
        self.persistentIcon:Hide()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:UpdateTextVisibility()
    local clamped = C_Navigation.WasClampedToScreen();
    local showTime = MapPinEnhanced:GetVar("Floating Pin", "Show Estimated Time")
    local showTitle = MapPinEnhanced:GetVar("Floating Pin", "Show Title")
    local hasDefaultTitle = CONSTANTS.DEFAULT_PIN_NAME == ((self.pinData and self.pinData.title) or "")
    local isPersistent = self.pinData and self.pinData.persistent

    if clamped or (not showTime and not showTitle) then -- clamped or dont show title and time
        self.title:Hide()
        self.distantText:Hide()
        self.persistentIcon:Hide()
        return
    end

    if not showTime then -- dont show time but show title
        self.distantText:Hide()
        return
    end
    if not showTitle then -- dont show title but show time
        self.title:Hide()
        self.persistentIcon:Hide()
        return
    end


    self.distantText:Show()
    if hasDefaultTitle then -- options has title enabled, but the title is the default title
        self.title:Hide()
        self.persistentIcon:Hide()
        return
    end

    self.persistentIcon:SetShown(isPersistent)
    self.title:Show()
end

---override the function in the base pin mixin to handle the title visibilty for the default title
---@param overrideTitle any
function MapPinEnhancedSuperTrackedPinMixin:SetTitle(overrideTitle)
    if not self.pinData then
        return
    end
    if overrideTitle then
        self.pinData.title = overrideTitle
    end
    local title = self.pinData.title
    self.title:SetText(title)
    self:UpdateTextVisibility()
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

local lastUpdateTime = 0
local margin = 20
---@type number? is not the real height when game is loaded
local screenWidthHalf

function MapPinEnhancedSuperTrackedPinMixin:CheckIsCentered()
    if not self.navFrameCreated then return end
    if not self:IsShown() then return end
    if not lastUpdateTime or (GetTime() - lastUpdateTime) > 0.1 then
        local navFrame = C_Navigation.GetFrame();
        if not navFrame then return end
        local x = navFrame:GetLeft()
        local diff = math.abs(x - screenWidthHalf)
        if diff < margin then
            self:LockHighlight()
        else
            self:UnlockHighlight()
        end
        lastUpdateTime = GetTime()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:AddOptions()
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterCheckbox({
        category = "Floating Pin",
        label = "Show Estimated Time",
        default = MapPinEnhanced:GetDefault("Floating Pin", "Show Estimated Time") --[[@as boolean]],
        init = MapPinEnhanced:GetVar("Floating Pin", "Show Estimated Time") --[[@as boolean]],
        onChange = function(value)
            -- even though we disable the text, we still want to update the time -> need it for automatic removal of pins
            MapPinEnhanced:SaveVar("Floating Pin", "Show Estimated Time", value)
            self.distantText:SetShown(value)
        end
    })
    Options:RegisterCheckbox({
        category = "Floating Pin",
        label = "Show Title",
        default = MapPinEnhanced:GetDefault("Floating Pin", "Show Title") --[[@as boolean]],
        init = MapPinEnhanced:GetVar("Floating Pin", "Show Title") --[[@as boolean]],
        onChange = function(value)
            MapPinEnhanced:SaveVar("Floating Pin", "Show Title", value)
            self:UpdateTextVisibility()
        end
    })

    Options:RegisterCheckbox({
        category = "Floating Pin",
        label = "Show Centered Highlight",
        default = MapPinEnhanced:GetDefault("Floating Pin", "Show Centered Highlight") --[[@as boolean]],
        init = MapPinEnhanced:GetVar("Floating Pin", "Show Centered Highlight") --[[@as boolean]],
        description = "Highlight the floating pin when it is centered on the screen.",
        onChange = function(value)
            MapPinEnhanced:SaveVar("Floating Pin", "Show Centered Highlight", value)
            if value then
                self:SetScript("OnUpdate", self.CheckIsCentered)
            else
                self:SetScript("OnUpdate", nil)
                self:UnlockHighlight()
            end
        end
    })

    Options:RegisterCheckbox({
        category = "Floating Pin",
        label = "Override world quest tracking",
        default = MapPinEnhanced:GetDefault("Floating Pin", "Override world quest tracking") --[[@as boolean]],
        init = MapPinEnhanced:GetVar("Floating Pin", "Override world quest tracking") --[[@as boolean]],
        description =
        "When enabled, the tracked pin will be retracted when a world quest is tracked (flying over the world quest on the map).",
        onChange = function(value)
            if value then
                self:RegisterEvent("QUEST_POI_UPDATE");
            else
                self:UnregisterEvent("QUEST_POI_UPDATE");
            end
            MapPinEnhanced:SaveVar("Floating Pin", "Override world quest tracking", value)
        end
    })
end

function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    screenWidthHalf = GetScreenWidth() / 2
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");

    self:AddOptions()
    self.hooked = false
end

function MapPinEnhancedSuperTrackedPinMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self.navFrameCreated = true;
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self.navFrameCreated = false;
    elseif event == "QUEST_POI_UPDATE" then
        C_Timer.After(0.1, function()
            local PinManager = MapPinEnhanced:GetModule("PinManager")
            PinManager:TrackLastTrackedPin()
        end)
    end
end
