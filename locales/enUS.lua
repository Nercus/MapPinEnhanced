---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "enUS" then return end

---@class Locale
local L = MapPinEnhanced.L
L["General"] = "General"
L["Pins"] = "Pins"
L["Groups"] = "Groups"
L["Tracker"] = "Tracker"
L["Maps"] = "Maps"
L["Import/Export"] = "Import/Export"
L["Miscellaneous"] = "Miscellaneous"
L["Map Pin"] = "Map Pin"
L["Uncategorized Pins"] = "Uncategorized Pins"
L["Temporary Import"] = "Temporary Import"
L["Create a Pin at Your Current Location"] = "Create a Pin at Your Current Location"
L["Show Coordinates Display"] = "Show Coordinates Display"
L["Toggle the on-screen display of your current coordinates"] =
"Toggle the on-screen display of your current coordinates"
