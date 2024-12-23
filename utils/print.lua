---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local normalColor = CreateColor(1, 0.82, 0)
local prefix = MapPinEnhanced:WrapTextInColor(MapPinEnhanced.addonName .. ": ", normalColor)


---Print a styled message to the chat
---@param ... string
function MapPinEnhanced:Print(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    print(prefix .. str)
end

---Print a styled message to the chat,
---@param header string
---@param list string[]
function MapPinEnhanced:PrintList(header, list)
    local bulletTexture = MapPinEnhanced:GetTexture("PinTrackedCustom")
    local bulletTextureString = string.format("|T%s:12:12:2:-2|t", bulletTexture)
    self:Print(self:WrapTextInColor(header, normalColor))
    for _, item in ipairs(list) do
        print(bulletTextureString .. " " .. item)
    end
end
