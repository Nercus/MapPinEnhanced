---@meta
---@class MapPinEnhanced
---@field RegisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', func: fun(eventname: string, attribute: 'TRACKING', isTracked: boolean), key: UUID)
---@field FireCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID, attribute: 'TRACKING', isTracked: boolean)
---@field RegisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', func: fun(eventname: string, attribute: 'TITLE', title: string), key: UUID)
---@field FireCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID, attribute: 'TITLE', title: string))
---@field RegisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', func: fun(eventname: string, attribute: 'TOOLTIP', tooltipData: PinTooltip), key: UUID)
---@field FireCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID, attribute: 'TOOLTIP', tooltipData: PinTooltip)
---@field RegisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', func: fun(eventname: string, attribute: 'ICON', iconInfo: PinIcon), key: UUID)
---@field FireCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID, attribute: 'ICON', iconInfo: PinIcon)
---@field RegisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', func: fun(eventname: string, attribute: 'COLOR', color: PinColor), key: UUID)
---@field FireCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID, attribute: 'COLOR', color: PinColor)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: 'PIN_UPDATED', key: UUID)
MapPinEnhanced = {}


-- TODO: the typings don't match the actual implementation, adjust again -> Use one event per attribute -> So PIN_UPDATED_COLOR_<pinid> or something like that
