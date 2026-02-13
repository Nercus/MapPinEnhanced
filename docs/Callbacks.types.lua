---@meta

---@class MapPinEnhanced
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", func: fun(eventname: string, isTracked: boolean), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", func: fun(eventname: string, title: string), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", func: fun(eventname: string, iconInfo: PinIcon), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", func: fun(eventname: string, color: ColorMixin), key: string)
---@field RegisterCallback fun(self: MapPinEnhanced, event: "PIN_ADDED", func: fun(eventname: string, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin))
---@field RegisterCallback fun(self: MapPinEnhanced, event: "GROUP_UPDATED", func: fun(eventname: string, group: MapPinEnhancedGroupMixin))
MapPinEnhanced = {}

---@class MapPinEnhanced
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", key: string, isTracked: boolean)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", key: string, title: string)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", key: string, iconInfo: PinIcon)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", key: string, color: ColorMixin)
---@field FireCallback fun(self: MapPinEnhanced, event: "PIN_ADDED", key: nil, group: MapPinEnhancedGroupMixin, pin: MapPinEnhancedPinMixin)
---@field FireCallback fun(self: MapPinEnhanced, event: "GROUP_UPDATED", key: nil, group: MapPinEnhancedGroupMixin)
MapPinEnhanced = {}

---@class MapPinEnhanced
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TRACKING", key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_TITLE", key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_ICON", key: string)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: "PIN_UPDATED_COLOR", key: string)
MapPinEnhanced = {}
