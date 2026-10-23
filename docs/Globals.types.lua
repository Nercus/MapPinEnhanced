---@meta

IN_GAME_NAVIGATION_RANGE = "%s |4yd:yds"
MAP_PIN = "Map Pin"

LE_PARTY_CATEGORY_HOME = 1

-- Current Retail macro constants are newer than the installed editor annotations.
---@type { MAX_ACCOUNT_MACROS: number, MAX_CHARACTER_MACROS: number }?
Constants.MacroConsts = nil

---@param questLogIndex number
---@return string? text
function GetQuestLogCompletionText(questLogIndex) end

-- QuestMapFrame passes true when displaying the destination instead of travel waypoints.
---@param questID number
---@param ignoreWaypoints boolean?
---@return number? mapID
function GetQuestUiMapID(questID, ignoreWaypoints) end

---@class NumyFunctionProfiler
NumyFunctionProfiler = {}

---@param addonName string
---@param moduleName string
---@param moduleTable table
function NumyFunctionProfiler:WrapModules(addonName, moduleName, moduleTable)
end
