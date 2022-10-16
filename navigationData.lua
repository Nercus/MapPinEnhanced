local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("NavigationData")

local NavigationData = {
	{ ['type'] = 'Boat', ['mapId'] = 56, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.62263488769531, ['x'] = 0.0634765625, ['source'] = 1, }, -- From Wetlands to Dustwallow Marsh
	{ ['type'] = 'Boat', ['mapId'] = 62, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.89469909667969, ['x'] = 0.52285766601562, ['source'] = -1, ['target'] = 2, }, -- From Azuremyst Isle to Darkshore
	{ ['type'] = 'Boat', ['mapId'] = 97, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.54183959960938, ['x'] = 0.20384216308594, ['source'] = 2, }, -- From Azuremyst Isle to Darkshore
	{ ['type'] = 'Boat', ['mapId'] = 97, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.54183959960938, ['x'] = 0.20384216308594, ['source'] = -1, ['target'] = 3, }, -- From Darkshore to Azuremyst Isle
	{ ['type'] = 'Boat', ['mapId'] = 62, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.89469909667969, ['x'] = 0.52285766601562, ['source'] = 3, }, -- From Darkshore to Azuremyst Isle
	{ ['type'] = 'Boat', ['mapId'] = 10, ['reqs'] = {}, ['continent'] = 1, ['y'] = 0.73222351074219,
		['x'] = 0.70146179199219, ['source'] = -1, ['target'] = 4, }, -- From The Cape of Stranglethorn to Northern Barrens
	{ ['type'] = 'Boat', ['mapId'] = 210, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.67041015625,
		['x'] = 0.39083862304688, ['source'] = 4, }, -- From The Cape of Stranglethorn to Northern Barrens
	{ ['type'] = 'Boat', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.53140258789062,
		['x'] = 0.52484130859375, ['source'] = -1, ['target'] = 5, }, -- From Northern Stranglethorn to Orgrimmar
	{ ['type'] = 'Boat', ['mapId'] = 50, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.52389526367188,
		['x'] = 0.37107849121094, ['source'] = 5, }, -- From Northern Stranglethorn to Orgrimmar
	{ ['type'] = 'Boat', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.62286376953125,
		['x'] = 0.44801330566406, ['source'] = -1, ['target'] = 6, }, -- From Borean Tundra to Orgrimmar
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571,
		['y'] = 0.53611755371094, ['x'] = 0.41377258300781, ['source'] = 6, }, -- From Borean Tundra to Orgrimmar
	{ ['type'] = 'Boat', ['mapId'] = 463, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.3815,
		['x'] = 0.7092, ['source'] = -1, ['target'] = 7, }, -- From Zuldazar to Echo Isles
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1642, ['y'] = 0.6504,
		['x'] = 0.5808, ['source'] = 7, }, -- From Zuldazar to Echo Isles
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 0,
		['y'] = 0.5622, ['x'] = 0.2283, ['source'] = -1, ['target'] = 8, }, -- From Boralus to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1643,
		['y'] = 0.2594, ['x'] = 0.775, ['source'] = 8, }, -- From Boralus to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 56, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.62263488769531, ['x'] = 0.0634765625, ['source'] = -1, ['target'] = 9, }, -- From Dustwallow Marsh to Wetlands
	{ ['type'] = 'Boat', ['mapId'] = 70, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.56373596191406, ['x'] = 0.715576171875, ['source'] = 9, }, -- From Dustwallow Marsh to Wetlands
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.25837707519531, ['x'] = 0.17703247070312, ['source'] = -1, ['target'] = 10, }, -- From Borean Tundra to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.69459533691406, ['x'] = 0.59768676757812, ['source'] = 10, }, -- From Borean Tundra to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 56, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.55833435058594, ['x'] = 0.046951293945312, ['source'] = -1, ['target'] = 11, }, -- From Howling Fjord to Wetlands
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.626220703125, ['x'] = 0.61399841308594, ['source'] = 11, }, -- From Howling Fjord to Wetlands
	{ ['type'] = 'Boat', ['mapId'] = 18, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.58735656738281,
		['x'] = 0.60694885253906, ['source'] = -1, ['target'] = 12, }, -- From Orgrimmar to Tirisfal Glades
	{ ['type'] = 'Boat', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.55856323242188,
		['x'] = 0.50790405273438, ['source'] = 12, }, -- From Orgrimmar to Tirisfal Glades
	{ ['type'] = 'Boat', ['mapId'] = 50, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.52389526367188,
		['x'] = 0.37107849121094, ['source'] = -1, ['target'] = 13, }, -- From Orgrimmar to Northern Stranglethorn
	{ ['type'] = 'Boat', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.53140258789062,
		['x'] = 0.52484130859375, ['source'] = 13, }, -- From Orgrimmar to Northern Stranglethorn
	{ ['type'] = 'Boat', ['mapId'] = 210, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.67041015625,
		['x'] = 0.39083862304688, ['source'] = -1, ['target'] = 14, }, -- From Northern Barrens to The Cape of Stranglethorn
	{ ['type'] = 'Boat', ['mapId'] = 10, ['reqs'] = {}, ['continent'] = 1, ['y'] = 0.73222351074219,
		['x'] = 0.70146179199219, ['source'] = 14, }, -- From Northern Barrens to The Cape of Stranglethorn
	{ ['type'] = 'Boat', ['mapId'] = 18, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.59027099609375,
		['x'] = 0.59033203125, ['source'] = -1, ['target'] = 15, }, -- From Howling Fjord to Tirisfal Glades
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571,
		['y'] = 0.28282165527344, ['x'] = 0.77711486816406, ['source'] = 15, }, -- From Howling Fjord to Tirisfal Glades
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.31375122070312, ['x'] = 0.69371032714844, ['source'] = -1, ['target'] = 16, }, -- From Ironforge to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 87, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.51225280761719, ['x'] = 0.76412963867188, ['source'] = 16, }, -- From Ironforge to Stormwind City
	{ ['type'] = 'Boat', ['mapId'] = 87, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.51225280761719, ['x'] = 0.76412963867188, ['source'] = -1, ['target'] = 17, }, -- From Stormwind City to Ironforge
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.31375122070312, ['x'] = 0.69371032714844, ['source'] = 17, }, -- From Stormwind City to Ironforge
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.69459533691406, ['x'] = 0.59768676757812, ['source'] = -1, ['target'] = 18, }, -- From Stormwind City to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.25837707519531, ['x'] = 0.17703247070312, ['source'] = 18, }, -- From Stormwind City to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.626220703125, ['x'] = 0.61399841308594, ['source'] = -1, ['target'] = 19, }, -- From Wetlands to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 56, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.55833435058594, ['x'] = 0.046951293945312, ['source'] = 19, }, -- From Wetlands to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571,
		['y'] = 0.53611755371094, ['x'] = 0.41377258300781, ['source'] = -1, ['target'] = 20, }, -- From Orgrimmar to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.62286376953125,
		['x'] = 0.44801330566406, ['source'] = 20, }, -- From Orgrimmar to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571,
		['y'] = 0.28282165527344, ['x'] = 0.77711486816406, ['source'] = -1, ['target'] = 21, }, -- From Tirisfal Glades to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 18, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.59027099609375,
		['x'] = 0.59033203125, ['source'] = 21, }, -- From Tirisfal Glades to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.57768249511719,
		['x'] = 0.23497009277344, ['source'] = -1, ['target'] = 22, }, -- From Dragonblight to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 115, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.78422546386719,
		['x'] = 0.4962158203125, ['source'] = 22, }, -- From Dragonblight to Howling Fjord
	{ ['type'] = 'Boat', ['mapId'] = 115, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.78422546386719,
		['x'] = 0.4962158203125, ['source'] = -1, ['target'] = 23, }, -- From Howling Fjord to Dragonblight
	{ ['type'] = 'Boat', ['mapId'] = 117, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.57768249511719,
		['x'] = 0.23497009277344, ['source'] = 23, }, -- From Howling Fjord to Dragonblight
	{ ['type'] = 'Boat', ['mapId'] = 115, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.787353515625,
		['x'] = 0.47946166992188, ['source'] = -1, ['target'] = 24, }, -- From Borean Tundra to Dragonblight
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.53628540039062,
		['x'] = 0.78892517089844, ['source'] = 24, }, -- From Borean Tundra to Dragonblight
	{ ['type'] = 'Boat', ['mapId'] = 114, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.53628540039062,
		['x'] = 0.78892517089844, ['source'] = -1, ['target'] = 25, }, -- From Dragonblight to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 115, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.787353515625,
		['x'] = 0.47946166992188, ['source'] = 25, }, -- From Dragonblight to Borean Tundra
	{ ['type'] = 'Boat', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '38599', }, ['continent'] = 1116,
		['y'] = 0.2717, ['x'] = 0.5559, ['source'] = -1, ['target'] = 26, }, -- From Tanaan Jungle to Tanaan Jungle
	{ ['type'] = 'Boat', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '38599', }, ['continent'] = 1116,
		['y'] = 0.4743, ['x'] = 0.6002, ['source'] = 26, }, -- From Tanaan Jungle to Tanaan Jungle
	{ ['type'] = 'Boat', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38603', }, ['continent'] = 1116,
		['y'] = 0.2729, ['x'] = 0.5551, ['source'] = -1, ['target'] = 27, }, -- From Tanaan Jungle to Tanaan Jungle
	{ ['type'] = 'Boat', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38603', }, ['continent'] = 1116,
		['y'] = 0.5873, ['x'] = 0.5767, ['source'] = 27, }, -- From Tanaan Jungle to Tanaan Jungle
	{ ['type'] = 'Boat', ['mapId'] = 739, ['reqs'] = { ['qid'] = '40959', ['cls'] = 'HUNTER', }, ['continent'] = 1220,
		['y'] = 0.2783, ['x'] = 0.3664, ['source'] = -1, ['target'] = 28, }, -- From Dalaran to Trueshot Lodge
	{ ['type'] = 'Boat', ['mapId'] = 627, ['reqs'] = { ['qid'] = '40959', ['cls'] = 'HUNTER', }, ['continent'] = 1220,
		['y'] = 0.413, ['x'] = 0.7277, ['source'] = 28, }, -- From Dalaran to Trueshot Lodge
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1642,
		['y'] = 0.625, ['x'] = 0.584, ['source'] = -1, ['target'] = 29, }, -- From Stormsong Valley to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 942, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1643,
		['y'] = 0.3375, ['x'] = 0.5143, ['source'] = 29, }, -- From Stormsong Valley to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1642,
		['y'] = 0.625, ['x'] = 0.584, ['source'] = -1, ['target'] = 30, }, -- From Stormsong Valley to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 942, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1643,
		['y'] = 0.2449, ['x'] = 0.5198, ['source'] = 30, }, -- From Stormsong Valley to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51340', }, ['continent'] = 1642,
		['y'] = 0.625, ['x'] = 0.584, ['source'] = -1, ['target'] = 31, }, -- From Drustvar to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 896, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51340', }, ['continent'] = 1643,
		['y'] = 0.4335, ['x'] = 0.2061, ['source'] = 31, }, -- From Drustvar to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51589', }, ['continent'] = 1642,
		['y'] = 0.625, ['x'] = 0.584, ['source'] = -1, ['target'] = 32, }, -- From Tiragarde Sound to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 895, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51589', }, ['continent'] = 1643,
		['y'] = 0.5119, ['x'] = 0.8785, ['source'] = 32, }, -- From Tiragarde Sound to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1642, ['y'] = 0.6504,
		['x'] = 0.5808, ['source'] = -1, ['target'] = 33, }, -- From Echo Isles to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 463, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.3815,
		['x'] = 0.7092, ['source'] = 33, }, -- From Echo Isles to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 864, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51283', }, ['continent'] = 1642,
		['y'] = 0.3317, ['x'] = 0.356, ['source'] = -1, ['target'] = 34, }, -- From Boralus to Vol'dun
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51283', }, ['continent'] = 1643,
		['y'] = 0.2663, ['x'] = 0.6792, ['source'] = 34, }, -- From Boralus to Vol'dun
	{ ['type'] = 'Boat', ['mapId'] = 863, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51088', }, ['continent'] = 1642,
		['y'] = 0.3992, ['x'] = 0.6195, ['source'] = -1, ['target'] = 35, }, -- From Boralus to Nazmir
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51088', }, ['continent'] = 1643,
		['y'] = 0.2663, ['x'] = 0.6792, ['source'] = 35, }, -- From Boralus to Nazmir
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1642,
		['y'] = 0.7086, ['x'] = 0.4068, ['source'] = -1, ['target'] = 36, }, -- From Boralus to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1643,
		['y'] = 0.2663, ['x'] = 0.6792, ['source'] = 36, }, -- From Boralus to Zuldazar
	{ ['type'] = 'Boat', ['mapId'] = 1165, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1642,
		['y'] = 0.2132, ['x'] = 0.7573, ['source'] = -1, ['target'] = 37, }, -- From Mechagon Island to Dazar'alor
	{ ['type'] = 'Boat', ['mapId'] = 1462, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1643,
		['y'] = 0.8759, ['x'] = 0.4184, ['source'] = 37, }, -- From Mechagon Island to Dazar'alor
	{ ['type'] = 'Boat', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222, ['y'] = 0.4251,
		['x'] = 0.2962, ['source'] = -1, ['target'] = 38, }, -- From Sinfall to Revendreth
	{ ['type'] = 'Boat', ['mapId'] = 1700, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222, ['y'] = 0.4729,
		['x'] = 0.6724, ['source'] = 38, }, -- From Sinfall to Revendreth
	{ ['type'] = 'Boat', ['mapId'] = 896, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51340', }, ['continent'] = 1643,
		['y'] = 0.4369, ['x'] = 0.2061, ['source'] = -1, ['target'] = 39, }, -- From Zuldazar to Drustvar
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51340', }, ['continent'] = 1642,
		['y'] = 0.6299, ['x'] = 0.5846, ['source'] = 39, }, -- From Zuldazar to Drustvar
	{ ['type'] = 'Boat', ['mapId'] = 942, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1643,
		['y'] = 0.2449, ['x'] = 0.5198, ['source'] = -1, ['target'] = 40, }, -- From Zuldazar to Stormsong Valley
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51532', }, ['continent'] = 1642,
		['y'] = 0.6299, ['x'] = 0.5846, ['source'] = 40, }, -- From Zuldazar to Stormsong Valley
	{ ['type'] = 'Boat', ['mapId'] = 895, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51589', }, ['continent'] = 1643,
		['y'] = 0.5116, ['x'] = 0.882, ['source'] = -1, ['target'] = 41, }, -- From Zuldazar to Tiragarde Sound
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '51589', }, ['continent'] = 1642,
		['y'] = 0.6299, ['x'] = 0.5846, ['source'] = 41, }, -- From Zuldazar to Tiragarde Sound
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51283', }, ['continent'] = 1643,
		['y'] = 0.2706, ['x'] = 0.7022, ['source'] = -1, ['target'] = 42, }, -- From Vol'dun to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 864, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51283', }, ['continent'] = 1642,
		['y'] = 0.3424, ['x'] = 0.3668, ['source'] = 42, }, -- From Vol'dun to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51088', }, ['continent'] = 1643,
		['y'] = 0.2706, ['x'] = 0.7022, ['source'] = -1, ['target'] = 43, }, -- From Nazmir to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 863, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51088', }, ['continent'] = 1642,
		['y'] = 0.4005, ['x'] = 0.6206, ['source'] = 43, }, -- From Nazmir to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1643,
		['y'] = 0.2706, ['x'] = 0.7022, ['source'] = -1, ['target'] = 44, }, -- From Zuldazar to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 862, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1642,
		['y'] = 0.7104, ['x'] = 0.4046, ['source'] = 44, }, -- From Zuldazar to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 1643,
		['y'] = 0.2594, ['x'] = 0.775, ['source'] = -1, ['target'] = 45, }, -- From Stormwind City to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '51308', }, ['continent'] = 0,
		['y'] = 0.5622, ['x'] = 0.2283, ['source'] = 45, }, -- From Stormwind City to Boralus
	{ ['type'] = 'Boat', ['mapId'] = 1462, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1643,
		['y'] = 0.2132, ['x'] = 0.7573, ['source'] = -1, ['target'] = 46, }, -- From Dazar'alor to Mechagon Island
	{ ['type'] = 'Boat', ['mapId'] = 1165, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1642,
		['y'] = 0.8759, ['x'] = 0.4184, ['source'] = 46, }, -- From Dazar'alor to Mechagon Island
	{ ['type'] = 'Boat', ['mapId'] = 1165, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1642,
		['y'] = 0.8743, ['x'] = 0.4175, ['source'] = -1, ['target'] = 47, }, -- From Mechagon Island to Dazar'alor
	{ ['type'] = 'Boat', ['mapId'] = 1462, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '55651', }, ['continent'] = 1643,
		['y'] = 0.2262, ['x'] = 0.7548, ['source'] = 47, }, -- From Mechagon Island to Dazar'alor
	{ ['type'] = 'LocalPortal', ['mapId'] = 57, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.48550415039062, ['x'] = 0.27494812011719, ['source'] = -1, ['target'] = 48, }, -- From Teldrassil to Teldrassil
	{ ['y'] = 0.88526916503906, ['x'] = 0.55094909667969, ['mapId'] = 57, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 48, ['type'] = 'LocalPortal', }, -- From Teldrassil to Teldrassil
	{ ['type'] = 'LocalPortal', ['mapId'] = 57, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.88526916503906, ['x'] = 0.55094909667969, ['source'] = -1, ['target'] = 49, }, -- From Teldrassil to Teldrassil
	{ ['y'] = 0.48550415039062, ['x'] = 0.27494812011719, ['mapId'] = 57, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 49, ['type'] = 'LocalPortal', }, -- From Teldrassil to Teldrassil
	{ ['type'] = 'LocalPortal', ['mapId'] = 97, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.5409, ['x'] = 0.2005, ['source'] = -1, ['target'] = 50, }, -- From Teldrassil to Azuremyst Isle
	{ ['y'] = 0.8946, ['x'] = 0.523, ['mapId'] = 57, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 50, ['type'] = 'LocalPortal', }, -- From Teldrassil to Azuremyst Isle
	{ ['type'] = 'LocalPortal', ['mapId'] = 57, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.8947, ['x'] = 0.5238, ['source'] = -1, ['target'] = 51, }, -- From Azuremyst Isle to Teldrassil
	{ ['y'] = 0.5409, ['x'] = 0.2005, ['mapId'] = 97, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 51, ['type'] = 'LocalPortal', }, -- From Azuremyst Isle to Teldrassil
	{ ['type'] = 'LocalPortal', ['mapId'] = 249, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '28112', }, ['continent'] = 1,
		['y'] = 0.34246826171875, ['x'] = 0.54893493652344, ['source'] = -1, ['target'] = 52, }, -- From Orgrimmar to Uldum
	{ ['y'] = 0.38578796386719, ['x'] = 0.48880004882812, ['mapId'] = 85,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '28112', }, ['continent'] = 1, ['source'] = 52,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Uldum
	{ ['type'] = 'LocalPortal', ['mapId'] = 198, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25316', }, ['continent'] = 1,
		['y'] = 0.23371887207031, ['x'] = 0.63485717773438, ['source'] = -1, ['target'] = 53, }, -- From Orgrimmar to Mount Hyjal
	{ ['y'] = 0.38290405273438, ['x'] = 0.51069641113281, ['mapId'] = 85,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25316', }, ['continent'] = 1, ['source'] = 53,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Mount Hyjal
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25316', }, ['continent'] = 1,
		['y'] = 0.37886047363281, ['x'] = 0.5013427734375, ['source'] = -1, ['target'] = 54, }, -- From Mount Hyjal to Orgrimmar
	{ ['y'] = 0.24444580078125, ['x'] = 0.63479614257812, ['mapId'] = 198,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25316', }, ['continent'] = 1, ['source'] = 54,
		['type'] = 'LocalPortal', }, -- From Mount Hyjal to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 1473, ['reqs'] = { ['passlvl'] = '50', }, ['continent'] = 2215,
		['y'] = 0.3594, ['x'] = 0.5023, ['source'] = -1, ['target'] = 55, }, -- From Silithus to Chamber of Heart
	{ ['y'] = 0.4451, ['x'] = 0.4311, ['mapId'] = 81, ['reqs'] = { ['passlvl'] = '50', }, ['continent'] = 1,
		['source'] = 55, ['type'] = 'LocalPortal', }, -- From Silithus to Chamber of Heart
	{ ['type'] = 'LocalPortal', ['mapId'] = 81, ['reqs'] = { ['passlvl'] = '50', }, ['continent'] = 1, ['y'] = 0.4519,
		['x'] = 0.4141, ['source'] = -1, ['target'] = 56, }, -- From Chamber of Heart to Silithus
	{ ['y'] = 0.3099, ['x'] = 0.5023, ['mapId'] = 1473, ['reqs'] = { ['passlvl'] = '50', }, ['continent'] = 2215,
		['source'] = 56, ['type'] = 'LocalPortal', }, -- From Chamber of Heart to Silithus
	{ ['type'] = 'LocalPortal', ['mapId'] = 74, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.283,
		['x'] = 0.546, ['source'] = -1, ['target'] = 57, }, -- From Orgrimmar to Caverns of Time
	{ ['y'] = 0.9247, ['x'] = 0.5639, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 57, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Caverns of Time
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.2681,
		['x'] = 0.5814, ['source'] = -1, ['target'] = 58, }, -- From Caverns of Time to Orgrimmar
	{ ['y'] = 0.2681, ['x'] = 0.5814, ['mapId'] = 74, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 58, ['type'] = 'LocalPortal', }, -- From Caverns of Time to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 245, ['reqs'] = { ['fac'] = 'Alliance', ['lvl'] = '30', }, ['continent'] = 0,
		['y'] = 0.60920715332031, ['x'] = 0.73674011230469, ['source'] = -1, ['target'] = 59, }, -- From Stormwind City to Tol Barad Peninsula
	{ ['y'] = 0.1837158203125, ['x'] = 0.73211669921875, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['lvl'] = '30', }, ['continent'] = 0, ['source'] = 59,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Tol Barad Peninsula
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['lvl'] = '30', }, ['continent'] = 0,
		['y'] = 0.18284606933594, ['x'] = 0.73388671875, ['source'] = -1, ['target'] = 60, }, -- From Tol Barad Peninsula to Stormwind City
	{ ['y'] = 0.58865356445312, ['x'] = 0.7523193359375, ['mapId'] = 245,
		['reqs'] = { ['fac'] = 'Alliance', ['lvl'] = '30', }, ['continent'] = 0, ['source'] = 60,
		['type'] = 'LocalPortal', }, -- From Tol Barad Peninsula to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 204, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '14482', },
		['continent'] = 0, ['y'] = 0.72802734375, ['x'] = 0.55703735351562, ['source'] = -1, ['target'] = 61, }, -- From Stormwind City to Abyssal Depths
	{ ['y'] = 0.1685791015625, ['x'] = 0.73297119140625, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '14482', }, ['continent'] = 0, ['source'] = 61,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Abyssal Depths
	{ ['type'] = 'LocalPortal', ['mapId'] = 241, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27545', },
		['continent'] = 0, ['y'] = 0.77784729003906, ['x'] = 0.79478454589844, ['source'] = -1, ['target'] = 62, }, -- From Stormwind City to Twilight Highlands
	{ ['y'] = 0.16426086425781, ['x'] = 0.75343322753906, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27545', }, ['continent'] = 0, ['source'] = 62,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Twilight Highlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27545', },
		['continent'] = 0, ['y'] = 0.16810607910156, ['x'] = 0.75169372558594, ['source'] = -1, ['target'] = 63, }, -- From Twilight Highlands to Stormwind City
	{ ['y'] = 0.77784729003906, ['x'] = 0.79478454589844, ['mapId'] = 241,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27545', }, ['continent'] = 0, ['source'] = 63,
		['type'] = 'LocalPortal', }, -- From Twilight Highlands to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 90, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.1633,
		['x'] = 0.8459, ['source'] = -1, ['target'] = 64, }, -- From Northern Stranglethorn to Undercity
	{ ['y'] = 0.5099, ['x'] = 0.3755, ['mapId'] = 50, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['source'] = 64, ['type'] = 'LocalPortal', }, -- From Northern Stranglethorn to Undercity
	{ ['type'] = 'LocalPortal', ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['y'] = 0.16448974609375, ['x'] = 0.50619506835938, ['source'] = -1, ['target'] = 65, }, -- From Tirisfal Glades to Silvermoon City
	{ ['y'] = 0.67436218261719, ['x'] = 0.59449768066406, ['mapId'] = 18, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 0, ['source'] = 65, ['type'] = 'LocalPortal', }, -- From Tirisfal Glades to Silvermoon City
	{ ['type'] = 'LocalPortal', ['mapId'] = 18, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['y'] = 0.67436218261719, ['x'] = 0.59449768066406, ['source'] = -1, ['target'] = 66, }, -- From Silvermoon City to Tirisfal Glades
	{ ['y'] = 0.16448974609375, ['x'] = 0.50619506835938, ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 0, ['source'] = 66, ['type'] = 'LocalPortal', }, -- From Silvermoon City to Tirisfal Glades
	{ ['type'] = 'LocalPortal', ['mapId'] = 95, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.96380615234375,
		['x'] = 0.51576232910156, ['source'] = -1, ['target'] = 67, }, -- From Eastern Plaguelands to Ghostlands
	{ ['y'] = 0.08770751953125, ['x'] = 0.54376220703125, ['mapId'] = 23, ['reqs'] = {}, ['continent'] = 0,
		['source'] = 67, ['type'] = 'LocalPortal', }, -- From Eastern Plaguelands to Ghostlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 23, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.08770751953125,
		['x'] = 0.54376220703125, ['source'] = -1, ['target'] = 68, }, -- From Ghostlands to Eastern Plaguelands
	{ ['y'] = 0.96380615234375, ['x'] = 0.51576232910156, ['mapId'] = 95, ['reqs'] = {}, ['continent'] = 0,
		['source'] = 68, ['type'] = 'LocalPortal', }, -- From Ghostlands to Eastern Plaguelands
	{ ['type'] = 'LocalPortal', ['mapId'] = 122, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.3069, ['x'] = 0.471,
		['source'] = -1, ['target'] = 69, }, -- From Magisters' Terrace to Isle of Quel'Danas
	{ ['y'] = 0.496, ['x'] = 0.0439, ['mapId'] = 348, ['reqs'] = {}, ['continent'] = 585, ['source'] = 69,
		['type'] = 'LocalPortal', }, -- From Magisters' Terrace to Isle of Quel'Danas
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['rac'] = 'DarkIronDwarf', }, ['continent'] = 0,
		['y'] = 0.1725, ['x'] = 0.5449, ['source'] = -1, ['target'] = 70, }, -- From Blackrock Depths to Stormwind City
	{ ['y'] = 0.2682, ['x'] = 0.5925, ['mapId'] = 1186, ['reqs'] = { ['rac'] = 'DarkIronDwarf', }, ['continent'] = 2081,
		['source'] = 70, ['type'] = 'LocalPortal', }, -- From Blackrock Depths to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 1186, ['reqs'] = { ['rac'] = 'DarkIronDwarf', }, ['continent'] = 2081,
		['y'] = 0.2434, ['x'] = 0.6143, ['source'] = -1, ['target'] = 71, }, -- From Stormwind City to Blackrock Depths
	{ ['y'] = 0.1601, ['x'] = 0.5269, ['mapId'] = 84, ['reqs'] = { ['rac'] = 'DarkIronDwarf', }, ['continent'] = 0,
		['source'] = 71, ['type'] = 'LocalPortal', }, -- From Stormwind City to Blackrock Depths
	{ ['type'] = 'LocalPortal', ['mapId'] = 127, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.42845153808594,
		['x'] = 0.15812683105469, ['source'] = -1, ['target'] = 72, }, -- From Dalaran to Crystalsong Forest
	{ ['y'] = 0.46798706054688, ['x'] = 0.55915832519531, ['mapId'] = 125, ['reqs'] = {}, ['continent'] = 571,
		['source'] = 72, ['type'] = 'LocalPortal', }, -- From Dalaran to Crystalsong Forest
	{ ['type'] = 'LocalPortal', ['mapId'] = 125, ['reqs'] = {}, ['continent'] = 571, ['y'] = 0.46791076660156,
		['x'] = 0.55921936035156, ['source'] = -1, ['target'] = 73, }, -- From Crystalsong Forest to Dalaran
	{ ['y'] = 0.42845153808594, ['x'] = 0.15812683105469, ['mapId'] = 127, ['reqs'] = {}, ['continent'] = 571,
		['source'] = 73, ['type'] = 'LocalPortal', }, -- From Crystalsong Forest to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 120, ['reqs'] = { ['qid'] = '12821', }, ['continent'] = 571,
		['y'] = 0.81881713867188, ['x'] = 0.50555419921875, ['source'] = -1, ['target'] = 74, }, -- From The Storm Peaks to The Storm Peaks
	{ ['y'] = 0.85292053222656, ['x'] = 0.41020202636719, ['mapId'] = 120, ['reqs'] = { ['qid'] = '12821', },
		['continent'] = 571, ['source'] = 74, ['type'] = 'LocalPortal', }, -- From The Storm Peaks to The Storm Peaks
	{ ['type'] = 'LocalPortal', ['mapId'] = 120, ['reqs'] = { ['qid'] = '12821', }, ['continent'] = 571,
		['y'] = 0.85359191894531, ['x'] = 0.40985107421875, ['source'] = -1, ['target'] = 75, }, -- From The Storm Peaks to The Storm Peaks
	{ ['y'] = 0.8193359375, ['x'] = 0.50700378417969, ['mapId'] = 120, ['reqs'] = { ['qid'] = '12821', },
		['continent'] = 571, ['source'] = 75, ['type'] = 'LocalPortal', }, -- From The Storm Peaks to The Storm Peaks
	{ ['type'] = 'LocalPortal', ['mapId'] = 207, ['reqs'] = { ['qid'] = '26709', }, ['continent'] = 646,
		['y'] = 0.13459777832031, ['x'] = 0.57026672363281, ['source'] = -1, ['target'] = 76, }, -- From Deepholm to Deepholm
	{ ['y'] = 0.50308227539062, ['x'] = 0.49266052246094, ['mapId'] = 207, ['reqs'] = { ['qid'] = '26709', },
		['continent'] = 646, ['source'] = 76, ['type'] = 'LocalPortal', }, -- From Deepholm to Deepholm
	{ ['type'] = 'LocalPortal', ['mapId'] = 207, ['reqs'] = { ['qid'] = '26709', }, ['continent'] = 646,
		['y'] = 0.50559997558594, ['x'] = 0.49301147460938, ['source'] = -1, ['target'] = 77, }, -- From Deepholm to Deepholm
	{ ['y'] = 0.13557434082031, ['x'] = 0.57244873046875, ['mapId'] = 207, ['reqs'] = { ['qid'] = '26709', },
		['continent'] = 646, ['source'] = 77, ['type'] = 'LocalPortal', }, -- From Deepholm to Deepholm
	{ ['type'] = 'LocalPortal', ['mapId'] = 388, ['reqs'] = { ['qid'] = '31110', }, ['continent'] = 870,
		['y'] = 0.22329711914062, ['x'] = 0.28970336914062, ['source'] = -1, ['target'] = 78, }, -- From Townlong Steppes to Townlong Steppes
	{ ['y'] = 0.69879150390625, ['x'] = 0.48457336425781, ['mapId'] = 388, ['reqs'] = { ['qid'] = '31110', },
		['continent'] = 870, ['source'] = 78, ['type'] = 'LocalPortal', }, -- From Townlong Steppes to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 388, ['reqs'] = { ['qid'] = '31110', }, ['continent'] = 870,
		['y'] = 0.69947814941406, ['x'] = 0.48579406738281, ['source'] = -1, ['target'] = 79, }, -- From Townlong Steppes to Townlong Steppes
	{ ['y'] = 0.22114562988281, ['x'] = 0.2900390625, ['mapId'] = 388, ['reqs'] = { ['qid'] = '31110', },
		['continent'] = 870, ['source'] = 79, ['type'] = 'LocalPortal', }, -- From Townlong Steppes to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 388,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870,
		['y'] = 0.68890380859375, ['x'] = 0.49754333496094, ['source'] = -1, ['target'] = 80, }, -- From Isle of Thunder to Townlong Steppes
	{ ['y'] = 0.90576171875, ['x'] = 0.35334777832031, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870, ['source'] = 80,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870,
		['y'] = 0.89848327636719, ['x'] = 0.34861755371094, ['source'] = -1, ['target'] = 81, }, -- From Townlong Steppes to Isle of Thunder
	{ ['y'] = 0.68672180175781, ['x'] = 0.49742126464844, ['mapId'] = 388,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870, ['source'] = 81,
		['type'] = 'LocalPortal', }, -- From Townlong Steppes to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870,
		['y'] = 0.83781433105469, ['x'] = 0.3162841796875, ['source'] = -1, ['target'] = 82, }, -- From Isle of Thunder to Isle of Thunder
	{ ['y'] = 0.8946533203125, ['x'] = 0.34902954101562, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870, ['source'] = 82,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870,
		['y'] = 0.89263916015625, ['x'] = 0.3477783203125, ['source'] = -1, ['target'] = 83, }, -- From Isle of Thunder to Isle of Thunder
	{ ['y'] = 0.8370361328125, ['x'] = 0.31631469726562, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32681', ['nqid'] = '32644', ['fac'] = 'Alliance', }, ['continent'] = 870, ['source'] = 83,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870,
		['y'] = 0.52955627441406, ['x'] = 0.28367614746094, ['source'] = -1, ['target'] = 84, }, -- From Townlong Steppes to Isle of Thunder
	{ ['y'] = 0.7340087890625, ['x'] = 0.50650024414062, ['mapId'] = 388,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870, ['source'] = 84,
		['type'] = 'LocalPortal', }, -- From Townlong Steppes to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 388,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870,
		['y'] = 0.7340087890625, ['x'] = 0.50650024414062, ['source'] = -1, ['target'] = 85, }, -- From Isle of Thunder to Townlong Steppes
	{ ['y'] = 0.52955627441406, ['x'] = 0.28367614746094, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870, ['source'] = 85,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870,
		['y'] = 0.52833557128906, ['x'] = 0.33061218261719, ['source'] = -1, ['target'] = 86, }, -- From Isle of Thunder to Isle of Thunder
	{ ['y'] = 0.51728820800781, ['x'] = 0.28480529785156, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870, ['source'] = 86,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870,
		['y'] = 0.52833557128906, ['x'] = 0.33061218261719, ['source'] = -1, ['target'] = 87, }, -- From Isle of Thunder to Isle of Thunder
	{ ['y'] = 0.52714538574219, ['x'] = 0.2857666015625, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870, ['source'] = 87,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870,
		['y'] = 0.51728820800781, ['x'] = 0.28480529785156, ['source'] = -1, ['target'] = 88, }, -- From Isle of Thunder to Isle of Thunder
	{ ['y'] = 0.52833557128906, ['x'] = 0.33061218261719, ['mapId'] = 504,
		['reqs'] = { ['qid'] = '32680', ['nqid'] = '32212', ['fac'] = 'Horde', }, ['continent'] = 870, ['source'] = 88,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 388, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '32644', },
		['continent'] = 870, ['y'] = 0.68890380859375, ['x'] = 0.49754333496094, ['source'] = -1, ['target'] = 89, }, -- From Isle of Thunder to Townlong Steppes
	{ ['y'] = 0.73481750488281, ['x'] = 0.64712524414062, ['mapId'] = 504,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '32644', }, ['continent'] = 870, ['source'] = 89,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 504, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '32644', },
		['continent'] = 870, ['y'] = 0.72474670410156, ['x'] = 0.64079284667969, ['source'] = -1, ['target'] = 90, }, -- From Townlong Steppes to Isle of Thunder
	{ ['y'] = 0.68663024902344, ['x'] = 0.4974365234375, ['mapId'] = 388,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '32644', }, ['continent'] = 870, ['source'] = 90,
		['type'] = 'LocalPortal', }, -- From Townlong Steppes to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 388, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '32212', },
		['continent'] = 870, ['y'] = 0.73158264160156, ['x'] = 0.50694274902344, ['source'] = -1, ['target'] = 91, }, -- From Isle of Thunder to Townlong Steppes
	{ ['y'] = 0.32695007324219, ['x'] = 0.33213806152344, ['mapId'] = 504,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '32212', }, ['continent'] = 870, ['source'] = 91,
		['type'] = 'LocalPortal', }, -- From Isle of Thunder to Townlong Steppes
	{ ['type'] = 'LocalPortal', ['mapId'] = 504, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '32212', },
		['continent'] = 870, ['y'] = 0.32432556152344, ['x'] = 0.33247375488281, ['source'] = -1, ['target'] = 92, }, -- From Townlong Steppes to Isle of Thunder
	{ ['y'] = 0.73397827148438, ['x'] = 0.50651550292969, ['mapId'] = 388,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '32212', }, ['continent'] = 870, ['source'] = 92,
		['type'] = 'LocalPortal', }, -- From Townlong Steppes to Isle of Thunder
	{ ['type'] = 'LocalPortal', ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '36614', },
		['continent'] = 1116, ['y'] = 0.3553, ['x'] = 0.4442, ['source'] = -1, ['target'] = 93, }, -- From Frostwall Mine to Warspear
	{ ['y'] = 0.486, ['x'] = 0.7516, ['mapId'] = 585, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '36614', },
		['continent'] = 1116, ['source'] = 93, ['type'] = 'LocalPortal', }, -- From Frostwall Mine to Warspear
	{ ['type'] = 'LocalPortal', ['mapId'] = 543, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '34078', },
		['continent'] = 1116, ['y'] = 0.6973, ['x'] = 0.4639, ['source'] = -1, ['target'] = 94, }, -- From Frostwall Mine to Gorgrond
	{ ['y'] = 0.1164, ['x'] = 0.6207, ['mapId'] = 585, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '34078', },
		['continent'] = 1116, ['source'] = 94, ['type'] = 'LocalPortal', }, -- From Frostwall Mine to Gorgrond
	{ ['type'] = 'LocalPortal', ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '36615', },
		['continent'] = 1116, ['y'] = 0.525, ['x'] = 0.317, ['source'] = -1, ['target'] = 95, }, -- From Lunarfall Excavation to Stormshield
	{ ['y'] = 0.275, ['x'] = 0.702, ['mapId'] = 579, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '36615', },
		['continent'] = 1116, ['source'] = 95, ['type'] = 'LocalPortal', }, -- From Lunarfall Excavation to Stormshield
	{ ['type'] = 'LocalPortal', ['mapId'] = 543, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '34033', },
		['continent'] = 1116, ['y'] = 0.5977, ['x'] = 0.5291, ['source'] = -1, ['target'] = 96, }, -- From Lunarfall Excavation to Gorgrond
	{ ['y'] = 0.6903, ['x'] = 0.5884, ['mapId'] = 579, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '34033', },
		['continent'] = 1116, ['source'] = 96, ['type'] = 'LocalPortal', }, -- From Lunarfall Excavation to Gorgrond
	{ ['type'] = 'LocalPortal', ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '37935', },
		['continent'] = 1116, ['y'] = 0.3553, ['x'] = 0.4442, ['source'] = -1, ['target'] = 97, }, -- From Tanaan Jungle to Warspear
	{ ['y'] = 0.4735, ['x'] = 0.6102, ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '37935', },
		['continent'] = 1116, ['source'] = 97, ['type'] = 'LocalPortal', }, -- From Tanaan Jungle to Warspear
	{ ['type'] = 'LocalPortal', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '37935', },
		['continent'] = 1116, ['y'] = 0.473, ['x'] = 0.6087, ['source'] = -1, ['target'] = 98, }, -- From Warspear to Tanaan Jungle
	{ ['y'] = 0.4391, ['x'] = 0.5309, ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '37935', },
		['continent'] = 1116, ['source'] = 98, ['type'] = 'LocalPortal', }, -- From Warspear to Tanaan Jungle
	{ ['type'] = 'LocalPortal', ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38445', },
		['continent'] = 1116, ['y'] = 0.5248, ['x'] = 0.3171, ['source'] = -1, ['target'] = 99, }, -- From Tanaan Jungle to Stormshield
	{ ['y'] = 0.6046, ['x'] = 0.5746, ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38445', },
		['continent'] = 1116, ['source'] = 99, ['type'] = 'LocalPortal', }, -- From Tanaan Jungle to Stormshield
	{ ['type'] = 'LocalPortal', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38445', },
		['continent'] = 1116, ['y'] = 0.6032, ['x'] = 0.5753, ['source'] = -1, ['target'] = 100, }, -- From Stormshield to Tanaan Jungle
	{ ['y'] = 0.4124, ['x'] = 0.3642, ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38445', },
		['continent'] = 1116, ['source'] = 100, ['type'] = 'LocalPortal', }, -- From Stormshield to Tanaan Jungle
	{ ['type'] = 'LocalPortal', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '38416', },
		['continent'] = 1116, ['y'] = 0.473, ['x'] = 0.6087, ['source'] = -1, ['target'] = 101, }, -- From The Breached Ossuary to Tanaan Jungle
	{ ['y'] = 0.5683, ['x'] = 0.5027, ['mapId'] = 538, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '38416', },
		['continent'] = 1116, ['source'] = 101, ['type'] = 'LocalPortal', }, -- From The Breached Ossuary to Tanaan Jungle
	{ ['type'] = 'LocalPortal', ['mapId'] = 534, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38562', },
		['continent'] = 1116, ['y'] = 0.6032, ['x'] = 0.5753, ['source'] = -1, ['target'] = 102, }, -- From The Breached Ossuary to Tanaan Jungle
	{ ['y'] = 0.5517, ['x'] = 0.5235, ['mapId'] = 538, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '38562', },
		['continent'] = 1116, ['source'] = 102, ['type'] = 'LocalPortal', }, -- From The Breached Ossuary to Tanaan Jungle
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '44740', }, ['continent'] = 1220, ['y'] = 0.6943,
		['x'] = 0.5446, ['source'] = -1, ['target'] = 103, }, -- From Suramar to Suramar
	{ ['y'] = 0.4505, ['x'] = 0.3675, ['mapId'] = 680, ['reqs'] = { ['qid'] = '44740', }, ['continent'] = 1220,
		['source'] = 103, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '44740', }, ['continent'] = 1220, ['y'] = 0.4505,
		['x'] = 0.3675, ['source'] = -1, ['target'] = 104, }, -- From Suramar to Suramar
	{ ['y'] = 0.6943, ['x'] = 0.5446, ['mapId'] = 680, ['reqs'] = { ['qid'] = '44740', }, ['continent'] = 1220,
		['source'] = 104, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 682, ['reqs'] = { ['qid'] = '41575', }, ['continent'] = 1220, ['y'] = 0.3676,
		['x'] = 0.5235, ['source'] = -1, ['target'] = 105, }, -- From Suramar to Felsoul Hold
	{ ['y'] = 0.4574, ['x'] = 0.3612, ['mapId'] = 680, ['reqs'] = { ['qid'] = '41575', }, ['continent'] = 1220,
		['source'] = 105, ['type'] = 'LocalPortal', }, -- From Suramar to Felsoul Hold
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '41575', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 106, }, -- From Felsoul Hold to Suramar
	{ ['y'] = 0.3671, ['x'] = 0.5354, ['mapId'] = 682, ['reqs'] = { ['qid'] = '41575', }, ['continent'] = 1220,
		['source'] = 106, ['type'] = 'LocalPortal', }, -- From Felsoul Hold to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43811', }, ['continent'] = 1220, ['y'] = 0.791,
		['x'] = 0.4361, ['source'] = -1, ['target'] = 107, }, -- From Suramar to Suramar
	{ ['y'] = 0.4504, ['x'] = 0.3617, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43811', }, ['continent'] = 1220,
		['source'] = 107, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43811', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 108, }, -- From Suramar to Suramar
	{ ['y'] = 0.7924, ['x'] = 0.4369, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43811', }, ['continent'] = 1220,
		['source'] = 108, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 684, ['reqs'] = { ['qid'] = '42230', }, ['continent'] = 1220, ['y'] = 0.1505,
		['x'] = 0.4137, ['source'] = -1, ['target'] = 109, }, -- From Suramar to Shattered Locus
	{ ['y'] = 0.4555, ['x'] = 0.359, ['mapId'] = 680, ['reqs'] = { ['qid'] = '42230', }, ['continent'] = 1220,
		['source'] = 109, ['type'] = 'LocalPortal', }, -- From Suramar to Shattered Locus
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42230', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 110, }, -- From Shattered Locus to Suramar
	{ ['y'] = 0.1376, ['x'] = 0.4093, ['mapId'] = 684, ['reqs'] = { ['qid'] = '42230', }, ['continent'] = 1220,
		['source'] = 110, ['type'] = 'LocalPortal', }, -- From Shattered Locus to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43813', }, ['continent'] = 1220, ['y'] = 0.4467,
		['x'] = 0.367, ['source'] = -1, ['target'] = 111, }, -- From Suramar to Suramar
	{ ['y'] = 0.6063, ['x'] = 0.434, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43813', }, ['continent'] = 1220,
		['source'] = 111, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43813', }, ['continent'] = 1220, ['y'] = 0.6063,
		['x'] = 0.434, ['source'] = -1, ['target'] = 112, }, -- From Suramar to Suramar
	{ ['y'] = 0.4467, ['x'] = 0.367, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43813', }, ['continent'] = 1220,
		['source'] = 112, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43808', }, ['continent'] = 1220, ['y'] = 0.1087,
		['x'] = 0.3079, ['source'] = -1, ['target'] = 113, }, -- From Suramar to Suramar
	{ ['y'] = 0.4525, ['x'] = 0.3601, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43808', }, ['continent'] = 1220,
		['source'] = 113, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43808', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 114, }, -- From Suramar to Suramar
	{ ['y'] = 0.1102, ['x'] = 0.3083, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43808', }, ['continent'] = 1220,
		['source'] = 114, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42487', }, ['continent'] = 1220, ['y'] = 0.8197,
		['x'] = 0.4745, ['source'] = -1, ['target'] = 115, }, -- From Suramar to Suramar
	{ ['y'] = 0.4475, ['x'] = 0.3648, ['mapId'] = 680, ['reqs'] = { ['qid'] = '42487', }, ['continent'] = 1220,
		['source'] = 115, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42487', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 116, }, -- From Suramar to Suramar
	{ ['y'] = 0.8138, ['x'] = 0.4773, ['mapId'] = 680, ['reqs'] = { ['qid'] = '42487', }, ['continent'] = 1220,
		['source'] = 116, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43809', }, ['continent'] = 1220, ['y'] = 0.3538,
		['x'] = 0.4217, ['source'] = -1, ['target'] = 117, }, -- From Suramar to Suramar
	{ ['y'] = 0.4466, ['x'] = 0.3692, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43809', }, ['continent'] = 1220,
		['source'] = 117, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '43809', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 118, }, -- From Suramar to Suramar
	{ ['y'] = 0.3524, ['x'] = 0.4203, ['mapId'] = 680, ['reqs'] = { ['qid'] = '43809', }, ['continent'] = 1220,
		['source'] = 118, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '44084', }, ['continent'] = 1220, ['y'] = 0.608,
		['x'] = 0.6409, ['source'] = -1, ['target'] = 119, }, -- From Suramar to Suramar
	{ ['y'] = 0.45, ['x'] = 0.3695, ['mapId'] = 680, ['reqs'] = { ['qid'] = '44084', }, ['continent'] = 1220,
		['source'] = 119, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '44084', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 120, }, -- From Suramar to Suramar
	{ ['y'] = 0.6043, ['x'] = 0.64, ['mapId'] = 680, ['reqs'] = { ['qid'] = '44084', }, ['continent'] = 1220,
		['source'] = 120, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['nqid'] = '38649', ['qid'] = '42487', },
		['continent'] = 1220, ['y'] = 0.8197, ['x'] = 0.4745, ['source'] = -1, ['target'] = 121, }, -- From Suramar to Suramar
	{ ['y'] = 0.4475, ['x'] = 0.3648, ['mapId'] = 680, ['reqs'] = { ['nqid'] = '38649', ['qid'] = '42487', },
		['continent'] = 1220, ['source'] = 121, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['nqid'] = '38649', ['qid'] = '42487', },
		['continent'] = 1220, ['y'] = 0.4509, ['x'] = 0.364, ['source'] = -1, ['target'] = 122, }, -- From Suramar to Suramar
	{ ['y'] = 0.8138, ['x'] = 0.4773, ['mapId'] = 680, ['reqs'] = { ['nqid'] = '38649', ['qid'] = '42487', },
		['continent'] = 1220, ['source'] = 122, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42889', }, ['continent'] = 1220, ['y'] = 0.7887,
		['x'] = 0.5204, ['source'] = -1, ['target'] = 123, }, -- From Suramar to Suramar
	{ ['y'] = 0.4475, ['x'] = 0.3649, ['mapId'] = 680, ['reqs'] = { ['qid'] = '42889', }, ['continent'] = 1220,
		['source'] = 123, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42889', }, ['continent'] = 1220, ['y'] = 0.4509,
		['x'] = 0.364, ['source'] = -1, ['target'] = 124, }, -- From Suramar to Suramar
	{ ['y'] = 0.7875, ['x'] = 0.5198, ['mapId'] = 680, ['reqs'] = { ['qid'] = '42889', }, ['continent'] = 1220,
		['source'] = 124, ['type'] = 'LocalPortal', }, -- From Suramar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['qid'] = '40959', ['cls'] = 'HUNTER', },
		['continent'] = 1220, ['y'] = 0.4475, ['x'] = 0.6089, ['source'] = -1, ['target'] = 125, }, -- From Trueshot Lodge to Dalaran
	{ ['y'] = 0.4336, ['x'] = 0.4868, ['mapId'] = 739, ['reqs'] = { ['qid'] = '40959', ['cls'] = 'HUNTER', },
		['continent'] = 1220, ['source'] = 125, ['type'] = 'LocalPortal', }, -- From Trueshot Lodge to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['qid'] = '40653', ['cls'] = 'DRUID', },
		['continent'] = 1220, ['y'] = 0.4475, ['x'] = 0.6089, ['source'] = -1, ['target'] = 126, }, -- From The Dreamgrove to Dalaran
	{ ['y'] = 0.4303, ['x'] = 0.5663, ['mapId'] = 747, ['reqs'] = { ['qid'] = '40653', ['cls'] = 'DRUID', },
		['continent'] = 1220, ['source'] = 126, ['type'] = 'LocalPortal', }, -- From The Dreamgrove to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['cls'] = 'DEATHKNIGHT', }, ['continent'] = 1220,
		['y'] = 0.4475, ['x'] = 0.6089, ['source'] = -1, ['target'] = 127, }, -- From Acherus: The Ebon Hold to Dalaran
	{ ['y'] = 0.3376, ['x'] = 0.2497, ['mapId'] = 648, ['reqs'] = { ['cls'] = 'DEATHKNIGHT', }, ['continent'] = 1220,
		['source'] = 127, ['type'] = 'LocalPortal', }, -- From Acherus: The Ebon Hold to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = {}, ['continent'] = 1220, ['y'] = 0.4475, ['x'] = 0.6089,
		['source'] = -1, ['target'] = 128, }, -- From Stormheim to Dalaran
	{ ['y'] = 0.4071, ['x'] = 0.3008, ['mapId'] = 634, ['reqs'] = {}, ['continent'] = 1220, ['source'] = 128,
		['type'] = 'LocalPortal', }, -- From Stormheim to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 720, ['reqs'] = { ['cls'] = 'DEMONHUNTER', }, ['continent'] = 1519,
		['y'] = 0.913, ['x'] = 0.5931, ['source'] = -1, ['target'] = 129, }, -- From Dalaran to Mardum, the Shattered Abyss
	{ ['y'] = 0.6927, ['x'] = 0.9796, ['mapId'] = 627, ['reqs'] = { ['cls'] = 'DEMONHUNTER', }, ['continent'] = 1220,
		['source'] = 129, ['type'] = 'LocalPortal', }, -- From Dalaran to Mardum, the Shattered Abyss
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1220,
		['y'] = 0.4294, ['x'] = 0.6469, ['source'] = -1, ['target'] = 130, }, -- From Suramar to Dalaran
	{ ['y'] = 0.8762, ['x'] = 0.5867, ['mapId'] = 680, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1220,
		['source'] = 130, ['type'] = 'LocalPortal', }, -- From Suramar to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 830, ['reqs'] = { [''] = 'Grand Artificer Romuul', ['qid'] = '48440', },
		['continent'] = 1669, ['y'] = 0.8179, ['x'] = 0.6259, ['source'] = -1, ['target'] = 131, }, -- From The Vindicaar to Krokuun
	{ ['y'] = 0.2336, ['x'] = 0.4335, ['mapId'] = 831,
		['reqs'] = { [''] = 'Grand Artificer Romuul', ['qid'] = '48440', }, ['continent'] = 1669, ['source'] = 131,
		['type'] = 'LocalPortal', }, -- From The Vindicaar to Krokuun
	{ ['type'] = 'LocalPortal', ['mapId'] = 1970, ['reqs'] = { ['qid'] = '64957', }, ['continent'] = 2374, ['y'] = 0.6943,
		['x'] = 0.3327, ['source'] = -1, ['target'] = 132, }, -- From Oribos to Zereth Mortis
	{ ['y'] = 0.2544, ['x'] = 0.4959, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '64957', }, ['continent'] = 2222,
		['source'] = 132, ['type'] = 'LocalPortal', }, -- From Oribos to Zereth Mortis
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '64957', }, ['continent'] = 2222, ['y'] = 0.3004,
		['x'] = 0.4955, ['source'] = -1, ['target'] = 133, }, -- From Zereth Mortis to Oribos
	{ ['y'] = 0.6977, ['x'] = 0.3287, ['mapId'] = 1970, ['reqs'] = { ['qid'] = '64957', }, ['continent'] = 2374,
		['source'] = 133, ['type'] = 'LocalPortal', }, -- From Zereth Mortis to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '63665', }, ['continent'] = 2222, ['y'] = 0.3344,
		['x'] = 0.374, ['source'] = -1, ['target'] = 134, }, -- From Korthia to Oribos
	{ ['y'] = 0.2406, ['x'] = 0.6447, ['mapId'] = 1961, ['reqs'] = { ['qid'] = '63665', }, ['continent'] = 2222,
		['source'] = 134, ['type'] = 'LocalPortal', }, -- From Korthia to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1961, ['reqs'] = { ['qid'] = '63665', }, ['continent'] = 2222, ['y'] = 0.2411,
		['x'] = 0.6438, ['source'] = -1, ['target'] = 135, }, -- From Oribos to Korthia
	{ ['y'] = 0.2089, ['x'] = 0.2916, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '63665', }, ['continent'] = 2222,
		['source'] = 135, ['type'] = 'LocalPortal', }, -- From Oribos to Korthia
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.6092,
		['x'] = 0.4952, ['source'] = -1, ['target'] = 136, }, -- From Oribos to Oribos
	{ ['y'] = 0.5786, ['x'] = 0.5211, ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 136, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.42,
		['x'] = 0.4938, ['source'] = -1, ['target'] = 137, }, -- From Oribos to Oribos
	{ ['y'] = 0.4274, ['x'] = 0.521, ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 137, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.5786,
		['x'] = 0.5207, ['source'] = -1, ['target'] = 138, }, -- From Oribos to Oribos
	{ ['y'] = 0.6079, ['x'] = 0.4957, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 138, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.4244,
		['x'] = 0.521, ['source'] = -1, ['target'] = 139, }, -- From Oribos to Oribos
	{ ['y'] = 0.4235, ['x'] = 0.4956, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 139, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.5162,
		['x'] = 0.5566, ['source'] = -1, ['target'] = 140, }, -- From Oribos to Oribos
	{ ['y'] = 0.5036, ['x'] = 0.5714, ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 140, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.5156,
		['x'] = 0.4338, ['source'] = -1, ['target'] = 141, }, -- From Oribos to Oribos
	{ ['y'] = 0.5034, ['x'] = 0.4702, ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 141, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.5036,
		['x'] = 0.5714, ['source'] = -1, ['target'] = 142, }, -- From Oribos to Oribos
	{ ['y'] = 0.5159, ['x'] = 0.5568, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 142, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222, ['y'] = 0.503,
		['x'] = 0.4712, ['source'] = -1, ['target'] = 143, }, -- From Oribos to Oribos
	{ ['y'] = 0.5157, ['x'] = 0.4344, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '60154', }, ['continent'] = 2222,
		['source'] = 143, ['type'] = 'LocalPortal', }, -- From Oribos to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1543, ['reqs'] = { ['qid'] = '59874', }, ['continent'] = 2222, ['y'] = 0.4099,
		['x'] = 0.4495, ['source'] = -1, ['target'] = 144, }, -- From Oribos to The Maw
	{ ['y'] = 0.5088, ['x'] = 0.4927, ['mapId'] = 1671, ['reqs'] = { ['qid'] = '59874', }, ['continent'] = 2222,
		['source'] = 144, ['type'] = 'LocalPortal', }, -- From Oribos to The Maw
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '60338', }, ['continent'] = 2222, ['y'] = 0.5033,
		['x'] = 0.2038, ['source'] = -1, ['target'] = 145, }, -- From Ardenweald to Oribos
	{ ['y'] = 0.1727, ['x'] = 0.6835, ['mapId'] = 1565, ['reqs'] = { ['qid'] = '60338', }, ['continent'] = 2222,
		['source'] = 145, ['type'] = 'LocalPortal', }, -- From Ardenweald to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['qid'] = '59874', }, ['continent'] = 2222, ['y'] = 0.5031,
		['x'] = 0.1924, ['source'] = -1, ['target'] = 146, }, -- From The Maw to Oribos
	{ ['y'] = 0.4216, ['x'] = 0.4238, ['mapId'] = 1543, ['reqs'] = { ['qid'] = '59874', }, ['continent'] = 2222,
		['source'] = 146, ['type'] = 'LocalPortal', }, -- From The Maw to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1911, ['reqs'] = { ['qid'] = '60136', }, ['continent'] = 2453, ['y'] = 0.4708,
		['x'] = 0.1629, ['source'] = -1, ['target'] = 147, }, -- From The Maw to Torghast - Entrance
	{ ['y'] = 0.3939, ['x'] = 0.482, ['mapId'] = 1543, ['reqs'] = { ['qid'] = '60136', }, ['continent'] = 2222,
		['source'] = 147, ['type'] = 'LocalPortal', }, -- From The Maw to Torghast - Entrance
	{ ['type'] = 'LocalPortal', ['mapId'] = 1543, ['reqs'] = { ['qid'] = '60136', }, ['continent'] = 2222, ['y'] = 0.3957,
		['x'] = 0.4814, ['source'] = -1, ['target'] = 148, }, -- From Torghast - Entrance to The Maw
	{ ['y'] = 0.4713, ['x'] = 0.1043, ['mapId'] = 1911, ['reqs'] = { ['qid'] = '60136', }, ['continent'] = 2453,
		['source'] = 148, ['type'] = 'LocalPortal', }, -- From Torghast - Entrance to The Maw
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['qid'] = '60453', }, ['continent'] = 2222, ['y'] = 0.6769,
		['x'] = 0.371, ['source'] = -1, ['target'] = 149, }, -- From Maldraxxus to Maldraxxus
	{ ['y'] = 0.6696, ['x'] = 0.3799, ['mapId'] = 1536, ['reqs'] = { ['qid'] = '60453', }, ['continent'] = 2222,
		['source'] = 149, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['qid'] = '60453', }, ['continent'] = 2222, ['y'] = 0.6683,
		['x'] = 0.3806, ['source'] = -1, ['target'] = 150, }, -- From Maldraxxus to Maldraxxus
	{ ['y'] = 0.6756, ['x'] = 0.3713, ['mapId'] = 1536, ['reqs'] = { ['qid'] = '60453', }, ['continent'] = 2222,
		['source'] = 150, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57536', }, ['continent'] = 2222, ['y'] = 0.4668,
		['x'] = 0.3194, ['source'] = -1, ['target'] = 151, }, -- From Revendreth to Revendreth
	{ ['y'] = 0.5026, ['x'] = 0.2485, ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57536', }, ['continent'] = 2222,
		['source'] = 151, ['type'] = 'LocalPortal', }, -- From Revendreth to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57536', }, ['continent'] = 2222, ['y'] = 0.5031,
		['x'] = 0.2482, ['source'] = -1, ['target'] = 152, }, -- From Revendreth to Revendreth
	{ ['y'] = 0.467, ['x'] = 0.3198, ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57536', }, ['continent'] = 2222,
		['source'] = 152, ['type'] = 'LocalPortal', }, -- From Revendreth to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57885', }, ['continent'] = 2222, ['y'] = 0.286,
		['x'] = 0.5742, ['source'] = -1, ['target'] = 153, }, -- From Revendreth to Revendreth
	{ ['y'] = 0.3029, ['x'] = 0.5873, ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57885', }, ['continent'] = 2222,
		['source'] = 153, ['type'] = 'LocalPortal', }, -- From Revendreth to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57885', }, ['continent'] = 2222, ['y'] = 0.3034,
		['x'] = 0.5891, ['source'] = -1, ['target'] = 154, }, -- From Revendreth to Revendreth
	{ ['y'] = 0.2867, ['x'] = 0.5738, ['mapId'] = 1525, ['reqs'] = { ['qid'] = '57885', }, ['continent'] = 2222,
		['source'] = 154, ['type'] = 'LocalPortal', }, -- From Revendreth to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1699, ['reqs'] = { ['qid'] = '59327', }, ['continent'] = 2222, ['y'] = 0.5706,
		['x'] = 0.2365, ['source'] = -1, ['target'] = 155, }, -- From Revendreth to Sinfall
	{ ['y'] = 0.4267, ['x'] = 0.2935, ['mapId'] = 1525, ['reqs'] = { ['qid'] = '59327', }, ['continent'] = 2222,
		['source'] = 155, ['type'] = 'LocalPortal', }, -- From Revendreth to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['qid'] = '59327', }, ['continent'] = 2222, ['y'] = 0.4253,
		['x'] = 0.2957, ['source'] = -1, ['target'] = 156, }, -- From Sinfall to Revendreth
	{ ['y'] = 0.6134, ['x'] = 0.177, ['mapId'] = 1699, ['reqs'] = { ['qid'] = '59327', }, ['continent'] = 2222,
		['source'] = 156, ['type'] = 'LocalPortal', }, -- From Sinfall to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1912, ['reqs'] = { ['qid'] = '60267', }, ['continent'] = 2453, ['y'] = 0.6881,
		['x'] = 0.5068, ['source'] = -1, ['target'] = 157, }, -- From Torghast - Entrance to The Runecarver's Oubliette
	{ ['y'] = 0.6204, ['x'] = 0.1595, ['mapId'] = 1911, ['reqs'] = { ['qid'] = '60267', }, ['continent'] = 2453,
		['source'] = 157, ['type'] = 'LocalPortal', }, -- From Torghast - Entrance to The Runecarver's Oubliette
	{ ['type'] = 'LocalPortal', ['mapId'] = 1911, ['reqs'] = { ['qid'] = '60267', }, ['continent'] = 2453, ['y'] = 0.5784,
		['x'] = 0.1609, ['source'] = -1, ['target'] = 158, }, -- From The Runecarver's Oubliette to Torghast - Entrance
	{ ['y'] = 0.8196, ['x'] = 0.5033, ['mapId'] = 1912, ['reqs'] = { ['qid'] = '60267', }, ['continent'] = 2453,
		['source'] = 158, ['type'] = 'LocalPortal', }, -- From The Runecarver's Oubliette to Torghast - Entrance
	{ ['type'] = 'LocalPortal', ['mapId'] = 1700, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222, ['y'] = 0.3954,
		['x'] = 0.6886, ['source'] = -1, ['target'] = 159, }, -- From Sinfall to Sinfall
	{ ['y'] = 0.4819, ['x'] = 0.3655, ['mapId'] = 1699, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222,
		['source'] = 159, ['type'] = 'LocalPortal', }, -- From Sinfall to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1699, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222, ['y'] = 0.4723,
		['x'] = 0.3791, ['source'] = -1, ['target'] = 160, }, -- From Sinfall to Sinfall
	{ ['y'] = 0.3824, ['x'] = 0.7064, ['mapId'] = 1700, ['reqs'] = { ['qid'] = '59321', }, ['continent'] = 2222,
		['source'] = 160, ['type'] = 'LocalPortal', }, -- From Sinfall to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1533, ['reqs'] = { ['qid'] = '58530', }, ['continent'] = 2222, ['y'] = 0.3034,
		['x'] = 0.4942, ['source'] = -1, ['target'] = 161, }, -- From Sinfall to Bastion
	{ ['y'] = 0.4941, ['x'] = 0.4617, ['mapId'] = 1699, ['reqs'] = { ['qid'] = '58530', }, ['continent'] = 2222,
		['source'] = 161, ['type'] = 'LocalPortal', }, -- From Sinfall to Bastion
	{ ['type'] = 'LocalPortal', ['mapId'] = 1699, ['reqs'] = { ['qid'] = '58530', }, ['continent'] = 2222, ['y'] = 0.4911,
		['x'] = 0.4353, ['source'] = -1, ['target'] = 162, }, -- From Bastion to Sinfall
	{ ['y'] = 0.3035, ['x'] = 0.4938, ['mapId'] = 1533, ['reqs'] = { ['qid'] = '58530', }, ['continent'] = 2222,
		['source'] = 162, ['type'] = 'LocalPortal', }, -- From Bastion to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.5031, ['x'] = 0.1924, ['source'] = -1, ['target'] = 163, }, -- From Heart of the Forest to Oribos
	{ ['y'] = 0.2847, ['x'] = 0.599, ['mapId'] = 1702, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 163, ['type'] = 'LocalPortal', }, -- From Heart of the Forest to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.5031, ['x'] = 0.2034, ['source'] = -1, ['target'] = 164, }, -- From Elysian Hold to Oribos
	{ ['y'] = 0.6479, ['x'] = 0.4882, ['mapId'] = 1707, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 164, ['type'] = 'LocalPortal', }, -- From Elysian Hold to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['qid'] = '57583', }, ['continent'] = 2222, ['y'] = 0.7357,
		['x'] = 0.6572, ['source'] = -1, ['target'] = 165, }, -- From Heart of the Forest to Fungal Terminus
	{ ['y'] = 0.2635, ['x'] = 0.5521, ['mapId'] = 1702, ['reqs'] = { ['qid'] = '57583', }, ['continent'] = 2222,
		['source'] = 165, ['type'] = 'LocalPortal', }, -- From Heart of the Forest to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 166, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.7906, ['x'] = 0.5328, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 166, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 167, }, -- From The Root Cellar to Fungal Terminus
	{ ['y'] = 0.6828, ['x'] = 0.5041, ['mapId'] = 1826, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 167, ['type'] = 'LocalPortal', }, -- From The Root Cellar to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 168, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.6026, ['x'] = 0.6573, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 168, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 169, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.4259, ['x'] = 0.575, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 169, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 170, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.5125, ['x'] = 0.2644, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 170, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 171, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.3463, ['x'] = 0.2951, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 171, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7357, ['x'] = 0.6572, ['source'] = -1, ['target'] = 172, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.2755, ['x'] = 0.4939, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 172, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1702, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.2635, ['x'] = 0.5521, ['source'] = -1, ['target'] = 173, }, -- From Fungal Terminus to Heart of the Forest
	{ ['y'] = 0.6308, ['x'] = 0.5845, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 173, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Heart of the Forest
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.7906, ['x'] = 0.5328, ['source'] = -1, ['target'] = 174, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.6769, ['x'] = 0.5302, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 174, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1826, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.6828, ['x'] = 0.5041, ['source'] = -1, ['target'] = 175, }, -- From Fungal Terminus to The Root Cellar
	{ ['y'] = 0.5368, ['x'] = 0.6007, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 175, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to The Root Cellar
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.6026, ['x'] = 0.6573, ['source'] = -1, ['target'] = 176, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.6132, ['x'] = 0.4295, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 176, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.4259, ['x'] = 0.575, ['source'] = -1, ['target'] = 177, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.3891, ['x'] = 0.5671, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 177, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.5125, ['x'] = 0.2644, ['source'] = -1, ['target'] = 178, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.3665, ['x'] = 0.5196, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 178, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.3463, ['x'] = 0.2951, ['source'] = -1, ['target'] = 179, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.4009, ['x'] = 0.4239, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '1', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 179, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.2755, ['x'] = 0.4939, ['source'] = -1, ['target'] = 180, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.4839, ['x'] = 0.3965, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '2', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 180, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.2522, ['x'] = 0.7369, ['source'] = -1, ['target'] = 181, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.6638, ['x'] = 0.4579, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 181, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.736, ['x'] = 0.6575, ['source'] = -1, ['target'] = 182, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.2521, ['x'] = 0.7372, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 182, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.6954, ['x'] = 0.4109, ['source'] = -1, ['target'] = 183, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.354, ['x'] = 0.4687, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 183, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.736, ['x'] = 0.6575, ['source'] = -1, ['target'] = 184, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.6953, ['x'] = 0.4111, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 184, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.6695, ['x'] = 0.2028, ['source'] = -1, ['target'] = 185, }, -- From Fungal Terminus to Ardenweald
	{ ['y'] = 0.4356, ['x'] = 0.5878, ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 185, ['type'] = 'LocalPortal', }, -- From Fungal Terminus to Ardenweald
	{ ['type'] = 'LocalPortal', ['mapId'] = 1819, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['y'] = 0.736, ['x'] = 0.6575, ['source'] = -1, ['target'] = 186, }, -- From Ardenweald to Fungal Terminus
	{ ['y'] = 0.6696, ['x'] = 0.2029, ['mapId'] = 1565, ['reqs'] = { ['trank'] = '3', ['qid'] = '57583', },
		['continent'] = 2222, ['source'] = 186, ['type'] = 'LocalPortal', }, -- From Ardenweald to Fungal Terminus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.7342, ['x'] = 0.5039, ['source'] = -1, ['target'] = 187, }, -- From Seat of the Primus to Maldraxxus
	{ ['y'] = 0.2295, ['x'] = 0.5882, ['mapId'] = 1698, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 187, ['type'] = 'LocalPortal', }, -- From Seat of the Primus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1698, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.2585, ['x'] = 0.5871, ['source'] = -1, ['target'] = 188, }, -- From Maldraxxus to Seat of the Primus
	{ ['y'] = 0.7399, ['x'] = 0.504, ['mapId'] = 1536, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 188, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Seat of the Primus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.4301, ['x'] = 0.2608, ['source'] = -1, ['target'] = 189, }, -- From Seat of the Primus to Maldraxxus
	{ ['y'] = 0.3702, ['x'] = 0.5644, ['mapId'] = 1698, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 189, ['type'] = 'LocalPortal', }, -- From Seat of the Primus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1698, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.2585, ['x'] = 0.5871, ['source'] = -1, ['target'] = 190, }, -- From Maldraxxus to Seat of the Primus
	{ ['y'] = 0.4327, ['x'] = 0.2586, ['mapId'] = 1536, ['reqs'] = { ['trank'] = '1', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 190, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Seat of the Primus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.1637, ['x'] = 0.5114, ['source'] = -1, ['target'] = 191, }, -- From Seat of the Primus to Maldraxxus
	{ ['y'] = 0.3775, ['x'] = 0.6162, ['mapId'] = 1698, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 191, ['type'] = 'LocalPortal', }, -- From Seat of the Primus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1698, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.3424, ['x'] = 0.5892, ['source'] = -1, ['target'] = 192, }, -- From Maldraxxus to Seat of the Primus
	{ ['y'] = 0.1639, ['x'] = 0.5164, ['mapId'] = 1536, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 192, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Seat of the Primus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1536, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.3364, ['x'] = 0.7427, ['source'] = -1, ['target'] = 193, }, -- From Seat of the Primus to Maldraxxus
	{ ['y'] = 0.305, ['x'] = 0.6158, ['mapId'] = 1698, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 193, ['type'] = 'LocalPortal', }, -- From Seat of the Primus to Maldraxxus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1698, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.3424, ['x'] = 0.5892, ['source'] = -1, ['target'] = 194, }, -- From Maldraxxus to Seat of the Primus
	{ ['y'] = 0.3364, ['x'] = 0.7446, ['mapId'] = 1536, ['reqs'] = { ['trank'] = '2', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 194, ['type'] = 'LocalPortal', }, -- From Maldraxxus to Seat of the Primus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['trank'] = '3', ['qid'] = '63059', },
		['continent'] = 2222, ['y'] = 0.5031, ['x'] = 0.2034, ['source'] = -1, ['target'] = 195, }, -- From Seat of the Primus to Oribos
	{ ['y'] = 0.3148, ['x'] = 0.5638, ['mapId'] = 1698, ['reqs'] = { ['trank'] = '3', ['qid'] = '63059', },
		['continent'] = 2222, ['source'] = 195, ['type'] = 'LocalPortal', }, -- From Seat of the Primus to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['trank'] = '1', ['qid'] = '60147', },
		['continent'] = 2222, ['y'] = 0.3246, ['x'] = 0.5674, ['source'] = -1, ['target'] = 196, }, -- From Sinfall to Revendreth
	{ ['y'] = 0.495, ['x'] = 0.4618, ['mapId'] = 1699, ['reqs'] = { ['trank'] = '1', ['qid'] = '60147', },
		['continent'] = 2222, ['source'] = 196, ['type'] = 'LocalPortal', }, -- From Sinfall to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1699, ['reqs'] = { ['trank'] = '1', ['qid'] = '60147', },
		['continent'] = 2222, ['y'] = 0.495, ['x'] = 0.4618, ['source'] = -1, ['target'] = 197, }, -- From Revendreth to Sinfall
	{ ['y'] = 0.3246, ['x'] = 0.5674, ['mapId'] = 1525, ['reqs'] = { ['trank'] = '1', ['qid'] = '60147', },
		['continent'] = 2222, ['source'] = 197, ['type'] = 'LocalPortal', }, -- From Revendreth to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['trank'] = '1', ['qid'] = '60060', },
		['continent'] = 2222, ['y'] = 0.7548, ['x'] = 0.7076, ['source'] = -1, ['target'] = 198, }, -- From Sinfall to Revendreth
	{ ['y'] = 0.3622, ['x'] = 0.4212, ['mapId'] = 1699, ['reqs'] = { ['trank'] = '1', ['qid'] = '60060', },
		['continent'] = 2222, ['source'] = 198, ['type'] = 'LocalPortal', }, -- From Sinfall to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1699, ['reqs'] = { ['trank'] = '1', ['qid'] = '60060', },
		['continent'] = 2222, ['y'] = 0.3622, ['x'] = 0.4212, ['source'] = -1, ['target'] = 199, }, -- From Revendreth to Sinfall
	{ ['y'] = 0.7548, ['x'] = 0.7076, ['mapId'] = 1525, ['reqs'] = { ['trank'] = '1', ['qid'] = '60060', },
		['continent'] = 2222, ['source'] = 199, ['type'] = 'LocalPortal', }, -- From Revendreth to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['trank'] = '2', ['qid'] = '60159', },
		['continent'] = 2222, ['y'] = 0.4394, ['x'] = 0.7361, ['source'] = -1, ['target'] = 200, }, -- From Sinfall to Revendreth
	{ ['y'] = 0.5349, ['x'] = 0.6358, ['mapId'] = 1700, ['reqs'] = { ['trank'] = '2', ['qid'] = '60159', },
		['continent'] = 2222, ['source'] = 200, ['type'] = 'LocalPortal', }, -- From Sinfall to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1700, ['reqs'] = { ['trank'] = '2', ['qid'] = '60159', },
		['continent'] = 2222, ['y'] = 0.5349, ['x'] = 0.6358, ['source'] = -1, ['target'] = 201, }, -- From Revendreth to Sinfall
	{ ['y'] = 0.4394, ['x'] = 0.7361, ['mapId'] = 1525, ['reqs'] = { ['trank'] = '2', ['qid'] = '60159', },
		['continent'] = 2222, ['source'] = 201, ['type'] = 'LocalPortal', }, -- From Revendreth to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 1525, ['reqs'] = { ['trank'] = '2', ['qid'] = '60160', },
		['continent'] = 2222, ['y'] = 0.5707, ['x'] = 0.4348, ['source'] = -1, ['target'] = 202, }, -- From Sinfall to Revendreth
	{ ['y'] = 0.3656, ['x'] = 0.5834, ['mapId'] = 1700, ['reqs'] = { ['trank'] = '2', ['qid'] = '60160', },
		['continent'] = 2222, ['source'] = 202, ['type'] = 'LocalPortal', }, -- From Sinfall to Revendreth
	{ ['type'] = 'LocalPortal', ['mapId'] = 1700, ['reqs'] = { ['trank'] = '2', ['qid'] = '60160', },
		['continent'] = 2222, ['y'] = 0.3656, ['x'] = 0.5834, ['source'] = -1, ['target'] = 203, }, -- From Revendreth to Sinfall
	{ ['y'] = 0.5707, ['x'] = 0.4348, ['mapId'] = 1525, ['reqs'] = { ['trank'] = '2', ['qid'] = '60160', },
		['continent'] = 2222, ['source'] = 203, ['type'] = 'LocalPortal', }, -- From Revendreth to Sinfall
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '60151', }, ['continent'] = 1,
		['y'] = 0.9027, ['x'] = 0.5625, ['source'] = -1, ['target'] = 204, }, -- From Oribos to Orgrimmar
	{ ['y'] = 0.5477, ['x'] = 0.2085, ['mapId'] = 1670, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '60151', },
		['continent'] = 2222, ['source'] = 204, ['type'] = 'LocalPortal', }, -- From Oribos to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 81, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', }, ['continent'] = 1,
		['y'] = 0.4519, ['x'] = 0.4141, ['source'] = -1, ['target'] = 205, }, -- From Dazar'alor to Silithus
	{ ['y'] = 0.8467, ['x'] = 0.7322, ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['source'] = 205, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Silithus
	{ ['type'] = 'LocalPortal', ['mapId'] = 88, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', }, ['continent'] = 1,
		['y'] = 0.1687, ['x'] = 0.2221, ['source'] = -1, ['target'] = 206, }, -- From Dazar'alor to Thunder Bluff
	{ ['y'] = 0.7725, ['x'] = 0.735, ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['source'] = 206, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Thunder Bluff
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', }, ['continent'] = 1,
		['y'] = 0.8981, ['x'] = 0.571, ['source'] = -1, ['target'] = 207, }, -- From Dazar'alor to Orgrimmar
	{ ['y'] = 0.6967, ['x'] = 0.7317, ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['source'] = 207, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 81, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1, ['y'] = 0.4519, ['x'] = 0.4141, ['source'] = -1, ['target'] = 208, }, -- From Boralus to Silithus
	{ ['y'] = 0.1567, ['x'] = 0.6975, ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['source'] = 208, ['type'] = 'LocalPortal', }, -- From Boralus to Silithus
	{ ['type'] = 'LocalPortal', ['mapId'] = 103, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1, ['y'] = 0.5982, ['x'] = 0.4762, ['source'] = -1, ['target'] = 209, }, -- From Boralus to The Exodar
	{ ['y'] = 0.1508, ['x'] = 0.7035, ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['source'] = 209, ['type'] = 'LocalPortal', }, -- From Boralus to The Exodar
	{ ['type'] = 'LocalPortal', ['mapId'] = 62, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.3619, ['x'] = 0.4794, ['source'] = -1, ['target'] = 210, }, -- From Boralus to Darkshore
	{ ['y'] = 0.2444, ['x'] = 0.6625, ['mapId'] = 1161, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1643, ['source'] = 210, ['type'] = 'LocalPortal', }, -- From Boralus to Darkshore
	{ ['type'] = 'LocalPortal', ['mapId'] = 62, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Horde', }, ['continent'] = 1,
		['y'] = 0.35, ['x'] = 0.4631, ['source'] = -1, ['target'] = 211, }, -- From Dazar'alor to Darkshore
	{ ['y'] = 0.9449, ['x'] = 0.5198, ['mapId'] = 1165, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Horde', },
		['continent'] = 1642, ['source'] = 211, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Darkshore
	{ ['type'] = 'LocalPortal', ['mapId'] = 249, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '28112', },
		['continent'] = 1, ['y'] = 0.34246826171875, ['x'] = 0.54893493652344, ['source'] = -1, ['target'] = 212, }, -- From Stormwind City to Uldum
	{ ['y'] = 0.20494079589844, ['x'] = 0.75245666503906, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '28112', }, ['continent'] = 0, ['source'] = 212,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Uldum
	{ ['type'] = 'LocalPortal', ['mapId'] = 198, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '25316', },
		['continent'] = 1, ['y'] = 0.23391723632812, ['x'] = 0.63487243652344, ['source'] = -1, ['target'] = 213, }, -- From Stormwind City to Mount Hyjal
	{ ['y'] = 0.1868896484375, ['x'] = 0.76181030273438, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '25316', }, ['continent'] = 0, ['source'] = 213,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Mount Hyjal
	{ ['type'] = 'LocalPortal', ['mapId'] = 103, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.59820556640625, ['x'] = 0.4761962890625, ['source'] = -1, ['target'] = 214, }, -- From Shrine of Seven Stars to The Exodar
	{ ['y'] = 0.30500793457031, ['x'] = 0.70770263671875, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 214, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to The Exodar
	{ ['type'] = 'LocalPortal', ['mapId'] = 89, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.78672790527344, ['x'] = 0.43467712402344, ['source'] = -1, ['target'] = 215, }, -- From Shrine of Seven Stars to Darnassus
	{ ['y'] = 0.43572998046875, ['x'] = 0.77194213867188, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 215, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to Darnassus
	{ ['type'] = 'LocalPortal', ['mapId'] = 78, ['reqs'] = { ['qid'] = '12548', }, ['continent'] = 1,
		['y'] = 0.07916259765625, ['x'] = 0.50398254394531, ['source'] = -1, ['target'] = 216, }, -- From Sholazar Basin to Un'Goro Crater
	{ ['y'] = 0.82762145996094, ['x'] = 0.40266418457031, ['mapId'] = 119, ['reqs'] = { ['qid'] = '12548', },
		['continent'] = 571, ['source'] = 216, ['type'] = 'LocalPortal', }, -- From Sholazar Basin to Un'Goro Crater
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 217, }, -- From Dalaran to Orgrimmar
	{ ['y'] = 0.2544, ['x'] = 0.5541, ['mapId'] = 125, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571,
		['source'] = 217, ['type'] = 'LocalPortal', }, -- From Dalaran to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 218, }, -- From Shattrath City to Orgrimmar
	{ ['y'] = 0.4881, ['x'] = 0.5674, ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 530,
		['source'] = 218, ['type'] = 'LocalPortal', }, -- From Shattrath City to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '27203', }, ['continent'] = 1,
		['y'] = 0.37886047363281, ['x'] = 0.5013427734375, ['source'] = -1, ['target'] = 219, }, -- From Deepholm to Orgrimmar
	{ ['y'] = 0.53091430664062, ['x'] = 0.50927734375, ['mapId'] = 207,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '27203', }, ['continent'] = 646, ['source'] = 219,
		['type'] = 'LocalPortal', }, -- From Deepholm to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['lvl'] = '30', }, ['continent'] = 1,
		['y'] = 0.37886047363281, ['x'] = 0.5013427734375, ['source'] = -1, ['target'] = 220, }, -- From Tol Barad Peninsula to Orgrimmar
	{ ['y'] = 0.79652404785156, ['x'] = 0.56301879882812, ['mapId'] = 245,
		['reqs'] = { ['fac'] = 'Horde', ['lvl'] = '30', }, ['continent'] = 0, ['source'] = 220, ['type'] = 'LocalPortal', }, -- From Tol Barad Peninsula to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '26830', }, ['continent'] = 1,
		['y'] = 0.37886047363281, ['x'] = 0.5013427734375, ['source'] = -1, ['target'] = 221, }, -- From Twilight Highlands to Orgrimmar
	{ ['y'] = 0.53532409667969, ['x'] = 0.73550415039062, ['mapId'] = 241,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '26830', }, ['continent'] = 0, ['source'] = 221,
		['type'] = 'LocalPortal', }, -- From Twilight Highlands to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '29690', }, ['continent'] = 1,
		['y'] = 0.8981, ['x'] = 0.571, ['source'] = -1, ['target'] = 222, }, -- From The Jade Forest to Orgrimmar
	{ ['y'] = 0.1401, ['x'] = 0.2853, ['mapId'] = 371, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '29690', },
		['continent'] = 870, ['source'] = 222, ['type'] = 'LocalPortal', }, -- From The Jade Forest to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 88, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['y'] = 0.16867065429688, ['x'] = 0.22212219238281, ['source'] = -1, ['target'] = 223, }, -- From Shrine of Two Moons to Thunder Bluff
	{ ['y'] = 0.36204528808594, ['x'] = 0.73603820800781, ['mapId'] = 392, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 223, ['type'] = 'LocalPortal', }, -- From Shrine of Two Moons to Thunder Bluff
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['y'] = 0.40715026855469, ['x'] = 0.68649291992188, ['source'] = -1, ['target'] = 224, }, -- From Shrine of Two Moons to Orgrimmar
	{ ['y'] = 0.42718505859375, ['x'] = 0.7337646484375, ['mapId'] = 392, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 224, ['type'] = 'LocalPortal', }, -- From Shrine of Two Moons to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['y'] = 0.40715026855469, ['x'] = 0.68649291992188, ['source'] = -1, ['target'] = 225, }, -- From Kun-Lai Summit to Orgrimmar
	{ ['y'] = 0.43572998046875, ['x'] = 0.48530578613281, ['mapId'] = 379, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 225, ['type'] = 'LocalPortal', }, -- From Kun-Lai Summit to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 86, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.6453,
		['x'] = 0.4828, ['source'] = -1, ['target'] = 226, }, -- From Hellfire Peninsula to Orgrimmar
	{ ['y'] = 0.4945, ['x'] = 0.8922, ['mapId'] = 100, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 530,
		['source'] = 226, ['type'] = 'LocalPortal', }, -- From Hellfire Peninsula to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 86, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['y'] = 0.64529418945312, ['x'] = 0.48283386230469, ['source'] = -1, ['target'] = 227, }, -- From Hellfire Peninsula to Orgrimmar
	{ ['y'] = 0.47703552246094, ['x'] = 0.88575744628906, ['mapId'] = 100, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 530, ['source'] = 227, ['type'] = 'LocalPortal', }, -- From Hellfire Peninsula to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 57, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.8947, ['x'] = 0.5238, ['source'] = -1, ['target'] = 228, }, -- From Stormwind City to Teldrassil
	{ ['y'] = 0.5604, ['x'] = 0.2385, ['mapId'] = 84, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 0, ['source'] = 228, ['type'] = 'LocalPortal', }, -- From Stormwind City to Teldrassil
	{ ['type'] = 'LocalPortal', ['mapId'] = 62, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.1874, ['x'] = 0.4595, ['source'] = -1, ['target'] = 229, }, -- From Stormwind City to Darkshore
	{ ['y'] = 0.5604, ['x'] = 0.2385, ['mapId'] = 84, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 0, ['source'] = 229, ['type'] = 'LocalPortal', }, -- From Stormwind City to Darkshore
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 230, }, -- From Warspear to Orgrimmar
	{ ['y'] = 0.5163, ['x'] = 0.6066, ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1116,
		['source'] = 230, ['type'] = 'LocalPortal', }, -- From Warspear to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 231, }, -- From Dalaran to Orgrimmar
	{ ['y'] = 0.2399, ['x'] = 0.5528, ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1220,
		['source'] = 231, ['type'] = 'LocalPortal', }, -- From Dalaran to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 232, }, -- From Azsuna to Orgrimmar
	{ ['y'] = 0.413, ['x'] = 0.4668, ['mapId'] = 630, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1220,
		['source'] = 232, ['type'] = 'LocalPortal', }, -- From Azsuna to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 198, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', }, ['continent'] = 1,
		['y'] = 0.2583, ['x'] = 0.5929, ['source'] = -1, ['target'] = 233, }, -- From Emerald Dreamway to Mount Hyjal
	{ ['y'] = 0.5256, ['x'] = 0.5305, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 233, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to Mount Hyjal
	{ ['type'] = 'LocalPortal', ['mapId'] = 80, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', }, ['continent'] = 1,
		['y'] = 0.6019, ['x'] = 0.6759, ['source'] = -1, ['target'] = 234, }, -- From Emerald Dreamway to Moonglade
	{ ['y'] = 0.7959, ['x'] = 0.2612, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 234, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to Moonglade
	{ ['type'] = 'LocalPortal', ['mapId'] = 12, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', }, ['continent'] = 1,
		['y'] = 0.639, ['x'] = 0.4126, ['source'] = -1, ['target'] = 235, }, -- From Emerald Dreamway to Kalimdor
	{ ['y'] = 0.3888, ['x'] = 0.2357, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 235, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to Kalimdor
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1, ['y'] = 0.8981,
		['x'] = 0.571, ['source'] = -1, ['target'] = 236, }, -- From Silvermoon City to Orgrimmar
	{ ['y'] = 0.1869, ['x'] = 0.5855, ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['source'] = 236, ['type'] = 'LocalPortal', }, -- From Silvermoon City to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 103, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1, ['y'] = 0.5982,
		['x'] = 0.4762, ['source'] = -1, ['target'] = 237, }, -- From Stormwind City to The Exodar
	{ ['y'] = 0.871, ['x'] = 0.437, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['source'] = 237, ['type'] = 'LocalPortal', }, -- From Stormwind City to The Exodar
	{ ['type'] = 'LocalPortal', ['mapId'] = 74, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1, ['y'] = 0.283,
		['x'] = 0.546, ['source'] = -1, ['target'] = 238, }, -- From Stormwind City to Caverns of Time
	{ ['y'] = 0.8555, ['x'] = 0.4382, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['source'] = 238, ['type'] = 'LocalPortal', }, -- From Stormwind City to Caverns of Time
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1, ['y'] = 0.7725,
		['x'] = 0.3984, ['source'] = -1, ['target'] = 239, }, -- From Suramar to Orgrimmar
	{ ['y'] = 0.8729, ['x'] = 0.5821, ['mapId'] = 680, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1220,
		['source'] = 239, ['type'] = 'LocalPortal', }, -- From Suramar to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 85, ['reqs'] = { ['rac'] = 'HighmountainTauren', }, ['continent'] = 1,
		['y'] = 0.7721, ['x'] = 0.3982, ['source'] = -1, ['target'] = 240, }, -- From Thunder Totem to Orgrimmar
	{ ['y'] = 0.6388, ['x'] = 0.4642, ['mapId'] = 652, ['reqs'] = { ['rac'] = 'HighmountainTauren', },
		['continent'] = 1220, ['source'] = 240, ['type'] = 'LocalPortal', }, -- From Thunder Totem to Orgrimmar
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '60151', },
		['continent'] = 0, ['y'] = 0.9023, ['x'] = 0.4635, ['source'] = -1, ['target'] = 241, }, -- From Oribos to Stormwind City
	{ ['y'] = 0.4567, ['x'] = 0.2086, ['mapId'] = 1670, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '60151', },
		['continent'] = 2222, ['source'] = 241, ['type'] = 'LocalPortal', }, -- From Oribos to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', }, ['continent'] = 0,
		['y'] = 0.1926, ['x'] = 0.583, ['source'] = -1, ['target'] = 242, }, -- From Dazar'alor to Silvermoon City
	{ ['y'] = 0.6233, ['x'] = 0.7339, ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['source'] = 242, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Silvermoon City
	{ ['type'] = 'LocalPortal', ['mapId'] = 14, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '53208', }, ['continent'] = 0,
		['y'] = 0.2995, ['x'] = 0.274, ['source'] = -1, ['target'] = 243, }, -- From Dazar'alor to Arathi Highlands
	{ ['y'] = 0.9455, ['x'] = 0.5191, ['mapId'] = 1165, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '53208', },
		['continent'] = 1642, ['source'] = 243, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Arathi Highlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 14, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '53194', },
		['continent'] = 0, ['y'] = 0.6514, ['x'] = 0.2158, ['source'] = -1, ['target'] = 244, }, -- From Dazar'alor to Arathi Highlands
	{ ['y'] = 0.2447, ['x'] = 0.6614, ['mapId'] = 1165, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '53194', },
		['continent'] = 1642, ['source'] = 244, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Arathi Highlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 0, ['y'] = 0.9023, ['x'] = 0.4634, ['source'] = -1, ['target'] = 245, }, -- From Boralus to Stormwind City
	{ ['y'] = 0.1675, ['x'] = 0.7023, ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['source'] = 245, ['type'] = 'LocalPortal', }, -- From Boralus to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 87, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 0, ['y'] = 0.0843, ['x'] = 0.2551, ['source'] = -1, ['target'] = 246, }, -- From Boralus to Ironforge
	{ ['y'] = 0.1547, ['x'] = 0.7081, ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['source'] = 246, ['type'] = 'LocalPortal', }, -- From Boralus to Ironforge
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 247, }, -- From Azsuna to Stormwind City
	{ ['y'] = 0.4141, ['x'] = 0.4669, ['mapId'] = 630, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1220,
		['source'] = 247, ['type'] = 'LocalPortal', }, -- From Azsuna to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 90, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.1633,
		['x'] = 0.8459, ['source'] = -1, ['target'] = 248, }, -- From Orgrimmar to Undercity
	{ ['y'] = 0.5561, ['x'] = 0.5079, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 248, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Undercity
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = 249, }, -- From Dalaran to Stormwind City
	{ ['y'] = 0.625, ['x'] = 0.39498901367188, ['mapId'] = 125, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['source'] = 249, ['type'] = 'LocalPortal', }, -- From Dalaran to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 250, }, -- From Shattrath City to Stormwind City
	{ ['y'] = 0.481, ['x'] = 0.5711, ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 530,
		['source'] = 250, ['type'] = 'LocalPortal', }, -- From Shattrath City to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.1924,
		['x'] = 0.5826, ['source'] = -1, ['target'] = 251, }, -- From Orgrimmar to Silvermoon City
	{ ['y'] = 0.8832, ['x'] = 0.5606, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 251, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Silvermoon City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 0, ['y'] = 0.8653, ['x'] = 0.4959, ['source'] = -1, ['target'] = 252, }, -- From Teldrassil to Stormwind City
	{ ['y'] = 0.937, ['x'] = 0.5503, ['mapId'] = 57, ['reqs'] = { ['notlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 252, ['type'] = 'LocalPortal', }, -- From Teldrassil to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 253, }, -- From The Exodar to Stormwind City
	{ ['y'] = 0.6263, ['x'] = 0.4825, ['mapId'] = 103, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['source'] = 253, ['type'] = 'LocalPortal', }, -- From The Exodar to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.8653,
		['x'] = 0.4959, ['source'] = -1, ['target'] = 254, }, -- From Hellfire Peninsula to Stormwind City
	{ ['y'] = 0.51, ['x'] = 0.8922, ['mapId'] = 100, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 530,
		['source'] = 254, ['type'] = 'LocalPortal', }, -- From Hellfire Peninsula to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = 255, }, -- From Hellfire Peninsula to Stormwind City
	{ ['y'] = 0.52810668945312, ['x'] = 0.88632202148438, ['mapId'] = 100, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 530, ['source'] = 255, ['type'] = 'LocalPortal', }, -- From Hellfire Peninsula to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27203', },
		['continent'] = 0, ['y'] = 0.18338012695312, ['x'] = 0.74455261230469, ['source'] = -1, ['target'] = 256, }, -- From Deepholm to Stormwind City
	{ ['y'] = 0.53837585449219, ['x'] = 0.48519897460938, ['mapId'] = 207,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27203', }, ['continent'] = 646, ['source'] = 256,
		['type'] = 'LocalPortal', }, -- From Deepholm to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '25316', },
		['continent'] = 0, ['y'] = 0.18338012695312, ['x'] = 0.74455261230469, ['source'] = -1, ['target'] = 257, }, -- From Mount Hyjal to Stormwind City
	{ ['y'] = 0.23129272460938, ['x'] = 0.62605285644531, ['mapId'] = 198,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '25316', }, ['continent'] = 1, ['source'] = 257,
		['type'] = 'LocalPortal', }, -- From Mount Hyjal to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '31732', },
		['continent'] = 0, ['y'] = 0.9023, ['x'] = 0.4634, ['source'] = -1, ['target'] = 258, }, -- From The Jade Forest to Stormwind City
	{ ['y'] = 0.8516, ['x'] = 0.4623, ['mapId'] = 371, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '31732', },
		['continent'] = 870, ['source'] = 258, ['type'] = 'LocalPortal', }, -- From The Jade Forest to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = 259, }, -- From Shrine of Seven Stars to Stormwind City
	{ ['y'] = 0.36099243164062, ['x'] = 0.71446228027344, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 259, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 87, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.084274291992188, ['x'] = 0.25509643554688, ['source'] = -1, ['target'] = 260, }, -- From Shrine of Seven Stars to Ironforge
	{ ['y'] = 0.4091796875, ['x'] = 0.74085998535156, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 260, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to Ironforge
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['y'] = 0.17002868652344, ['x'] = 0.67733764648438, ['source'] = -1, ['target'] = 261, }, -- From Kun-Lai Summit to Stormwind City
	{ ['y'] = 0.43368530273438, ['x'] = 0.48965454101562, ['mapId'] = 379, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 261, ['type'] = 'LocalPortal', }, -- From Kun-Lai Summit to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 204, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25924', }, ['continent'] = 0,
		['y'] = 0.60946655273438, ['x'] = 0.51368713378906, ['source'] = -1, ['target'] = 262, }, -- From Orgrimmar to Abyssal Depths
	{ ['y'] = 0.36517333984375, ['x'] = 0.49224853515625, ['mapId'] = 85,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '25924', }, ['continent'] = 1, ['source'] = 262,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Abyssal Depths
	{ ['type'] = 'LocalPortal', ['mapId'] = 245,
		['reqs'] = { ['qid'] = '29690', ['fac'] = 'Horde', ['lvl'] = '30', }, ['continent'] = 0, ['y'] = 0.80064392089844,
		['x'] = 0.55775451660156, ['source'] = -1, ['target'] = 263, }, -- From Orgrimmar to Tol Barad Peninsula
	{ ['y'] = 0.39295959472656, ['x'] = 0.47404479980469, ['mapId'] = 85,
		['reqs'] = { ['qid'] = '29690', ['fac'] = 'Horde', ['lvl'] = '30', }, ['continent'] = 1, ['source'] = 263,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Tol Barad Peninsula
	{ ['type'] = 'LocalPortal', ['mapId'] = 241, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '26830', }, ['continent'] = 0,
		['y'] = 0.53392028808594, ['x'] = 0.73631286621094, ['source'] = -1, ['target'] = 264, }, -- From Orgrimmar to Twilight Highlands
	{ ['y'] = 0.39410400390625, ['x'] = 0.50221252441406, ['mapId'] = 85,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '26830', }, ['continent'] = 1, ['source'] = 264,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Twilight Highlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 90, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['y'] = 0.16328430175781, ['x'] = 0.84580993652344, ['source'] = -1, ['target'] = 265, }, -- From Shrine of Two Moons to Undercity
	{ ['y'] = 0.48118591308594, ['x'] = 0.74226379394531, ['mapId'] = 392, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 265, ['type'] = 'LocalPortal', }, -- From Shrine of Two Moons to Undercity
	{ ['type'] = 'LocalPortal', ['mapId'] = 110, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 0,
		['y'] = 0.19242858886719, ['x'] = 0.58259582519531, ['source'] = -1, ['target'] = 266, }, -- From Shrine of Two Moons to Silvermoon City
	{ ['y'] = 0.52592468261719, ['x'] = 0.75790405273438, ['mapId'] = 392, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 266, ['type'] = 'LocalPortal', }, -- From Shrine of Two Moons to Silvermoon City
	{ ['type'] = 'LocalPortal', ['mapId'] = 122, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.34480285644531,
		['x'] = 0.48248291015625, ['source'] = -1, ['target'] = 267, }, -- From Shattrath City to Isle of Quel'Danas
	{ ['y'] = 0.42045593261719, ['x'] = 0.48799133300781, ['mapId'] = 111, ['reqs'] = {}, ['continent'] = 530,
		['source'] = 267, ['type'] = 'LocalPortal', }, -- From Shattrath City to Isle of Quel'Danas
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 268, }, -- From Stormshield to Stormwind City
	{ ['y'] = 0.3799, ['x'] = 0.6083, ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1116,
		['source'] = 268, ['type'] = 'LocalPortal', }, -- From Stormshield to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 269, }, -- From Dalaran to Stormwind City
	{ ['y'] = 0.6298, ['x'] = 0.393, ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1220,
		['source'] = 269, ['type'] = 'LocalPortal', }, -- From Dalaran to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 26, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', }, ['continent'] = 0,
		['y'] = 0.235, ['x'] = 0.6248, ['source'] = -1, ['target'] = 270, }, -- From Emerald Dreamway to The Hinterlands
	{ ['y'] = 0.652, ['x'] = 0.5027, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 270, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to The Hinterlands
	{ ['type'] = 'LocalPortal', ['mapId'] = 47, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', }, ['continent'] = 0,
		['y'] = 0.3706, ['x'] = 0.4659, ['source'] = -1, ['target'] = 271, }, -- From Emerald Dreamway to Duskwood
	{ ['y'] = 0.6892, ['x'] = 0.3981, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 271, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to Duskwood
	{ ['type'] = 'LocalPortal', ['mapId'] = 24,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.6261,
		['x'] = 0.3863, ['source'] = -1, ['target'] = 272, }, -- From Dalaran to Light's Hope Chapel
	{ ['y'] = 0.6976, ['x'] = 0.3267, ['mapId'] = 627,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Alliance', }, ['continent'] = 1220,
		['source'] = 272, ['type'] = 'LocalPortal', }, -- From Dalaran to Light's Hope Chapel
	{ ['type'] = 'LocalPortal', ['mapId'] = 24,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.6146,
		['x'] = 0.3942, ['source'] = -1, ['target'] = 273, }, -- From Dalaran to Light's Hope Chapel
	{ ['y'] = 0.1349, ['x'] = 0.6192, ['mapId'] = 627,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Horde', }, ['continent'] = 1220, ['source'] = 273,
		['type'] = 'LocalPortal', }, -- From Dalaran to Light's Hope Chapel
	{ ['type'] = 'LocalPortal', ['mapId'] = 42,
		['reqs'] = { ['qid'] = '40718', ['nqid'] = '44663', ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.4605,
		['x'] = 0.726, ['source'] = -1, ['target'] = 274, }, -- From Stormwind City to Deadwind Pass
	{ ['y'] = 0.3483, ['x'] = 0.8025, ['mapId'] = 84,
		['reqs'] = { ['qid'] = '40718', ['nqid'] = '44663', ['fac'] = 'Alliance', }, ['continent'] = 0, ['source'] = 274,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Deadwind Pass
	{ ['type'] = 'LocalPortal', ['mapId'] = 42,
		['reqs'] = { ['qid'] = '40718', ['nqid'] = '44184', ['fac'] = 'Horde', }, ['continent'] = 0, ['y'] = 0.4605,
		['x'] = 0.726, ['source'] = -1, ['target'] = 275, }, -- From Orgrimmar to Deadwind Pass
	{ ['y'] = 0.7114, ['x'] = 0.3632, ['mapId'] = 86,
		['reqs'] = { ['qid'] = '40718', ['nqid'] = '44184', ['fac'] = 'Horde', }, ['continent'] = 1, ['source'] = 275,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Deadwind Pass
	{ ['type'] = 'LocalPortal', ['mapId'] = 122, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.4815, ['x'] = 0.5704,
		['source'] = -1, ['target'] = 276, }, -- From Shattrath City to Isle of Quel'Danas
	{ ['y'] = 0.4205, ['x'] = 0.4872, ['mapId'] = 111, ['reqs'] = {}, ['continent'] = 530, ['source'] = 276,
		['type'] = 'LocalPortal', }, -- From Shattrath City to Isle of Quel'Danas
	{ ['type'] = 'LocalPortal', ['mapId'] = 17, ['reqs'] = {}, ['continent'] = 0, ['y'] = 0.5345, ['x'] = 0.5496,
		['source'] = -1, ['target'] = 277, }, -- From Hellfire Peninsula to Blasted Lands
	{ ['y'] = 0.5022, ['x'] = 0.8978, ['mapId'] = 100, ['reqs'] = {}, ['continent'] = 530, ['source'] = 277,
		['type'] = 'LocalPortal', }, -- From Hellfire Peninsula to Blasted Lands
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['rac'] = 'VoidElf', }, ['continent'] = 0, ['y'] = 0.1475,
		['x'] = 0.54, ['source'] = -1, ['target'] = 278, }, -- From Telogrus Rift to Stormwind City
	{ ['y'] = 0.215, ['x'] = 0.2802, ['mapId'] = 971, ['reqs'] = { ['rac'] = 'VoidElf', }, ['continent'] = 1865,
		['source'] = 278, ['type'] = 'LocalPortal', }, -- From Telogrus Rift to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['rac'] = 'Mechagnome', }, ['continent'] = 0, ['y'] = 0.1648,
		['x'] = 0.5411, ['source'] = -1, ['target'] = 279, }, -- From Mechagon City to Stormwind City
	{ ['y'] = 0.6064, ['x'] = 0.2072, ['mapId'] = 1573, ['reqs'] = { ['rac'] = 'Mechagnome', }, ['continent'] = 2268,
		['source'] = 279, ['type'] = 'LocalPortal', }, -- From Mechagon City to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['rac'] = 'LightforgedDraenei', }, ['continent'] = 0,
		['y'] = 0.1475, ['x'] = 0.54, ['source'] = -1, ['target'] = 280, }, -- From The Vindicaar to Stormwind City
	{ ['y'] = 0.2532, ['x'] = 0.4322, ['mapId'] = 941, ['reqs'] = { ['rac'] = 'LightforgedDraenei', },
		['continent'] = 1860, ['source'] = 280, ['type'] = 'LocalPortal', }, -- From The Vindicaar to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0, ['y'] = 0.9023,
		['x'] = 0.4634, ['source'] = -1, ['target'] = 281, }, -- From Caverns of Time to Stormwind City
	{ ['y'] = 0.2683, ['x'] = 0.589, ['mapId'] = 74, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['source'] = 281, ['type'] = 'LocalPortal', }, -- From Caverns of Time to Stormwind City
	{ ['type'] = 'LocalPortal', ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 530,
		['y'] = 0.49209594726562, ['x'] = 0.53005981445312, ['source'] = -1, ['target'] = 282, }, -- From Shrine of Two Moons to Shattrath City
	{ ['y'] = 0.57313537597656, ['x'] = 0.63674926757812, ['mapId'] = 392, ['reqs'] = { ['fac'] = 'Horde', },
		['continent'] = 870, ['source'] = 282, ['type'] = 'LocalPortal', }, -- From Shrine of Two Moons to Shattrath City
	{ ['type'] = 'LocalPortal', ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 530,
		['y'] = 0.49209594726562, ['x'] = 0.53005981445312, ['source'] = -1, ['target'] = 283, }, -- From Shrine of Seven Stars to Shattrath City
	{ ['y'] = 0.53025817871094, ['x'] = 0.68421936035156, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 283, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to Shattrath City
	{ ['type'] = 'LocalPortal', ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 530, ['y'] = 0.4921,
		['x'] = 0.53, ['source'] = -1, ['target'] = 284, }, -- From Orgrimmar to Shattrath City
	{ ['y'] = 0.8748, ['x'] = 0.5713, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 284, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Shattrath City
	{ ['type'] = 'LocalPortal', ['mapId'] = 111, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 530,
		['y'] = 0.4023, ['x'] = 0.5497, ['source'] = -1, ['target'] = 285, }, -- From Stormwind City to Shattrath City
	{ ['y'] = 0.8586, ['x'] = 0.448, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['source'] = 285, ['type'] = 'LocalPortal', }, -- From Stormwind City to Shattrath City
	{ ['type'] = 'LocalPortal', ['mapId'] = 100, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 530,
		['y'] = 0.4956, ['x'] = 0.8915, ['source'] = -1, ['target'] = 286, }, -- From Darnassus to Hellfire Peninsula
	{ ['y'] = 0.7817, ['x'] = 0.4399, ['mapId'] = 89, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['source'] = 286, ['type'] = 'LocalPortal', }, -- From Darnassus to Hellfire Peninsula
	{ ['type'] = 'LocalPortal', ['mapId'] = 125, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = 287, }, -- From Shrine of Seven Stars to Dalaran
	{ ['y'] = 0.39312744140625, ['x'] = 0.61943054199219, ['mapId'] = 394, ['reqs'] = { ['fac'] = 'Alliance', },
		['continent'] = 870, ['source'] = 287, ['type'] = 'LocalPortal', }, -- From Shrine of Seven Stars to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 119, ['reqs'] = { ['qid'] = '12548', }, ['continent'] = 571,
		['y'] = 0.82762145996094, ['x'] = 0.40266418457031, ['source'] = -1, ['target'] = 288, }, -- From Un'Goro Crater to Sholazar Basin
	{ ['y'] = 0.07916259765625, ['x'] = 0.50398254394531, ['mapId'] = 78, ['reqs'] = { ['qid'] = '12548', },
		['continent'] = 1, ['source'] = 288, ['type'] = 'LocalPortal', }, -- From Un'Goro Crater to Sholazar Basin
	{ ['type'] = 'LocalPortal', ['mapId'] = 116, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 571, ['y'] = 0.2975, ['x'] = 0.5043, ['source'] = -1, ['target'] = 289, }, -- From Emerald Dreamway to Grizzly Hills
	{ ['y'] = 0.2662, ['x'] = 0.3176, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 289, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to Grizzly Hills
	{ ['type'] = 'LocalPortal', ['mapId'] = 888, ['reqs'] = {}, ['continent'] = 1733, ['y'] = 0.82, ['x'] = 0.4369,
		['source'] = -1, ['target'] = 290, }, -- From Sholazar Basin to Hall of Communion
	{ ['y'] = 0.53, ['x'] = 0.8843, ['mapId'] = 119, ['reqs'] = {}, ['continent'] = 571, ['source'] = 290,
		['type'] = 'LocalPortal', }, -- From Sholazar Basin to Hall of Communion
	{ ['type'] = 'LocalPortal', ['mapId'] = 125, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 571, ['y'] = 0.4678,
		['x'] = 0.5592, ['source'] = -1, ['target'] = 291, }, -- From Orgrimmar to Dalaran
	{ ['y'] = 0.9169, ['x'] = 0.5626, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 291, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 125, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 571,
		['y'] = 0.4678, ['x'] = 0.5592, ['source'] = -1, ['target'] = 292, }, -- From Stormwind City to Dalaran
	{ ['y'] = 0.8859, ['x'] = 0.4447, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['source'] = 292, ['type'] = 'LocalPortal', }, -- From Stormwind City to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 207, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27203', },
		['continent'] = 646, ['y'] = 0.53555297851562, ['x'] = 0.4873046875, ['source'] = -1, ['target'] = 293, }, -- From Stormwind City to Deepholm
	{ ['y'] = 0.19636535644531, ['x'] = 0.73190307617188, ['mapId'] = 84,
		['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '27203', }, ['continent'] = 0, ['source'] = 293,
		['type'] = 'LocalPortal', }, -- From Stormwind City to Deepholm
	{ ['type'] = 'LocalPortal', ['mapId'] = 207, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '27203', },
		['continent'] = 646, ['y'] = 0.5294189453125, ['x'] = 0.50592041015625, ['source'] = -1, ['target'] = 294, }, -- From Orgrimmar to Deepholm
	{ ['y'] = 0.36338806152344, ['x'] = 0.50839233398438, ['mapId'] = 85,
		['reqs'] = { ['fac'] = 'Horde', ['qid'] = '27203', }, ['continent'] = 1, ['source'] = 294,
		['type'] = 'LocalPortal', }, -- From Orgrimmar to Deepholm
	{ ['type'] = 'LocalPortal', ['mapId'] = 371, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '29690', },
		['continent'] = 870, ['y'] = 0.1398, ['x'] = 0.2856, ['source'] = -1, ['target'] = 295, }, -- From Orgrimmar to The Jade Forest
	{ ['y'] = 0.921, ['x'] = 0.5747, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '29690', },
		['continent'] = 1, ['source'] = 295, ['type'] = 'LocalPortal', }, -- From Orgrimmar to The Jade Forest
	{ ['type'] = 'LocalPortal', ['mapId'] = 371, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '31732', },
		['continent'] = 870, ['y'] = 0.8507, ['x'] = 0.4618, ['source'] = -1, ['target'] = 296, }, -- From Stormwind City to The Jade Forest
	{ ['y'] = 0.8723, ['x'] = 0.4566, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '31732', },
		['continent'] = 0, ['source'] = 296, ['type'] = 'LocalPortal', }, -- From Stormwind City to The Jade Forest
	{ ['type'] = 'LocalPortal', ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '34446', },
		['continent'] = 1116, ['y'] = 0.3553, ['x'] = 0.4442, ['source'] = -1, ['target'] = 297, }, -- From Blasted Lands to Warspear
	{ ['y'] = 0.5388, ['x'] = 0.5494, ['mapId'] = 17, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '34446', },
		['continent'] = 0, ['source'] = 297, ['type'] = 'LocalPortal', }, -- From Blasted Lands to Warspear
	{ ['type'] = 'LocalPortal', ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '35884', },
		['continent'] = 1116, ['y'] = 0.5248, ['x'] = 0.3171, ['source'] = -1, ['target'] = 298, }, -- From Blasted Lands to Stormshield
	{ ['y'] = 0.5388, ['x'] = 0.5494, ['mapId'] = 17, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '35884', },
		['continent'] = 0, ['source'] = 298, ['type'] = 'LocalPortal', }, -- From Blasted Lands to Stormshield
	{ ['type'] = 'LocalPortal', ['mapId'] = 624, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1116, ['y'] = 0.4974,
		['x'] = 0.5695, ['source'] = -1, ['target'] = 299, }, -- From Orgrimmar to Warspear
	{ ['y'] = 0.8793, ['x'] = 0.5826, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', }, ['continent'] = 1,
		['source'] = 299, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Warspear
	{ ['type'] = 'LocalPortal', ['mapId'] = 622, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1116,
		['y'] = 0.3993, ['x'] = 0.6153, ['source'] = -1, ['target'] = 300, }, -- From Stormwind City to Stormshield
	{ ['y'] = 0.92, ['x'] = 0.4808, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 0,
		['source'] = 300, ['type'] = 'LocalPortal', }, -- From Stormwind City to Stormshield
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['qid'] = '48440', }, ['continent'] = 1220, ['y'] = 0.4473,
		['x'] = 0.6092, ['source'] = -1, ['target'] = 301, }, -- From The Vindicaar to Dalaran
	{ ['y'] = 0.2549, ['x'] = 0.4339, ['mapId'] = 832, ['reqs'] = { ['qid'] = '48440', }, ['continent'] = 1669,
		['source'] = 301, ['type'] = 'LocalPortal', }, -- From The Vindicaar to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['qid'] = '48081', }, ['continent'] = 1220, ['y'] = 0.4473,
		['x'] = 0.6092, ['source'] = -1, ['target'] = 302, }, -- From The Vindicaar to Dalaran
	{ ['y'] = 0.2584, ['x'] = 0.4939, ['mapId'] = 884, ['reqs'] = { ['qid'] = '48081', }, ['continent'] = 1669,
		['source'] = 302, ['type'] = 'LocalPortal', }, -- From The Vindicaar to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['qid'] = '48199', }, ['continent'] = 1220, ['y'] = 0.4473,
		['x'] = 0.6092, ['source'] = -1, ['target'] = 303, }, -- From The Vindicaar to Dalaran
	{ ['y'] = 0.5602, ['x'] = 0.3507, ['mapId'] = 887, ['reqs'] = { ['qid'] = '48199', }, ['continent'] = 1669,
		['source'] = 303, ['type'] = 'LocalPortal', }, -- From The Vindicaar to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = {}, ['continent'] = 1220, ['y'] = 0.5054, ['x'] = 0.3965,
		['source'] = -1, ['target'] = 304, }, -- From Hall of Communion to Dalaran
	{ ['y'] = 0.088, ['x'] = 0.4978, ['mapId'] = 888, ['reqs'] = {}, ['continent'] = 1733, ['source'] = 304,
		['type'] = 'LocalPortal', }, -- From Hall of Communion to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['cls'] = 'MONK', ['qid'] = '40236', },
		['continent'] = 1220, ['y'] = 0.4473, ['x'] = 0.6092, ['source'] = -1, ['target'] = 305, }, -- From The Wandering Isle to Dalaran
	{ ['y'] = 0.5717, ['x'] = 0.524, ['mapId'] = 709, ['reqs'] = { ['cls'] = 'MONK', ['qid'] = '40236', },
		['continent'] = 1514, ['source'] = 305, ['type'] = 'LocalPortal', }, -- From The Wandering Isle to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 379, ['reqs'] = { ['cls'] = 'MONK', ['qid'] = '40236', }, ['continent'] = 870,
		['y'] = 0.4312, ['x'] = 0.4869, ['source'] = -1, ['target'] = 306, }, -- From The Wandering Isle to Kun-Lai Summit
	{ ['y'] = 0.5441, ['x'] = 0.5005, ['mapId'] = 709, ['reqs'] = { ['cls'] = 'MONK', ['qid'] = '40236', },
		['continent'] = 1514, ['source'] = 306, ['type'] = 'LocalPortal', }, -- From The Wandering Isle to Kun-Lai Summit
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['cls'] = 'MAGE', }, ['continent'] = 1220, ['y'] = 0.4473,
		['x'] = 0.6092, ['source'] = -1, ['target'] = 307, }, -- From Hall of the Guardian to Dalaran
	{ ['y'] = 0.9012, ['x'] = 0.5731, ['mapId'] = 734, ['reqs'] = { ['cls'] = 'MAGE', }, ['continent'] = 1513,
		['source'] = 307, ['type'] = 'LocalPortal', }, -- From Hall of the Guardian to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 630, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1220, ['y'] = 0.1511, ['x'] = 0.5791, ['source'] = -1, ['target'] = 308, }, -- Using Teleportation Nexus to Azsuna
	{ ['y'] = 0.3997, ['x'] = 0.551, ['mapId'] = 734, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1513, ['source'] = 308, ['type'] = 'LocalPortal', }, -- From Hall of the Guardian to Azsuna
	{ ['type'] = 'LocalPortal', ['mapId'] = 650, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1220, ['y'] = 0.638, ['x'] = 0.314, ['source'] = -1, ['target'] = 309, }, -- Using Teleportation Nexus to Highmountain
	{ ['y'] = 0.4437, ['x'] = 0.5664, ['mapId'] = 734, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1513, ['source'] = 309, ['type'] = 'LocalPortal', }, -- From Hall of the Guardian to Highmountain
	{ ['type'] = 'LocalPortal', ['mapId'] = 641, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1220, ['y'] = 0.561, ['x'] = 0.513, ['source'] = -1, ['target'] = 310, }, -- Using Teleportation Nexus to Val'sharah
	{ ['y'] = 0.4601, ['x'] = 0.6684, ['mapId'] = 734, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1513, ['source'] = 310, ['type'] = 'LocalPortal', }, -- From Hall of the Guardian to Val'sharah
	{ ['type'] = 'LocalPortal', ['mapId'] = 634, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1220, ['y'] = 0.6051, ['x'] = 0.3134, ['source'] = -1, ['target'] = 311, }, -- Using Teleportation Nexus to Stormheim
	{ ['y'] = 0.4196, ['x'] = 0.6709, ['mapId'] = 734, ['reqs'] = { ['cls'] = 'MAGE', ['spell'] = '223413', },
		['continent'] = 1513, ['source'] = 311, ['type'] = 'LocalPortal', }, -- From Hall of the Guardian to Stormheim
	{ ['type'] = 'LocalPortal', ['mapId'] = 627,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Alliance', }, ['continent'] = 1220,
		['y'] = 0.6889, ['x'] = 0.332, ['source'] = -1, ['target'] = 312, }, -- From Light's Hope Chapel to Dalaran
	{ ['y'] = 0.6384, ['x'] = 0.3779, ['mapId'] = 24,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Alliance', }, ['continent'] = 0, ['source'] = 312,
		['type'] = 'LocalPortal', }, -- From Light's Hope Chapel to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Horde', }, ['continent'] = 1220, ['y'] = 0.1482,
		['x'] = 0.6127, ['source'] = -1, ['target'] = 313, }, -- From Light's Hope Chapel to Dalaran
	{ ['y'] = 0.6384, ['x'] = 0.3779, ['mapId'] = 24,
		['reqs'] = { ['qid'] = '38576', ['cls'] = 'PALADIN', ['fac'] = 'Horde', }, ['continent'] = 0, ['source'] = 313,
		['type'] = 'LocalPortal', }, -- From Light's Hope Chapel to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 747, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1220, ['y'] = 0.3507, ['x'] = 0.516, ['source'] = -1, ['target'] = 314, }, -- From Emerald Dreamway to The Dreamgrove
	{ ['y'] = 0.2393, ['x'] = 0.4552, ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['source'] = 314, ['type'] = 'LocalPortal', }, -- From Emerald Dreamway to The Dreamgrove
	{ ['type'] = 'LocalPortal', ['mapId'] = 630, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '44184', },
		['continent'] = 1220, ['y'] = 0.4136, ['x'] = 0.4682, ['source'] = -1, ['target'] = 315, }, -- From Orgrimmar to Azsuna
	{ ['y'] = 0.8955, ['x'] = 0.5882, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '44184', },
		['continent'] = 1, ['source'] = 315, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Azsuna
	{ ['type'] = 'LocalPortal', ['mapId'] = 630, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '44663', },
		['continent'] = 1220, ['y'] = 0.4141, ['x'] = 0.4669, ['source'] = -1, ['target'] = 316, }, -- From Stormwind City to Azsuna
	{ ['y'] = 0.9339, ['x'] = 0.4687, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '44663', },
		['continent'] = 0, ['source'] = 316, ['type'] = 'LocalPortal', }, -- From Stormwind City to Azsuna
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Alliance', ['cls'] = 'PRIEST', },
		['continent'] = 1220, ['y'] = 0.5731, ['x'] = 0.3948, ['source'] = -1, ['target'] = 317, }, -- From Netherlight Temple to Dalaran
	{ ['y'] = 0.8071, ['x'] = 0.498, ['mapId'] = 702, ['reqs'] = { ['fac'] = 'Alliance', ['cls'] = 'PRIEST', },
		['continent'] = 1512, ['source'] = 317, ['type'] = 'LocalPortal', }, -- From Netherlight Temple to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Horde', ['cls'] = 'PRIEST', },
		['continent'] = 1220, ['y'] = 0.177, ['x'] = 0.63, ['source'] = -1, ['target'] = 318, }, -- From Netherlight Temple to Dalaran
	{ ['y'] = 0.8071, ['x'] = 0.498, ['mapId'] = 702, ['reqs'] = { ['fac'] = 'Horde', ['cls'] = 'PRIEST', },
		['continent'] = 1512, ['source'] = 318, ['type'] = 'LocalPortal', }, -- From Netherlight Temple to Dalaran
	{ ['type'] = 'LocalPortal', ['mapId'] = 635, ['reqs'] = { ['qid'] = '39803', ['cls'] = 'WARRIOR', },
		['continent'] = 1220, ['y'] = 0.5223, ['x'] = 0.6018, ['source'] = -1, ['target'] = 319, }, -- From Skyhold to Shield's Rest
	{ ['y'] = 0.2498, ['x'] = 0.5834, ['mapId'] = 695, ['reqs'] = { ['qid'] = '39803', ['cls'] = 'WARRIOR', },
		['continent'] = 1479, ['source'] = 319, ['type'] = 'LocalPortal', }, -- From Skyhold to Shield's Rest
	{ ['type'] = 'LocalPortal', ['mapId'] = 630, ['reqs'] = { ['qid'] = '38443', ['cls'] = 'WARRIOR', },
		['continent'] = 1220, ['y'] = 0.2808, ['x'] = 0.4758, ['source'] = -1, ['target'] = 320, }, -- From Skyhold to Azsuna
	{ ['y'] = 0.2498, ['x'] = 0.5834, ['mapId'] = 695, ['reqs'] = { ['qid'] = '38443', ['cls'] = 'WARRIOR', },
		['continent'] = 1479, ['source'] = 320, ['type'] = 'LocalPortal', }, -- From Skyhold to Azsuna
	{ ['type'] = 'LocalPortal', ['mapId'] = 641, ['reqs'] = { ['qid'] = '38384', ['cls'] = 'WARRIOR', },
		['continent'] = 1220, ['y'] = 0.7489, ['x'] = 0.5471, ['source'] = -1, ['target'] = 321, }, -- From Skyhold to Val'sharah
	{ ['y'] = 0.2498, ['x'] = 0.5834, ['mapId'] = 695, ['reqs'] = { ['qid'] = '38384', ['cls'] = 'WARRIOR', },
		['continent'] = 1479, ['source'] = 321, ['type'] = 'LocalPortal', }, -- From Skyhold to Val'sharah
	{ ['type'] = 'LocalPortal', ['mapId'] = 750, ['reqs'] = { ['qid'] = '38907', ['cls'] = 'WARRIOR', },
		['continent'] = 1220, ['y'] = 0.4211, ['x'] = 0.3973, ['source'] = -1, ['target'] = 322, }, -- From Skyhold to Thunder Totem
	{ ['y'] = 0.2498, ['x'] = 0.5834, ['mapId'] = 695, ['reqs'] = { ['qid'] = '38907', ['cls'] = 'WARRIOR', },
		['continent'] = 1479, ['source'] = 322, ['type'] = 'LocalPortal', }, -- From Skyhold to Thunder Totem
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['qid'] = '42229', ['cls'] = 'WARRIOR', },
		['continent'] = 1220, ['y'] = 0.482, ['x'] = 0.3308, ['source'] = -1, ['target'] = 323, }, -- From Skyhold to Suramar
	{ ['y'] = 0.2498, ['x'] = 0.5834, ['mapId'] = 695, ['reqs'] = { ['qid'] = '42229', ['cls'] = 'WARRIOR', },
		['continent'] = 1479, ['source'] = 323, ['type'] = 'LocalPortal', }, -- From Skyhold to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.5188, ['x'] = 0.5159, ['source'] = -1, ['target'] = 324, }, -- From Mount Hyjal to Emerald Dreamway
	{ ['y'] = 0.261, ['x'] = 0.5907, ['mapId'] = 198, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1, ['source'] = 324, ['type'] = 'LocalPortal', }, -- From Mount Hyjal to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.5188, ['x'] = 0.5159, ['source'] = -1, ['target'] = 325, }, -- From Mount Hyjal to Emerald Dreamway
	{ ['y'] = 0.261, ['x'] = 0.5907, ['mapId'] = 198, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1, ['source'] = 325, ['type'] = 'LocalPortal', }, -- From Mount Hyjal to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.625, ['x'] = 0.4942, ['source'] = -1, ['target'] = 326, }, -- From The Hinterlands to Emerald Dreamway
	{ ['y'] = 0.2279, ['x'] = 0.6232, ['mapId'] = 26, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 0, ['source'] = 326, ['type'] = 'LocalPortal', }, -- From The Hinterlands to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.66, ['x'] = 0.3884, ['source'] = -1, ['target'] = 327, }, -- From Duskwood to Emerald Dreamway
	{ ['y'] = 0.3586, ['x'] = 0.4656, ['mapId'] = 47, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 0, ['source'] = 327, ['type'] = 'LocalPortal', }, -- From Duskwood to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.2648, ['x'] = 0.451, ['source'] = -1, ['target'] = 328, }, -- From The Dreamgrove to Emerald Dreamway
	{ ['y'] = 0.2241, ['x'] = 0.5543, ['mapId'] = 747, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1220, ['source'] = 328, ['type'] = 'LocalPortal', }, -- From The Dreamgrove to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.2953, ['x'] = 0.324, ['source'] = -1, ['target'] = 329, }, -- From Grizzly Hills to Emerald Dreamway
	{ ['y'] = 0.2932, ['x'] = 0.5035, ['mapId'] = 116, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 571, ['source'] = 329, ['type'] = 'LocalPortal', }, -- From Grizzly Hills to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.7776, ['x'] = 0.2631, ['source'] = -1, ['target'] = 330, }, -- From Moonglade to Emerald Dreamway
	{ ['y'] = 0.6023, ['x'] = 0.6796, ['mapId'] = 80, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1, ['source'] = 330, ['type'] = 'LocalPortal', }, -- From Moonglade to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 715, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1540, ['y'] = 0.7776, ['x'] = 0.2631, ['source'] = -1, ['target'] = 331, }, -- From Kalimdor to Emerald Dreamway
	{ ['y'] = 0.1068, ['x'] = 0.5131, ['mapId'] = 12, ['reqs'] = { ['qid'] = '40645', ['cls'] = 'DRUID', },
		['continent'] = 1, ['source'] = 331, ['type'] = 'LocalPortal', }, -- From Kalimdor to Emerald Dreamway
	{ ['type'] = 'LocalPortal', ['mapId'] = 702, ['reqs'] = { ['fac'] = 'Alliance', ['cls'] = 'PRIEST', },
		['continent'] = 1512, ['y'] = 0.8071, ['x'] = 0.498, ['source'] = -1, ['target'] = 332, }, -- From Dalaran to Netherlight Temple
	{ ['y'] = 0.5731, ['x'] = 0.3948, ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Alliance', ['cls'] = 'PRIEST', },
		['continent'] = 1220, ['source'] = 332, ['type'] = 'LocalPortal', }, -- From Dalaran to Netherlight Temple
	{ ['type'] = 'LocalPortal', ['mapId'] = 702, ['reqs'] = { ['fac'] = 'Horde', ['cls'] = 'PRIEST', },
		['continent'] = 1512, ['y'] = 0.8071, ['x'] = 0.498, ['source'] = -1, ['target'] = 333, }, -- From Dalaran to Netherlight Temple
	{ ['y'] = 0.177, ['x'] = 0.63, ['mapId'] = 627, ['reqs'] = { ['fac'] = 'Horde', ['cls'] = 'PRIEST', },
		['continent'] = 1220, ['source'] = 333, ['type'] = 'LocalPortal', }, -- From Dalaran to Netherlight Temple
	{ ['type'] = 'LocalPortal', ['mapId'] = 971, ['reqs'] = { ['rac'] = 'VoidElf', }, ['continent'] = 1865,
		['y'] = 0.2301, ['x'] = 0.2868, ['source'] = -1, ['target'] = 334, }, -- From Stormwind City to Telogrus Rift
	{ ['y'] = 0.1532, ['x'] = 0.5448, ['mapId'] = 84, ['reqs'] = { ['rac'] = 'VoidElf', }, ['continent'] = 0,
		['source'] = 334, ['type'] = 'LocalPortal', }, -- From Stormwind City to Telogrus Rift
	{ ['type'] = 'LocalPortal', ['mapId'] = 1573, ['reqs'] = { ['rac'] = 'Mechagnome', }, ['continent'] = 2268,
		['y'] = 0.6472, ['x'] = 0.2109, ['source'] = -1, ['target'] = 335, }, -- From Stormwind City to Mechagon City
	{ ['y'] = 0.1615, ['x'] = 0.5272, ['mapId'] = 84, ['reqs'] = { ['rac'] = 'Mechagnome', }, ['continent'] = 0,
		['source'] = 335, ['type'] = 'LocalPortal', }, -- From Stormwind City to Mechagon City
	{ ['type'] = 'LocalPortal', ['mapId'] = 941, ['reqs'] = { ['rac'] = 'LightforgedDraenei', }, ['continent'] = 1860,
		['y'] = 0.4622, ['x'] = 0.4997, ['source'] = -1, ['target'] = 336, }, -- From Stormwind City to The Vindicaar
	{ ['y'] = 0.1447, ['x'] = 0.5441, ['mapId'] = 84, ['reqs'] = { ['rac'] = 'LightforgedDraenei', }, ['continent'] = 0,
		['source'] = 336, ['type'] = 'LocalPortal', }, -- From Stormwind City to The Vindicaar
	{ ['type'] = 'LocalPortal', ['mapId'] = 680, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1220,
		['y'] = 0.8529, ['x'] = 0.5955, ['source'] = -1, ['target'] = 337, }, -- From Orgrimmar to Suramar
	{ ['y'] = 0.7687, ['x'] = 0.4007, ['mapId'] = 85, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1,
		['source'] = 337, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Suramar
	{ ['type'] = 'LocalPortal', ['mapId'] = 652, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1220,
		['y'] = 0.6406, ['x'] = 0.4417, ['source'] = -1, ['target'] = 338, }, -- From Orgrimmar to Thunder Totem
	{ ['y'] = 0.7687, ['x'] = 0.4007, ['mapId'] = 85, ['reqs'] = { ['rac'] = 'Nightborne', }, ['continent'] = 1,
		['source'] = 338, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Thunder Totem
	{ ['type'] = 'LocalPortal', ['mapId'] = 831, ['reqs'] = { ['qid'] = '48440', }, ['continent'] = 1669, ['y'] = 0.8137,
		['x'] = 0.6115, ['source'] = -1, ['target'] = 339, }, -- From Dalaran to The Vindicaar
	{ ['y'] = 0.4929, ['x'] = 0.7426, ['mapId'] = 627, ['reqs'] = { ['qid'] = '48440', }, ['continent'] = 1220,
		['source'] = 339, ['type'] = 'LocalPortal', }, -- From Dalaran to The Vindicaar
	{ ['type'] = 'LocalPortal', ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['y'] = 0.6458, ['x'] = 0.6828, ['source'] = -1, ['target'] = 340, }, -- From Silithus to Dazar'alor
	{ ['y'] = 0.4519, ['x'] = 0.4159, ['mapId'] = 81, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1, ['source'] = 340, ['type'] = 'LocalPortal', }, -- From Silithus to Dazar'alor
	{ ['type'] = 'LocalPortal', ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1642, ['y'] = 0.6458, ['x'] = 0.6828, ['source'] = -1, ['target'] = 341, }, -- From Orgrimmar to Dazar'alor
	{ ['y'] = 0.9123, ['x'] = 0.5851, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '46957', },
		['continent'] = 1, ['source'] = 341, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Dazar'alor
	{ ['type'] = 'LocalPortal', ['mapId'] = 1163, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Horde', },
		['continent'] = 1642, ['y'] = 0.6458, ['x'] = 0.6828, ['source'] = -1, ['target'] = 342, }, -- From Darkshore to Dazar'alor
	{ ['y'] = 0.3509, ['x'] = 0.4626, ['mapId'] = 62, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Horde', },
		['continent'] = 1, ['source'] = 342, ['type'] = 'LocalPortal', }, -- From Darkshore to Dazar'alor
	{ ['type'] = 'LocalPortal', ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '56044', },
		['continent'] = 1642, ['y'] = 0.6458, ['x'] = 0.6828, ['source'] = -1, ['target'] = 343, }, -- From Nazjatar to Dazar'alor
	{ ['y'] = 0.6274, ['x'] = 0.4727, ['mapId'] = 1355, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '56044', },
		['continent'] = 1718, ['source'] = 343, ['type'] = 'LocalPortal', }, -- From Nazjatar to Dazar'alor
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '60151', },
		['continent'] = 2222, ['y'] = 0.5031, ['x'] = 0.2034, ['source'] = -1, ['target'] = 344, }, -- From Stormwind City to Oribos
	{ ['y'] = 0.9496, ['x'] = 0.4756, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '60151', },
		['continent'] = 0, ['source'] = 344, ['type'] = 'LocalPortal', }, -- From Stormwind City to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1670, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '60151', },
		['continent'] = 2222, ['y'] = 0.5031, ['x'] = 0.2034, ['source'] = -1, ['target'] = 345, }, -- From Orgrimmar to Oribos
	{ ['y'] = 0.8785, ['x'] = 0.5832, ['mapId'] = 85, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '60151', },
		['continent'] = 1, ['source'] = 345, ['type'] = 'LocalPortal', }, -- From Orgrimmar to Oribos
	{ ['type'] = 'LocalPortal', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['y'] = 0.1587, ['x'] = 0.7018, ['source'] = -1, ['target'] = 346, }, -- From Silithus to Boralus
	{ ['y'] = 0.4486, ['x'] = 0.4149, ['mapId'] = 81, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1, ['source'] = 346, ['type'] = 'LocalPortal', }, -- From Silithus to Boralus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 1643, ['y'] = 0.1587, ['x'] = 0.7018, ['source'] = -1, ['target'] = 347, }, -- From Stormwind City to Boralus
	{ ['y'] = 0.9512, ['x'] = 0.4872, ['mapId'] = 84, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '47189', },
		['continent'] = 0, ['source'] = 347, ['type'] = 'LocalPortal', }, -- From Stormwind City to Boralus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1161, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1643, ['y'] = 0.1587, ['x'] = 0.7018, ['source'] = -1, ['target'] = 348, }, -- From Darkshore to Boralus
	{ ['y'] = 0.3624, ['x'] = 0.4799, ['mapId'] = 62, ['reqs'] = { ['passlvl'] = '50', ['fac'] = 'Alliance', },
		['continent'] = 1, ['source'] = 348, ['type'] = 'LocalPortal', }, -- From Darkshore to Boralus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1643,
		['y'] = 0.1577, ['x'] = 0.6996, ['source'] = -1, ['target'] = 349, }, -- From Nazjatar to Boralus
	{ ['y'] = 0.5262, ['x'] = 0.3995, ['mapId'] = 1355, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1718,
		['source'] = 349, ['type'] = 'LocalPortal', }, -- From Nazjatar to Boralus
	{ ['type'] = 'LocalPortal', ['mapId'] = 1355, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '56043', },
		['continent'] = 1718, ['y'] = 0.5284, ['x'] = 0.3996, ['source'] = -1, ['target'] = 350, }, -- From Boralus to Nazjatar
	{ ['y'] = 0.1536, ['x'] = 0.6989, ['mapId'] = 1161, ['reqs'] = { ['fac'] = 'Alliance', ['qid'] = '56043', },
		['continent'] = 1643, ['source'] = 350, ['type'] = 'LocalPortal', }, -- From Boralus to Nazjatar
	{ ['type'] = 'LocalPortal', ['mapId'] = 1355, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '56044', },
		['continent'] = 1718, ['y'] = 0.6263, ['x'] = 0.4719, ['source'] = -1, ['target'] = 351, }, -- From Dazar'alor to Nazjatar
	{ ['y'] = 0.8433, ['x'] = 0.6356, ['mapId'] = 1163, ['reqs'] = { ['fac'] = 'Horde', ['qid'] = '56044', },
		['continent'] = 1642, ['source'] = 351, ['type'] = 'LocalPortal', }, -- From Dazar'alor to Nazjatar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 71, ['reqs'] = { ['spell'] = 23441, }, ['continent'] = 1,
		['y'] = 0.27835083007812, ['x'] = 0.52236938476562, ['source'] = -1, ['target'] = -1, }, -- Using Gadgetzan Transporter to Tanaris
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 80, ['reqs'] = { ['spell'] = 18960, }, ['continent'] = 1,
		['y'] = 0.32414245605469, ['x'] = 0.56265258789062, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Moonglade to Moonglade
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 89, ['reqs'] = { ['spell'] = 3565, ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.78672790527344, ['x'] = 0.43467712402344, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Darnassus to Darnassus
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 70, ['reqs'] = { ['spell'] = 49359, ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.48992919921875, ['x'] = 0.6600341796875, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Theramore to Dustwallow Marsh
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 86, ['reqs'] = { ['spell'] = 3567, }, ['continent'] = 1,
		['y'] = 0.64529418945312, ['x'] = 0.48283386230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Orgrimmar to Orgrimmar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 199, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53600', },
		['continent'] = 1, ['y'] = 0.093, ['x'] = 0.3911, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Southern Barrens
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 85, ['reqs'] = { ['spell'] = 147787, }, ['continent'] = 1, ['y'] = 0.3774,
		['x'] = 0.4996, ['source'] = -1, ['target'] = -1, }, --
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 103, ['reqs'] = { ['spell'] = 32271, ['fac'] = 'Alliance', },
		['continent'] = 1, ['y'] = 0.59820556640625, ['x'] = 0.4761962890625, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Exodar to The Exodar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 86, ['reqs'] = { ['spell'] = 89158, }, ['continent'] = 1,
		['y'] = 0.64529418945312, ['x'] = 0.48283386230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Orgrimmar to Orgrimmar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 83, ['reqs'] = { ['spell'] = 23442, }, ['continent'] = 1,
		['y'] = 0.49714660644531, ['x'] = 0.59614562988281, ['source'] = -1, ['target'] = -1, }, -- Using Everlook Transporter to Winterspring
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 86, ['reqs'] = { ['spell'] = 89158, }, ['continent'] = 1,
		['y'] = 0.64529418945312, ['x'] = 0.48283386230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Orgrimmar to Orgrimmar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 86, ['reqs'] = { ['spell'] = 89158, }, ['continent'] = 1,
		['y'] = 0.64529418945312, ['x'] = 0.48283386230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Orgrimmar to Orgrimmar
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 88, ['reqs'] = { ['spell'] = 3566, ['fac'] = 'Horde', },
		['continent'] = 1, ['y'] = 0.16867065429688, ['x'] = 0.22212219238281, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Thunder Bluff to Thunder Bluff
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 84, ['reqs'] = { ['spell'] = 89157, }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stormwind to Stormwind City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 84, ['reqs'] = { ['spell'] = 147787, }, ['continent'] = 0, ['y'] = 0.1841,
		['x'] = 0.7444, ['source'] = -1, ['target'] = -1, }, --
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 17, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53594', },
		['continent'] = 0, ['y'] = 0.128, ['x'] = 0.6197, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Blasted Lands
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 84, ['reqs'] = { ['spell'] = 3561, ['fac'] = 'Alliance', },
		['continent'] = 0, ['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stormwind to Stormwind City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 90, ['reqs'] = { ['spell'] = 3563, ['fac'] = 'Horde', },
		['continent'] = 0, ['y'] = 0.16328430175781, ['x'] = 0.84580993652344, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Undercity to Undercity
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 245, ['reqs'] = { ['spell'] = 88342, ['fac'] = 'Alliance', },
		['continent'] = 0, ['y'] = 0.60920715332031, ['x'] = 0.73674011230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Tol Barad to Tol Barad Peninsula
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 245, ['reqs'] = { ['spell'] = 88344, ['fac'] = 'Horde', },
		['continent'] = 0, ['y'] = 0.78768920898438, ['x'] = 0.54998779296875, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Tol Barad to Tol Barad Peninsula
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 110, ['reqs'] = { ['spell'] = 32272, ['fac'] = 'Horde', },
		['continent'] = 0, ['y'] = 0.19242858886719, ['x'] = 0.58259582519531, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Silvermoon to Silvermoon City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 210, ['reqs'] = { ['spell'] = 71436, }, ['continent'] = 0,
		['y'] = 0.73820495605469, ['x'] = 0.40982055664062, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Booty Bay to The Cape of Stranglethorn
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 51, ['reqs'] = { ['spell'] = 49358, ['fac'] = 'Horde', },
		['continent'] = 0, ['y'] = 0.55804443359375, ['x'] = 0.49844360351562, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stonard to Swamp of Sorrows
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 87, ['reqs'] = { ['spell'] = 3562, ['fac'] = 'Alliance', },
		['continent'] = 0, ['y'] = 0.084274291992188, ['x'] = 0.25509643554688, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Ironforge to Ironforge
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 84, ['reqs'] = { ['spell'] = 89157, }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stormwind to Stormwind City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 23, ['reqs'] = { ['spell'] = 50977, ['nqid'] = '39757', },
		['continent'] = 0, ['y'] = 0.50027465820312, ['x'] = 0.83717346191406, ['source'] = -1, ['target'] = -1, }, -- Using Death Gate to Eastern Plaguelands
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 245, ['reqs'] = { ['spell'] = 88344, }, ['continent'] = 0,
		['y'] = 0.78768920898438, ['x'] = 0.54998779296875, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Tol Barad to Tol Barad Peninsula
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 245, ['reqs'] = { ['spell'] = 88342, }, ['continent'] = 0,
		['y'] = 0.60920715332031, ['x'] = 0.73674011230469, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Tol Barad to Tol Barad Peninsula
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 84, ['reqs'] = { ['spell'] = 89157, }, ['continent'] = 0,
		['y'] = 0.86529541015625, ['x'] = 0.49591064453125, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stormwind to Stormwind City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 111, ['reqs'] = { ['spell'] = 33690, ['fac'] = 'Alliance', },
		['continent'] = 530, ['y'] = 0.40232849121094, ['x'] = 0.5496826171875, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Shattrath to Shattrath City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 111, ['reqs'] = { ['spell'] = 35715, ['fac'] = 'Horde', },
		['continent'] = 530, ['y'] = 0.49209594726562, ['x'] = 0.53005981445312, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Shattrath to Shattrath City
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 105, ['reqs'] = { ['spell'] = 36941, }, ['continent'] = 530,
		['y'] = 0.65093994140625, ['x'] = 0.60400390625, ['source'] = -1, ['target'] = -1, }, -- Using Toshley's Station Transporter to Blade's Edge Mountains
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 104, ['reqs'] = { ['spell'] = 41234, }, ['continent'] = 530,
		['y'] = 0.43910217285156, ['x'] = 0.64851379394531, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Black Temple to Shadowmoon Valley
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 105, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53597', },
		['continent'] = 530, ['y'] = 0.1764, ['x'] = 0.7242, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Blade's Edge Mountains
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 109, ['reqs'] = { ['spell'] = 36890, }, ['continent'] = 530,
		['y'] = 0.63595581054688, ['x'] = 0.32980346679688, ['source'] = -1, ['target'] = -1, }, -- Using Area52 Transporter to Netherstorm
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 115, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53596', },
		['continent'] = 571, ['y'] = 0.4992, ['x'] = 0.4535, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Dragonblight
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 118, ['reqs'] = { ['spell'] = 66238, }, ['continent'] = 571,
		['y'] = 0.22642517089844, ['x'] = 0.69369506835938, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Argent Tournament to Icecrown
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53142, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Portal: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 125, ['reqs'] = { ['spell'] = 53140, }, ['continent'] = 571,
		['y'] = 0.46791076660156, ['x'] = 0.55921936035156, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Dalaran - Northrend to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 207, ['reqs'] = { ['spell'] = 80256, }, ['continent'] = 646,
		['y'] = 0.55465698242188, ['x'] = 0.4998779296875, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Deepholm to Deepholm
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 379, ['reqs'] = { ['spell'] = 126892, ['nqid'] = '40236', },
		['continent'] = 870, ['y'] = 0.42939758300781, ['x'] = 0.48635864257812, ['source'] = -1, ['target'] = -1, }, -- Using Zen Pilgrimage to Kun-Lai Summit
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 390, ['reqs'] = { ['spell'] = 132627, }, ['continent'] = 870,
		['y'] = 0.21823120117188, ['x'] = 0.62501525878906, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Vale of Eternal Blossoms to Vale of Eternal Blossoms
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 390, ['reqs'] = { ['spell'] = 132621, }, ['continent'] = 870,
		['y'] = 0.61051940917969, ['x'] = 0.863037109375, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Vale of Eternal Blossoms to Vale of Eternal Blossoms
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 376, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53598', },
		['continent'] = 870, ['y'] = 0.7359, ['x'] = 0.3151, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Valley of the Four Winds
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 622, ['reqs'] = { ['spell'] = 176248, ['fac'] = 'Alliance', },
		['continent'] = 1116, ['y'] = 0.514, ['x'] = 0.588, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Stormshield to Stormshield
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 624, ['reqs'] = { ['spell'] = 176242, ['fac'] = 'Horde', },
		['continent'] = 1116, ['y'] = 0.514, ['x'] = 0.588, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Warspear to Warspear
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 550, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53590', },
		['continent'] = 1116, ['y'] = 0.0825, ['x'] = 0.6575, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Nagrand
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 579, ['reqs'] = { ['spell'] = 171253, ['fac'] = 'Alliance', },
		['continent'] = 1116, ['y'] = 0.5281, ['x'] = 0.4264, ['source'] = -1, ['target'] = -1, }, -- Using Garrison Hearthstone to Lunarfall Excavation
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 590, ['reqs'] = { ['spell'] = 171253, ['fac'] = 'Horde', },
		['continent'] = 1116, ['y'] = 0.5301, ['x'] = 0.4095, ['source'] = -1, ['target'] = -1, }, -- Using Garrison Hearthstone to Frostwall
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 709, ['reqs'] = { ['spell'] = 126892, ['qid'] = '40236', },
		['continent'] = 1514, ['y'] = 0.4865, ['x'] = 0.5146, ['source'] = -1, ['target'] = -1, }, -- Using Zen Pilgrimage to The Wandering Isle
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 627, ['reqs'] = { ['spell'] = 222695, }, ['continent'] = 1220,
		['y'] = 0.4476, ['x'] = 0.6072, ['source'] = -1, ['target'] = -1, }, -- Using Dalaran Hearthstone to Dalaran
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 648, ['reqs'] = { ['spell'] = 50977, ['qid'] = '39757', },
		['continent'] = 1220, ['y'] = 0.3044, ['x'] = 0.2743, ['source'] = -1, ['target'] = -1, }, -- Using Death Gate to Acherus: The Ebon Hold
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 646, ['reqs'] = { ['spell'] = 265225, ['qid'] = '53589', },
		['continent'] = 1220, ['y'] = 0.4799, ['x'] = 0.7169, ['source'] = -1, ['target'] = -1, }, -- Using Mole Machine to Broken Shore
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 734, ['reqs'] = { ['spell'] = 193759, }, ['continent'] = 1513,
		['y'] = 0.8613, ['x'] = 0.5763, ['source'] = -1, ['target'] = -1, }, -- Using Teleport: Hall of the Guardian to Hall of the Guardian
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 715, ['reqs'] = { ['spell'] = 193753, }, ['continent'] = 1540,
		['y'] = 0.5315, ['x'] = 0.3533, ['source'] = -1, ['target'] = -1, }, -- Using Dreamwalk to Emerald Dreamway
	{ ['type'] = 'UnboundTeleport', ['mapId'] = 1543, ['reqs'] = { ['map'] = '1543', ['spell'] = 325624, },
		['continent'] = 2222, ['y'] = 0.4125, ['x'] = 0.4622, ['source'] = -1, ['target'] = -1, }, -- Using Cypher of Relocation to The Maw
	{ ['type'] = 'Boat', ['mapId'] = 70, ['reqs'] = { ['fac'] = 'Alliance', }, ['continent'] = 1,
		['y'] = 0.56373596191406, ['x'] = 0.715576171875, ['source'] = -1, ['target'] = 1, }, -- From Wetlands to Dustwallow Marsh
}



local function checkReq(type, value)
	if not type then return false end
	if not value then return false end

	if type == "lvl" or type == "passlvl" then
		return UnitLevel("player") >= tonumber(value)
	elseif type == "notlvl" then
		return UnitLevel("player") < tonumber(value)
	elseif type == "qid" then
		local qid = tonumber(value)
		if qid then
			return C_QuestLog.IsQuestFlaggedCompleted(qid)
		end
	elseif type == "nqid" then
		local qid = tonumber(value)
		if qid then
			return not C_QuestLog.IsQuestFlaggedCompleted(qid)
		end
	elseif type == "fac" then
		return UnitFactionGroup("player") == tostring(value)
	elseif type == "cls" then
		return select(2, UnitClass("player")) == value
	elseif type == "rac" then
		return select(2, UnitRace("player")) == value
	elseif type == "map" then
		local playerMap = C_Map.GetBestMapForUnit("player")
		return playerMap == tonumber(value)
	elseif type == "spell" then
		local spell = tonumber(value)
		if IsSpellKnown(spell) then
			return true
		end

		return false
	end
	return true
end

function module:OnInitialize()
	core.NavigationData = {}
	local linkIndex = 0
	for _, node in ipairs(NavigationData) do
		local reqs = node.reqs
		if reqs then
			local validNode = true
			for rKey, rValue in pairs(reqs) do
				if not checkReq(rKey, rValue) then
					validNode = false
					break
				end
			end
			if validNode then
				table.insert(core.NavigationData, node)
			end
		else
			table.insert(core.NavigationData, node)
		end
	end
end
