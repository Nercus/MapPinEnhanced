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



---@class OldMapPinEnhancedDB
---@field global {options: {autoOpenTracker: boolean, showInfoOnSuperTrackedFrame: boolean, showTimeOnSuperTrackedFrame: boolean, changedalpha: boolean, maxTrackerEntries: number, autoTrackNearest: boolean}, presets: {name: string, input: string}[]}
