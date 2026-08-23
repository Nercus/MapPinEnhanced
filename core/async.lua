---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedPackedArguments : table
---@field n integer

---@return MapPinEnhancedPackedArguments
local function PackArguments(...)
    return { n = select("#", ...), ... }
end

---Debounce a function call to prevent it from being called too frequently.
---Cancel and flush do nothing when no call is pending. Either operation clears
---the pending arguments, and flush executes the pending call at most once.
---@param func fun(...)
---@param delay number delay in seconds
---@param onChange? fun(...) a function to call with the debounced function's return values
---@return fun(...) schedule replaces the pending call and restarts the delay
---@return fun() cancel discards the pending call
---@return fun() flush immediately executes the pending call once
function MapPinEnhanced:DebounceChange(func, delay, onChange)
    assert(type(func) == "function", "MapPinEnhanced:DebounceChange: function not provided")
    assert(type(delay) == "number", "MapPinEnhanced:DebounceChange: delay not provided")
    ---@type FunctionContainer?
    local timer
    ---@type MapPinEnhancedPackedArguments?
    local pendingArguments

    local function Cancel()
        if timer then
            timer:Cancel()
        end
        timer = nil
        pendingArguments = nil
    end

    local function RunPending()
        if not pendingArguments then return end
        local arguments = pendingArguments
        timer = nil
        pendingArguments = nil
        local results = PackArguments(func(unpack(arguments, 1, arguments.n)))
        if onChange then
            onChange(unpack(results, 1, results.n))
        end
    end

    local function Schedule(...)
        Cancel()
        pendingArguments = PackArguments(...)
        timer = C_Timer.NewTimer(delay, function()
            RunPending()
        end)
    end

    local function Flush()
        if not pendingArguments then return end
        if timer then
            timer:Cancel()
        end
        RunPending()
    end

    return Schedule, Cancel, Flush
end

---Batch the execution of a list of functions with a delay between each execution
---@param funcList (fun(): boolean?)[] functions may return false to stop the batch early
---@param onUpdate fun(progress: integer, maxProgress: integer)?
---@param onFinish fun()?
---@param batchSize integer? number of functions to execute per batch, defaults to 1
---@param onError fun(message: string)?
function MapPinEnhanced:BatchExecution(funcList, onUpdate, onFinish, batchSize, onError)
    assert(type(funcList) == "table", "Function list not provided")
    assert(type(onUpdate) == "function" or onUpdate == nil, "OnUpdate not a function")
    assert(type(onFinish) == "function" or onFinish == nil, "OnFinish not a function")
    assert(type(onError) == "function" or onError == nil, "OnError not a function")
    if not batchSize or batchSize < 1 then
        batchSize = 1
    end

    local frameRate = GetFramerate()
    if frameRate == 0 then frameRate = 1 end
    local delay = 1 / frameRate

    ---@async
    local function Worker()
        local maxProgress = #funcList
        local i = 1
        while i <= maxProgress do
            -- Execute a BATCH of functions
            local batchEnd = math.min(i + batchSize - 1, maxProgress)
            for j = i, batchEnd do
                local shouldContinue = funcList[j]()
                if onUpdate then onUpdate(j, maxProgress) end
                if shouldContinue == false then return end
            end
            i = batchEnd + 1

            -- Yield after each batch (except the last)
            if i <= maxProgress then
                coroutine.yield()
            end
        end
    end

    local workerThread = coroutine.create(Worker)
    local ticker
    ticker = C_Timer.NewTicker(delay,
        function()
            local success, message = coroutine.resume(workerThread)
            if not success then
                ticker:Cancel()
                if onError then onError(tostring(message)) end
                return
            end
            if coroutine.status(workerThread) == "dead" then
                ticker:Cancel()
                if onFinish then onFinish() end
                return
            end
        end
    )
end
