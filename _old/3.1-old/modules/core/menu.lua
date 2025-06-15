---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Menu
local Menu = MapPinEnhanced:GetModule("Menu")

local function GenerateMenuElement(rootDescription, entry)
    if entry.type == "title" then
        return rootDescription:CreateTitle(entry.label)
    elseif entry.type == "button" then
        return rootDescription:CreateButton(entry.label, entry.onClick)
    elseif entry.type == "checkbox" then
        return rootDescription:CreateCheckbox(entry.label, entry.isSelected, entry.setSelected, entry.data)
    elseif entry.type == "radio" then
        return rootDescription:CreateRadio(entry.label, entry.isSelected, entry.setSelected, entry.data)
    elseif entry.type == "divider" then
        return rootDescription:CreateDivider()
    elseif entry.type == "spacer" then
        return rootDescription:CreateSpacer()
    elseif entry.type == "template" then
        local templateEl = rootDescription:CreateTemplate(entry.template) --[[@as BaseMenuDescriptionMixin]]
        templateEl:AddInitializer(entry.initializer)
        return templateEl
    elseif entry.type == "submenu" then
        local subMenuButton = rootDescription:CreateButton(entry.label) --[[@as BaseMenuDescriptionMixin]]
        ---@type AnyMenuEntry[]
        local entries = type(entry.entries) == "function" and entry.entries() or entry.entries
        for _, subEntry in ipairs(entries) do
            GenerateMenuElement(subMenuButton, subEntry)
        end
        return subMenuButton
    end
end


---@param menuTemplate AnyMenuEntry[]
---@return function
function Menu:GetGeneratorFunction(menuTemplate)
    assert(type(menuTemplate) == "table")
    return function(_, rootDescription)
        ---@cast rootDescription SubMenuUtil
        for _, entry in ipairs(menuTemplate) do
            GenerateMenuElement(rootDescription, entry)
        end
    end
end

---@param parentFrame ScriptRegion
---@param menuTemplate AnyMenuEntry[]
function Menu:GenerateMenu(parentFrame, menuTemplate)
    assert(type(parentFrame) == "table")
    assert(type(menuTemplate) == "table")

    MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
        ---@cast rootDescription SubMenuUtil
        for _, entry in ipairs(menuTemplate) do
            GenerateMenuElement(rootDescription, entry)
        end
    end)
end
