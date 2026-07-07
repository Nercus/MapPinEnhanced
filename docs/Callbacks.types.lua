---@meta

---@class MapPinEnhanced
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", func: fun(eventname: string, isTracked: boolean), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", func: fun(eventname: string, title: string), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", func: fun(eventname: string, texture: string, usesAtlas: boolean), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", func: fun(eventname: string, color: PinColor), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_LOCK", func: fun(eventname: string, lock: boolean), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_ADDED", func: fun(eventname: string, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin))
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_REMOVED", func: fun(eventname: string, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin))
---@field RegisterCallback fun(self: MapPinEnhanced, event: "GROUP_UPDATED", func: fun(eventname: string, group: MapPinEnhancedGroupMixin))
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_TRACKING_CHANGED", func: fun(eventname: string, pinID: UUID, isTracked: boolean))
MapPinEnhanced = {}

---@class MapPinEnhanced
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", key: string, isTracked: boolean)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", key: string, title: string)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", key: string, texture: string, usesAtlas: boolean)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", key: string, color: PinColor)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_LOCK", key: string, lock: boolean)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_ADDED", key: nil, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_REMOVED", key: nil, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin)
---@field FireCallback fun(self: MapPinEnhanced, event: "GROUP_UPDATED", key: nil, group: MapPinEnhancedGroupMixin)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_TRACKING_CHANGED", key: nil, pinID: UUID, isTracked: boolean)
MapPinEnhanced = {}

---@class MapPinEnhanced
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", func: fun(eventname: string, isTracked: boolean), key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", func: fun(eventname: string, title: string), key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", func: fun(eventname: string, texture: string, usesAtlas: boolean), key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", func: fun(eventname: string, color: PinColor), key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_LOCK", func: fun(eventname: string, lock: boolean), key: string)
MapPinEnhanced = {}
