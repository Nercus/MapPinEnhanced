---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- The TOC and package exclusions remove this entire tool from release builds.
local L = MapPinEnhanced.L
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

---@class ProfilerCapture
---@field started number
---@field duration number
---@field modules string[]
---@field rows ProfilerRow[]
---@field replacements ProfilerReplacement[]

---@type ProfilerCapture?
local activeCapture
---@type ProfilerCapture?
local lastCapture
---@type table<string, boolean>
local selected = {}
local allModules = true
---@type MapPinEnhancedCopyTextDialogTemplate?
local exportWindow

---@param capture ProfilerCapture
---@param row ProfilerRow
---@param started number
---@param ... any
---@return ... any
local function FinishCall(capture, row, started, ...)
    if activeCapture == capture then
        local elapsed = (clock() - started) * 1000
        row.completed = row.completed + 1
        row.total = row.total + elapsed
        row.maximum = math.max(row.maximum, elapsed)
    end
    -- Forward varargs directly: nil holes and trailing nils must survive.
    return ...
end

---@param capture ProfilerCapture
---@param row ProfilerRow
---@param original function
---@return function
local function Wrap(capture, row, original)
    return function(...)
        -- A consumer may retain this wrapper after Stop restores its table.
        if activeCapture ~= capture then return original(...) end
        row.calls = row.calls + 1
        if coroutine.running() then
            -- No protected call or timing across coroutine yields: preserve
            -- yielding/error behavior and never report suspended time as work.
            row.coroutineCalls = row.coroutineCalls + 1
            return original(...)
        end
        return FinishCall(capture, row, clock(), original(...))
    end
end

---@return table<string, table<string, any>>, string[]
local function GetModules()
    local modules = { Core = MapPinEnhanced }
    local names = { "Core" }
    for name, module in pairs(MapPinEnhanced.modules) do
        modules[name] = module
        names[#names + 1] = name
    end
    table.sort(names)
    return modules, names
end

local function StopCapture()
    local capture = activeCapture
    if not capture then return end
    activeCapture = nil
    capture.duration = clock() - capture.started
    for _, entry in ipairs(capture.replacements) do
        -- Do not overwrite a replacement installed by another owner mid-capture.
        if entry.owner[entry.key] == entry.wrapper then
            entry.owner[entry.key] = entry.original
        end
    end
    wipe(capture.replacements)
end

---@class MapPinEnhancedProfilerTemplate : MapPinEnhancedWindowTemplate
---@field modulesButton Button
---@field startButton Button
---@field stopButton Button
---@field resetButton Button
---@field exportButton Button
---@field status FontString
---@field coverage FontString
---@field minimizeButton Button
---@field compactButton MapPinEnhancedProfilerCompactTemplate?
---@field minimized boolean?
MapPinEnhancedProfilerMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@class MapPinEnhancedProfilerCompactTemplate : MapPinEnhancedButtonTemplate
---@field profiler MapPinEnhancedProfilerTemplate
MapPinEnhancedProfilerCompactMixin = {}

function MapPinEnhancedProfilerCompactMixin:RestoreProfiler()
    self.profiler:RestoreWindow()
end

function MapPinEnhancedProfilerCompactMixin:OnHide()
    local profiler = self.profiler
    if profiler and profiler.minimized then
        -- Escape or UIParent hiding closes the compact view and stops capture.
        profiler.minimized = false
        self:Hide()
        profiler:StopCapture()
    end
end

function MapPinEnhancedProfilerMixin:Minimize()
    if not self.compactButton then
        self.compactButton = CreateFrame("Button", "MapPinEnhancedProfilerCompact", UIParent,
            "MapPinEnhancedProfilerCompactTemplate") --[[@as MapPinEnhancedProfilerCompactTemplate]]
        self.compactButton.profiler = self
        table.insert(UISpecialFrames, "MapPinEnhancedProfilerCompact")
    end
    self.minimized = true
    self.compactButton:SetText(activeCapture and L["Profiler: recording - restore"] or L["Profiler: restore"])
    self.compactButton:Show()
    -- Keep capture alive while transferring visibility to the side button.
    self:HideImmediately()
end

function MapPinEnhancedProfilerMixin:RestoreWindow()
    self.minimized = false
    if self.compactButton then self.compactButton:Hide() end
    self:Refresh()
    self:Show()
end

function MapPinEnhancedProfilerMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self:SetTitle(L["Profiler"])
    self.coverage:SetText(L["Profiles module methods. Private helpers, UI Mixins and earlier callback references are not individually covered. Coroutine calls are counted without timing."])
    self:Refresh()
end

function MapPinEnhancedProfilerMixin:Refresh()
    local _, names = GetModules()
    local count = 0
    for _, name in ipairs(names) do
        if allModules or selected[name] then count = count + 1 end
    end
    self.modulesButton:SetText(string.format(L["Modules: %d"], count))
    self.modulesButton:SetEnabled(activeCapture == nil)
    self.startButton:SetEnabled(activeCapture == nil and count > 0)
    self.stopButton:SetEnabled(activeCapture ~= nil)
    self.resetButton:SetEnabled(activeCapture == nil and lastCapture ~= nil)
    self.exportButton:SetEnabled(activeCapture == nil and lastCapture ~= nil)
    if activeCapture then
        self.status:SetText(L["Recording. Closing this window stops capture."])
    elseif lastCapture then
        self.status:SetText(string.format(L["Capture stopped: %.2f seconds. Export to inspect results."], lastCapture.duration))
    else
        self.status:SetText(L["Select modules, then start a new capture."])
    end
end

function MapPinEnhancedProfilerMixin:SelectModules()
    if activeCapture then return end
    local _, names = GetModules()
    ---@type AnyMenuEntry[]
    local entries = {
        {
            type = "checkbox", label = L["All modules"],
            isSelected = function() return allModules end,
            setSelected = function()
                allModules = not allModules
                wipe(selected)
                self:Refresh()
            end,
        },
    }
    for _, name in ipairs(names) do
        entries[#entries + 1] = {
            type = "checkbox", label = name,
            isSelected = function() return allModules or selected[name] == true end,
            setSelected = function()
                if allModules then
                    allModules = false
                    for _, moduleName in ipairs(names) do selected[moduleName] = true end
                end
                selected[name] = not selected[name]
                self:Refresh()
            end,
        }
    end
    MapPinEnhanced:GenerateMenu(self.modulesButton, entries)
end

function MapPinEnhancedProfilerMixin:StartCapture()
    if activeCapture or not MapPinEnhanced:GetVar("devMode") then return end
    local modules, names = GetModules()
    ---@type ProfilerCapture
    local capture = { started = 0, duration = 0, modules = {}, rows = {}, replacements = {} }
    for _, name in ipairs(names) do
        if allModules or selected[name] then
            capture.modules[#capture.modules + 1] = name
            for key, original in pairs(modules[name]) do
                if type(key) == "string" and type(original) == "function" then
                    ---@type ProfilerRow
                    local row = {
                        name = name .. "." .. key, calls = 0, completed = 0,
                        coroutineCalls = 0, total = 0, maximum = 0,
                    }
                    local wrapper = Wrap(capture, row, original)
                    capture.rows[#capture.rows + 1] = row
                    capture.replacements[#capture.replacements + 1] = {
                        owner = modules[name], key = key, original = original, wrapper = wrapper,
                    }
                    modules[name][key] = wrapper
                end
            end
        end
    end
    if #capture.modules == 0 then return end
    if exportWindow then exportWindow:Hide() end
    lastCapture = capture
    -- Wrappers only record after every selected method has been installed.
    capture.started = clock()
    activeCapture = capture
    self:Refresh()
end

function MapPinEnhancedProfilerMixin:StopCapture()
    StopCapture()
    self:Refresh()
end

function MapPinEnhancedProfilerMixin:ResetCapture()
    if activeCapture then return end
    lastCapture = nil
    if exportWindow then exportWindow:Hide() end
    self:Refresh()
end

function MapPinEnhancedProfilerMixin:OnHide()
    if not self.minimized then StopCapture() end
    self:Refresh()
    MapPinEnhancedWindowMixin.OnHide(self)
end

function MapPinEnhancedProfilerMixin:ExportCapture()
    local capture = lastCapture
    if activeCapture or not capture then return end
    table.sort(capture.rows, function(a, b)
        if a.total == b.total then return a.name < b.name end
        return a.total > b.total
    end)
    local version, build = GetBuildInfo()
    local lines = {
        "Map Pin Enhanced profiler v1",
        "Addon: " .. (C_AddOns.GetAddOnMetadata(MapPinEnhanced.name, "Version") or "unknown"),
        "Client: " .. version .. " (" .. build .. ")",
        "Modules: " .. table.concat(capture.modules, ", "),
        string.format("Capture seconds: %.6f", capture.duration),
        "Scope: table methods present at Start; Core is the addon table. Zero-call rows included.",
        "Private helpers and UI Mixins have no separate rows; previously captured callbacks can bypass wrappers.",
        "Coroutine calls are counted but not timed. Deferred work is not attributed to its scheduling method.",
        "Times are inclusive elapsed milliseconds with profiler overhead; do not sum rows as CPU usage.",
        "Average uses completed timed calls. Incomplete calls errored or were in flight when capture stopped.",
        "Function\tCalls\tTimed calls\tCoroutine calls\tIncomplete calls\tTotal ms\tMax ms\tAverage ms",
    }
    for _, row in ipairs(capture.rows) do
        lines[#lines + 1] = string.format("%s\t%d\t%d\t%d\t%d\t%.6f\t%.6f\t%.6f", row.name,
            row.calls, row.completed, row.coroutineCalls, row.calls - row.completed - row.coroutineCalls,
            row.total, row.maximum, row.completed > 0 and row.total / row.completed or 0)
    end
    if not exportWindow then
        exportWindow = CreateFrame("Frame", "MapPinEnhancedProfilerExport", UIParent,
            "MapPinEnhancedCopyTextDialogTemplate") --[[@as MapPinEnhancedCopyTextDialogTemplate]]
    end
    exportWindow:Open(L["Profiler"], table.concat(lines, "\n"))
end

-- Define the virtual template's Mixin even outside devmode; only developer
-- sessions register an entry point, and Start checks the flag again.
if not MapPinEnhanced:GetVar("devMode") then return end

---@type MapPinEnhancedProfilerTemplate?
local window
MapPinEnhanced:AddDebugCustomDebugAction({
    type = "button", label = L["Profiler"],
    onClick = function()
        if not MapPinEnhanced:GetVar("devMode") then return end
        if not window then
            window = CreateFrame("Frame", "MapPinEnhancedProfiler", UIParent,
                "MapPinEnhancedProfilerTemplate") --[[@as MapPinEnhancedProfilerTemplate]]
        end
        window:RestoreWindow()
    end,
})
