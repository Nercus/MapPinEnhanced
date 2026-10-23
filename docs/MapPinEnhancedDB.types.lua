---@meta

---@class MapPinEnhancedSavedFramePosition
---@field x number?
---@field y number?
---@field point string?
---@field scale number?
---@field fixedPosition boolean? Tracker position has been converted to its fixed-size owner.

---@class MapPinEnhancedMinimapSettings
---@field hide boolean?
---@field minimapPos number?
---@field lock boolean?
---@field showInCompartment boolean?

---@class MapPinEnhancedDB
---@field legacyOptionsMigrated boolean? Legacy preferences were copied; source fields remain for recovery.
---@field legacyGroupsMigrated boolean? Legacy pins/sets were copied once; source fields remain for recovery.
---@field options table<string, number|string|boolean|table>? Category.OptionName keys.
---@field startupWizard StartupProgress? Account introduction progress.
---@field trackerVisible boolean?
---@field trackerMinimized boolean?
---@field minimapButton MapPinEnhancedMinimapSettings? LibDBIcon visibility, position and compartment preferences.
---@field flightTimer table<string, NavigationSavedFlight>? Character-scoped active flight for reload recovery.
---@field learnedTaxiNodes table<string, table<number, boolean>>? Character-scoped positive discoveries observed at flight masters.
---@field taxiNodeMaps table<string, table<number, NavigationTaxiNodeState[]>>? Plain character-scoped node metadata refreshed only at flight masters.
---@field groups table<UUID, SaveableGroupData>?
---@field frames table<string, MapPinEnhancedSavedFramePosition>?
---@field notificationOffsetY number? Shared notification offset from the top of UIParent.
---@field hearthstoneDestinations table<string, NavigationHearthstoneDestination>? Character-scoped home bind coordinates.
---@field campDestinations table<string, NavigationCampDestination>? Character-scoped observed Vulpera camps.
---@field toyGossipOptions table<string, table<number, boolean>>? Character-scoped toy/spell destination availability by globally unique gossip option ID; historical key retained.
---@field hearthstoneToys table<string, number>? Character-scoped last successfully used home-bind toy item IDs.
---@field navigationEquipment table<string, table<integer, NavigationEquipmentRestore>>? Character-scoped pending travel-gear restoration by equipment slot.
MapPinEnhancedDB = {}
