---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedImportWindowBackground : Texture
---@field fadeIn AnimationGroup
---@field fadeOut AnimationGroup

---@class MapPinEnhancedImportWindowGlow : Texture
---@field fadeIn AnimationGroup
---@field fadeOut AnimationGroup


---@class MapPinEnhancedImportWindowScrollFrame : ScrollFrame
---@field NineSlice Frame
---@field editBox EditBox
---@field bg MapPinEnhancedImportWindowBackground
---@field glow MapPinEnhancedImportWindowGlow


---@class MapPinEnhancedImportWindowMixin : Frame
---@field TitleContainer Frame
---@field SetTitle function
---@field scrollFrame MapPinEnhancedImportWindowScrollFrame
---@field helpText FontString
MapPinEnhancedImportWindowMixin = {}


function MapPinEnhancedImportWindowMixin:UpdateHelpTextVisibility()
    local text = self:GetText() --[[@as string]]
    if string.len(text) == 0 then
        self.helpText:Show()
    else
        self.helpText:Hide()
    end
end

function MapPinEnhancedImportWindowMixin:OnLoad()
    self:SetTitle("Import Pins")
    self:SetScript("OnMouseDown", function()
        if (not self:IsMovable()) then
            return
        end
        if (not self.TitleContainer:IsMouseOver()) then
            return
        end
        self:StartMoving()
    end)

    self:SetScript("OnMouseUp", function()
        self:StopMovingOrSizing()
    end)
    self.scrollFrame:SetScript("OnMouseDown", function()
        self.scrollFrame.editBox:SetFocus()
    end)

    self.scrollFrame.editBox:SetScript("OnEditFocusGained", function()
        self.scrollFrame.glow.fadeIn:Play()
        self.scrollFrame.bg.fadeIn:Play()
        self:UpdateHelpTextVisibility()
    end)

    self.scrollFrame.editBox:SetScript("OnEditFocusLost", function()
        self.scrollFrame.glow.fadeOut:Play()
        self.scrollFrame.bg.fadeOut:Play()
        self:UpdateHelpTextVisibility()
    end)
end

function MapPinEnhancedImportWindowMixin:Close()
    self:Hide()
end

function MapPinEnhancedImportWindowMixin:Open()
    self:Show()
end

function MapPinEnhancedImportWindowMixin:GetText()
    return self.scrollFrame.editBox:GetText()
end
