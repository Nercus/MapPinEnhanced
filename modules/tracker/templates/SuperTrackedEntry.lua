---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")
local Pins = MapPinEnhanced:GetModule("Pins")
local L = MapPinEnhanced.L

---@class MapPinEnhancedSuperTrackedEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field title FontString
---@field entry SuperTrackingEntry?
---@field removeButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedSuperTrackedEntryMixin = {}

---@class MapPinEnhancedSuperTrackedEntryRemoveTemplate : MapPinEnhancedIconButtonTemplate
MapPinEnhancedSuperTrackedEntryRemoveMixin = {}

function MapPinEnhancedSuperTrackedEntryRemoveMixin:OnClick()
    local parent = self:GetParent() --[[@as MapPinEnhancedSuperTrackedEntryTemplate]]
    parent:RemoveEntry()
end

---@param entry SuperTrackingEntry?
function MapPinEnhancedSuperTrackedEntryMixin:ApplyEntry(entry)
    self.entry = entry
    self:SetShown(entry ~= nil)
    if not entry then
        self.title:SetText("")
        self.pinFrame:SetIconTexture(nil)
        return
    end
    self.pinFrame:SetStyleMode(Pins.STYLE_MODE_OUTLINE)
    self.pinFrame:SetIconTexture(entry.texture, entry.usesAtlas)
    if entry.tracked then
        self.pinFrame:SetTracked(true)
    else
        self.pinFrame:SetUntracked()
    end
    self.pinFrame:SetAlpha(entry.tracked and 1 or 0.55)
    self.title:SetAlpha(entry.tracked and 1 or 0.6)
    self.title:SetText(entry.title)
    self:EnableMouse(true)
    if GameTooltip:IsOwned(self) then self:OnEnter() end
end

---@param button string
function MapPinEnhancedSuperTrackedEntryMixin:OnClick(button)
    if not self.entry then return end
    if button == "RightButton" then
        self:ShowMenu()
    elseif button == "LeftButton" and self.entry.canToggle then
        Providers:ToggleSuperTrackingEntry(self.entry.changeNumber)
    end
end

function MapPinEnhancedSuperTrackedEntryMixin:RemoveEntry()
    if self.entry then Providers:RemoveSuperTrackingEntry(self.entry.changeNumber) end
end

function MapPinEnhancedSuperTrackedEntryMixin:ShowMenu()
    if not self.entry then return end
    local changeNumber = self.entry.changeNumber
    MapPinEnhanced:GenerateMenu(self, {
        {
            type = "button",
            label = L["Remove"],
            onClick = function()
                Providers:RemoveSuperTrackingEntry(changeNumber)
            end
        },
        {
            type = "button",
            label = L["Convert to Pin"],
            onClick = function()
                Providers:ConvertSuperTrackingEntryToPin(changeNumber)
            end
        },
        {
            type = "button",
            label = L["Share as Pin"],
            onClick = function()
                Providers:ShareSuperTrackingEntry(changeNumber)
            end
        },
    })
end

function MapPinEnhancedSuperTrackedEntryMixin:OnEnter()
    if not self.entry then
        self:OnLeave()
        return
    end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.entry.title, 1, 0.82, 0, 1, true)
    MapPinEnhanced:AddDescriptionToTooltip(self.entry.description)
    if self.entry.canToggle then
        GameTooltip:AddLine(self.entry.tracked and L["Stop tracking"] or L["Track"], 1, 1, 1)
    end
    GameTooltip:Show()
end

function MapPinEnhancedSuperTrackedEntryMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedSuperTrackedEntryMixin:OnHide()
    self:OnLeave()
    if GameTooltip:IsOwned(self.removeButton) then GameTooltip:Hide() end
    self.pinFrame:HidePulse()
    self.entry = nil
end
