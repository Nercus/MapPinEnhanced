---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- SavedVariables load before XML. Run before optionMigrations and frame creation
-- so defaults and LibWindow registrations cannot hide the legacy preferences.
if MapPinEnhanced:GetVar("legacyOptionsMigrated") then return end

---@param key string
---@return table<string, any>
local function GetTable(key)
    local value = MapPinEnhanced:GetVar(key)
    return type(value) == "table" and value or {}
end

local global = GetTable("global")
local tracker = GetTable("tracker")
local floating = GetTable("floatingPin")
if not next(global) and not next(tracker) and
    not next(floating) and not MapPinEnhanced:GetVar("minimapIcon") then
    return
end

---@param value any
---@return boolean
local function IsNumber(value)
    return type(value) == "number" and value == value and math.abs(value) < math.huge
end

---@param value any
---@param ... string
local function SaveMissing(value, ...)
    if value == nil or MapPinEnhanced:GetVar(...) ~= nil then return end
    local keys = { ... } ---@type any[]
    keys[#keys + 1] = value
    MapPinEnhanced:SetVar(unpack(keys))
end

---@param key string
---@param value any
---@param valueType string
local function SaveOption(key, value, valueType)
    if type(value) == valueType then SaveMissing(value, "options", key) end
end

local minimap = GetTable("minimapIcon")
if not next(minimap) and type(global.minimap) == "table" then minimap = global.minimap end
for _, key in ipairs({ "hide", "lock", "showInCompartment" }) do
    if type(minimap[key]) == "boolean" then SaveMissing(minimap[key], "minimapButton", key) end
end
if IsNumber(minimap.minimapPos) then SaveMissing(minimap.minimapPos, "minimapButton", "minimapPos") end

if IsNumber(tracker.trackerScale) and tracker.trackerScale >= 0.5 and tracker.trackerScale <= 2 then
    -- optionMigrations applies the existing nearest-preset conversion.
    SaveMissing(tracker.trackerScale, "frames", "tracker", "scale")
end
if IsNumber(tracker.trackerHeight) then
    SaveOption("Miscellaneous.Tracker.MaximumRows", math.max(3, math.min(12, math.floor(tracker.trackerHeight))),
        "number")
end
if IsNumber(tracker.backgroundOpacity) and tracker.backgroundOpacity >= 0 and tracker.backgroundOpacity <= 1 then
    SaveOption("Miscellaneous.Tracker.BackgroundOpacity", tracker.backgroundOpacity * 100, "number")
end
SaveOption("Wayfinder.General.ShowETA", floating.showEstimatedTime, "boolean")

MapPinEnhanced:SetVar("legacyOptionsMigrated", true)
