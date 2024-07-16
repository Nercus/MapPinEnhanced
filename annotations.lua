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
---@field pinID string
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
---@field setID string
---@field name string
---@field AddPin fun(self, pinData:pinData)
---@field RemovePin fun(self, mapID:string, x:number, y:number)
---@field Delete fun()
---@field GetPins fun():table<string, pinData>
---@field GetPin fun(self, mapID:string, x:number, y:number):pinData
---@field TrackerSetEntry MapPinEnhancedTrackerSetEntryMixin
---@field SetEditorEntry MapPinEnhancedTrackerSetEntryMixin



---@param frameType string
---@param parent string?
---@param frameTemplate string?
---@param resetterFunc fun()?
---@param forbidden boolean?
---@return FramePool
function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden) end

---@class FramePool
local FramePool = {}
---@return string
function FramePool:GetTemplate() end

---@return Frame
function FramePool:Acquire() end

---@param obj Frame
---@return boolean success
function FramePool:Release(obj) end

function FramePool:ReleaseAll() end
