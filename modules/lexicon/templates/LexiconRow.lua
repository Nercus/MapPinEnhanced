---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Lexicon = MapPinEnhanced:GetModule("Lexicon")

---@class MapPinEnhancedLexiconRowTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field title FontString
---@field subtitle FontString
---@field result LexiconResult?
MapPinEnhancedLexiconRowMixin = {}

---@param result LexiconResult
function MapPinEnhancedLexiconRowMixin:ApplyResult(result)
    self.result = result
    self.title:SetText(MapPinEnhanced:EscapeMarkup(result.label))
    local subtitle = result.subtitle
    if result.distance then subtitle = subtitle .. ", " .. MapPinEnhanced:FormatDistance(result.distance) end
    self.subtitle:SetText(MapPinEnhanced:EscapeMarkup(subtitle))
    self.pinFrame:SetIconTexture(Lexicon.PIN_ICON_KEYS[result.texture] or result.texture)
    self.pinFrame:SetTracked(true)
end

function MapPinEnhancedLexiconRowMixin:OnClick()
    if self.result then Lexicon:Activate(self.result) end
end

function MapPinEnhancedLexiconRowMixin:Reset()
    self.result = nil
    self:UnlockHighlight()
    self.pinFrame:SetUntracked()
    self.pinFrame:SetIconTexture(nil)
    self.title:SetText("")
    self.subtitle:SetText("")
end
