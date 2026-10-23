---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

-- Retail moved this limit into Constants; Forever retains the global.
local maxAccountMacros = Constants.MacroConsts and Constants.MacroConsts.MAX_ACCOUNT_MACROS or MAX_ACCOUNT_MACROS

---@class MacroButtonSetup
---@field title string Localized macro name.
---@field body string
---@field icon number|string

---@class MapPinEnhancedMacroButtonTemplate : Button, MapPinEnhancedTooltipMixin
---@field icon Texture
---@field macro MacroButtonSetup?
---@field available boolean?
---@field refreshMacroState fun()?
MapPinEnhancedMacroButtonMixin = {}

function MapPinEnhancedMacroButtonMixin:OnLoad()
    self:RegisterForClicks("LeftButtonUp")
    self:SetMotionScriptsWhileDisabled(true)
    self:Disable()
end

---@param data MacroButtonSetup
function MapPinEnhancedMacroButtonMixin:Setup(data)
    assert(type(data.title) == "string" and data.title ~= "", "MacroButton:Setup requires a title")
    assert(type(data.body) == "string" and strtrim(data.body) ~= "" and #data.body <= 255,
        "MacroButton:Setup requires a nonempty macro body of at most 255 bytes")
    assert(type(data.icon) == "string" or type(data.icon) == "number", "MacroButton:Setup requires an icon")
    self.macro = { title = data.title, body = strtrim(data.body), icon = data.icon }
    self.available = true
    self.icon:SetTexture(data.icon)
    if self:IsShown() then self:OnShow() end
end

---@return number? macroIndex
---@return string? reason
function MapPinEnhancedMacroButtonMixin:GetMacroState()
    if not self.macro then return nil end
    if InCombatLockdown() then return nil, L["Macros cannot be picked up during combat."] end
    local accountCount, characterCount = GetNumMacros()
    for index = 1, maxAccountMacros + characterCount do
        if index <= accountCount or index > maxAccountMacros then
            local _, _, body = GetMacroInfo(index)
            if body and strtrim(body) == self.macro.body then return index end
        end
    end
    if accountCount >= maxAccountMacros then return nil, L["No account macro slots available."] end
end

function MapPinEnhancedMacroButtonMixin:RefreshMacroState()
    local _, reason = self:GetMacroState()
    self:SetEnabled(self.macro ~= nil and self.available ~= false and reason == nil)
    self.icon:SetDesaturated(not self:IsEnabled())
    self:SetAlpha(self:IsEnabled() and 1 or 0.5)
    local tooltip = self.macro and (self.macro.title .. "\n\n" .. self.macro.body .. "\n\n" ..
        (reason or L["Click to pick up the macro"])) or nil
    self:SetTooltip(tooltip)
    if GameTooltip:GetOwner() == self then self:OnTooltipEnter() end
end

---@param available boolean
function MapPinEnhancedMacroButtonMixin:SetAvailable(available)
    self.available = available
    self:RefreshMacroState()
end

function MapPinEnhancedMacroButtonMixin:OnClick()
    if not self.macro or self.available == false then return end
    local index, reason = self:GetMacroState()
    if reason then
        self:RefreshMacroState()
        return
    end
    local icon = self.macro.icon
    if type(icon) == "string" then
        local fileID = GetFileIDFromPath(icon)
        if fileID and fileID > 0 then icon = fileID end
    end
    if index then
        local _, savedIcon = GetMacroInfo(index)
        if savedIcon ~= icon then EditMacro(index, nil, icon) end
    else
        CreateMacro(self.macro.title, icon, self.macro.body)
    end
    -- Native updates can reorder macros; resolve the saved body before pickup.
    index = self:GetMacroState()
    if index then
        ClearCursor()
        PickupMacro(index)
    end
    self:RefreshMacroState()
end

function MapPinEnhancedMacroButtonMixin:OnShow()
    if self.macro and not self.refreshMacroState then
        self.refreshMacroState = function() self:RefreshMacroState() end
        MapPinEnhanced:RegisterEvent("UPDATE_MACROS", self.refreshMacroState)
        MapPinEnhanced:RegisterEvent("PLAYER_REGEN_DISABLED", self.refreshMacroState)
        MapPinEnhanced:RegisterEvent("PLAYER_REGEN_ENABLED", self.refreshMacroState)
    end
    self:RefreshMacroState()
end

function MapPinEnhancedMacroButtonMixin:OnHide()
    if self.refreshMacroState then
        MapPinEnhanced:UnregisterEventForFunction("UPDATE_MACROS", self.refreshMacroState)
        MapPinEnhanced:UnregisterEventForFunction("PLAYER_REGEN_DISABLED", self.refreshMacroState)
        MapPinEnhanced:UnregisterEventForFunction("PLAYER_REGEN_ENABLED", self.refreshMacroState)
        self.refreshMacroState = nil
    end
    self:OnTooltipLeave()
end

function MapPinEnhancedMacroButtonMixin:Reset()
    self:OnHide()
    self.macro = nil
    self.available = nil
    self.icon:SetTexture(nil)
    self:SetTooltip(nil)
    self:RefreshMacroState()
end
