---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib

---@param addon NercLibAddon
function NercLib:AddEventsModule(addon)
    ---@class Events
    local Events = addon:GetModule("Events")

    local AddonEventFrame = CreateFrame("Frame")
    local registeredEvents = {} ---@type table<WowEvent, table<number, function>>

    ---register event
    ---@param event WowEvent
    ---@param func function
    function Events:RegisterEvent(event, func)
        assert(event, "Event must be provided")
        assert(func, "Function must be provided")

        if not registeredEvents[event] then
            registeredEvents[event] = {}
        end
        table.insert(registeredEvents[event], func)
        AddonEventFrame:RegisterEvent(event)
    end

    ---unregister event
    ---@param event WowEvent
    function Events:UnregisterEvent(event)
        assert(event, "Event must be provided")
        registeredEvents[event] = nil
        AddonEventFrame:UnregisterEvent(event)
    end

    ---unregister a specific event for a specific function
    ---@param event WowEvent
    ---@param func function
    function Events:UnregisterEventForFunction(event, func)
        assert(event, "Event must be provided")
        assert(func, "Function must be provided")
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
            AddonEventFrame:UnregisterEvent(event)
        end
    end

    ---check if an event is registered for a specific function
    ---@param event WowEvent
    ---@param func function
    ---@return boolean
    function Events:IsEventRegisteredForFunction(event, func)
        assert(event, "Event must be provided")
        assert(func, "Function must be provided")
        for _, f in ipairs(registeredEvents[event] or {}) do
            if f == func then
                return true
            end
        end
        return false
    end

    AddonEventFrame:SetScript("OnEvent", function(_, event, ...)
        if registeredEvents[event] then
            for _, func in ipairs(registeredEvents[event]) do
                func(event, ...)
            end
        end
    end)
end
