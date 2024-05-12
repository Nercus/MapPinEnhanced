---@type string
local AddOnName = ...

---@class Wayfinder
local Wayfinder = select(2, ...)

Wayfinder.version = C_AddOns.GetAddOnMetadata("Wayfinder", "Version")
Wayfinder.addonName = AddOnName
Wayfinder.isWrath = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
Wayfinder.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
Wayfinder.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Wayfinder.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
