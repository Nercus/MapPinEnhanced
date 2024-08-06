---@meta

--- MapPinEnhanced specific CallbackHandler annotation

---@alias CallbackEvent 'UpdateSetList'


---@class MPHCallbackHandler
local CallbackHandler = {}

---Register a callback on the given object.
---@param event CallbackEvent
---@param method function
---@param arg any
function CallbackHandler:RegisterCallback(event, method, arg) end

---Unregister a callback on the given object.
---@param event CallbackEvent
function CallbackHandler:UnregisterCallback(event) end

---Unregister all callbacks on the given object.
function CallbackHandler:UnregisterAllCallbacks() end

---@class MPHCallbackHandlerRegistry
---@field OnUnused? fun(registry: CallbackHandlerRegistry, target: table, eventName: CallbackEvent) If defined, called when an event stops.
---@field OnUsed? fun(registry: CallbackHandlerRegistry, target: table, eventName: CallbackEvent) If defined, called when an event starts.
local MPHCallbackHandlerRegistry = {}

---fires the given event/message into the registry
---@param eventname CallbackEvent
---@param ... unknown passed to the functions listening to the event.
function MPHCallbackHandlerRegistry:Fire(eventname, ...) end

---@class PropagateMouseClicks
---@field SetPropagateMouseClicks fun(self:Frame, propagate: boolean)

---@class PropagateMouseMotion
---@field SetPropagateMouseMotion fun(self:Frame, propagate: boolean)


---@param frameType string
---@param parent string?
---@param frameTemplate string?
---@param resetterFunc fun()?
---@param forbidden boolean?
---@return FramePool
function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden) end

---@class FramePool
local FramePool = {}
---@return string
function FramePool:GetTemplate() end

---@return Frame
function FramePool:Acquire() end

---@param obj Frame
---@return boolean success
function FramePool:Release(obj) end

function FramePool:ReleaseAll() end

function FramePool:EnumerateActive() end

---@return ScriptRegion region
function GetMouseFoci() end

---@class MenuUtil
MenuUtil = {}

function MenuUtil.TraverseMenu(elementDescription, op, condition) end

function MenuUtil.GetSelections(elementDescription, condition) end

function MenuUtil.ShowTooltip(owner, func, ...) end

function MenuUtil.HideTooltip(owner) end

function MenuUtil.HookTooltipScripts(owner, func) end

function MenuUtil.CreateRootMenuDescription(menuMixin) end

function MenuUtil.CreateContextMenu(ownerRegion, generator, ...) end

function MenuUtil.SetElementText(elementDescription, text) end

function MenuUtil.GetElementText(elementDescription) end

function MenuUtil.CreateFrame() end

function MenuUtil.CreateTemplate(template) end

function MenuUtil.CreateTitle(text, color) end

function MenuUtil.CreateButton(text, callback, data) end

function MenuUtil.CreateCheckbox(text, isSelected, setSelected, data) end

function MenuUtil.CreateRadio(text, isSelected, setSelected, data) end

function MenuUtil.CreateColorSwatch(text, callback, colorInfo) end

function MenuUtil.CreateButtonMenu(dropdown, ...) end

function MenuUtil.CreateButtonContextMenu(ownerRegion, ...) end

function MenuUtil.CreateCheckboxMenu(dropdown, isSelected, setSelected, ...) end

function MenuUtil.CreateCheckboxContextMenu(ownerRegion, isSelected, setSelected, ...) end

function MenuUtil.CreateRadioMenu(dropdown, isSelected, setSelected, ...) end

function MenuUtil.CreateRadioContextMenu(ownerRegion, isSelected, setSelected, ...) end

function MenuUtil.CreateEnumRadioMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function MenuUtil.CreateEnumRadioContextMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function MenuUtil.CreateDivider() end

function MenuUtil.CreateSpacer() end

---@class SubMenuUtil
SubMenuUtil = {}

function SubMenuUtil:TraverseMenu(elementDescription, op, condition) end

function SubMenuUtil:GetSelections(elementDescription, condition) end

function SubMenuUtil:ShowTooltip(owner, func, ...) end

function SubMenuUtil:HideTooltip(owner) end

function SubMenuUtil:HookTooltipScripts(owner, func) end

function SubMenuUtil:CreateRootMenuDescription(menuMixin) end

function SubMenuUtil:CreateContextMenu(ownerRegion, generator, ...) end

function SubMenuUtil:SetElementText(elementDescription, text) end

function SubMenuUtil:GetElementText(elementDescription) end

function SubMenuUtil:CreateFrame() end

function SubMenuUtil:CreateTemplate(template) end

function SubMenuUtil:CreateTitle(text, color) end

function SubMenuUtil:CreateButton(text, callback, data) end

function SubMenuUtil:CreateCheckbox(text, isSelected, setSelected, data) end

function SubMenuUtil:CreateRadio(text, isSelected, setSelected, data) end

function SubMenuUtil:CreateColorSwatch(text, callback, colorInfo) end

function SubMenuUtil:CreateButtonMenu(dropdown, ...) end

function SubMenuUtil:CreateButtonContextMenu(ownerRegion, ...) end

function SubMenuUtil:CreateCheckboxMenu(dropdown, isSelected, setSelected, ...) end

function SubMenuUtil:CreateCheckboxContextMenu(ownerRegion, isSelected, setSelected, ...) end

function SubMenuUtil:CreateRadioMenu(dropdown, isSelected, setSelected, ...) end

function SubMenuUtil:CreateRadioContextMenu(ownerRegion, isSelected, setSelected, ...) end

function SubMenuUtil:CreateEnumRadioMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function SubMenuUtil:CreateEnumRadioContextMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function SubMenuUtil:CreateDivider() end

function SubMenuUtil:CreateSpacer() end

---@type table<string, table>
StaticPopupDialogs = {}
---@param dialogName string
function StaticPopup_Show(dialogName) end

---@class SuperTrackedFrameMixin
SuperTrackedFrameMixin = {}

---@class SuperTrackedFrame : Frame
SuperTrackedFrame = {}

---@class WaypointLocationPinMixin
WaypointLocationPinMixin = {}


---@param NavigationState Enum.NavigationState
---@param alphaValue number
function SuperTrackedFrameMixin:SetTargetAlphaForState(NavigationState, alphaValue) end

---@class UiMapPoint
UiMapPoint = {}

---@param mapID number
---@param x number
---@param y number
---@param z number
---@return UiMapPoint
function UiMapPoint.CreateFromCoordinates(mapID, x, y, z) end

---@param mapID number
---@param position Vector2DMixin
---@param z number
---@return UiMapPoint
function UiMapPoint.CreateFromVector2D(mapID, position, z) end

---@param mapID number
---@param position Vector3DMixin
---@return UiMapPoint
function UiMapPoint.CreateFromVector3D(mapID, position) end

---@meta
---@class WorldMapFrame
---@field pinPools table<string, FramePool>
WorldMapFrame = {}

---@return number
function WorldMapFrame:GetMapID() end

---@class ColorPickerFrame : Frame
ColorPickerFrame = {}

---@return number, number, number
function ColorPickerFrame:GetColorRGB() end

---@return number
function ColorPickerFrame:GetColorAlpha() end

---@class ColorPickerInfo
---@field swatchFunc fun()
---@field hasOpacity boolean
---@field opacityFunc fun()
---@field opacity number
---@field cancelFunc fun()
---@field r number
---@field g number
---@field b number
---@field a number


function ColorPickerFrame:SetupColorPickerAndShow(info) end

---@class DropdownButton : Button
---@field SetupMenu fun(self:DropdownButton, generator:fun(owner:Frame, rootDescription:table))
