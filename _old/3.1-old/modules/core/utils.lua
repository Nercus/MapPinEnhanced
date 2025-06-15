---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Utils
local Utils = MapPinEnhanced:GetModule("Utils")

function Utils:DebounceChange(func, delay)
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

---Abbreviate a number to a more readable format
---@param number number
---@return string
function Utils:AbbreviateNumber(number)
    if number >= 1e12 then
        return string.format("%.1fT", number / 1e12)
    elseif number >= 1e9 then
        return string.format("%.1fB", number / 1e9)
    elseif number >= 1e6 then
        return string.format("%.2fM", number / 1e6)
    elseif number >= 1e3 then
        return string.format("%.1fK", number / 1e3)
    else
        return string.format("%d", number)
    end
end

---Wrap text in a color
---@param text string
---@param color ColorMixin
---@return string
function Utils:WrapTextInColor(text, color)
    assert(type(color) == "table", "Color must be a color object")
    local colorEscape = string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
    return colorEscape .. text .. "|r"
end

local random = math.random

---@alias UUID string a UUID in the format of 'xxxxxxxx-xxxx' or 'prefix-xxxxxxxx-xxxx'

---generate a UUID in the format of 'xxxxxxxx-xxxx'
---@param prefix? string optional prefix to add to the UUID
---@return UUID
function Utils:GenerateUUID(prefix)
    local template = 'xxxxxxxx-yxxx'
    local ans = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return prefix and prefix .. '-' .. ans or ans
end

local defaultColor = ConsoleGetColorFromType(1)
local prefix = Utils:WrapTextInColor(MapPinEnhanced.addonName .. ": ", defaultColor)


---Print a styled message to the chat
---@param ... string
function Utils:Print(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    print(prefix .. str)
end

function Utils:PrintUnformatted(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    print(str)
end
