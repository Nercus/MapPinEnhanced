---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinProvider : Module
local PinProvider = Wayfinder:GetModule("PinProvider")

---@class PinManager
local PinManager = Wayfinder:GetModule("PinManager")


--- TODO: add a function to register a callback so other addons now when a pin is added
--- TODO: add a wrapper to parse tomtom pin info
local globalWayfinder = {}
globalWayfinder.AddPin = PinManager.AddPin

---@type table
_G[Wayfinder.addonName] = globalWayfinder
