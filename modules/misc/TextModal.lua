-- Template: file://./TextModal.xml
---@class MapPinEnhancedTextModalMixin : Frame
---@field TitleContainer Frame
---@field SetTitle function
---@field title FontString
---@field editBox EditBox
---@field bg MapPinEnhancedImportWindowBackground
---@field glow MapPinEnhancedImportWindowGlow
---@field acceptButton Button
---@field cancelButton Button
---@field clearEditboxButton Button
---@field options ModalOptions
MapPinEnhancedTextModalMixin = {}

---@class ModalOptions
---@field title string
---@field autoFocus boolean
---@field onAccept function
---@field onCancel function



function MapPinEnhancedTextModalMixin:UpdateEditBoxElementsVisibility()
    local text = self:GetText() --[[@as string]]
    if string.len(text) == 0 then
        self.title:Show()
        self.acceptButton:Disable()
        self.clearEditboxButton:Hide()
    else
        self.title:Hide()
        self.acceptButton:Enable()
        self.clearEditboxButton:Show()
    end
end

function MapPinEnhancedTextModalMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTextModalMixin:OnLoad()
    self:SetScript("OnMouseDown", function()
        if (not self:IsMovable()) then
            return
        end
        if (not self.TitleContainer:IsMouseOver()) then
            self.editBox:SetFocus()
            return
        end
        self:StartMoving()
    end)

    self:SetScript("OnMouseUp", function()
        self:StopMovingOrSizing()
    end)

    self.editBox:SetScript("OnEditFocusGained", function()
        self.glow.fadeIn:Play()
        self.bg.fadeIn:Play()
        self.title:Hide()
    end)

    self.editBox:SetScript("OnEditFocusLost", function()
        self.glow.fadeOut:Play()
        self.bg.fadeOut:Play()
        self:UpdateEditBoxElementsVisibility()
    end)

    self.editBox:SetScript("OnEnterPressed", function()
        self:Accept()
    end)

    self.editBox:SetScript("OnEscapePressed", function()
        self:Close()
    end)

    self.editBox:SetScript("OnTextChanged", function()
        self:UpdateEditBoxElementsVisibility()
    end)

    self.acceptButton:SetScript("OnClick", function()
        self:Accept()
    end)

    self.cancelButton:SetScript("OnClick", function()
        self:Cancel()
    end)

    self.acceptButton:Disable()
end

function MapPinEnhancedTextModalMixin:Accept()
    self.options.onAccept(self:GetText())
    self:Close()
end

function MapPinEnhancedTextModalMixin:Cancel()
    self.options.onCancel()
    self:Close()
end

function MapPinEnhancedTextModalMixin:Close()
    self:Hide()
end

---@param options ModalOptions
function MapPinEnhancedTextModalMixin:Open(options)
    self.options = options
    if options.autoFocus then
        self.editBox:SetAutoFocus(true)
        self.editBox:SetText("")
        self.editBox:SetCursorPosition(1)
    end
    self:SetTitle(options.title)
    self:Show()
end

function MapPinEnhancedTextModalMixin:GetText()
    return self.editBox:GetText()
end
