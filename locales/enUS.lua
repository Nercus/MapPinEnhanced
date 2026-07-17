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
L["Collections (%d)"] = "Collections (%d)"
L["Pins (%d)"] = "Pins (%d)"
L["Search collections..."] = "Search collections..."
L["Search for option..."] = "Search for option..."

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
L["Rename Pin"] = "Rename Pin"
L["Pin Title"] = "Pin Title"
L["Save"] = "Save"
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
L["You can import pins or collections by pasting the either multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"You can import pins or collections by pasting the either multiple slash commands or a Map Pin Enhanced export string (starting with %s)"
L["Temporary import"] = "Temporary import"
L["Add to existing collection"] = "Add to existing collection"
L["Create new collection"] = "Create new collection"
L["Click to paste export string or slash commands here"] = "Click to paste export string or slash commands here"
L["Import"] = "Import"
L["Export"] = "Export"
L["Way commands"] = "Way commands"
L["Serialized data"] = "Serialized data"
L["Choose an export format, then copy the text below."] = "Choose an export format, then copy the text below."
L["Command prefix:"] = "Command prefix:"
L["Exporting %d pins across %d maps"] = "Exporting %d pins across %d maps"
L["Warning: /way commands only preserve pin titles. Custom icons and colors will be lost."] =
"Warning: /way commands only preserve pin titles. Custom icons and colors will be lost."
L["Cancel"] = "Cancel"
L["Yes"] = "Yes"
L["No"] = "No"
L["Enter collection name"] = "Enter collection name"
L["Do you want to import the collection '%s' from player '%s'?"] =
"Do you want to import the collection '%s' from player '%s'?"

L["Toggle the tracker visibility."] = "Toggle the tracker visibility."
L["Open the options frame"] = "Open the options frame"
L["Toggle display of your current coordinates on the screen."] =
"Toggle display of your current coordinates on the screen."

L["Loaded set \"%s\"."] = "Loaded set \"%s\"."
L["\"%s\" reached at %s."] = "\"%s\" reached at %s."
L["Location reached at %s."] = "Location reached at %s."
L["\"%s\" reached at %s."] = "\"%s\" reached at %s."
L["It is locked."] = "It is locked."
L["Location reached at %s."] = "Location reached at %s."
L["Cannot set waypoint on the %s map."] = "Cannot set waypoint on the %s map."

L["Close"] = "Close"
L["Version: %s (%s)"] = "Version: %s (%s)"
L["Build: %s"] = "Build: %s"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"] =
"Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"
L["Open the about dialog to view version information."] = "Open the about dialog to view version information."

------------------------------ Options ------------------------------
L["General.Distance_GROUPLABEL"] = "Distance"
L["General.Distance.ShowUnit_LABEL"] = "Show Distance Unit"
L["General.Distance.ShowUnit_DESCRIPTION"] = "Show the distance unit next to distance values."

L["Miscellaneous"] = "Miscellaneous"
L["Miscellaneous.Coords_GROUPLABEL"] = "Coordinates Display"
L["Miscellaneous.Coords.Enable_LABEL"] = "Enable Coordinates Display"
L["Miscellaneous.Coords.Enable_DESCRIPTION"] = "Toggle the on-screen display of your current coordinates"
L["Miscellaneous.Coords.Lock_LABEL"] = "Lock Coordinates Display"
L["Miscellaneous.Coords.Lock_DESCRIPTION"] = "Toggle whether the coordinates display can be moved or not."

L["Wayfinder"] = "Wayfinder"
L["Wayfinder.Floating_GROUPLABEL"] = "Floating"
L["Wayfinder.Floating.Enable_LABEL"] = "Enable Floating Wayfinder"
L["Wayfinder.Floating.Enable_DESCRIPTION"] =
"Show a floating wayfinder on your screen."
L["Wayfinder.Floating.Style_LABEL"] = "Floating Wayfinder Style"
L["Wayfinder.Floating.Style_DESCRIPTION"] =
"Choose the floating wayfinder style. Modern shows more info, Simple is more compact and works better with other addons."
L["Modern"] = "Modern"
L["Simple"] = "Simple"


L["Wayfinder.Arrow_GROUPLABEL"] = "Arrow"
L["Wayfinder.Arrow.Enable_LABEL"] = "Enable Arrow Wayfinder"
L["Wayfinder.Arrow.Enable_DESCRIPTION"] =
"Show an arrow on the world map pointing to the next waypoint in your route."
L["Wayfinder.Arrow.RotatePin_LABEL"] = "Rotate Center Pin"
L["Wayfinder.Arrow.RotatePin_DESCRIPTION"] =
"Rotate the pin in the middle of the arrow toward the next waypoint."
