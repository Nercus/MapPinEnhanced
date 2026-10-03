---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedNavigationReportLink : MapPinEnhancedInputTemplate
---@field url string

---@class MapPinEnhancedNavigationReportTemplate : MapPinEnhancedCopyTextDialogTemplate
---@field heading FontString
---@field instructions FontString
---@field descriptionLabel FontString
---@field reportLabel FontString
---@field copyHint FontString
---@field github MapPinEnhancedNavigationReportLink
---@field curseforge MapPinEnhancedNavigationReportLink
---@field description MapPinEnhancedTextareaTemplate
---@field debugText string?
MapPinEnhancedNavigationReportMixin = CreateFromMixins(MapPinEnhancedCopyTextDialogMixin)

function MapPinEnhancedNavigationReportMixin:OnLoad()
    MapPinEnhancedCopyTextDialogMixin.OnLoad(self)
    self.heading:SetText(L["Help improve navigation"])
    self.instructions:SetText(L["Describe the problem, then copy the report below and post it on either issue page. Copy a URL into your browser to get started."])
    self.descriptionLabel:SetText(L["What went wrong?"])
    self.description:SetPlaceholder(L["What happened, what did you expect, and how can we reproduce it?"])
    self.description.editbox:SetMaxLetters(0)
    self.reportLabel:SetText(L["Your report (description and debug data)"])
    self.copyHint:SetText(L["Click the report or a URL to select it, then press Ctrl+C to copy."])
end

---@param debugText string
function MapPinEnhancedNavigationReportMixin:OpenReport(debugText)
    self.debugText = debugText
    self.description.editbox:SetText("")
    self.github:SetText(self.github.url)
    self.curseforge:SetText(self.curseforge.url)
    MapPinEnhancedCopyTextDialogMixin.Open(self, L["Report a navigation problem"], debugText)
    self.description:SetVerticalScroll(0)
    self.output.editbox:ClearFocus()
    self.description.editbox:SetFocus()
end

function MapPinEnhancedNavigationReportMixin:UpdateReport()
    if not self.debugText then return end
    local description = strtrim(self.description.editbox:GetText() or "")
    self.text = description ~= "" and
        (self.debugText .. "\n\n" .. L["What went wrong?"] .. "\n" .. description) or self.debugText
    self.output.editbox:SetText(self.text)
    self.output:SetVerticalScroll(0)
end

function MapPinEnhancedNavigationReportMixin:OnHide()
    self.debugText = nil
    self.description.editbox:ClearFocus()
    self.description.editbox:SetText("")
    self.github:ClearFocus()
    self.curseforge:ClearFocus()
    MapPinEnhancedCopyTextDialogMixin.OnHide(self)
end
