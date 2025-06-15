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

---@class BaseMenuDescriptionMixin
BaseMenuDescriptionMixin = {}

---@param initializer fun(frame: Frame, elementDescription: BaseMenuDescriptionMixin, menu: BaseMenuDescriptionMixin)
---@param index number?
function BaseMenuDescriptionMixin:AddInitializer(initializer, index) end

---@param isRadio boolean
function BaseMenuDescriptionMixin:SetRadio(isRadio) end

---@return boolean
function BaseMenuDescriptionMixin:IsSelected() end

---@return boolean
function BaseMenuDescriptionMixin:SetIsSelected() end

function BaseMenuDescriptionMixin:SetSelectionIgnored() end

---@param soundKit number
function BaseMenuDescriptionMixin:SetSoundKit(soundKit) end

---@param onEnter fun()
function BaseMenuDescriptionMixin:SetOnEnter(onEnter) end

---@param onLeave fun()
function BaseMenuDescriptionMixin:SetOnLeave(onLeave) end

---@param isEnabled boolean
function BaseMenuDescriptionMixin:SetEnabled(isEnabled) end

---@return boolean
function BaseMenuDescriptionMixin:IsEnabled() end

---@param data table
function BaseMenuDescriptionMixin:SetData(data) end

---@param callback fun(data:table,menuInputData:table, menu: BaseMenuDescriptionMixin):integer
function BaseMenuDescriptionMixin:SetResponder(callback) end

---@param response MenuResponse
function BaseMenuDescriptionMixin:SetResponse(response) end

---@param tooltip fun()
function BaseMenuDescriptionMixin:SetTooltip(tooltip) end

---@param inputContext integer
---@param buttonName string
function BaseMenuDescriptionMixin:Pick(inputContext, buttonName) end

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


---@class ScrollableTextarea : ScrollFrame
---@field bg Texture
---@field gainFocus Animation
---@field loseFocus Animation
---@field editBox EditBox
---@field focusButton Frame


---@class ClickPropagatableFrame : Frame, PropagateMouseClicks
---@class ClicksPropagatableButton : Button, PropagateMouseClicks
---@class MousePropagatableFrame : Frame, PropagateMouseMotion
---@class MousePropagatableButton : Button, PropagateMouseMotion
---@class BothPropagatableFrame : Frame, PropagateMouseClicks, PropagateMouseMotion
---@class BothPropagatableButton : Button, PropagateMouseClicks, PropagateMouseMotion


---@class HereBeDragonMapData
---@field mapType Enum.UIMapType
---@field parent number
---@field name string
---@field instance number



---@param mapID number
function OpenWorldMap(mapID) end

MenuConstants =
{
    VerticalLinearDirection = 1,
    VerticalGridDirection = 2,
    HorizontalGridDirection = 3,
    AutoCalculateColumns = nil,
    ElementPollFrequencySeconds = .2,
    PrintSecure = false,
};

--[[
Response values are optional returns from description handlers to inform the menu
structure to remain open, reinitialize all the children, or only close the leafmost menu.
It is common for menus with checkboxes or radio options to return Refresh in order for
the children to visually update.
--]]
---@class MenuResponse
MenuResponse =
{
    Open = 1,     -- Menu remains open and unchanged
    Refresh = 2,  -- All frames in the menu are reinitialized
    Close = 3,    -- Parent menus remain open but this menu closes
    CloseAll = 4, -- All menus close
};


--[[
Passed to element handlers to inform which input is responsible for invoking the element handler,
which is relevant in some specialized use cases. See Blizzard_CharacterCustomize.lua.
Can be used to
]] --
---@class MenuInputContext
MenuInputContext =
{
    None = 1,
    MouseButton = 2,
    MouseWheel = 3,
};


---@class AddonCompartmentFrame : Frame
AddonCompartmentFrame = {}

---@param data {text: string, icon: string, notCheckable: boolean, func: fun(_, buttonName: string, menu: Frame)}
function AddonCompartmentFrame:RegisterAddon(data) end

FACTION_HORDE = "Horde"
FACTION_ALLIANCE = "Alliance"

---@type MapPinEnhancedDB
MapPinEnhancedDB = {}

---@class UIErrorsFrame
UIErrorsFrame = {}

function UIErrorsFrame:AddMessage(message, r, g, b, a) end

-- typed only for english client, but that doesnt matter using ingame global anyways
MAP_PIN_HYPERLINK = "|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location"


---@param editBox EditBox
function ChatEdit_ActivateChat(editBox) end

---@param link string
function ChatEdit_InsertLink(link) end

---@class DEFAULT_CHAT_FRAME
---@field editBox EditBox
---@field Clear fun()
---@field GetNumMessages fun():number
---@field GetMessageInfo fun(_, index: number):string
DEFAULT_CHAT_FRAME = {}


---@class MapPinEnhancedSquareButton : Button
---@field iconTexture string
---@field tooltip? string

---@class ScripRegionWithPinInfo : ScriptRegion
---@field pinTemplate string


-- extend herebedragons type annotation with mapData
---@class HereBeDragons-2.0
---@field mapData table<number, HereBeDragonMapData>
