---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
local Options = MapPinEnhanced:GetModule("Options")

---------------------------------------------------------------------------

local function MigratePriorTo300()
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.autoOpenTracker ~= nil then
        ---@type boolean
        local value = MapPinEnhancedDB.global.options.autoOpenTracker
        MapPinEnhanced:SaveVar("tracker", "autoVisibility", value and "both" or "none")
    end
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.showInfoOnSuperTrackedFrame ~= nil then
        ---@type boolean
        local value = MapPinEnhancedDB.global.options.showInfoOnSuperTrackedFrame
        MapPinEnhanced:SaveVar("floatingPin", "showTitle", value)
    end
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.showTimeOnSuperTrackedFrame ~= nil then
        ---@type boolean
        local value = MapPinEnhancedDB.global.options.showTimeOnSuperTrackedFrame
        MapPinEnhanced:SaveVar("floatingPin", "showEstimatedTime", value)
    end
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.changedalpha ~= nil then
        ---@type boolean
        local value = MapPinEnhancedDB.global.options.changedalpha
        MapPinEnhanced:SaveVar("floatingPin", "unlimitedDistance", value)
    end
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.maxTrackerEntries ~= nil then
        ---@type number
        local value = MapPinEnhancedDB.global.options.maxTrackerEntries
        MapPinEnhanced:SaveVar("tracker", "trackerHeight", value)
    end
    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.autoTrackNearest ~= nil then
        ---@type boolean
        local value = MapPinEnhancedDB.options.autoTrackNearest
        MapPinEnhanced:SaveVar("general", "autoTrackNearestPin", value)
    end


    if MapPinEnhancedDB.global and MapPinEnhancedDB.global.presets then
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        local PinProvider = MapPinEnhanced:GetModule("PinProvider")
        ---@diagnostic disable-next-line: param-type-mismatch, no-unknown we don't type anything we just want to migrate them over
        for _, preset in pairs(MapPinEnhancedDB.global.presets) do
            local migratedSetName = preset.name or "Imported"
            if preset.input then
                local pins = PinProvider:DeserializeWayString(preset.input)
                local newSet = SetManager:AddSet(migratedSetName)
                for _, pin in ipairs(pins) do
                    newSet:AddPin({
                        mapID = pin.mapID,
                        x = pin.x,
                        y = pin.y,
                        title = pin.title,
                    }, true)
                end
            end
        end
        SetManager:PersistSets()
    end
    MapPinEnhanced:DeleteVar("global")
    MapPinEnhanced:DeleteVar("profileKeys")
    MapPinEnhanced:DeleteVar("profiles")
end

local function MigrateBetaNaming()
    local SuperTrackingOther = MapPinEnhanced:GetVar("SuperTrackingOther")
    if SuperTrackingOther ~= nil then
        MapPinEnhanced:MigrateVar("SuperTrackingOther", "superTrackingOther")
    end

    local sets = MapPinEnhanced:GetVar("Sets")
    if not sets then return end
    MapPinEnhanced:MigrateVar("Sets", "sets")
end


---Migration function to handle changes in the saved variables
---@param oldVersion number
function Options:MigrateOptionByVersion(oldVersion)
    if oldVersion < 300 then -- versions before 3.0.0
        MigratePriorTo300()
    end
    MigrateBetaNaming() -- NOTE: only keep this for some time, we expect that all beta testers have moved to a newer version quickly
end

function MapPinEnhanced:UpdateVersionInfo()
    if self.lastVersion then return end -- only update once
    self.lastVersion = self:GetVar("version") --[[@as number]]
    local currentVersion = self.version
    if not self.lastVersion or self.lastVersion ~= currentVersion then
        self:SaveVar("version", currentVersion)
        self:PrintHelp()          -- show the help message after a new upate
        C_Map.ClearUserWaypoint() -- we always clear the waypoint on init after a new update
        local PinManager = self:GetModule("PinManager")
        PinManager:UntrackTrackedPin()
    end
    Options:MigrateOptionByVersion(self.lastVersion or 0)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:UpdateVersionInfo()
end)
