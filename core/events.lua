---@class MapPinEnhanced
---@field registeredEvents table<WowEvent, function[]>
local MapPinEnhanced = select(2, ...)

---@type CallbackHandler-1.0
local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0");

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

---@class CallbackTarget
---@field RegisterCallback fun(self: CallbackTarget, event: string, func: function, ...)
---@field UnregisterCallback fun(self: CallbackTarget, event: string, func: function)
---@field UnregisterAllCallbacks fun(self: CallbackTarget, event: string)
local callbackTarget = {}
local callbackRegistry = CallbackHandler:New(callbackTarget, "RegisterCallback", "UnregisterCallback",
    "UnregisterAllCallbacks");

---@enum CallbackEvent
local CALLBACK_EVENTS = {
    MY_TEST_EVENT = "MY_TEST_EVENT"
}


---@param callbackEvent CallbackEvent
---@param func function
---@param ... any
function MapPinEnhanced:RegisterCallback(callbackEvent, func, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(CALLBACK_EVENTS[callbackEvent], "Callback event is not valid event")
    assert(func, "Function must be provided")

    callbackTarget:RegisterCallback(callbackEvent, func, ...)
end

---@param callbackEvent CallbackEvent
---@param func function
function MapPinEnhanced:UnregisterCallback(callbackEvent, func)
    assert(callbackEvent, "Callback event must be provided")
    assert(CALLBACK_EVENTS[callbackEvent], "Callback event is not valid event")
    assert(func, "Function must be provided")

    callbackTarget:UnregisterCallback(callbackEvent, func)
end

---@param callbackEvent CallbackEvent
---@param ... any
function MapPinEnhanced:FireCallback(callbackEvent, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(CALLBACK_EVENTS[callbackEvent], "Callback event is not valid event")
    callbackRegistry:Fire(callbackEvent, ...)
end

---Call a function with restricted access, ensuring it runs outside of combat.
---@param func function
---@param warning string|nil A warning message to display if the function is called while in combat
---@param ... unknown
function MapPinEnhanced:CallRestricted(func, warning, ...)
    local inCombat = InCombatLockdown()
    local args = { ... }
    if inCombat then
        if warning then
            self:Print(warning)
        end
        self:RegisterEvent("PLAYER_REGEN_ENABLED", function()
            self:UnregisterEvent("PLAYER_REGEN_ENABLED")
            func(unpack(args))
        end)
    else
        func(...)
    end
end
