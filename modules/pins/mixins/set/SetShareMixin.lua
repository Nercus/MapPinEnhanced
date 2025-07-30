---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinSetMixin
MapPinEnhancedPinSetShareMixin = {}

--- [AddonName: Setname-PlayerName]
local preFilteredFormatPattern = "[%s: %s-%s]"


function MapPinEnhancedPinSetShareMixin:OnRequestReceived(setName, playerName)
    if self.name ~= setName then
        return
    end
    -- if the link was created more than 5 minutes ago, do not send it
    if not self.linkCreated or (GetTime() - self.linkCreated) > 300 then
        return
    end
    local setData = self:GetSaveableData()
    MapPinEnhanced:SendDataAddonMessage("TRANSMIT_SET", setData, "WHISPER", playerName)
end

function MapPinEnhancedPinSetShareMixin:LinkToChat()
    assert(self.name, "MapPinEnhancedPinSetShareMixin:LinkToChat: name is nil")
    local setName = self.name
    self.linkCreated = GetTime()

    MapPinEnhanced:OnTextAddonMessage("REQUEST_SET", function(data)
        if not string.find(data, setName) then
            return
        end
        local set, player = strsplit(":", data)
        self:OnRequestReceived(set, player)
    end)


    local link = string.format(preFilteredFormatPattern, MapPinEnhanced.name, setName, MapPinEnhanced.me)
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(link)
end
