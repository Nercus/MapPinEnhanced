---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local DEFAULT_TRANSPORT_SECONDS = 240
local DEFAULT_TRAM_SECONDS = 300
local DEFAULT_BOAT_SECONDS = 150
local FALLBACK_UNCERTAINTY_FACTOR = 0.5

---@class NavigationTransportDock
---@field map integer World instance ID, not UI map ID
---@field x number
---@field y number
---@field z number
---@field site string?
---@field name string?

---@class NavigationTransportSchedule
---@field kind string
---@field period number Milliseconds
---@field stops {dock: integer, arrive: number, depart: number}[]
---@field frames number[][]
---@field faction string?
---@field site string?
---@field fit table?

---@class NavigationTransportLink
---@field routeID integer
---@field fromDock integer
---@field toDock integer

---@class NavigationTransportData
---@field routeID integer
---@field rideSeconds number
---@field waitSeconds number
---@field accessSeconds number
---@field periodSeconds number

-- Without an observed server phase, integrate waiting over a full loop. For
-- unequal departure gaps, a random arrival lands in each gap in proportion to
-- its length. Never interpret source animation offsets as live server time.
---@param path NavigationStaticPath
---@return NavigationTransportData?
---@return string?
local function TransportDataprovider(path)
    local link = path.transportSchedule
    if not link then return nil end
    local schedule = Navigation.transportSchedules and Navigation.transportSchedules[link.routeID]
    assert(schedule and schedule.period > 0, "Navigation transport schedule is missing or invalid")
    local departures = {} ---@type {time: number, ride: number}[]
    for _, stop in ipairs(schedule.stops) do
        if stop.dock == link.fromDock then
            local ride = math.huge
            for _, arrival in ipairs(schedule.stops) do
                if arrival.dock == link.toDock then
                    local duration = (arrival.arrive - stop.depart) % schedule.period
                    if duration > 0 then ride = math.min(ride, duration) end
                end
            end
            assert(ride < math.huge, "Navigation transport schedule has no destination stop")
            departures[#departures + 1] = { time = stop.depart % schedule.period, ride = ride }
        end
    end
    assert(#departures > 0, "Navigation transport schedule has no departure stop")
    table.sort(departures, function(a, b) return a.time < b.time end)
    local wait = 0 ---@type number
    local ride = 0 ---@type number
    for index, departure in ipairs(departures) do
        local previous = departures[index == 1 and #departures or index - 1]
        local gap = #departures == 1 and schedule.period or (departure.time - previous.time) % schedule.period
        wait = wait + gap * gap / (2 * schedule.period)
        ride = ride + gap * departure.ride / schedule.period
    end
    ---@type NavigationTransportData
    local data = {
        routeID = link.routeID,
        rideSeconds = ride / 1000,
        waitSeconds = wait / 1000,
        accessSeconds = path.transportAccessSeconds or 0,
        periodSeconds = schedule.period / 1000,
    }
    return data
end

---@param pathType string
---@param icon string
---@param method string
local function RegisterTransport(pathType, icon, method)
    local defaultSeconds = pathType == "tram" and DEFAULT_TRAM_SECONDS or
        (pathType == "boat" or pathType == "ship") and DEFAULT_BOAT_SECONDS or DEFAULT_TRANSPORT_SECONDS
    ---@param graph NavigationGraph
    ---@param _preparedData NavigationPreparedData
    ---@param pathReference integer
    ---@return NavigationCalculatedPathCost
    local function CostCalculator(graph, _preparedData, pathReference)
        local data = graph.pathHandlerData[pathReference] ---@type NavigationTransportData?
        if data then
            local seconds = data.rideSeconds + data.waitSeconds + data.accessSeconds
            local uncertainty = math.max(data.waitSeconds, seconds * 0.25)
            return {
                expectedSeconds = seconds,
                uncertaintySeconds = uncertainty,
                comparisonSeconds = seconds + uncertainty,
                explanation = {
                    kind = "scheduled-transport",
                    pathType = pathType,
                    seconds = seconds,
                    estimated = true,
                    timingScope = "modeled-schedule",
                    routeID = data.routeID,
                    rideSeconds = data.rideSeconds,
                    waitSeconds = data.waitSeconds,
                    accessSeconds = data.accessSeconds,
                    periodSeconds = data.periodSeconds,
                },
            }
        end
        local authoredDuration = graph.pathDurations[pathReference]
        local usesFallback = type(authoredDuration) ~= "number" or
            authoredDuration <= 0 or authoredDuration == math.huge
        local expectedSeconds = usesFallback and defaultSeconds or authoredDuration
        local uncertaintySeconds = usesFallback and expectedSeconds * FALLBACK_UNCERTAINTY_FACTOR or 0
        return {
            expectedSeconds = expectedSeconds,
            uncertaintySeconds = uncertaintySeconds,
            comparisonSeconds = expectedSeconds + uncertaintySeconds,
            explanation = {
                kind = "scheduled-transport",
                pathType = pathType,
                seconds = expectedSeconds,
                estimated = usesFallback,
            },
        }
    end

    Navigation:RegisterPathHandler(pathType, function()
        return icon, method, L["Navigation Take Transport"]
    end, TransportDataprovider, CostCalculator)
end

RegisterTransport("boat", "FlightMasterFerry", L["Navigation Method Boat"])
RegisterTransport("ship", "FlightMasterFerry", L["Navigation Method Ship"])
RegisterTransport("zeppelin", "Vehicle-Air-Unoccupied", L["Navigation Method Zeppelin"])
RegisterTransport("tram", "Vehicle-SilvershardMines-MineCart", L["Navigation Method Tram"])
RegisterTransport("transport", "Vehicle-Ground-Unoccupied", L["Navigation Method Transport"])
