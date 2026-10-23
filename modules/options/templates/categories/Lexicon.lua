---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionLexiconMacroTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedMacroButtonTemplate
MapPinEnhancedOptionLexiconMacroMixin = {}

function MapPinEnhancedOptionLexiconMacroMixin:OnLoad()
    -- This action shares option layout, but has no saved preference to register.
    self.child:Setup({
        title = MapPinEnhanced.L["Location Lexicon"],
        body = "/mph find",
        icon = 4419344,
    })
    self.label:SetFontObject(MapPinEnhancedFontOptionsLeft)
    self.description:SetFontObject(MapPinEnhancedFontOptionsHighlight)
    MapPinEnhancedFormFieldMixin.OnLoad(self)
end

---@param enabled boolean
function MapPinEnhancedOptionLexiconMacroMixin:SetEnabledState(enabled)
    self.optionEnabled = enabled
    self.child:SetAvailable(enabled)
end
