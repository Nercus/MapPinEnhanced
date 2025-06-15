---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib



---@param addon NercLibAddon
function NercLib:AddUtilsModule(addon)
    ---@class Utils
    local Utils = addon:GetModule("Utils")

    function Utils:DebounceChange(func, delay)
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
                func(unpack(args))
            end)
        end
    end

    ---Batch the execution of a list of functions with a delay between each execution
    ---@param funcList fun()[]
    ---@param onUpdate fun(progress: integer, maxProgress: integer)?
    ---@param onFinish fun()?
    function Utils:BatchExecution(funcList, onUpdate, onFinish)
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
            end)
    end
end
