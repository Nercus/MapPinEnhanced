---@meta

---@class MapPinEnhancedSavedFramePosition
---@field x number?
---@field y number?
---@field point string?
---@field scale number?
---@field fixedPosition boolean? Tracker position has been converted to its fixed-size owner.

---@class MapPinEnhancedDB
---@field groups table<UUID, SaveableGroupData>?
---@field frames table<string, MapPinEnhancedSavedFramePosition>?
---@field notificationOffsetY number? Shared notification offset from the top of UIParent.
---@field hearthstoneDestinations table<string, NavigationHearthstoneDestination>? Character-scoped home bind coordinates.
MapPinEnhancedDB = {}
