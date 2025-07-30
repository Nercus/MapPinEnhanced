---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers Providers are different ways to get pin or set information and insert that into MPH
local Providers = MapPinEnhanced:GetModule("Providers")

---@enum PIN_TEXTURE_OVERRIDES
local PIN_TEXTURE_OVERRIDES = {
    ["worldquest-questmarker-questbang"] = "worldquest-tracker-questmarker",
}


---Parses the blizzard map pin info from the mouse focus. This happens when ctrl clicking on the map
---@param mouseFocus table
---@return {name: string, texture: string?, isAtlas: boolean, x: number?, y: number?}
local function ParseBlizzardMapPinInfo(mouseFocus)
    assert(mouseFocus, "mouseFocus is required to parse the map pin info.")

    local name = mouseFocus.name ---@type string?
    if mouseFocus.questID then -- has a quest id so we can get the quest name
        local questTitle = C_QuestLog.GetTitleForQuestID(mouseFocus.questID)
        name = questTitle or nil
    end


    local isAtlas = false
    local texture = mouseFocus.texture ---@type string?
    ---@type AreaPOIInfo
    local poiInfo = mouseFocus.poiInfo
    if poiInfo and poiInfo.atlasName then
        texture = poiInfo.atlasName
        if PIN_TEXTURE_OVERRIDES[texture] then
            texture = PIN_TEXTURE_OVERRIDES[texture]
        end
        isAtlas = true
    end
    if mouseFocus.Display and mouseFocus.Display.Icon then
        ---@type string?
        texture = mouseFocus.Display.Icon:GetAtlas()
        isAtlas = true
    end

    local x, y = nil, nil
    if mouseFocus.normalizedX and mouseFocus.normalizedY then
        ---@type number
        x = mouseFocus.normalizedX
        ---@type number
        y = mouseFocus.normalizedY
    end
    return {
        name = name,
        texture = texture,
        isAtlas = isAtlas,
        x = x,
        y = y,
    }
end

---@class ScripRegionWithPinInfo : ScriptRegion
---@field pinTemplate string

---Detects the pin info of the mouse focus. This is used to get the name and texture of the pin.
---@return {name: string, texture: string?, isAtlas: boolean, x: number?, y: number?}|nil
function Providers:DetectMouseFocusPinInfo()
    ---@type ScripRegionWithPinInfo[]? we use that the mouse is actually over a pin element even though we don't know the the exact type here
    local mouseFocus = GetMouseFoci()
    if not mouseFocus then return end
    local pinTemplate = nil ---@type string?
    for _, mouseFocusTable in ipairs(mouseFocus) do
        pinTemplate = mouseFocusTable.pinTemplate
        if pinTemplate and (string.find(pinTemplate, "%a+PinTemplate")) then
            return ParseBlizzardMapPinInfo(mouseFocusTable)
        end
    end
    if not pinTemplate then return nil end
    return nil
end
