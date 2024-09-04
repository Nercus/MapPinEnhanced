---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Events
local Events = MapPinEnhanced:GetModule("Events")


local MapPinEnhancedFrame = CreateFrame("Frame")
local registeredEvents = {} ---@type table<WowEvent, table<number, function>>

---register event
---@param event WowEvent
---@param func function
function Events:RegisterEvent(event, func)
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end
    table.insert(registeredEvents[event], func)
    MapPinEnhancedFrame:RegisterEvent(event)
end

---unregister event
---@param event WowEvent
function Events:UnregisterEvent(event)
    registeredEvents[event] = nil
    MapPinEnhancedFrame:UnregisterEvent(event)
end

---unregister a specific event for a specific function
---@param event WowEvent
---@param func function
function Events:UnregisterEventForFunction(event, func)
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
function Events:IsEventRegisteredForFunction(event, func)
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

---@enum MapPinEnhancedEvent @The events that can be triggered by the MapPinEnhanced module.
local MapPinEnhancedEvent = {
    "UpdateSetList", -- Fired when the full set list is updated (e.g. after a set is added or removed)
    "UpdateSet",     -- Fired when a specific set is updated (e.g. after a pin is added or removed)
}

function Events:CheckEventName(event)
    ---@type string?
    local eventName = event:match("([^:]+)")
    if not MapPinEnhancedEvent[eventName] then
        error("Invalid event name: " .. event)
    end
end

---@param owner table Mostly this will be the mixin of the object that is registering the event
---@param event MapPinEnhancedEvent  | string The event to register
---@param func function The function to call when the event is triggered
function Events:RegisterEventCallback(owner, event, func)
    self:CheckEventName(event)
    MapPinEnhanced.RegisterCallback(owner, event, func)
end

---@param owner table Mostly this will be the mixin of the object that is registering the event
---@param event MapPinEnhancedEvent  | string The event to unregister
function Events:UnregisterEventCallback(owner, event)
    self:CheckEventName(event)
    MapPinEnhanced.UnregisterCallback(owner, event)
end

---@type table<MapPinEnhancedEvent|string, FunctionContainer>
local eventTimers = {}

---@param event MapPinEnhancedEvent | string The event to trigger
---@param ... any The arguments to pass to the callback functions
function Events:FireEvent(event, ...)
    self:CheckEventName(event)
    if eventTimers[event] then
        eventTimers[event]:Cancel()
    end
    local args = { ... }
    eventTimers[event] = C_Timer.NewTimer(0.1, function()
        MapPinEnhanced.CB:Fire(event, unpack(args))
    end)
end

function Events:FireEventImmediat(event, ...)
    self:CheckEventName(event)
    MapPinEnhanced.CB:Fire(event, ...)
end
