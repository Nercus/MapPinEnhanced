---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Collections
local Collections = MapPinEnhanced:GetModule("Collections")
---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@alias CollectionColor PinColor
Collections.COLLECTION_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME

---@type CollectionColor
Collections.DEFAULT_COLOR = Pins.DEFAULT_COLOR
