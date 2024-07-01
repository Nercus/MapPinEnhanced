---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")

---@class PinManager
local PinManager = MapPinEnhanced:GetModule("PinManager")


-- TODO: add a function to register a callback so other addons know when a pin is added
-- TODO: add a wrapper to parse tomtom pin info
local globalMapPinEnhanced = {}
globalMapPinEnhanced.AddPin = PinManager.AddPin

---@type table
_G[MapPinEnhanced.addonName] = globalMapPinEnhanced
