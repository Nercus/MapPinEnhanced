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
