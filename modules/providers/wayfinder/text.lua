---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

---@param text string?
---@param title string?
---@return string?
function Providers:PlainDescription(text, title)
    text = MapPinEnhanced:ToPlainText(text)
    return text ~= title and text or nil
end
