---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCopyTextDialogTemplate : MapPinEnhancedWindowTemplate
---@field output MapPinEnhancedTextareaTemplate
---@field text string?
MapPinEnhancedCopyTextDialogMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

function MapPinEnhancedCopyTextDialogMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.output.editbox:SetMaxLetters(0)
end

---@param title string
---@param text string
function MapPinEnhancedCopyTextDialogMixin:Open(title, text)
    self:SetTitle(title)
    self.text = text
    local editbox = self.output.editbox
    editbox:SetScript("OnTextChanged", function(_, userInput)
        if userInput and self.text then
            editbox:SetText(self.text)
            editbox:HighlightText()
        end
    end)
    editbox:SetScript("OnMouseUp", function() editbox:HighlightText() end)
    editbox:SetScript("OnEscapePressed", function() self:Hide() end)
    editbox:SetText(text)
    self:Show()
    self.output:SetVerticalScroll(0)
    editbox:SetFocus()
    editbox:HighlightText()
end

function MapPinEnhancedCopyTextDialogMixin:OnHide()
    local editbox = self.output.editbox
    editbox:SetScript("OnTextChanged", nil)
    editbox:SetScript("OnMouseUp", nil)
    editbox:SetScript("OnEscapePressed", nil)
    editbox:ClearFocus()
    editbox:SetText("")
    self.text = nil
    MapPinEnhancedWindowMixin.OnHide(self)
end
