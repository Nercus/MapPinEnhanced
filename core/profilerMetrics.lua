---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class ProfilerCaptureOwner
local Profiler = MapPinEnhanced.profiler

---@class ProfilerMetrics
---@field frames integer
---@field addon number
---@field application number
---@field overall number
---@field maximum number
---@field over1 integer
---@field over2 integer
---@field over5 integer
---@field over10 integer
---@field seconds number

---@class ProfilerCapture
---@field native ProfilerMetrics?
---@field timeline ProfilerMetrics[]
---@field nativeUnavailable string?
---@field nativeSkipped integer
---@field nativeStop? fun()
---@field baseline boolean

---@return ProfilerMetrics
local function NewMetrics()
    return { frames = 0, addon = 0, application = 0, overall = 0, maximum = 0,
        over1 = 0, over2 = 0, over5 = 0, over10 = 0, seconds = 0 }
end

---@param values ProfilerMetrics
---@param addon number
---@param application number
---@param overall number
---@param elapsed number
local function AddSample(values, addon, application, overall, elapsed)
    values.frames = values.frames + 1
    values.addon = values.addon + addon
    values.application = values.application + application
    values.overall = values.overall + overall
    values.maximum = math.max(values.maximum, addon)
    values.seconds = values.seconds + elapsed
    if addon > 1 then values.over1 = values.over1 + 1 end
    if addon > 2 then values.over2 = values.over2 + 1 end
    if addon > 5 then values.over5 = values.over5 + 1 end
    if addon > 10 then values.over10 = values.over10 + 1 end
end

local function IsReadableMetric(value)
    return not (issecretvalue and issecretvalue(value)) and type(value) == "number" and value >= 0 and value < math.huge
end

-- This nonvisual driver samples the previous engine tick once per rendered frame.
-- It owns no UI hierarchy and is detached completely on Stop, including minimized captures.
local driver = CreateFrame("Frame")
driver:Hide()

---@param capture ProfilerCapture
function Profiler:StartMetrics(capture)
    capture.native, capture.timeline, capture.nativeSkipped = NewMetrics(), {}, 0
    if not C_AddOnProfiler or not C_AddOnProfiler.IsEnabled or not C_AddOnProfiler.IsEnabled() or
        not C_AddOnProfiler.GetAddOnMetric or not C_AddOnProfiler.GetApplicationMetric or
        not C_AddOnProfiler.GetOverallMetric or not Enum.AddOnProfilerMetric then
        capture.nativeUnavailable = "Native addon profiling is unavailable on this client."
        return
    end
    local metric = Enum.AddOnProfilerMetric.LastTime
    if metric == nil then
        capture.nativeUnavailable = "Native LastTime metric is unavailable on this client."
        return
    end
    local first = true
    local bucket = NewMetrics()
    driver:SetScript("OnUpdate", function(_, elapsed)
        -- The first tick may precede Start; omit it instead of charging setup to the capture.
        if first then first = false return end
        if not C_AddOnProfiler.IsEnabled() then
            capture.nativeSkipped = capture.nativeSkipped + 1
            return
        end
        local addon = C_AddOnProfiler.GetAddOnMetric(MapPinEnhanced.name, metric)
        local application = C_AddOnProfiler.GetApplicationMetric(metric)
        local overall = C_AddOnProfiler.GetOverallMetric(metric)
        if not IsReadableMetric(addon) or not IsReadableMetric(application) or not IsReadableMetric(overall) then
            capture.nativeSkipped = capture.nativeSkipped + 1
            return
        end
        if bucket.frames == 0 then capture.timeline[#capture.timeline + 1] = bucket end
        AddSample(capture.native, addon, application, overall, elapsed)
        AddSample(bucket, addon, application, overall, elapsed)
        if bucket.seconds >= 10 then bucket = NewMetrics() end
    end)
    capture.nativeStop = function()
        driver:SetScript("OnUpdate", nil)
        driver:Hide()
    end
    driver:Show()
end

local function Percent(numerator, denominator)
    if denominator <= 0 then return "n/a" end
    return string.format("%.3f", numerator / denominator * 100)
end

---@param label string
---@param values ProfilerMetrics
---@return string
local function FormatMetrics(label, values)
    return string.format("%s\t%d\t%.3f\t%.6f\t%.6f\t%.6f\t%s\t%s\t%s\t%d\t%d\t%d\t%d",
        label, values.frames, values.seconds, values.addon,
        values.frames > 0 and values.addon / values.frames or 0, values.maximum,
        Percent(values.addon, values.application - values.overall + values.addon),
        Percent(values.addon, values.application), Percent(values.addon, values.overall),
        values.over1, values.over2, values.over5, values.over10)
end

---@param capture ProfilerCapture
---@param lines string[]
function Profiler:AppendMetricsExport(capture, lines)
    lines[#lines + 1] = ""
    lines[#lines + 1] = "Native whole-addon measurements (engine attribution, including libraries and profiler overhead):"
    if capture.nativeUnavailable or not capture.native then
        lines[#lines + 1] = capture.nativeUnavailable or "No native samples available."
        return
    end
    lines[#lines + 1] = "LastTime sampled once per frame; first tick omitted. Final current tick is not yet available. No native counters are reset."
    lines[#lines + 1] = "Blizzard impact % = addon / (application - all addons + addon); application % = addon / application; addon share % = addon / all addons. Ratios use summed sampled times, not averages of percentages."
    lines[#lines + 1] = "Blizzard impact uses the tooltip denominator over this capture, not its rolling recent-average window. These are engine time ratios, not OS CPU utilization or measured FPS loss."
    lines[#lines + 1] = "Timeline buckets contain approximately 10 sampled seconds; final bucket may be shorter. Baseline avoids detailed wrappers; neither mode removes the sampling cost."
    lines[#lines + 1] = string.format("Skipped unavailable/secret samples: %d", capture.nativeSkipped)
    lines[#lines + 1] = "Window\tFrames\tSampled seconds\tAddon ms\tAddon ms/frame\tPeak ms\tBlizzard impact %\tApplication %\tAddon share %\tFrames >1ms\tFrames >2ms\tFrames >5ms\tFrames >10ms"
    lines[#lines + 1] = FormatMetrics("Capture", capture.native)
    for index, bucket in ipairs(capture.timeline) do
        lines[#lines + 1] = FormatMetrics("Window " .. index, bucket)
    end
end
