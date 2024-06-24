---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinProvider : Module
local PinProvider = Wayfinder:CreateModule("PinProvider")

local PIN_TEXTURE_OVERRIDES = {
    ["worldquest-questmarker-questbang"] = "worldquest-tracker-questmarker",
}


---@class FrameWithTemplate : Frame
---@field pinTemplate string
---@diagnostic disable-next-line: no-unknown GetMouseFoci is not defined in the extension yet
local GetMouseFoci = GetMouseFoci ---@type fun(): table<number, FrameWithTemplate> | nil

---@param mouseFocus table
---@return string | nil name, string | nil texture, boolean isAtlas
local function ParseBlizzardMapPinInfo(mouseFocus)
    assert(mouseFocus, "mouseFocus is required to parse the map pin info.")
    local pinTexture = mouseFocus.Texture ---@type Texture | nil
    if not pinTexture then
        return nil, nil, false
    end
    local name = mouseFocus.name ---@type string | nil
    if mouseFocus.questID then -- has a quest id so we can get the quest name
        local questTitle = C_QuestLog.GetTitleForQuestID(mouseFocus.questID)
        name = questTitle or nil
    end
    if name and pinTexture then
        local texture = pinTexture:GetAtlas() ---@type string | nil
        if texture then
            if PIN_TEXTURE_OVERRIDES[texture] then
                texture = PIN_TEXTURE_OVERRIDES[texture] ---@type string
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
---@return string | nil name, string | nil texture, boolean isAtlas
function PinProvider:DetectMouseFocusPinInfo()
    local mouseFocus = GetMouseFoci()
    if not mouseFocus then
        return nil, nil, false
    end
    local pinTemplate = nil ---@type string | nil
    for _, mouseFocusTable in ipairs(mouseFocus) do
        pinTemplate = mouseFocusTable.pinTemplate
        if pinTemplate and (string.find(pinTemplate, "%a+PinTemplate")) then
            return ParseBlizzardMapPinInfo(mouseFocusTable)
        end
    end
    if not pinTemplate then
        return nil, nil, false
    end
    return nil, nil, false
end
