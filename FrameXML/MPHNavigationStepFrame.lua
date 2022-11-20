MPHNavigationStepFrameMixin = {}



function MPHNavigationStepFrameMixin:StartSpinner()
    self.action:Hide()
    self.text:Hide()
    self.spinnerTexture:Show()
    self.spinner:Play()
end

function MPHNavigationStepFrameMixin:StopSpinner()
    self.spinnerTexture:Hide()
    self.spinner:Stop()
end

function MPHNavigationStepFrameMixin:SetText(text)
    self.text:SetText(text)
    self.action:Hide()
    self.text:SetWidth(230)
    self.text:Show()
end

function MPHNavigationStepFrameMixin:SetAction(spellId, text)
    local name, _, icon = GetSpellInfo(spellId)
    self.action:SetAttribute("type", "macro")
    self.action:SetAttribute("macrotext", "/use " .. name)
    self.action.icon:SetTexture(icon)
    self.text:SetText(text)
    self.text:SetWidth(200)
    self.text:Show()
    self.action:Show()
    self.action.icon:Show()
end
