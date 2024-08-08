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
