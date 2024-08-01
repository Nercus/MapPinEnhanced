-- TODO: wrapper for settings are here: might want to use a similiar debounce method like https://gist.github.com/Meorawr/c8b09f8a0ffc0b9f3fc32494c8208194


---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options : Module
---@field CATEGORIES table<OPTIONCATEGORY, string>
local Options = MapPinEnhanced:CreateModule("Options")


---@enum OPTIONCATEGORY
local OptionCategories = {
    General = "General",
    Tracker = "Tracker",
    FloatingPin = "Floating Pin"
}

local CATEGORY_ORDER = {
    OptionCategories.General,
    OptionCategories.Tracker,
    OptionCategories.FloatingPin
}

Options.CATEGORIES = OptionCategories

function Options:SetOptionDisabledState()
end
