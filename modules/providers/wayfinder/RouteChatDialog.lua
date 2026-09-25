---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedRouteChatDialogTemplate : MapPinEnhancedWindowTemplate
---@field destination FontString
---@field prompt FontString
---@field recipientLabel FontString
---@field recipient MapPinEnhancedInputTemplate
---@field channel MapPinEnhancedDropdownTemplate
---@field send MapPinEnhancedButtonTemplate
---@field cancel MapPinEnhancedButtonTemplate
---@field onSend? fun(chatType: string, recipient: string?): boolean
MapPinEnhancedRouteChatDialogMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@param chatType string?
---@return boolean
local function IsChannelAvailable(chatType)
    if chatType == "PARTY" then return IsInGroup(LE_PARTY_CATEGORY_HOME) end
    if chatType == "RAID" then return IsInRaid(LE_PARTY_CATEGORY_HOME) end
    return chatType == "SAY" or chatType == "WHISPER"
end

function MapPinEnhancedRouteChatDialogMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self:SetTitle(L["Export Route to Chat"])
    self.prompt:SetText(L["Navigation Chat Choose Channel"])
    self.recipientLabel:SetText(L["Navigation Chat Whisper To"])
    self.channel.options = {
        { label = L["Party"], value = "PARTY" },
        { label = L["Raid"], value = "RAID" },
        { label = L["Say"], value = "SAY" },
        { label = L["Whisper"], value = "WHISPER" },
    }
    self.channel:SetupMenu(function(_, root)
        ---@cast root ElementMenuDescriptionProxy
        for _, option in ipairs(self.channel.options) do
            local entry = root:CreateRadio(option.label, function()
                return self.channel.activeValue == option.value
            end, function()
                self.channel:SetSelectedValue(option.value)
                self:UpdateControls()
            end)
            entry:SetEnabled(IsChannelAvailable(option.value))
        end
    end)
end

---@param header string
---@param onSend fun(chatType: string, recipient: string?): boolean
function MapPinEnhancedRouteChatDialogMixin:Open(header, onSend)
    self.onSend = onSend
    self.destination:SetText(header)
    self.recipient:ClearFocus()
    self.recipient:SetText("")
    self.channel:CloseMenu()
    self.channel:SetSelectedValue("SAY")
    self:UpdateControls()
    self:Show()
end

function MapPinEnhancedRouteChatDialogMixin:UpdateControls()
    if not self.send then return end
    local chatType = self.channel.activeValue
    local whisper = chatType == "WHISPER"
    self.recipientLabel:SetShown(whisper)
    self.recipient:SetShown(whisper)
    if not whisper then self.recipient:ClearFocus() end
    self.recipient:UpdatePlaceholderVisibility()
    self.recipient:UpdateClearButtonVisibility()
    local recipient = strtrim(self.recipient:GetText() or "")
    local validRecipient = recipient ~= "" and not recipient:find("[%s|]")
    self.send:SetEnabled(self.onSend ~= nil and IsChannelAvailable(chatType) and (not whisper or validRecipient))
    self:SetHeight(whisper and 280 or 220)
end

function MapPinEnhancedRouteChatDialogMixin:Send()
    local chatType = self.channel.activeValue
    if not self.onSend or not IsChannelAvailable(chatType) then return end
    ---@type string?
    local recipient
    if chatType == "WHISPER" then
        recipient = strtrim(self.recipient:GetText() or "")
        if recipient == "" or recipient:find("[%s|]") then return end
    end
    -- Only the Send button sends, preserving its hardware event for Say.
    if self.onSend(chatType, recipient) then self:Hide() end
end

function MapPinEnhancedRouteChatDialogMixin:OnHide()
    self.onSend = nil
    self.channel:CloseMenu()
    self.channel:SetSelectedValue(nil)
    self.recipient:ClearFocus()
    self.recipient:SetText("")
    self.destination:SetText("")
    MapPinEnhancedWindowMixin.OnHide(self)
end
