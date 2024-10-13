---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Tracker
local Tracker = MapPinEnhanced:GetModule("Tracker")
local Events = MapPinEnhanced:GetModule("Events")
local Options = MapPinEnhanced:GetModule("Options")
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
local SlashCommand = MapPinEnhanced:GetModule("SlashCommand")

local L = MapPinEnhanced.L

-- TODO: rewrite the tracker, thats a mess right now: use https://warcraft.wiki.gg/wiki/Making_scrollable_frames

---@return MapPinEnhancedTrackerFrame
function Tracker:GetTrackerFrame()
    if not self.trackerFrame then
        self.trackerFrame = CreateFrame("Frame", "MapPinEnhancedTrackerFrame", UIParent,
            "MapPinEnhancedTrackerFrameTemplate") --[[@as MapPinEnhancedTrackerFrame]]
    end
    return self.trackerFrame
end

function Tracker:UpdateHeight()
    local trackerFrame = self:GetTrackerFrame()
    trackerFrame:UpdateHeight()
end

function Tracker:SetTitle(title)
    local trackerFrame = self:GetTrackerFrame()
    trackerFrame:SetTrackerTitle(title)
end

---@param view TrackerViewType
---@param frame MapPinEnhancedTrackerPinEntryMixin -- TODO: or the other frame types
function Tracker:RemoveEntry(view, frame)
    local trackerFrame = self:GetTrackerFrame()
    local viewFrame = trackerFrame:GetViewFrameForType(view)
    if not viewFrame then return end
    -- check if viewFrame is the active view
    local activeView = self:GetActiveView()
    if not activeView then return end
    if activeView ~= view then return end
    if viewFrame.RemoveEntry then
        ---@cast viewFrame MapPinEnhancedTrackerPinView | MapPinEnhancedTrackerSetView
        viewFrame:RemoveEntry(frame)
    end
end

---@param view TrackerViewType
---@param frame MapPinEnhancedTrackerPinEntryMixin -- TODO: or the other frame types
function Tracker:AddEntry(view, frame)
    local trackerFrame = self:GetTrackerFrame()
    local viewFrame = trackerFrame:GetViewFrameForType(view)
    if not viewFrame then return end
    -- check if viewFrame is the active view
    local activeView = self:GetActiveView()
    if not activeView then return end
    if activeView ~= view then return end
    if viewFrame.AddEntry then
        ---@cast viewFrame MapPinEnhancedTrackerPinView | MapPinEnhancedTrackerSetView
        viewFrame:AddEntry(frame)
    end
end

---@param view TrackerViewType
function Tracker:SetView(view)
    local trackerFrame = self:GetTrackerFrame()
    trackerFrame:SetView(view)
end

function Tracker:GetActiveView()
    local trackerFrame = self:GetTrackerFrame()
    return trackerFrame:GetActiveView()
end

---@param forceVisibleState boolean?
function Tracker:ToggleTracker(forceVisibleState)
    local trackerFrame = self:GetTrackerFrame()
    if forceVisibleState == true then
        trackerFrame:Open()
        return
    elseif forceVisibleState == false then
        trackerFrame:Close()
        return
    else
        trackerFrame:Toggle()
    end
end

function Tracker:RegisterOptions()
    Options:RegisterSelect({
        category = L["Tracker"],
        label = L["Automatic Visibility"],
        default = SavedVars:GetDefault("tracker", "autoVisibility") --[[@as string]],
        init = function() return SavedVars:Get("tracker", "autoVisibility") --[[@as string]] end,
        options = {
            { label = L["Disabled"],  value = "none", type = "radio" },
            { label = L["Automatic"], value = "both", type = "radio" }
        },
        onChange = function(value)
            SavedVars:Save("tracker", "autoVisibility", value)
        end,
        description = L
            ["When enabled, the tracker will be shown/hidden automatically based on the number of active pins."]
    })

    Options:RegisterCheckbox({
        category = L["Tracker"],
        label = L["Lock Tracker"],
        default = SavedVars:GetDefault("tracker", "lockTracker") --[[@as boolean]],
        init = function() return SavedVars:Get("tracker", "lockTracker") --[[@as boolean]] end,
        onChange = function(value)
            SavedVars:Save("tracker", "lockTracker", value)
        end
    })

    Options:RegisterSlider({
        category = L["Tracker"],
        label = L["Scale"],
        default = SavedVars:GetDefault("tracker", "trackerScale") --[[@as number]],
        init = function() return SavedVars:Get("tracker", "trackerScale") --[[@as number]] end,
        min = 0.5,
        max = 2,
        step = 0.05,
        onChange = function(value)
            SavedVars:Save("tracker", "trackerScale", value)
            local trackerFrame = self:GetTrackerFrame()
            trackerFrame:SetScale(value)
        end
    })

    Options:RegisterSlider({
        category = L["Tracker"],
        label = L["Background Opacity"],
        default = SavedVars:GetDefault("tracker", "backgroundOpacity") --[[@as number]],
        init = function() return SavedVars:Get("tracker", "backgroundOpacity") --[[@as number]] end,
        min = 0,
        max = 1,
        step = 0.1,
        onChange = function(value)
            SavedVars:Save("tracker", "backgroundOpacity", value)
            local trackerFrame = self:GetTrackerFrame()
            trackerFrame.blackBackground:SetAlpha(value)
        end
    })

    Options:RegisterCheckbox({
        category = L["Tracker"],
        label = L["Show Numbering"],
        default = SavedVars:GetDefault("tracker", "showNumbering") --[[@as boolean]],
        init = function() return SavedVars:Get("tracker", "showNumbering") --[[@as boolean]] end,
        onChange = function(value)
            SavedVars:Save("tracker", "showNumbering", value)
        end
    })

    Options:RegisterSlider({
        category = L["Tracker"],
        label = L["Displayed Number of Entries"],
        default = SavedVars:GetDefault("tracker", "trackerHeight") --[[@as number]],
        init = function() return SavedVars:Get("tracker", "trackerHeight") --[[@as number]] end,
        min = 1,
        max = 25,
        step = 1,
        onChange = function(value)
            SavedVars:Save("tracker", "trackerHeight", value)
            Tracker:UpdateHeight()
        end
    })
end

function Tracker:RegisterSlashCommands()
    SlashCommand:AddSlashCommand(L["Tracker"]:lower(), function()
        self:ToggleTracker()
    end, L["Toggle Tracker"])

    SlashCommand:AddSlashCommand(L["Import"]:lower(), function()
        self:ToggleTracker(true)
        self:SetView("Import")
    end, L["Import a Set"])
end

local initialized = false
function Tracker:OnInitialize()
    if initialized then return end
    self:RegisterOptions()
    self:RegisterSlashCommands()
    local trackerFrame = self:GetTrackerFrame()
    trackerFrame:RestoreVisibility()
    trackerFrame:RestorePosition()
    initialized = true
end

Events:RegisterEvent("PLAYER_LOGIN", function()
    Tracker:OnInitialize()
end)
