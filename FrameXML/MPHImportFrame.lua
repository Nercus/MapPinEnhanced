MPHImportFrameMixin = {};

function MPHImportFrameMixin:OnLoad()

    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetDesaturated(true)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAtlas("NPE_ArrowDown")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAtlas("NPE_ArrowDownGlow")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAtlas("NPE_ArrowDown")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAtlas("NPE_ArrowDown")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAtlas("NPE_ArrowUp")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetDesaturated(true)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAtlas("NPE_ArrowUpGlow")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAtlas("NPE_ArrowUp")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAtlas("NPE_ArrowUp")
    self.editBoxFrame.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAlpha(0.6)
    self.editBoxFrame.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.editBoxFrame.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.editBoxFrame.scrollFrame.ScrollBar.ThumbTexture:SetAlpha(0.6)

    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetDesaturated(true)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAtlas("NPE_ArrowDown")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Disabled:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAtlas("NPE_ArrowDownGlow")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Highlight:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAtlas("NPE_ArrowDown")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Normal:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAtlas("NPE_ArrowDown")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollDownButton.Pushed:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAtlas("NPE_ArrowUp")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Disabled:SetDesaturated(true)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAtlas("NPE_ArrowUpGlow")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Highlight:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAtlas("NPE_ArrowUp")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Normal:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAtlas("NPE_ArrowUp")
    self.presetsFrame.scrollFrame.ScrollBar.ScrollUpButton.Pushed:SetAlpha(0.6)
    self.presetsFrame.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.presetsFrame.scrollFrame.ScrollBar.ThumbTexture:SetAtlas("voicechat-icon-loudnessbar-2")
    self.presetsFrame.scrollFrame.ScrollBar.ThumbTexture:SetAlpha(0.6)
    self:SetTitle("Map Pin Enhanced Import Frame")
end

function MPHImportFrameMixin:OnDragStop()
    self:StopMovingOrSizing()
end

function MPHImportFrameMixin:OnDragStart()
    if self.TitleContainer:IsMouseOver() then
        self:StartMoving()
    end
end
