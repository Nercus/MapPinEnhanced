---@type string
local AddOnName = ...

---@class Wayfinder
local Wayfinder = select(2, ...)


local defaultColor = ConsoleGetColorFromType(1)
local prefix = Wayfinder:WrapTextInColor(AddOnName .. ": ", defaultColor)


---Print a styled message to the chat
---@param ... string
function Wayfinder:Print(...)
  local str = select(1, ...)
  local args = select(2, ...)
  if args then
    str = string.format(str, args) ---@type string
  end
  print(prefix .. str)
end
