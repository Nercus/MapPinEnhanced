local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Config")


local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")



local function updateTargetAlphaForState()
    if core.db.global.options["changedalpha"] then
        SuperTrackedFrameMixin:SetTargetAlphaForState(0, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(1, 1)
    else
        SuperTrackedFrameMixin:SetTargetAlphaForState(0, 0)
        SuperTrackedFrameMixin:SetTargetAlphaForState(1, 0.6)
    end
end

local function updateShowTimeOption()
    if core.db.global.options["showTimeOnSuperTrackedFrame"] then
        if not core.distanceTimerFast then
            core.distanceTimerFast = core:ScheduleRepeatingTimer("DistanceTimerFast", 1,
                function(distance)
                    if C_Navigation.WasClampedToScreen() then
                        if core.superTrackedTimer then
                            core.superTrackedTimer:Hide()
                        end
                    else
                        core:UpdateTrackerTime(distance)
                        if core.superTrackedTimer then
                            core.superTrackedTimer:Show()
                        end
                    end
                end)
        elseif core.distanceTimerFast.cancelled then
            core.distanceTimerFast = core:ScheduleRepeatingTimer("DistanceTimerFast", 1,
                function(distance)
                    if C_Navigation.WasClampedToScreen() then
                        if core.superTrackedTimer then
                            core.superTrackedTimer:Hide()
                        end
                    else
                        core:UpdateTrackerTime(distance)
                        if core.superTrackedTimer then
                            core.superTrackedTimer:Show()
                        end
                    end
                end)
        end
    else
        if core.distanceTimerFast then
            core:CancelTimer(core.distanceTimerFast)
            core.distanceTimerFast = nil
        end
        if core.superTrackedTimer then
            core.superTrackedTimer:Hide()
        end
    end
end

local function updateHidePinsOption()
    if not core.MPHFrame:IsShown() then
        if core.db.global.options["hidePins"] then
            core.pinManager:HideAllPins()
        else
            core.pinManager:ShowAllPins()
        end
    end
end

local function updateTrackerScaleOption()
    if core.db.global.options["trackerScale"] then
        core.MPHFrame:SetScale(core.db.global.options["trackerScale"])
    end
end

local filteredChannels = {
    "BATTLEGROUND_LEADER",
    "BATTLEGROUND",
    "BN_WHISPER",
    "BN_WHISPER_INFORM",
    "COMMUNITIES_CHANNEL",
    "GUILD",
    "OFFICER",
    "PARTY_LEADER",
    "PARTY",
    "RAID_LEADER",
    "RAID_WARNING",
    "RAID",
    "SAY",
    "WHISPER",
    "WHISPER_INFORM",
    "YELL"
}
local textPatterns = {
    "(%d+%.%d+), (%d+%.%d+)",
    "(%d+%.%d+) (%d+%.%d+)",
    "(%d+%.%d+),(%d+%.%d+)",
    "(%d+)%, (%d+)",
}


local function HyperLinkChatFilter(self, event, msg, ...)
    local x, y
    for i, j in ipairs(textPatterns) do
        x, y = string.match(msg, j)
        if x and y then
            x = (tonumber(x))
            y = (tonumber(y))
            if x and y then
                local mapID = C_Map.GetBestMapForUnit("player")
                local newMsg = core:FormatHyperlink(x / 100, y / 100, mapID) .. " (" .. x .. ", " .. y .. ")"
                return false, newMsg, ...
            end
        end
    end
end

local function updateHyperlinkOption()
    if core.db.global.options["hyperlink"] then
        for i, j in ipairs(filteredChannels) do
            ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. j, HyperLinkChatFilter)
        end
    else
        for i, j in ipairs(filteredChannels) do
            ChatFrame_RemoveMessageEventFilter("CHAT_MSG_" .. j, HyperLinkChatFilter)
        end
    end
end

local function setSettingsOnLoad()
    updateTargetAlphaForState()
    updateHyperlinkOption()
    updateTrackerScaleOption()
end

function module:OnEnable()
    if not core.db then return end
    setSettingsOnLoad()


    local options = {
        name = core.name,
        handler = core,
        type = "group",
        args = {
            unlimitedDistance = {
                type = "toggle",
                width = "full",
                name = "Unlimited Supertrack Distance",
                desc = "Allows you to supertrack pins that are further away than the default 1000 yards",
                get = function() return core.db.global.options["changedalpha"] end,
                set = function(info, value)
                    core.db.global.options["changedalpha"] = value
                    updateTargetAlphaForState()
                end,
            },
            showTime = {
                type = "toggle",
                width = "full",
                name = "Show Time to reach Pin",
                desc = "Shows the time left on the SuperTrackedFrame to reach the tracked pin",
                get = function() return core.db.global.options["showTimeOnSuperTrackedFrame"] end,
                set = function(info, value)
                    core.db.global.options["showTimeOnSuperTrackedFrame"] = value
                    updateShowTimeOption()
                end,
            },
            hidePins = {
                type = "toggle",
                width = "full",
                name = "Hide Pins when Pin Tracker is closed",
                desc = "Hide Pins when Pin Tracker is closed",
                get = function() return core.db.global.options["hidePins"] end,
                set = function(info, value)
                    core.db.global.options["hidePins"] = value
                    updateHidePinsOption()
                end,
            },
            hyperlink = {
                type = "toggle",
                width = "full",
                name = "Detect coordinates in chat",
                desc = "Detect coordinates in chat",
                get = function() return core.db.global.options["hyperlink"] end,
                set = function(info, value)
                    core.db.global.options["hyperlink"] = value
                    updateHyperlinkOption()
                end,
            },
            maxTrackerEntries = {
                type = "range",
                width = "full",
                name = "Max Tracker Entries",
                desc = "Sets the maximum number of entries in the tracker before scrolling",
                min = 3,
                max = 10,
                step = 1,
                get = function() return core.db.global.options["maxTrackerEntries"] end,
                set = function(info, value)
                    core.db.global.options["maxTrackerEntries"] = value
                    if (core.pinManager.UpdateTrackerPositions) then
                        core.pinManager:UpdateTrackerPositions()
                    end
                end,
            },
            pinTrackerScale = {
                type = "range",
                name = "Pin Tracker Scale",
                width = "full",
                desc = "Sets the scale of the Pin Tracker",
                min = 0.5,
                max = 1.5,
                step = 0.05,
                get = function() return core.db.global.options.trackerScale end,
                set = function(info, value)
                    core.db.global.options.trackerScale = value
                    updateTrackerScaleOption()
                end,
            },
        }
    }


    AceConfig:RegisterOptionsTable("MapPinEnhanced", options)
    core.optionsFrame = AceConfigDialog:AddToBlizOptions("MapPinEnhanced",
        core.name)
end
