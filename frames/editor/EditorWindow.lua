---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedEditorWindowMixin : Frame
---@field TitleContainer Frame
---@field SetTitle function
MapPinEnhancedEditorWindowMixin = {}




function MapPinEnhancedEditorWindowMixin:OnLoad()
    self:SetTitle("Map Pin Enhanced")
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
end

function MapPinEnhancedEditorWindowMixin:Close()
    self:Hide()
end

function MapPinEnhancedEditorWindowMixin:Open()
    self:Show()
end

function MapPinEnhancedEditorWindowMixin:Toggle()
    if self:IsShown() then
        self:Close()
    else
        self:Open()
    end
end
