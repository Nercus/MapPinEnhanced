---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---Debounce a function call to prevent it from being called too frequently
---@param func fun()
---@param delay number delay in seconds
---@param onChange? fun() a function to call when the debounced function is called
---@return function
function MapPinEnhanced:DebounceChange(func, delay, onChange)
    assert(type(func) == "function", "Function not provided")
    assert(type(delay) == "number", "Delay not provided")
    ---@type FunctionContainer?
    local timer
    return function(...)
        local args = { ... }
        if timer then
            timer:Cancel()
        end
        timer = C_Timer.NewTimer(delay, function()
            local result = { func(unpack(args)) }
            if onChange and result then
                onChange(unpack(result))
            end
        end)
    end
end

---Batch the execution of a list of functions with a delay between each execution
---@param funcList fun()[]
---@param onUpdate fun(progress: integer, maxProgress: integer)?
---@param onFinish fun()?
---@param batchSize integer? number of functions to execute per batch, defaults to 1
function MapPinEnhanced:BatchExecution(funcList, onUpdate, onFinish, batchSize)
    assert(type(funcList) == "table", "Function list not provided")
    assert(type(onUpdate) == "function" or onUpdate == nil, "OnUpdate not a function")
    assert(type(onFinish) == "function" or onFinish == nil, "OnFinish not a function")
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
                funcList[j]()
                if onUpdate then onUpdate(j, maxProgress) end
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
            local success = coroutine.resume(workerThread, GetTimePreciseSec() + delay)
            if not success or coroutine.status(workerThread) == "dead" then
                ticker:Cancel()
                if onFinish then onFinish() end
                return
            end
        end
    )
end
