---@diagnostic disable: duplicate-doc-field
---@meta


---@class MapPinEnhancedDB
---@field general General
---@field tracker Tracker
---@field floatingPin FloatingPin
---@field minimapIcon MinimapIcon
---@field trackerPosition TrackerPosition
---@field trackerVisible boolean
---@field devMode boolean
---@field loadedAddons table<string, boolean>
---@field version number
MapPinEnhancedDB = {}

---@class TrackerPosition
---@field x number
---@field y number

---@class FloatingPin
---@field unlimitedDistance boolean
---@field showEstimatedTime boolean
---@field showTitle boolean
---@field blockWorldQuestTracking boolean

---@class MinimapIcon
---@field hide boolean
---@field lock boolean
---@field minimapPos number

---@class General
---@field editorScale number
---@field autoTrackNearestPin boolean

---@class Tracker
---@field autoVisibility string
---@field lockTracker boolean
---@field trackerScale number
---@field backgroundOpacity number
---@field showNumbering boolean
---@field trackerHeight number

--------------ALL THE ANNOTATIONS FOR THE OLD DB STRUCTURE--------------

---@class OldMapPinEnhancedDB
---@field global {options: {autoOpenTracker: boolean, showInfoOnSuperTrackedFrame: boolean, showTimeOnSuperTrackedFrame: boolean, changedalpha: boolean, maxTrackerEntries: number, autoTrackNearest: boolean}, presets: {name: string, input: string}[]}

---@class SavedVars
---@field Delete fun(_, key1: "global")
---@field Delete fun(_, key1: "profileKeys")
---@field Delete fun(_, key1: "profiles")


-------------------------------------------------------------------------


---@class SavedVars
---@field Save fun(_, key1: "devMode", key2: boolean) Development mode is enabled/disabled
---@field Save fun(_, key1: "loadedAddons", key2: string[]) List of loaded addons before entering the development mode
---@field Save fun(_, key1: "version", key2: number) Last version of the addon
---@field Save fun(_, key1: "superTrackingOther", key2: boolean) Whether the super tracking is set to something other than the userwaypoint
---@field Save fun(_, key1: "sections", key2: table<string, {info: SectionInfo, pins: pinData[]}>) Save all sections
---@field Save fun(_, key1: "sections", key2: string, key3: {info: SectionInfo, pins: pinData[]}) Save a section
---@field Save fun(_, key1: "sections", key2: string, key3: "pins", key4: UUID, key5: pinData) Save a pin in a section
---@field Save fun(_, key1: "sets", key2: table<UUID, reducedSet>) Save all sets
---@field Save fun(_, key1: "sets", key2: UUID, key3: reducedSet) Save a set
---@field Save fun(_, key1: "general", key2: "autoTrackNearestPin", key3: boolean)
---@field Save fun(_, key1: "general", key2: "editorScale", key3: number)
---@field Save fun(_, key1: "tracker", key2: "autoVisibility", key3: string)
---@field Save fun(_, key1: "tracker", key2: "lockTracker", key3: boolean)
---@field Save fun(_, key1: "tracker", key2: "trackerScale", key3: number)
---@field Save fun(_, key1: "tracker", key2: "backgroundOpacity", key3: number)
---@field Save fun(_, key1: "tracker", key2: "showNumbering", key3: boolean)
---@field Save fun(_, key1: "tracker", key2: "trackerHeight", key3: number)
---@field Save fun(_, key1: "minimapIcon", key2: "hide", key3: boolean)
---@field Save fun(_, key1: "minimapIcon", key2: "lock", key3: boolean)
---@field Save fun(_, key1: "minimapIcon", key2: "minimapPos", key3: number)
---@field Save fun(_, key1: "floatingPin", key2: "unlimitedDistance", key3: boolean)
---@field Save fun(_, key1: "floatingPin", key2: "showEstimatedTime", key3: boolean)
---@field Save fun(_, key1: "floatingPin", key2: "showTitle", key3: boolean)
---@field Save fun(_, key1: "floatingPin", key2: "blockWorldQuestTracking", key3: boolean)
---@field Save fun(_, key1: "trackerPosition", key2: "x", key3: number)
---@field Save fun(_, key1: "trackerPosition", key2: "y", key3: number)
---@field Save fun(_, key1: "trackerPosition", key2: TrackerPosition)
---@field Save fun(_, key1: "trackerVisible", key2: boolean)



---@class SavedVars
---@field Get fun(_, key1: "devMode"): boolean?
---@field Get fun(_, key1: "loadedAddons"): string[]?
---@field Get fun(_, key1: "version"): number?
---@field Get fun(_, key1: "superTrackingOther"): boolean?
---@field Get fun(_, key1: "sections"): table<string, {info: SectionInfo, pins: pinData[]}>?
---@field Get fun(_, key1: "sections", key2: string): {info: SectionInfo, pins: pinData[]}?
---@field Get fun(_, key1: "sections", key2: string, key3: "pins", key4: UUID): pinData?
---@field Get fun(_, key1: "sets"): table<UUID, reducedSet>?
---@field Get fun(_, key1: "sets", key2: UUID): reducedSet?
---@field Get fun(_, key1: "general", key2: "autoTrackNearestPin"): boolean?
---@field Get fun(_, key1: "general", key2: "editorScale"): number?
---@field Get fun(_, key1: "tracker", key2: "autoVisibility"): string?
---@field Get fun(_, key1: "tracker", key2: "lockTracker"): boolean?
---@field Get fun(_, key1: "tracker", key2: "trackerScale"): number#?
---@field Get fun(_, key1: "tracker", key2: "backgroundOpacity"): number?
---@field Get fun(_, key1: "tracker", key2: "showNumbering"): boolean?
---@field Get fun(_, key1: "tracker", key2: "trackerHeight"): number?
---@field Get fun(_, key1: "minimapIcon", key2: "hide"): boolean?
---@field Get fun(_, key1: "minimapIcon", key2: "lock"): boolean?
---@field Get fun(_, key1: "minimapIcon", key2: "minimapPos"): number?
---@field Get fun(_, key1: "floatingPin", key2: "unlimitedDistance"): boolean?
---@field Get fun(_, key1: "floatingPin", key2: "showEstimatedTime"): boolean?
---@field Get fun(_, key1: "floatingPin", key2: "showTitle"): boolean?
---@field Get fun(_, key1: "floatingPin", key2: "blockWorldQuestTracking"): boolean?
---@field Get fun(_, key1: "trackerPosition", key2: "x"): number?
---@field Get fun(_, key1: "trackerPosition", key2: "y"): number?
---@field Get fun(_, key1: "trackerPosition"): TrackerPosition?
---@field Get fun(_, key1: "trackerVisible"): boolean?



---@class SavedVars
---@field GetDefault fun(_, key1: "general", key2: "autoTrackNearestPin"): boolean?
---@field GetDefault fun(_, key1: "general", key2: "editorScale"): number?
---@field GetDefault fun(_, key1: "tracker", key2: "autoVisibility"): string?
---@field GetDefault fun(_, key1: "tracker", key2: "lockTracker"): boolean?
---@field GetDefault fun(_, key1: "tracker", key2: "trackerScale"): number#?
---@field GetDefault fun(_, key1: "tracker", key2: "backgroundOpacity"): number?
---@field GetDefault fun(_, key1: "tracker", key2: "showNumbering"): boolean?
---@field GetDefault fun(_, key1: "tracker", key2: "trackerHeight"): number?
---@field GetDefault fun(_, key1: "minimapIcon", key2: "hide"): boolean?
---@field GetDefault fun(_, key1: "minimapIcon", key2: "lock"): boolean?
---@field GetDefault fun(_, key1: "minimapIcon", key2: "minimapPos"): number?
---@field GetDefault fun(_, key1: "floatingPin", key2: "unlimitedDistance"): boolean?
---@field GetDefault fun(_, key1: "floatingPin", key2: "showEstimatedTime"): boolean?
---@field GetDefault fun(_, key1: "floatingPin", key2: "showTitle"): boolean?
---@field GetDefault fun(_, key1: "floatingPin", key2: "blockWorldQuestTracking"): boolean?
---@field GetDefault fun(_, key1: "trackerPosition", key2: "x"): number?
---@field GetDefault fun(_, key1: "trackerPosition", key2: "y"): number?
---@field GetDefault fun(_, key1: "trackerPosition"): TrackerPosition?
---@field GetDefault fun(_, key1: "trackerVisible"): boolean?



---@class SavedVars
---@field Delete fun(_, key1: "devMode")
---@field Delete fun(_, key1: "loadedAddons")
---@field Delete fun(_, key1: "version")
---@field Delete fun(_, key1: "superTrackingOther")
---@field Delete fun(_, key1: "sections")
---@field Delete fun(_, key1: "sections", key2: string)
---@field Delete fun(_, key1: "sections", key2: string, key3: "pins", key4: UUID)
---@field Delete fun(_, key1: "sets")
---@field Delete fun(_, key1: "sets", key2: UUID)
---@field Delete fun(_, key1: "general", key2: "autoTrackNearestPin")
---@field Delete fun(_, key1: "general", key2: "editorScale")
---@field Delete fun(_, key1: "tracker", key2: "autoVisibility")
---@field Delete fun(_, key1: "tracker", key2: "lockTracker")
---@field Delete fun(_, key1: "tracker", key2: "trackerScale")
---@field Delete fun(_, key1: "tracker", key2: "backgroundOpacity")
---@field Delete fun(_, key1: "tracker", key2: "showNumbering")
---@field Delete fun(_, key1: "tracker", key2: "trackerHeight")
---@field Delete fun(_, key1: "minimapIcon", key2: "hide")
---@field Delete fun(_, key1: "minimapIcon", key2: "lock")
---@field Delete fun(_, key1: "minimapIcon", key2: "minimapPos")
---@field Delete fun(_, key1: "floatingPin", key2: "unlimitedDistance")
---@field Delete fun(_, key1: "floatingPin", key2: "showEstimatedTime")
---@field Delete fun(_, key1: "floatingPin", key2: "showTitle")
---@field Delete fun(_, key1: "floatingPin", key2: "blockWorldQuestTracking")
---@field Delete fun(_, key1: "trackerPosition", key2: "x")
---@field Delete fun(_, key1: "trackerPosition", key2: "y")
---@field Delete fun(_, key1: "trackerPosition")
---@field Delete fun(_, key1: "trackerVisible")
