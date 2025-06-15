---@class GuildBankLayouts : NercUtilsAddon
local GuildBankLayouts = LibStub("NercUtils"):GetAddon(...)

---@class Theme
local Theme = GuildBankLayouts:GetModule("Theme")

Theme.activeTheme = "Default"

---@type function[]
local callbacks = {}

function Theme:GetActiveTheme()
    return self.activeTheme or "Default"
end

function Theme:OnThemeChanged(cb)
    table.insert(callbacks, cb)
end

---@param theme AVAILABLE_THEMES
function Theme:SetActiveTheme(theme)
    self.activeTheme = theme
    for _, cb in ipairs(callbacks) do
        cb(theme)
    end
end

GuildBankLayouts:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    -- Initialize the theme system
    local button = CreateFrame("Button", nil, UIParent, "SharedButtonLargeTemplate")
    button:SetPoint("CENTER")
    button:SetText("Test Theme")
    button:SetScript("OnClick", function()
        Theme:SetActiveTheme("ElvUI")
    end)
end)
