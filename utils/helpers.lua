---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local random = math.random

---@alias UUID string

---generate a UUID in the format of 'xxxxxxxx-xxxx'
---@param prefix string optional prefix to add to the UUID
---@return UUID
function MapPinEnhanced:GenerateUUID(prefix)
    local template = 'xxxxxxxx-yxxx'
    local ans = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return prefix and prefix .. '-' .. ans or ans
end

function MapPinEnhanced:DebounceChange(func, delay)
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
function MapPinEnhanced:BatchExecution(funcList, onUpdate, onFinish)
    local frameRate = GetFramerate()
    if frameRate == 0 then frameRate = 1 end
    local delay = 1 / frameRate

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
