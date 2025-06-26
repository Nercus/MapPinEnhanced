---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---Debounce a function call to prevent it from being called too frequently
---@param func fun()
---@param delay number
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
function MapPinEnhanced:BatchExecution(funcList, onUpdate, onFinish)
    assert(type(funcList) == "table", "Function list not provided")
    assert(type(onUpdate) == "function" or onUpdate == nil, "OnUpdate not a function")
    assert(type(onFinish) == "function" or onFinish == nil, "OnFinish not a function")
    local frameRate = GetFramerate()
    if frameRate == 0 then frameRate = 1 end
    local delay = 1 / frameRate

    ---@async
    local function Worker()
        local maxProgress = #funcList
        local nextTime = coroutine.yield()
        for i = 1, maxProgress do
            funcList[i]()
            if onUpdate then onUpdate(i, maxProgress) end
            if GetTimePreciseSec() > nextTime then
                nextTime = coroutine.yield()
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
