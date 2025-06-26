---@class MapPinEnhanced
---@field registeredEvents table<WowEvent, function[]>
local MapPinEnhanced = select(2, ...)

---Register an event for a function to be called when the event is fired
---@param event WowEvent the event to register for
---@param func function the function to call when the event is fired
function MapPinEnhanced:RegisterEvent(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    if not self.registeredEvents[event] then
        self.registeredEvents[event] = {}
    end
    table.insert(self.registeredEvents[event], func)
    if (not self.addonEventFrame) then
        self.addonEventFrame = CreateFrame("Frame")
        self.addonEventFrame:SetScript("OnEvent", function(_, event, ...)
            local funcs = self.registeredEvents[event]
            if (funcs) then
                for _, func in ipairs(funcs) do
                    func(...)
                end
            end
        end)
    end
    self.addonEventFrame:RegisterEvent(event)
end

---Unregister an event for a given function
---@param event WowEvent the event to unregister for
---@param func function the function to unregister for
function MapPinEnhanced:UnregisterEventForFunction(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    if not self.registeredEvents[event] then
        self.registeredEvents[event] = {}
    end
    if self.registeredEvents[event] then
        for i, f in ipairs(self.registeredEvents[event]) do
            if f == func then
                table.remove(self.registeredEvents[event], i)
                break
            end
        end
    end
    if #self.registeredEvents[event] == 0 then
        self.registeredEvents[event] = nil
        self.addonEventFrame:UnregisterEvent(event)
    end
end

---Unregister an event for the addon
---@param event WowEvent the event to unregister for
function MapPinEnhanced:UnregisterEvent(event)
    assert(event, "Event must be provided")
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    self.registeredEvents[event] = nil
    self.addonEventFrame:UnregisterEvent(event)
end
