---@meta

---@class pinData
---@field mapID number
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to autotrack this pin on creation
---@field title string?
---@field texture string?
---@field usesAtlas boolean?
---@field color string?


---@class PinObject
---@field pinID UUID
---@field worldmapPin MapPinEnhancedWorldMapPinMixin
---@field minimapPin MapPinEnhancedMinimapPinMixin
---@field TrackerPinEntry MapPinEnhancedTrackerPinEntryMixin
---@field pinData pinData
---@field Track fun()
---@field Untrack fun()
---@field IsTracked fun():boolean
---@field Remove fun()
---@field GetPinData fun():pinData


---@class SetObject
---@field setID UUID
---@field name string
---@field AddPin fun(self, pinData:pinData)
---@field RemovePin fun(self, mapID:string, x:number, y:number)
---@field Delete fun()
---@field GetPins fun():table<string, pinData>
---@field GetPin fun(self, mapID:string, x:number, y:number):pinData
---@field TrackerSetEntry MapPinEnhancedTrackerSetEntryMixin
---@field SetEditorEntry MapPinEnhancedTrackerSetEntryMixin


---@type table<string, table | number | string | boolean>
MapPinEnhancedDB = {}
