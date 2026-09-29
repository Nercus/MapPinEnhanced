---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

local HOLIDAY_IDS = {
    ["DARKMOON FAIRE"] = 479,
    ["LOVE IS IN THE AIR"] = 423,
}
local calendarReady = false
local lastHolidayStates = {} ---@type table<number, boolean>
local refreshTicker ---@type FunctionContainer?

---@param value any
---@return boolean
local function IsReadableTable(value)
    return not MapPinEnhanced:IsSecretValue(value) and type(value) == "table" and
        not MapPinEnhanced:IsSecretTable(value)
end

---@param value any
---@return boolean
local function IsReadableNumber(value)
    return not MapPinEnhanced:IsSecretValue(value) and type(value) == "number"
end

---@param value any
---@return boolean
local function IsCalendarTime(value)
    if not IsReadableTable(value) then return false end
    for _, key in ipairs({ "year", "month", "monthDay", "weekday", "hour", "minute" }) do
        if not IsReadableNumber(value[key]) then return false end
    end
    return true
end

---@param holidayID number
---@return boolean? active
local function IsHolidayActive(holidayID)
    if not calendarReady or not C_Calendar or not C_Calendar.GetMonthInfo or
        not C_Calendar.GetNumDayEvents or not C_Calendar.GetDayEvent or
        not C_DateAndTime or not C_DateAndTime.GetCurrentCalendarTime or
        not C_DateAndTime.CompareCalendarTime then
        return nil
    end
    -- Calendar filters can hide an active holiday. Do not change the player's
    -- settings or interpret a filtered-out entry as proof that it is inactive.
    local filter = holidayID == 479 and "calendarShowDarkmoon" or "calendarShowHolidays"
    if not GetCVarBool(filter) then return nil end
    local now = C_DateAndTime.GetCurrentCalendarTime()
    local month = C_Calendar.GetMonthInfo(0)
    if not IsCalendarTime(now) or not IsReadableTable(month) or
        not IsReadableNumber(month.year) or not IsReadableNumber(month.month) then
        return nil
    end
    -- Offsets are relative to the displayed calendar month, not today's month.
    local offset = (now.year - month.year) * 12 + now.month - month.month
    local count = C_Calendar.GetNumDayEvents(offset, now.monthDay)
    if not IsReadableNumber(count) or count < 0 then return nil end
    local sawUnknown = false
    for index = 1, count do
        local event = C_Calendar.GetDayEvent(offset, now.monthDay, index)
        if not IsReadableTable(event) or MapPinEnhanced:IsSecretValue(event.calendarType) or
            type(event.calendarType) ~= "string" or not IsReadableNumber(event.eventID) then
            sawUnknown = true
        elseif event.calendarType == "HOLIDAY" and event.eventID == holidayID then
            if not IsCalendarTime(event.startTime) or not IsCalendarTime(event.endTime) then
                sawUnknown = true
            else
                -- Blizzard returns positive when the right-hand date is later.
                -- Include the start minute and exclude the end minute.
                local duration = C_DateAndTime.CompareCalendarTime(event.startTime, event.endTime)
                local started = C_DateAndTime.CompareCalendarTime(event.startTime, now)
                local remaining = C_DateAndTime.CompareCalendarTime(now, event.endTime)
                if not IsReadableNumber(duration) or not IsReadableNumber(started) or
                    not IsReadableNumber(remaining) or duration <= 0 then
                    sawUnknown = true
                elseif started >= 0 and remaining > 0 then
                    return true
                end
            end
        end
    end
    if sawUnknown then return nil end
    return false
end

---@param name string
---@return boolean? active
function Navigation:IsCalendarEventActive(name)
    local holidayID = HOLIDAY_IDS[string.upper(name)]
    if not holidayID then return nil end
    return IsHolidayActive(holidayID)
end

local function RefreshHolidayStates()
    local changed = false
    for _, holidayID in pairs(HOLIDAY_IDS) do
        local active = IsHolidayActive(holidayID)
        if active ~= lastHolidayStates[holidayID] then changed = true end
        lastHolidayStates[holidayID] = active
    end
    if changed and Navigation:GetGraph() then Navigation:RefreshEligibility() end
end

MapPinEnhanced:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", function()
    calendarReady = true
end)
MapPinEnhanced:RegisterEventBucket({ "CALENDAR_UPDATE_EVENT_LIST", "CVAR_UPDATE" }, RefreshHolidayStates, 0.5)

function Navigation:SetupCalendarRequirements()
    if refreshTicker then return end
    -- These observations belong to the addon session, not a displayed frame or
    -- active route. Only changed holiday states refresh the routing snapshot.
    refreshTicker = C_Timer.NewTicker(60, RefreshHolidayStates)
    if C_Calendar and C_Calendar.OpenCalendar then C_Calendar.OpenCalendar() end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function()
    if refreshTicker then refreshTicker:Cancel() end
    refreshTicker = nil
end)
