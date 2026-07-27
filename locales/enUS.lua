---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "enUS" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Shared UI ------------------------------
L["Cancel"] = "Cancel"
L["Close"] = "Close"
L["Confirm"] = "Confirm"
L["Import"] = "Import"
L["Save"] = "Save"

L["Click to edit"] = "Click to edit"

------------------------------ Pins ------------------------------
L["Map Pin"] = "Map Pin"
L["Change Color"] = "Change Color"
L["Change Icon"] = "Change Icon"
L["Atlas"] = "Atlas"
L["Color"] = "Color"
L["Icon"] = "Icon"
L["Locked"] = "Locked"
L["Map"] = "Map"
L["Name"] = "Name"
L["X"] = "X"
L["Y"] = "Y"
L["Show on Map"] = "Show on Map"
L["Mark Reached"] = "Mark Reached"
L["Delete Pin"] = "Delete Pin"
L["Delete pin \"%s\"?"] = "Delete pin \"%s\"?"
L["Share to Chat"] = "Share to Chat"
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"Failed to place pin on the map. Please check if the coordinates are correct!"
L["Can't Show on Map in Combat"] = "Can't Show on Map in Combat"
L["The world map cannot be opened automatically during combat. It will open after combat ends."] =
"The world map cannot be opened automatically during combat. It will open after combat ends."

------------------------------ Groups And Tracker ------------------------------
L["Group"] = "Group"
L["Hidden"] = "Hidden"
L["Hidden Groups"] = "Hidden Groups"
L["No hidden groups"] = "No hidden groups"
L["Pins (%d/%d)"] = "Pins (%d/%d)"
L["New Group %d"] = "New Group %d"
L["Ungrouped Pins"] = "Ungrouped Pins"
L["My Way Back"] = "My Way Back"
L["Import %d"] = "Import %d"
L["%d |4pin:pins;"] = "%d |4pin:pins;"
L["A group named \"%s\" already exists."] = "A group named \"%s\" already exists."
L["Rename Group"] = "Rename Group"
L["Delete Group"] = "Delete Group"
L["Clear Group"] = "Clear Group"
L["Clear Ungrouped Pins"] = "Clear Ungrouped Pins"
L["Show Group"] = "Show Group"
L["Hide Group"] = "Hide Group"
L["Show Reached Pins Again"] = "Show Reached Pins Again"
L["Delete group \"%s\" and all of its pins?"] = "Delete group \"%s\" and all of its pins?"
L["Clear all pins from \"%s\"?"] = "Clear all pins from \"%s\"?"
L["Ungrouped Pins is nearing its 100-pin limit (%d/100). Oldest reached pins will be removed first."] =
"Ungrouped Pins is nearing its 100-pin limit (%d/100). Oldest reached pins will be removed first."
L["Oldest reached pins removed from Ungrouped Pins: %d."] =
"Oldest reached pins removed from Ungrouped Pins: %d."
L["Tracking Mode"] = "Tracking Mode"
L["Track by Distance"] = "Track by Distance"
L["Track by Order"] = "Track by Order"
L["Toggle the tracker visibility."] = "Toggle the tracker visibility."
L["Toggle the group editor."] = "Toggle the group editor."

------------------------------ Editor ------------------------------
L["Editor"] = "Editor"
L["Contents"] = "Contents"
L["Search"] = "Search"
L["Rename Pin"] = "Rename Pin"

------------------------------ Dialogs ------------------------------
L["Info"] = "Info"
L["Version: %s (%s)"] = "Version: %s (%s)"
L["Build: %s"] = "Build: %s"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"] =
"Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"
L["Open the about dialog to view version information."] = "Open the about dialog to view version information."

------------------------------ Transfer ------------------------------
L["Export"] = "Export"
L["Way commands"] = "Way commands"
L["Serialized data"] = "Serialized data"
L["Open the import dialog to import map pins from a string."] =
"Open the import dialog to import map pins from a string."
L["Open the export dialog to export your map pins to a string."] =
"Open the export dialog to export your map pins to a string."
L["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"
L["Click to paste export string or slash commands here"] = "Click to paste export string or slash commands here"
L["Choose an export format, then copy the text below."] = "Choose an export format, then copy the text below."
L["Command prefix:"] = "Command prefix:"
L["Exporting %d pins across %d maps"] = "Exporting %d pins across %d maps"
L["%s: %d pins across %d maps"] = "%s: %d pins across %d maps"
L["%d invalid entries will be skipped"] = "%d invalid entries will be skipped"
L["Invalid or corrupted serialized data."] = "Invalid or corrupted serialized data."
L["No valid pins were found to import."] = "No valid pins were found to import."
L["Imported %d pins; skipped %d invalid entries."] = "Imported %d pins; skipped %d invalid entries."
L["Import failed."] = "Import failed."
L["Warning: /way commands only preserve pin titles. Custom icons and colors will be lost."] =
"Warning: /way commands only preserve pin titles. Custom icons and colors will be lost."

------------------------------ Providers ------------------------------
L["%s added hidden group \"%s\"."] = "%s added hidden group \"%s\"."
L["TomTom Pins"] = "TomTom Pins"
L["TomTom Waypoint"] = "TomTom Waypoint"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"TomTom Is Loaded! You may experience some unexpected behavior."
L["\"%s\" reached at %s."] = "\"%s\" reached at %s."
L["Location reached at %s."] = "Location reached at %s."
L["It is locked."] = "It is locked."
L["Cannot set waypoint on the %s map."] = "Cannot set waypoint on the %s map."

------------------------------ Miscellaneous ------------------------------
L["Back"] = "Back"
L["Create a Pin at Your Current Location"] = "Create a Pin at Your Current Location"
L["Toggle display of your current coordinates on the screen."] =
"Toggle display of your current coordinates on the screen."
L["Unable to determine your current map location."] = "Unable to determine your current map location."
L["Unable to determine your current position on the map."] = "Unable to determine your current position on the map."
L["%s's Position"] = "%s's Position"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"You Are in an Instance or a Zone Where the Map Is Not Available"
L["My Way Back group not found. Please create it first."] = "My Way Back group not found. Please create it first."

------------------------------ Options ------------------------------
L["General"] = "General"
L["Miscellaneous"] = "Miscellaneous"
L["Wayfinder"] = "Wayfinder"
L["Search for option..."] = "Search for option..."
L["Open the options frame"] = "Open the options frame"

L["General.Distance_GROUPLABEL"] = "Distance"
L["General.Distance.ShowUnit_LABEL"] = "Show Distance Unit"
L["General.Distance.ShowUnit_DESCRIPTION"] = "Show the distance unit next to distance values."
L["General.Tracking_GROUPLABEL"] = "Tracking"
L["General.Tracking.DefaultMode_LABEL"] = "Default Tracking Mode"
L["General.Tracking.DefaultMode_DESCRIPTION"] =
"Choose how newly created groups select the next pin to track."

L["Miscellaneous.Coords_GROUPLABEL"] = "Coordinates Display"
L["Miscellaneous.Coords.Enable_LABEL"] = "Enable Coordinates Display"
L["Miscellaneous.Coords.Enable_DESCRIPTION"] = "Toggle the on-screen display of your current coordinates"
L["Miscellaneous.Coords.Lock_LABEL"] = "Lock Coordinates Display"
L["Miscellaneous.Coords.Lock_DESCRIPTION"] = "Toggle whether the coordinates display can be moved or not."

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
