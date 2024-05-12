---@class Wayfinder
local Wayfinder = select(2, ...)

---Abbreviate a number to a more readable format
---@param number number
---@return string
function Wayfinder:AbbreviateNumber(number)
  if number >= 1e12 then
    return string.format("%.1fT", number / 1e12)
  elseif number >= 1e9 then
    return string.format("%.1fB", number / 1e9)
  elseif number >= 1e6 then
    return string.format("%.2fM", number / 1e6)
  elseif number >= 1e3 then
    return string.format("%.1fK", number / 1e3)
  else
    return string.format("%d", number)
  end
end

---Wrap text in a color
---@param text string
---@param color ColorMixin
---@return string
function Wayfinder:WrapTextInColor(text, color)
  assert(type(color) == "table", "Color must be a color object")
  local colorEscape = string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
  return colorEscape .. text .. "|r"
end
