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
    core:UpdateDistanceTimerState()
end

local function updateShowInfoOption()
    core:UpdateInfoState()
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

local function updateBlockMoving()
    if core.db.global.options["blockMoving"] then
        core.MPHFrame:SetMovable(false)
    else
        core.MPHFrame:SetMovable(true)
    end
end

local function setSettingsOnLoad()
    updateTargetAlphaForState()
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
            showInfo = {
                type = "toggle",
                width = "full",
                name = "Show Info on SuperTrackedFrame",
                desc = "Shows the title and texture on the SuperTrackedFrame for the tracked pin",
                get = function() return core.db.global.options["showInfoOnSuperTrackedFrame"] end,
                set = function(info, value)
                    core.db.global.options["showInfoOnSuperTrackedFrame"] = value
                    updateShowInfoOption()
                end,
            },
            blockMoving = {
                type = "toggle",
                width = "full",
                name = "Block Pin Tracker Moving",
                desc = "Blocks the Pin Tracker from being moved",
                get = function() return core.db.global.options["blockMoving"] end,
                set = function(info, value)
                    core.db.global.options["blockMoving"] = value
                    updateBlockMoving()
                end,
            },
            hidePins = {
                type = "toggle",
                width = "full",
                name = "Hide Pins when Pin Tracker is closed",
                desc = "Hide Pins when Pin Tracker is closed",
                disabled = function() return not core.db.global.options["autoOpenTracker"] end,
                get = function() return core.db.global.options["hidePins"] end,
                set = function(info, value)
                    core.db.global.options["hidePins"] = value
                    updateHidePinsOption()
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
            toggleMinmapButton = {
                type = "toggle",
                name = "Toggle Minimap Button",
                width = "full",
                desc = "Toggles the Minimap Button",
                get = function()
                    local show = core.db.global.minimap.hide
                    return not show
                end,
                set = function(info, value)
                    core.db.global.minimap.hide = not value
                    core:UpdateMinimapButton()
                end,
            },
            autoOpenPinTracker = {
                type = "toggle",
                name = "Auto Open Pin Tracker",
                width = "full",
                desc = "Auto Open Pin Tracker when a pin is added",
                get = function()
                    return core.db.global.options.autoOpenTracker
                end,
                set = function(info, value)
                    core.db.global.options.autoOpenTracker = value
                    if (value) then
                        if core.pinManager.GetNumPins() > 0 then
                            core:TogglePinTrackerWindow()
                        end
                    else
                        core.db.global.options["hidePins"] = false
                    end
                end,
            },
            autoTrackNearest = {
                type = "toggle",
                name = "Automatically Track Nearest Pin",
                width = "full",
                desc = "Automatically Track Nearest Pin when a pin is removed",
                get = function()
                    return core.db.global.options.autoTrackNearest
                end,
                set = function(info, value)
                    core.db.global.options.autoTrackNearest = value
                end,
            },
        }
    }


    AceConfig:RegisterOptionsTable("MapPinEnhanced", options)
    core.optionsFrame = AceConfigDialog:AddToBlizOptions("MapPinEnhanced",
        core.name)
end
