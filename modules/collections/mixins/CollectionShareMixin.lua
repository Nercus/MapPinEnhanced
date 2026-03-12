---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCollectionMixin
MapPinEnhancedCollectionShareMixin = {}

--- [AddonName: Collectionname-PlayerName]
local preFilteredFormatPattern = "[%s: %s-%s]"


function MapPinEnhancedCollectionShareMixin:OnRequestReceived(collectionName, playerName)
    if self.name ~= collectionName then
        return
    end
    if not self.linkCreated or (GetTime() - self.linkCreated) > 300 then
        return
    end
    local collectionData = self:GetSaveableData()
    MapPinEnhanced:SendDataAddonMessage("TRANSMIT_COLLECTION", collectionData, "WHISPER", playerName)
end

function MapPinEnhancedCollectionShareMixin:LinkToChat()
    assert(self.name, "MapPinEnhancedCollectionShareMixin:LinkToChat: name is nil")
    local collectionName = self.name
    self.linkCreated = GetTime()

    MapPinEnhanced:OnTextAddonMessage("REQUEST_COLLECTION", function(data)
        if not string.find(data, collectionName) then
            return
        end
        local collection, player = strsplit(":", data)
        self:OnRequestReceived(collection, player)
    end)

    local link = string.format(preFilteredFormatPattern, MapPinEnhanced.name, collectionName, MapPinEnhanced.me)
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(link)
end
