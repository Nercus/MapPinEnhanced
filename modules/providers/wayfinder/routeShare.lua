---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

---@param changeNumber integer
---@param chatType string
---@param target string?
---@param language number?
---@return boolean
local function SendRoute(changeNumber, chatType, target, language)
    local steps, destination = Navigation:GetRouteChatSteps(changeNumber)
    if not steps or not destination then
        MapPinEnhanced:Print(L["Navigation Chat Route Changed"])
        return false
    end
    if (chatType == "PARTY" and not IsInGroup(LE_PARTY_CATEGORY_HOME)) or
        (chatType == "RAID" and not IsInRaid(LE_PARTY_CATEGORY_HOME)) then
        MapPinEnhanced:Print(L["Navigation Chat Unavailable"])
        return false
    end
    local link = Providers:GetMapPinChatLink(destination.x, destination.y, destination.mapID)
    for index = 0, #steps do
        local instruction = index == 0 and destination.header or steps[index]
        local prefix = index > 0 and string.format("%d. ", index) or ""
        local suffix = index == #steps and " " .. link or ""
        local limit = 255 - #prefix - #suffix
        if #instruction > limit then
            instruction = MapPinEnhanced:GetUTF8Prefix(instruction, limit - 3) .. "..."
        end
        local message = prefix .. instruction .. suffix
        if chatType == "SAY" then
            -- Say must keep the Send button's hardware event rather than
            -- being deferred through a throttle callback.
            C_ChatInfo.SendChatMessage(message, chatType, language)
        else
            -- Keep the destination and ordering fixed while Chomp drains its
            -- queue; no navigation objects or editbox drafts are retained.
            MapPinEnhanced.Chomp.SendChatMessage(message, chatType, language,
                target, "MEDIUM", "MapPinEnhancedRoute")
        end
    end
    return true
end

local channelDialog ---@type MapPinEnhancedRouteChatDialogTemplate?

---@param changeNumber integer
---@return boolean
function Providers:ShareRouteToChat(changeNumber)
    local steps, destination = Navigation:GetRouteChatSteps(changeNumber)
    if not steps or not destination then return false end
    local editBox = ChatFrameUtil.GetActiveWindow() or ChatFrameUtil.ChooseBoxForSend()
    local language = editBox and editBox.languageID
    if not channelDialog then
        channelDialog = CreateFrame("Frame", "MapPinEnhancedRouteChatDialog", UIParent,
            "MapPinEnhancedRouteChatDialogTemplate")
    end
    channelDialog:Open(destination.header, function(selectedType, recipient)
        return SendRoute(changeNumber, selectedType, recipient, language)
    end)
    return true
end
