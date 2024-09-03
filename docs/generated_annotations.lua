--@class MapPinEnhancedTrackerSetEntry : Button
--@field highlight Texture
--@field left Texture
--@field right Texture
--@field icon Texture
--@field title FontString


--@class MapPinEnhancedTrackerPinEntryPin : MapPinEnhancedBasePin
--@field numbering FontString

--@class MapPinEnhancedTrackerPinEntry : Button
--@field Pin MapPinEnhancedTrackerPinEntryPin
--@field highlight Texture
--@field coordsText FontString
--@field zoneText FontString
--@field bgLeft Texture
--@field bgRight Texture
--@field bgMiddle Texture


--@class MapPinEnhancedTrackerFrameHeader : Frame
--@field closebutton MapPinEnhancedIconButton
--@field viewToggle MapPinEnhancedIconButton
--@field editorToggle MapPinEnhancedIconButton
--@field headerTexture Texture
--@field title FontString

--@class MapPinEnhancedTrackerFrameChild : Frame
--@field importButton MapPinEnhancedButtonYellow
--@field cancelButton MapPinEnhancedButtonRed
--@field importEditBox MapPinEnhancedScrollableTextarea

--@class MapPinEnhancedTrackerFrameScrollFrame : ScrollFrameTemplate
--@field Child MapPinEnhancedTrackerFrameChild

--@class MapPinEnhancedTrackerFrame : Frame
--@field header MapPinEnhancedTrackerFrameHeader
--@field scrollFrame MapPinEnhancedTrackerFrameScrollFrame
--@field blackBackground Texture


--@class MapPinEnhancedScrollableTextareaFocusButton : Frame
--@field infoText FontString

--@class MapPinEnhancedScrollableTextarea : ScrollFrameTemplate
--@field focusButton MapPinEnhancedScrollableTextareaFocusButton
--@field bg Texture


--@class MapPinEnhancedPopupDialog : MapPinEnhancedSimpleFrame
--@field accept MapPinEnhancedButtonYellow
--@field cancel MapPinEnhancedButtonRed
--@field text FontString


--@class MapPinEnhancedMenuInput : MapPinEnhancedInput


--@class MapPinEnhancedSlider : MinimalSliderTemplate
--@field Back Button
--@field Forward Button
--@field valueText FontString


--@class MapPinEnhancedSelect : WowStyle2DropdownTemplate


--@class MapPinEnhancedInput : EditBox
--@field Left Texture
--@field Right Texture
--@field Middle Texture


--@class MapPinEnhancedColorpicker : Button
--@field bg Texture
--@field bgMask MaskTexture
--@field color Texture
--@field highlight Texture


--@class MapPinEnhancedCheckbox : CheckButton


--@class MapPinEnhancedButton : MapPinEnhancedButtonRed


--@class MapPinEnhancedSquareButtonYellow : Button
--@field icon Texture


--@class MapPinEnhancedSquareButtonRed : Button
--@field icon Texture


--@class MapPinEnhancedSimpleFrame : Frame
--@field topleft Texture
--@field topright Texture
--@field bottomright Texture
--@field bottomleft Texture
--@field borderTop Texture
--@field borderBottom Texture
--@field borderLeft Texture
--@field borderRight Texture
--@field background Texture


--@class MapPinEnhancedButtonYellow : Button
--@field left Texture
--@field right Texture
--@field middle Texture
--@field highlight Texture
--@field icon Texture


--@class MapPinEnhancedButtonRed : Button
--@field left Texture
--@field right Texture
--@field middle Texture
--@field highlight Texture
--@field icon Texture


--@class MapPinEnhancedIconButton : Button


--@class MapPinEnhancedBaseFrame : Frame
--@field artLeft Frame
--@field artRight Frame
--@field topleft Texture
--@field topright Texture
--@field bottomright Texture
--@field bottomleft Texture
--@field artTop Texture
--@field artBottom Texture
--@field borderTopLeft Texture
--@field borderTopRight Texture
--@field borderBottomLeft Texture
--@field borderBottomRight Texture
--@field borderLeftTop Texture
--@field borderLeftBottom Texture
--@field borderRightTop Texture
--@field borderRightBottom Texture
--@field background Texture


--@class MapPinEnhancedWorldmapPinPulseTexture : Texture
--@field pulse AnimationGroup

--@class MapPinEnhancedWorldmapPin : MapPinEnhancedBasePin
--@field pulseTexture MapPinEnhancedWorldmapPinPulseTexture


--@class MapPinEnhancedSuperTrackedPin : MapPinEnhancedBasePin
--@field distantText FontString


--@class MapPinEnhancedBasePinSwirlTexture : Texture
--@field swirl AnimationGroup
--@field show AnimationGroup
--@field hide AnimationGroup

--@class MapPinEnhancedBasePinPulseHighlight : Texture
--@field pulse AnimationGroup

--@class MapPinEnhancedBasePin : Frame
--@field shadow Texture
--@field background Texture
--@field texture Texture
--@field lockIcon Texture
--@field title FontString
--@field icon Texture
--@field swirlTexture MapPinEnhancedBasePinSwirlTexture
--@field pulseHighlight MapPinEnhancedBasePinPulseHighlight
--@field iconMask MaskTexture
--@field highlight Texture


--@class MapPinEnhancedMinimapPin : MapPinEnhancedBasePin


--@class MapPinEnhancedEditorWindow : Frame
--@field sideBar MapPinEnhancedBaseFrame
--@field body MapPinEnhancedBaseFrame
--@field closebutton MapPinEnhancedSquareButtonRed
--@field versionText FontString


--@class MapPinEnhancedSetEditorViewSidebarHeader : Frame
--@field bg Texture
--@field title FontString

--@class MapPinEnhancedSetEditorViewSidebarSearchInput : MapPinEnhancedInput
--@field $parentClearButton Button

--@class MapPinEnhancedSetEditorViewSidebarScrollFrame : ScrollFrameTemplate
--@field Child Frame

--@class MapPinEnhancedSetEditorViewSidebar : Frame
--@field header MapPinEnhancedSetEditorViewSidebarHeader
--@field searchInput MapPinEnhancedSetEditorViewSidebarSearchInput
--@field switchViewButton MapPinEnhancedSquareButtonRed
--@field importButton MapPinEnhancedSquareButtonRed
--@field createSetButton MapPinEnhancedButtonYellow
--@field scrollFrame MapPinEnhancedSetEditorViewSidebarScrollFrame


--@class MapPinEnhancedSetEditorPinHeader : Frame
--@field bg Texture
--@field Pin FontString
--@field mapID FontString
--@field xCoord FontString
--@field yCoord FontString
--@field title FontString
--@field options FontString


--@class MapPinEnhancedSetEditorPinEntryMapID : MapPinEnhancedInput
--@field mapSelection MapPinEnhancedIconButton

--@class MapPinEnhancedSetEditorPinEntryCheckbox : MapPinEnhancedCheckbox
--@field label FontString

--@class MapPinEnhancedSetEditorPinEntryPinOptions : Frame
--@field checkbox MapPinEnhancedSetEditorPinEntryCheckbox

--@class MapPinEnhancedSetEditorPinEntry : Frame
--@field Pin MapPinEnhancedBasePin
--@field deleteButton Button
--@field mapID MapPinEnhancedSetEditorPinEntryMapID
--@field xCoord MapPinEnhancedInput
--@field yCoord MapPinEnhancedInput
--@field title MapPinEnhancedInput
--@field pinOptions MapPinEnhancedSetEditorPinEntryPinOptions
--@field bg Texture
--@field highlight Texture


--@class MapPinEnhancedSetEditorImportExportFrameExportTypeToggle : MapPinEnhancedCheckbox
--@field label FontString

--@class MapPinEnhancedSetEditorImportExportFrame : MapPinEnhancedScrollableTextarea
--@field exportTypeToggle MapPinEnhancedSetEditorImportExportFrameExportTypeToggle
--@field confirmImportButton MapPinEnhancedButtonYellow
--@field cancelImportButton MapPinEnhancedButtonRed
--@field cancelExportButton MapPinEnhancedButtonRed


--@class MapPinEnhancedSetEditorBodyHeaderSetName : EditBox
--@field editButton MapPinEnhancedIconButton

--@class MapPinEnhancedSetEditorBodyHeader : Frame
--@field setName MapPinEnhancedSetEditorBodyHeaderSetName
--@field deleteButton MapPinEnhancedSquareButtonRed
--@field exportButton MapPinEnhancedSquareButtonYellow
--@field importFromMapButton MapPinEnhancedSquareButtonYellow
--@field bg Texture
--@field infoText FontString


--@class MapPinEnhancedSetEditorViewBodyScrollFrame : ScrollFrameTemplate
--@field Child Frame

--@class MapPinEnhancedSetEditorViewBody : Frame
--@field pinListHeader MapPinEnhancedSetEditorPinHeader
--@field addPinButton MapPinEnhancedButtonYellow
--@field createSetButton MapPinEnhancedButtonYellow
--@field importButton MapPinEnhancedButtonYellow
--@field scrollFrame MapPinEnhancedSetEditorViewBodyScrollFrame


--@class MapPinEnhancedOptionEditorViewSidebarHeader : Frame
--@field bg Texture
--@field headerText FontString

--@class MapPinEnhancedOptionEditorViewSidebarScrollFrame : ScrollFrameTemplate
--@field Child Frame

--@class MapPinEnhancedOptionEditorViewSidebar : Frame
--@field header MapPinEnhancedOptionEditorViewSidebarHeader
--@field switchViewButton MapPinEnhancedButtonRed
--@field scrollFrame MapPinEnhancedOptionEditorViewSidebarScrollFrame


--@class MapPinEnhancedOptionEditorElement : Frame
--@field optionHolder Frame
--@field label FontString
--@field info Texture
--@field highlight Texture


--@class MapPinEnhancedOptionEditorViewCategoryButton : Button
--@field label FontString
--@field highlight Texture


--@class MapPinEnhancedOptionEditorViewBodyHeader : Frame
--@field bg Texture
--@field selectedCategoryName FontString

--@class MapPinEnhancedOptionEditorViewBodyScrollFrame : ScrollFrameTemplate
--@field Child Frame

--@class MapPinEnhancedOptionEditorViewBody : Frame
--@field header MapPinEnhancedOptionEditorViewBodyHeader
--@field scrollFrame MapPinEnhancedOptionEditorViewBodyScrollFrame
