---@meta

---@class MenuConstants
---@field VerticalGridDirection any
MenuConstants = {}

---@class MenuInputContext
---@field MouseButton number
MenuInputContext = {}

---@class MenuResponse
---@field Open number
MenuResponse = {}

---@alias MenuDescriptionInitializer fun(frame: Region, description: ElementMenuDescriptionProxy, menu: any): number?, number?

---@class ElementMenuDescriptionProxy
---@field minimumElementWidth? number
---@field AddInitializer fun(self: ElementMenuDescriptionProxy, initializer: MenuDescriptionInitializer)
---@field CreateButton fun(self: ElementMenuDescriptionProxy, text: string, callback: fun(...), data?: any): ElementMenuDescriptionProxy
---@field CreateCheckbox fun(self: ElementMenuDescriptionProxy, text: string, isSelected: fun(): boolean, setSelected: fun(isSelected: boolean), data?: any): ElementMenuDescriptionProxy
---@field CreateDivider fun(self: ElementMenuDescriptionProxy): ElementMenuDescriptionProxy
---@field CreateRadio fun(self: ElementMenuDescriptionProxy, text: string, isSelected: fun(): boolean, setSelected: fun(), data?: any): ElementMenuDescriptionProxy
---@field CreateSpacer fun(self: ElementMenuDescriptionProxy): ElementMenuDescriptionProxy
---@field CreateTemplate fun(self: ElementMenuDescriptionProxy, template: string, data?: any): ElementMenuDescriptionProxy
---@field CreateTitle fun(self: ElementMenuDescriptionProxy, text: string): ElementMenuDescriptionProxy
---@field Pick fun(self: ElementMenuDescriptionProxy, inputContext: number, buttonName?: string)
---@field SetGridMode fun(self: ElementMenuDescriptionProxy, direction: any, columns: number)
---@field SetResponder fun(self: ElementMenuDescriptionProxy, responder: fun(data: any, menuInputData: any, menu: any): number)

---@class MenuUtil
---@field CreateContextMenu fun(owner: Region, generator: fun(owner: Region, rootDescription: ElementMenuDescriptionProxy))
MenuUtil = {}
