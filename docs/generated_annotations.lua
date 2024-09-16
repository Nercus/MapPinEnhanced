--- TODO: move all the annotations to the correct file

---@class MapPinEnhancedWindowOptionSidebarHeader : Frame
---@field bg Texture
---@field headerText FontString

---@class MapPinEnhancedWindowOptionSidebarScrollFrame : ScrollFrameTemplate
---@field Child Frame

---@class MapPinEnhancedWindowOptionSidebar : Frame
---@field header MapPinEnhancedWindowOptionSidebarHeader
---@field switchViewButton MapPinEnhancedButtonRed
---@field scrollFrame MapPinEnhancedWindowOptionSidebarScrollFrame


---@class MapPinEnhancedWindowOptionBodyElement : Frame
---@field optionHolder Frame
---@field label FontString
---@field info Texture
---@field highlight Texture


---@class MapPinEnhancedWindowOptionSidebarEntry : Button
---@field label FontString
---@field highlight Texture


---@class MapPinEnhancedWindowOptionBodyHeader : Frame
---@field bg Texture
---@field selectedCategoryName FontString

---@class MapPinEnhancedWindowOptionBodyScrollFrame : ScrollFrameTemplate
---@field Child Frame

---@class MapPinEnhancedWindowOptionBody : Frame
---@field header MapPinEnhancedWindowOptionBodyHeader
---@field scrollFrame MapPinEnhancedWindowOptionBodyScrollFrame


---@class MapPinEnhancedWindowSetSidebarEntry : MapPinEnhancedTrackerSetEntry


---@class MapPinEnhancedWindowSetSidebarHeader : Frame
---@field bg Texture
---@field title FontString

---@class MapPinEnhancedWindowSetSidebarSearchInput : MapPinEnhancedInput
---@field clearButton Button

---@class MapPinEnhancedWindowSetSidebarScrollFrame : ScrollFrameTemplate
---@field Child Frame

---@class MapPinEnhancedWindowSetSidebar : Frame
---@field header MapPinEnhancedWindowSetSidebarHeader
---@field searchInput MapPinEnhancedWindowSetSidebarSearchInput
---@field switchViewButton MapPinEnhancedSquareButtonRed
---@field importButton MapPinEnhancedSquareButtonRed
---@field createSetButton MapPinEnhancedButtonYellow
---@field scrollFrame MapPinEnhancedWindowSetSidebarScrollFrame


---@class MapPinEnhancedWindowSetPinHeader : Frame
---@field bg Texture
---@field Pin FontString
---@field mapID FontString
---@field xCoord FontString
---@field yCoord FontString
---@field title FontString
---@field options FontString


---@class MapPinEnhancedWindowSetPinEntryMapID : MapPinEnhancedInput
---@field mapSelection MapPinEnhancedIconButton

---@class MapPinEnhancedWindowSetPinEntryCheckbox : MapPinEnhancedCheckbox
---@field label FontString

---@class MapPinEnhancedWindowSetPinEntryPinOptions : Frame
---@field checkbox MapPinEnhancedWindowSetPinEntryCheckbox

---@class MapPinEnhancedWindowSetPinEntry : Frame
---@field Pin MapPinEnhancedBasePin
---@field deleteButton Button
---@field mapID MapPinEnhancedWindowSetPinEntryMapID
---@field xCoord MapPinEnhancedInput
---@field yCoord MapPinEnhancedInput
---@field title MapPinEnhancedInput
---@field pinOptions MapPinEnhancedWindowSetPinEntryPinOptions
---@field bg Texture
---@field highlight Texture


---@class MapPinEnhancedWindowSetImportFrameExportTypeToggle : MapPinEnhancedCheckbox
---@field label FontString

---@class MapPinEnhancedWindowSetImportFrame : MapPinEnhancedScrollableTextarea
---@field exportTypeToggle MapPinEnhancedWindowSetImportFrameExportTypeToggle
---@field confirmImportButton MapPinEnhancedButtonYellow
---@field cancelImportButton MapPinEnhancedButtonRed
---@field cancelExportButton MapPinEnhancedButtonRed


---@class MapPinEnhancedWindowSetExportFrameExportTypeToggle : MapPinEnhancedCheckbox
---@field label FontString

---@class MapPinEnhancedWindowSetExportFrame : MapPinEnhancedScrollableTextarea
---@field exportTypeToggle MapPinEnhancedWindowSetExportFrameExportTypeToggle
---@field confirmImportButton MapPinEnhancedButtonYellow
---@field cancelImportButton MapPinEnhancedButtonRed
---@field cancelExportButton MapPinEnhancedButtonRed


---@class MapPinEnhancedWindowSetBodyHeaderSetName : EditBox
---@field editButton MapPinEnhancedIconButton

---@class MapPinEnhancedWindowSetBodyHeader : Frame
---@field setName MapPinEnhancedWindowSetBodyHeaderSetName
---@field deleteButton MapPinEnhancedSquareButtonRed
---@field exportButton MapPinEnhancedSquareButtonYellow
---@field importFromMapButton MapPinEnhancedSquareButtonYellow
---@field bg Texture
---@field infoText FontString


---@class MapPinEnhancedWindowSetBodyScrollFrame : ScrollFrameTemplate
---@field Child Frame

---@class MapPinEnhancedWindowSetBody : Frame
---@field pinListHeader MapPinEnhancedWindowSetPinHeader
---@field addPinButton MapPinEnhancedButtonYellow
---@field createSetButton MapPinEnhancedButtonYellow
---@field importButton MapPinEnhancedButtonYellow
---@field scrollFrame MapPinEnhancedWindowSetBodyScrollFrame


---@class MapPinEnhancedWindow : Frame
---@field sideBar MapPinEnhancedBaseFrame
---@field body MapPinEnhancedBaseFrame
---@field closebutton MapPinEnhancedSquareButtonRed
---@field versionText FontString

---@class MapPinEnhancedTrackerSetEntry : Button
---@field highlight Texture
---@field left Texture
---@field right Texture
---@field icon Texture
---@field title FontString


---@class MapPinEnhancedTrackerPinEntryPin : MapPinEnhancedBasePin
---@field numbering FontString

---@class MapPinEnhancedTrackerPinEntry : Button
---@field Pin MapPinEnhancedTrackerPinEntryPin
---@field highlight Texture
---@field coordsText FontString
---@field zoneText FontString
---@field bgLeft Texture
---@field bgRight Texture
---@field bgMiddle Texture



---@class MapPinEnhancedScrollableTextareaFocusButton : Frame
---@field infoText FontString

---@class MapPinEnhancedScrollableTextarea : ScrollFrameTemplate
---@field focusButton MapPinEnhancedScrollableTextareaFocusButton
---@field bg Texture


---@class MapPinEnhancedPopupDialog : MapPinEnhancedSimpleFrame
---@field accept MapPinEnhancedButtonYellow
---@field cancel MapPinEnhancedButtonRed
---@field text FontString


---@class MapPinEnhancedMenuInput : MapPinEnhancedInput


---@class MapPinEnhancedSimpleFrame : Frame
---@field topleft Texture
---@field topright Texture
---@field bottomright Texture
---@field bottomleft Texture
---@field borderTop Texture
---@field borderBottom Texture
---@field borderLeft Texture
---@field borderRight Texture
---@field background Texture


---@class MapPinEnhancedBaseFrame : Frame
---@field artLeft Frame
---@field artRight Frame
---@field topleft Texture
---@field topright Texture
---@field bottomright Texture
---@field bottomleft Texture
---@field artTop Texture
---@field artBottom Texture
---@field borderTopLeft Texture
---@field borderTopRight Texture
---@field borderBottomLeft Texture
---@field borderBottomRight Texture
---@field borderLeftTop Texture
---@field borderLeftBottom Texture
---@field borderRightTop Texture
---@field borderRightBottom Texture
---@field background Texture


---@class MapPinEnhancedSlider : MinimalSliderTemplate
---@field Back Button
---@field Forward Button
---@field valueText FontString


---@class MapPinEnhancedSelect : WowStyle2DropdownTemplate


---@class MapPinEnhancedInput : EditBox
---@field Left Texture
---@field Right Texture
---@field Middle Texture


---@class MapPinEnhancedColorpicker : Button
---@field bg Texture
---@field bgMask MaskTexture
---@field color Texture
---@field highlight Texture


---@class MapPinEnhancedCheckbox : CheckButton


---@class MapPinEnhancedButton : MapPinEnhancedButtonRed


---@class MapPinEnhancedSquareButtonYellow : Button
---@field icon Texture


---@class MapPinEnhancedSquareButtonRed : Button
---@field icon Texture


---@class MapPinEnhancedButtonYellow : Button
---@field left Texture
---@field right Texture
---@field middle Texture
---@field highlight Texture
---@field icon Texture


---@class MapPinEnhancedButtonRed : Button
---@field left Texture
---@field right Texture
---@field middle Texture
---@field highlight Texture
---@field icon Texture


---@class MapPinEnhancedIconButton : Button
---@field tooltip string


---@class MapPinEnhancedWorldmapPinPulseTexture : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedWorldmapPin : MapPinEnhancedBasePin
---@field pulseTexture MapPinEnhancedWorldmapPinPulseTexture


---@class MapPinEnhancedSuperTrackedPin : MapPinEnhancedBasePin
---@field distantText FontString


---@class MapPinEnhancedBasePinSwirlTexture : Texture
---@field swirl AnimationGroup
---@field show AnimationGroup
---@field hide AnimationGroup

---@class MapPinEnhancedBasePinPulseHighlight : Texture
---@field pulse AnimationGroup

---@class MapPinEnhancedBasePin : Frame
---@field shadow Texture
---@field background Texture
---@field texture Texture
---@field lockIcon Texture
---@field title FontString
---@field icon Texture
---@field swirlTexture MapPinEnhancedBasePinSwirlTexture
---@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
---@field iconMask MaskTexture
---@field highlight Texture


---@class MapPinEnhancedMinimapPin : MapPinEnhancedBasePin
