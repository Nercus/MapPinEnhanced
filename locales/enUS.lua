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
L["Icon Picker"] = "Icon Picker"
L["More..."] = "More..."
L["Select an icon"] = "Select an icon"
L["%d icons"] = "%d icons"
L["%d icons (loading...)"] = "%d icons (loading...)"
L["Import"] = "Import"
L["Save"] = "Save"

L["Click to edit"] = "Click to edit"

------------------------------ Pins ------------------------------
L["Map Pin"] = "Map Pin"
L["Target"] = "Target"
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
L["Groups"] = "Groups"
L["Create Group"] = "Create Group"
L["Select"] = "Select"
L["Select a group to start editing."] = "Select a group to start editing."
L["Show"] = "Show"
L["Hide"] = "Hide"
L["Ungrouped Pins"] = "Ungrouped Pins"
L["My Way Back"] = "My Way Back"
L["Import %d"] = "Import %d"
L["%d |4pin:pins;"] = "%d |4pin:pins;"
L["A group named \"%s\" already exists."] = "A group named \"%s\" already exists."
L["Rename Group"] = "Rename Group"
L["Add to New Group"] = "Add to New Group"
L["Delete Group"] = "Delete Group"
L["Clear Group"] = "Clear Group"
L["Clear Ungrouped Pins"] = "Clear Ungrouped Pins"
L["Show Group"] = "Show Group"
L["Hide Group"] = "Hide Group"
L["Show Reached Pins Again"] = "Show Reached Pins Again"
L["Delete group \"%s\" and all of its pins?"] = "Delete group \"%s\" and all of its pins?"
L["Clear all pins from \"%s\"?"] = "Clear all pins from \"%s\"?"
L["To maintain performance, Ungrouped Pins normally keeps up to 100 pins. It currently has %d; older pins will be removed automatically as more pins are reached."] =
"To maintain performance, Ungrouped Pins normally keeps up to 100 pins. It currently has %d; older pins will be removed automatically as more pins are reached."
L["Tracking Mode"] = "Tracking Mode"
L["Track by Distance"] = "Track by Distance"
L["Track by Order"] = "Track by Order"
L["Toggle the tracker visibility."] = "Toggle the tracker visibility."
L["Dungeon"] = "Dungeon"
L["Raid"] = "Raid"
L["Scenario"] = "Scenario"
L["Battleground"] = "Battleground"
L["Arena"] = "Arena"
L["None"] = "None"
L["No active pins"] = "No active pins"
L["No coordinates available"] = "No coordinates available"
L["Miscellaneous.Coords.Visibility_LABEL"] = "Automatic hide"
L["Miscellaneous.Coords.Visibility_DESCRIPTION"] =
"Hide the coordinate display when any selected condition is active."
L["Miscellaneous.Tracker_GROUPLABEL"] = "Tracker"
L["Miscellaneous.Tracker.Visibility_LABEL"] = "Automatic hide"
L["Miscellaneous.Tracker.Visibility_DESCRIPTION"] =
"Hide the tracker when any selected condition is active."
L["Toggle the group editor."] = "Toggle the group editor."

------------------------------ Editor ------------------------------
L["Editor"] = "Editor"
L["Edit Group"] = "Edit Group"
L["Contents"] = "Contents"
L["Search"] = "Search"
L["Rename Pin"] = "Rename Pin"
L["Optimize"] = "Optimize"
L["Optimize Route"] = "Optimize Route"
L["Optimizing will permanently reorder every pin in this group and cannot be undone."] =
"Optimizing will permanently reorder every pin in this group and cannot be undone."
L["Route optimization was canceled because the group changed."] =
"Route optimization was canceled because the group changed."
L["Loading"] = "Loading"

------------------------------ Dialogs ------------------------------
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
L["Warning: slash commands do not preserve custom icons or colors. /mappin also omits pin titles."] =
"Warning: slash commands do not preserve custom icons or colors. /mappin also omits pin titles."

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
L["Accept: %s"] = "Accept: %s"
L["Turn in: %s"] = "Turn in: %s"
L["%s — %s"] = "%s — %s"
L["Corpse"] = "Corpse"
L["Quest"] = "Quest"
L["Content"] = "Content"
L["Vignette"] = "Vignette"
L["House"] = "House"
L["%s's House"] = "%s's House"
L["Tracked %s could not be resolved as a location (%s). Please provide this information to the addon author."] =
"Tracked %s could not be resolved as a location (%s). Please provide this information to the addon author."
L["Unsupported super-tracking target (%s). Please provide this information to the addon author."] =
"Unsupported super-tracking target (%s). Please provide this information to the addon author."

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
L["My Way Back is unavailable on the map you are on right now."] =
"My Way Back is unavailable on the map you are on right now."

------------------------------ Options ------------------------------
L["General"] = "General"
L["Pins"] = "Pins"
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
L["General.Tracking.ArrivalMode_LABEL"] = "Wayfinder Arrival Detection"
L["General.Tracking.ArrivalMode_DESCRIPTION"] =
"Dynamic adjusts the arrival distance based on your approach speed. Static completes a target as soon as you are within 10 metres."
L["Dynamic"] = "Dynamic"
L["Static"] = "Static"
L["Reload UI"] = "Reload UI"
L["This change requires a UI reload. Reload now?"] = "This change requires a UI reload. Reload now?"

L["Pins.Miscellaneous_GROUPLABEL"] = "Miscellaneous"
L["Pins.Miscellaneous.ScaleOnHover_LABEL"] = "Scale Pins on Hover"
L["Pins.Miscellaneous.ScaleOnHover_DESCRIPTION"] =
"Enlarge world map while the mouse is over them."

L["Miscellaneous.Coords_GROUPLABEL"] = "Coordinates Display"
L["Miscellaneous.Coords.Enable_LABEL"] = "Enable Coordinates Display"
L["Miscellaneous.Coords.Enable_DESCRIPTION"] = "Toggle the on-screen display of your current coordinates"
L["Miscellaneous.Coords.Lock_LABEL"] = "Lock Coordinates Display"
L["Miscellaneous.Coords.Lock_DESCRIPTION"] = "Toggle whether the coordinates display can be moved or not."

L["Wayfinder.General_GROUPLABEL"] = "General"
L["Wayfinder.General.HideBlizzardFloatingDiamond_LABEL"] = "Hide Blizzard Floating Diamond"
L["Wayfinder.General.HideBlizzardFloatingDiamond_DESCRIPTION"] =
"Hide Blizzard's floating navigation diamond when the Map Pin Enhanced floating wayfinder is disabled."
L["Wayfinder.General.ReadoutMode_LABEL"] = "Readout"
L["Wayfinder.General.ReadoutMode_DESCRIPTION"] =
"Choose whether wayfinders show the ETA, distance, both values, or cycle between them."
L["ETA"] = "ETA"
L["Distance"] = "Distance"
L["Combined"] = "Combined"
L["Cycling"] = "Cycling"
L["%s - %s"] = "%s - %s"
L["Wayfinder.Floating_GROUPLABEL"] = "Floating"
L["Wayfinder.Floating.Enable_LABEL"] = "Enable Floating Wayfinder"
L["Wayfinder.Floating.Enable_DESCRIPTION"] =
"Show a floating wayfinder on your screen."
L["Wayfinder.Floating.Style_LABEL"] = "Floating Wayfinder Style"
L["Wayfinder.Floating.Style_DESCRIPTION"] =
"Choose the floating wayfinder style. Enhanced shows more information; Basic is compact and works better with other addons."
L["Enhanced"] = "Enhanced"
L["Basic"] = "Basic"
L["System Groups"] = "System Groups"
L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."] =
"System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."


L["Wayfinder.Arrow_GROUPLABEL"] = "Arrow"
L["Wayfinder.Arrow.Enable_LABEL"] = "Enable Arrow Wayfinder"
L["Wayfinder.Arrow.Enable_DESCRIPTION"] =
"Show an arrow on the world map pointing to the next waypoint in your route."
L["Wayfinder.Arrow.RotatePin_LABEL"] = "Rotate Center Pin"
L["Wayfinder.Arrow.RotatePin_DESCRIPTION"] =
"Rotate the pin in the middle of the arrow toward the next waypoint."
