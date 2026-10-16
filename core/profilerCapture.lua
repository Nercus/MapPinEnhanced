---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- Debug-only capture backend, loaded before templates copy their Mixin methods.
local clock = GetTimePreciseSec

---@class ProfilerRow
---@field name string
---@field calls integer
---@field completed integer
---@field coroutineCalls integer
---@field total number
---@field maximum number

---@class ProfilerReplacement
---@field owner table<string, any>
---@field key string
---@field original function
---@field wrapper function

---@class ProfilerPreparation
---@field capture ProfilerCapture?
---@field mode string
---@field events string
---@field paths integer
---@field slices integer
---@field total number
---@field maximum number
---@field outcome string
---@field started number
---@field duration number?

---@class ProfilerCapture
---@field started number
---@field duration number
---@field modules string[]
---@field selected table<string, boolean>
---@field rows ProfilerRow[]
---@field byName table<string, ProfilerRow>
---@field replacements ProfilerReplacement[]
---@field preparations ProfilerPreparation[]
---@field invalidations table<string, integer>
---@field pendingEvents table<string, boolean>
---@field batchResume? fun(worker: thread): boolean, any

---@class ProfilerCaptureOwner
local Profiler = {}
---@class MapPinEnhanced
---@field profiler ProfilerCaptureOwner
MapPinEnhanced.profiler = Profiler

---@type ProfilerCapture?
local active
local scopeNames = {} ---@type table<string, boolean>
-- Keep scope identity even before Start, without keeping completed workers alive.
local workers = setmetatable({}, { __mode = "k" }) ---@type table<thread, { name: string, pass: ProfilerPreparation?, phase: string? }>

---@param capture ProfilerCapture
---@param name string
---@return ProfilerRow
local function GetRow(capture, name)
    local row = capture.byName[name]
    if not row then
        row = { name = name, calls = 0, completed = 0, coroutineCalls = 0, total = 0, maximum = 0 }
        capture.byName[name] = row
        capture.rows[#capture.rows + 1] = row
    end
    return row
end

---@param row ProfilerRow
---@param elapsed number
local function RecordTime(row, elapsed)
    row.completed = row.completed + 1
    row.total = row.total + elapsed
    row.maximum = math.max(row.maximum, elapsed)
end

---@param capture ProfilerCapture
---@param row ProfilerRow
---@param started number
---@param ... any
---@return ... any
local function FinishCall(capture, row, started, ...)
    if active == capture then RecordTime(row, (clock() - started) * 1000) end
    return ...
end

---@param capture ProfilerCapture
---@param row ProfilerRow
---@param original function
---@return function
local function WrapMethod(capture, row, original)
    return function(...)
        if active ~= capture then return original(...) end
        row.calls = row.calls + 1
        if coroutine.running() then
            row.coroutineCalls = row.coroutineCalls + 1
            return original(...)
        end
        return FinishCall(capture, row, clock(), original(...))
    end
end

-- Only synchronous, non-yielding owners may use these scopes. Installing before
-- XML copies Mixins also covers existing frames and already-retained callbacks.
---@generic T: function
---@param name string
---@param original T
---@return T
function Profiler:WrapScope(name, original)
    scopeNames[name] = true
    local module = name:match("^([^.]+)")
    return function(...)
        local capture = active
        if not capture or not capture.selected[module] then return original(...) end
        local row = GetRow(capture, name)
        row.calls = row.calls + 1
        return FinishCall(capture, row, clock(), original(...))
    end
end

---@param name string
---@param pass ProfilerPreparation?
function Profiler:SetWorkerScope(name, pass)
    local worker = coroutine.running()
    if worker then workers[worker] = { name = name, pass = pass } end
end

-- Resume-local clocks charge phase segments only while the worker is running.
-- A phase may span yields; never put a synchronous WrapScope around yielding work.
---@type table<thread, { capture: ProfilerCapture, started: number, phase: string? }>
local resumes = {}

local function FinishPhase(resume, now)
    if active == resume.capture and resume.phase then
        local row = GetRow(resume.capture, resume.phase)
        row.calls = row.calls + 1
        RecordTime(row, (now - resume.started) * 1000)
    end
    resume.started = now
end

---@param name string
function Profiler:SetWorkerPhase(name)
    local worker = coroutine.running()
    local scope = worker and workers[worker]
    if not scope then return end
    scope.phase = name
    local resume = resumes[worker]
    if resume then
        FinishPhase(resume, clock())
        resume.phase = name
    end
end

---@param capture ProfilerCapture
---@param worker thread
---@param started number
---@param ... any
---@return ... any
local function FinishResume(capture, worker, started, ...)
    local resume = resumes[worker]
    if resume then FinishPhase(resume, clock()) end
    resumes[worker] = nil
    if active == capture then
        local elapsed = (clock() - started) * 1000
        if capture.selected.Core then
            local row = GetRow(capture, "Core.BatchExecutionSlice")
            row.calls = row.calls + 1
            RecordTime(row, elapsed)
        end
        local scope = workers[worker]
        if scope and capture.selected[scope.name:match("^([^.]+)")] then
            local row = GetRow(capture, scope.name)
            row.calls = row.calls + 1
            RecordTime(row, elapsed)
            local pass = scope.pass
            if pass and pass.capture == capture then
                pass.slices = pass.slices + 1
                pass.total = pass.total + elapsed
                pass.maximum = math.max(pass.maximum, elapsed)
            end
        end
    end
    return ...
end

---@param modules table<string, table<string, any>>
---@param names string[] selected module names
---@param baseline boolean?
---@return ProfilerCapture
function Profiler:Start(modules, names, baseline)
    self:Stop()
    ---@type ProfilerCapture
    local capture = {
        started = 0,
        duration = 0,
        modules = names,
        selected = {},
        rows = {},
        byName = {},
        replacements = {},
        preparations = {},
        invalidations = {},
        pendingEvents = {},
        timeline = {},
        nativeSkipped = 0,
        baseline = baseline == true
    }
    self:StartMetrics(capture)
    for _, name in ipairs(baseline and {} or names) do
        capture.selected[name] = true
        for key, original in pairs(modules[name]) do
            if type(key) == "string" and type(original) == "function" then
                local wrapper = WrapMethod(capture, GetRow(capture, name .. "." .. key), original)
                capture.replacements[#capture.replacements + 1] = {
                    owner = modules[name], key = key, original = original, wrapper = wrapper,
                }
                modules[name][key] = wrapper
            end
        end
    end
    for name in pairs(scopeNames) do
        if capture.selected[name:match("^([^.]+)")] then GetRow(capture, name) end
    end
    if capture.selected.Navigation then
        GetRow(capture, "Navigation.PreparationSlice")
        GetRow(capture, "Navigation.CalculationSlice")
    end
    if capture.selected.Core then GetRow(capture, "Core.BatchExecutionSlice") end
    if capture.selected.Core or capture.selected.Navigation then
        capture.batchResume = function(worker)
            if active ~= capture then return coroutine.resume(worker) end
            local started = clock()
            if capture.selected.Navigation then
                local scope = workers[worker]
                resumes[worker] = { capture = capture, started = started, phase = scope and scope.phase }
            end
            return FinishResume(capture, worker, started, coroutine.resume(worker))
        end
        MapPinEnhanced.profileBatchResume = capture.batchResume
    end
    capture.started = clock()
    active = capture
    return capture
end

function Profiler:Stop()
    local capture = active
    if not capture then return end
    active = nil
    if capture.nativeStop then capture.nativeStop() end
    capture.nativeStop = nil
    capture.duration = clock() - capture.started
    if MapPinEnhanced.profileBatchResume == capture.batchResume then MapPinEnhanced.profileBatchResume = nil end
    for _, entry in ipairs(capture.replacements) do
        if entry.owner[entry.key] == entry.wrapper then entry.owner[entry.key] = entry.original end
    end
    wipe(capture.replacements)
    -- In-flight feature closures may retain a pass after Stop/Reset. Do not let
    -- that pass keep the entire old capture alive or accept later outcomes.
    for _, pass in ipairs(capture.preparations) do pass.capture = nil end
end

---@param event string?
function Profiler:InvalidatePreparation(event)
    local capture = active
    if not capture or not capture.selected.Navigation then return end
    event = event or "explicit"
    capture.invalidations[event] = (capture.invalidations[event] or 0) + 1
    capture.pendingEvents[event] = true
end

---@param full boolean
---@return ProfilerPreparation?
function Profiler:BeginPreparation(full)
    local capture = active
    if not capture or not capture.selected.Navigation then return nil end
    local events = {} ---@type string[]
    for event in pairs(capture.pendingEvents) do events[#events + 1] = event end
    table.sort(events)
    wipe(capture.pendingEvents)
    ---@type ProfilerPreparation
    local pass = {
        capture = capture,
        mode = full and "full" or "selective",
        events = #events > 0 and table.concat(events, ",") or "before capture / no captured invalidation",
        paths = 0,
        slices = 0,
        total = 0,
        maximum = 0,
        outcome = "in flight at stop",
        started = clock() - capture.started
    }
    capture.preparations[#capture.preparations + 1] = pass
    return pass
end

---@param pass ProfilerPreparation?
function Profiler:CountPreparationPath(pass)
    if active and pass and pass.capture == active then pass.paths = pass.paths + 1 end
end

---@param pass ProfilerPreparation?
---@param outcome string
function Profiler:FinishPreparation(pass, outcome)
    if active and pass and pass.capture == active then
        pass.outcome = outcome
        pass.duration = clock() - active.started - pass.started
    end
end

---@param capture ProfilerCapture
---@param lines string[]
function Profiler:AppendPreparationExport(capture, lines)
    if not capture.selected.Navigation then return end
    lines[#lines + 1] = ""
    lines[#lines + 1] = "Preparation invalidations observed during capture (not necessarily passes or cancellations):"
    lines[#lines + 1] = "Event\tCount"
    local events = {} ---@type string[]
    for event in pairs(capture.invalidations) do events[#events + 1] = event end
    table.sort(events)
    for _, event in ipairs(events) do
        lines[#lines + 1] = string.format("%s\t%d", event, capture.invalidations[event])
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] =
    "Preparation passes started during capture; events are intake since previous pass start, not exclusive causes."
    lines[#lines + 1] =
    "Active ms excludes suspended time and completion callbacks; paths count evaluations, not unique requirements."
    lines[#lines + 1] =
    "Pass\tMode\tEvents\tPaths evaluated\tSlices\tActive ms\tMax slice ms\tOutcome\tStart s\tElapsed s"
    for index, pass in ipairs(capture.preparations) do
        lines[#lines + 1] = string.format("%d\t%s\t%s\t%d\t%d\t%.6f\t%.6f\t%s\t%.3f\t%.3f", index,
            pass.mode, pass.events, pass.paths, pass.slices, pass.total, pass.maximum, pass.outcome,
            pass.started, pass.duration or capture.duration - pass.started)
    end
end
