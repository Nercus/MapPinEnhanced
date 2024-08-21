---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider
local PinProvider = MapPinEnhanced:CreateModule("PinProvider")

local CONSTANTS = MapPinEnhanced.CONSTANTS

---------------------------------------------------------------------------

---Parses the blizzard map pin info from the mouse focus. This happens when ctrl clicking on the map
---@param mouseFocus table
---@return string? name, string? texture, boolean isAtlas
local function ParseBlizzardMapPinInfo(mouseFocus)
    assert(mouseFocus, "mouseFocus is required to parse the map pin info.")
    local pinTexture = mouseFocus.Texture ---@type Texture?
    if not pinTexture then
        return nil, nil, false
    end
    local name = mouseFocus.name ---@type string?
    if mouseFocus.questID then -- has a quest id so we can get the quest name
        local questTitle = C_QuestLog.GetTitleForQuestID(mouseFocus.questID)
        name = questTitle or nil
    end
    if name and pinTexture then
        local texture = pinTexture:GetAtlas() ---@type string?
        if texture then
            if CONSTANTS.PIN_TEXTURE_OVERRIDES[texture] then
                texture = CONSTANTS.PIN_TEXTURE_OVERRIDES[texture] ---@type string
            end
            return name, texture, true
        else
            texture = pinTexture:GetTexture()
            if texture then
                return name, texture, false
            end
        end
    end
    return nil, nil, false
end


---Detects the pin info of the mouse focus. This is used to get the name and texture of the pin.
---@return string? name, string? texture, boolean isAtlas
function PinProvider:DetectMouseFocusPinInfo()
    ---@type ScripRegionWithPinInfo[]? we use that the mouse is actually over a pin element even though we don't know the the exact type here
    local mouseFocus = GetMouseFoci()
    if not mouseFocus then return nil, nil, false end
    local pinTemplate = nil ---@type string?
    for _, mouseFocusTable in ipairs(mouseFocus) do
        pinTemplate = mouseFocusTable.pinTemplate
        if pinTemplate and (string.find(pinTemplate, "%a+PinTemplate")) then
            return ParseBlizzardMapPinInfo(mouseFocusTable)
        end
    end
    if not pinTemplate then return nil, nil, false end
    return nil, nil, false
end
