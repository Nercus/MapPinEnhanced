---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinProvider : Module
local PinProvider = Wayfinder:GetModule("PinProvider")

---@class PinManager
local PinManager = Wayfinder:GetModule("PinManager")

local globalWayfinder = {}
globalWayfinder.AddPin = PinManager.AddPin

---@type table
_G[Wayfinder.addonName] = globalWayfinder
