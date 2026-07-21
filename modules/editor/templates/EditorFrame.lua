---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedEditorTemplate : MapPinEnhancedWindowTemplate
MapPinEnhancedEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

function MapPinEnhancedEditorMixin:SetupHeaderDragging()
    self:SetMovable(true)
    self.header:EnableMouse(true)
    self.header:SetPropagateMouseClicks(true)

    self.header:HookScript("OnEnter", function()
        if self.header:IsMouseOver() then
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        end
    end)

    self.header:HookScript("OnLeave", function()
        ResetCursor()
    end)

    self.header:SetScript("OnMouseDown", function(_, button)
        if button ~= "LeftButton" then return end
        self:StartMoving()
        SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
    end)

    self.header:SetScript("OnMouseUp", function(_, button)
        if button ~= "LeftButton" then return end
        self:StopMovingOrSizing()
        if self.header:IsMouseOver() then
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        else
            ResetCursor()
        end
    end)
end

function MapPinEnhancedEditorMixin:ShowFrame()
    self:ClearAllPoints()
    self:SetPoint("CENTER")
    self:Show()
end

function MapPinEnhancedEditorMixin:HideFrame()
    self:StopMovingOrSizing()
    self:Hide()
end

function MapPinEnhancedEditorMixin:OnLoad()
    local frameName = self:GetName()
    assert(frameName, "MapPinEnhancedEditorMixin:OnLoad: window must have a global name")

    table.insert(UISpecialFrames, frameName)
    self:SetupHeaderDragging()

    if self.windowTitle then
        self:SetTitle(L[self.windowTitle] or self.windowTitle)
    end

    if self.windowColor then
        self:SetBackgroundGradientColor(self.windowColor)
    end
end
