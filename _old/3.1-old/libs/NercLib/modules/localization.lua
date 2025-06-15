---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib


---@param addon NercLibAddon
function NercLib:AddLocalizationModule(addon)
    ---@class Localization
    local Localization = addon:GetModule("Localization")
    local Debug = addon:GetModule("Debug")
    Localization.locale = GetLocale()
    setmetatable(Localization, {
        __index = function(t, k)
            local v = tostring(k)
            --@do-not-package@
            if Debug.Debug then
                Debug:Debug("Missing localization for: " .. v)
            end
            --@end-do-not-package@
            rawset(t, k, v)
            return v
        end
    })
end
