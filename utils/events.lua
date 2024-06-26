---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local MapPinEnhancedFrame = CreateFrame("Frame")
local registeredEvents = {} ---@type table<WowEvent, table<number, function>>

---register event
---@param event WowEvent
---@param func function
function MapPinEnhanced:RegisterEvent(event, func)
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end
    table.insert(registeredEvents[event], func)
    MapPinEnhancedFrame:RegisterEvent(event)
end

---unregister event
---@param event WowEvent
function MapPinEnhanced:UnregisterEvent(event)
    registeredEvents[event] = nil
    MapPinEnhancedFrame:UnregisterEvent(event)
end

---unregister a specific event for a specific function
---@param event WowEvent
---@param func function
function MapPinEnhanced:UnregisterEventForFunction(event, func)
    if registeredEvents[event] then
        for i, f in ipairs(registeredEvents[event]) do
            if f == func then
                table.remove(registeredEvents[event], i)
                break
            end
        end
    end
    if #registeredEvents[event] == 0 then
        registeredEvents[event] = nil
        MapPinEnhancedFrame:UnregisterEvent(event)
    end
end

---check if an event is registered for a specific function
---@param event WowEvent
---@param func function
---@return boolean
function MapPinEnhanced:IsEventRegisteredForFunction(event, func)
    for _, f in ipairs(registeredEvents[event] or {}) do
        if f == func then
            return true
        end
    end
    return false
end

MapPinEnhancedFrame:SetScript("OnEvent", function(_, event, ...)
    if registeredEvents[event] then
        for _, func in ipairs(registeredEvents[event]) do
            func(event, ...)
        end
    end
end)
