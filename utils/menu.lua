---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@alias MenuEntryType "button" | "title" | "checkbox" | "radio" | "divider" | "spacer" | "template" | "submenu"

---@class MenuEntry
---@field type MenuEntryType

---@class MenuButtonEntry : MenuEntry
---@field type "button"
---@field label string
---@field onClick fun()

---@class MenuTitleEntry : MenuEntry
---@field type "title"
---@field label string

---@class MenuCheckboxEntry : MenuEntry
---@field type "checkbox"
---@field label string
---@field isSelected fun(): boolean
---@field setSelected fun(isSelected: boolean)
---@field data number

---@class MenuRadioEntry : MenuEntry
---@field type "radio"
---@field label string
---@field isSelected fun(): boolean
---@field setSelected fun()
---@field data number

---@class MenuDividerEntry : MenuEntry
---@field type "divider"

---@class MenuSpacerEntry : MenuEntry
---@field type "spacer"

---@class MenuTemplateEntry : MenuEntry
---@field type "template"
---@field template string
---@field initializer fun(frame: Frame)

---@class MenuSubmenuEntry : MenuEntry
---@field type "submenu"
---@field label string
---@field entries AnyMenuEntry[] | function(): AnyMenuEntry[]


---@alias AnyMenuEntry MenuButtonEntry | MenuTitleEntry | MenuCheckboxEntry | MenuRadioEntry | MenuDividerEntry | MenuSpacerEntry | MenuTemplateEntry | MenuSubmenuEntry

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

---@param parentFrame ScriptRegion
---@param menuTemplate AnyMenuEntry[]
function MapPinEnhanced:GenerateMenu(parentFrame, menuTemplate)
    assert(type(parentFrame) == "table")
    assert(type(menuTemplate) == "table")

    MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
        ---@cast rootDescription SubMenuUtil
        for _, entry in ipairs(menuTemplate) do
            GenerateMenuElement(rootDescription, entry)
        end
    end)
end
