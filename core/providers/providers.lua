---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinProvider : Module
local PinProvider = Wayfinder:CreateModule("PinProvider")

-- NOTE: All the different providers are defined here. -> Ctrl + Click on Map, the SetUserWaypoint function, slash commands, etc.



---@param mouseFocus table
---@return string | nil, string | nil
local function ParseBlizzardMapPinInfo(mouseFocus)
    assert(mouseFocus, "mouseFocus is required to parse the map pin info.")
    local pinTexture = mouseFocus.Texture ---@type Texture | nil
    if not pinTexture then
        return nil, nil
    end
    local name = mouseFocus.name ---@type string | nil
    if mouseFocus.questID then -- has a quest id so we can get the quest name
        local questTitle = C_QuestLog.GetTitleForQuestID(mouseFocus.questID)
        name = questTitle or nil
    end
    if name and pinTexture then
        local atlas = pinTexture:GetAtlas()
        if atlas then
            if atlas == "worldquest-questmarker-questbang" then
                atlas = "worldquest-tracker-questmarker"
            end
            return name, atlas
        end
    end
    return nil, nil
end

---Detects the pin info of the mouse focus. This is used to get the name and texture of the pin.
---@return string | nil, string | nil
function PinProvider:DetectMouseFocusPinInfo()
    ---@type table
    local mouseFocus = GetMouseFocus()
    if not mouseFocus then
        return nil, nil
    end
    local pinTemplate = mouseFocus.pinTemplate ---@type string
    if not pinTemplate then
        return nil, nil
    end
    if (string.find(pinTemplate, "%a+PinTemplate")) then
        return ParseBlizzardMapPinInfo(mouseFocus)
    end
end
