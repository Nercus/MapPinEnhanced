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
L["Options"] = "Options"
L["Import/Export"] = "Import/Export"
L["Miscellaneous"] = "Miscellaneous"
L["Map Pin"] = "Map Pin"
L["Uncategorized Pins"] = "Uncategorized Pins"
L["Temporary Import"] = "Temporary Import"
L["Create a Pin at Your Current Location"] = "Create a Pin at Your Current Location"
L["Show Coordinates Display"] = "Show Coordinates Display"
L["Toggle the on-screen display of your current coordinates"] =
"Toggle the on-screen display of your current coordinates"
L["Back"] = "Back"
L["Change Color"] = "Change Color"
L["Change Icon"] = "Change Icon"
L["Show on Map"] = "Show on Map"
L["Share to Chat"] = "Share to Chat"
L["Coordinates Display"] = "Coordinates Display"
L["Lock Coordinates Display"] = "Lock Coordinates Display"
L["Toggle whether the coordinates display can be moved or not."] =
"Toggle whether the coordinates display can be moved or not."
L["My Way Back"] = "My Way Back"
L["Open the import dialog to import map pins from a string."] =
"Open the import dialog to import map pins from a string."
L["Open the export dialog to export your map pins to a string."] =
"Open the export dialog to export your map pins to a string."
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"Failed to place pin on the map. Please check if the coordinates are correct!"
L["Click to edit"] = "Click to edit"

-- TODO: remove these test strings
L["test.checkbox_LABEL"] = "Test Checkbox"
L["test.checkbox_DESCRIPTION"] = "Description for the test checkbox"
L["test.colorpicker_LABEL"] = "Test Colorpicker"
L["test.colorpicker_DESCRIPTION"] = "Description for the test colorpicker"
L["test.input_LABEL"] = "Test Input"
L["test.input_DESCRIPTION"] = "Description for the test input"
L["test.radiogroup_LABEL"] = "Test Radiogroup"
L["test.radiogroup_DESCRIPTION"] = "Description for the test radiogroup"
L["test.toggle_LABEL"] = "Test Toggle"
L["test.toggle_DESCRIPTION"] = "Description for the test toggle"
L["test.slider_LABEL"] = "Test Slider"
L["test.slider_DESCRIPTION"] = "Description for the test slider"


L["test.checkbox2_LABEL"] = "Test Checkbox2"
L["test.checkbox2_DESCRIPTION"] = "Description for the test checkbox2"
L["test.checkbox3_LABEL"] = "Test Checkbox3"
L["test.checkbox3_DESCRIPTION"] = "Description for the test checkbox3"
L["test.checkbox4_LABEL"] = "Test Checkbox4"
L["test.checkbox4_DESCRIPTION"] = "Description for the test checkbox4"
L["test.checkbox5_LABEL"] = "Test Checkbox5"
L["test.checkbox5_DESCRIPTION"] = "Description for the test checkbox5"
L["test.group1_GROUPLABEL"] = "Group A"
