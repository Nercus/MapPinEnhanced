---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Only home-bind items belong here; fixed-destination and random teleports do not.
-- Item/spell identities checked against the maintained catalogue:
-- https://github.com/awls99/Random-Hearthstone-Toy-Continued/blob/main/AllHearthToyIndex_en.lua
---@type table<number, number>
Navigation.hearthstoneItems = {
    [6948] = 8690, -- Hearthstone
    [54452] = 75136, -- Ethereal Portal
    [64488] = 94719, -- The Innkeeper's Daughter
    [93672] = 136508, -- Dark Portal
    [142542] = 231504, -- Tome of Town Portal
    [162973] = 278244, -- Greatfather Winter's Hearthstone
    [163045] = 278559, -- Headless Horseman's Hearthstone
    [165669] = 285362, -- Lunar Elder's Hearthstone
    [165670] = 285424, -- Peddlefeet's Lovely Hearthstone
    [165802] = 286031, -- Noble Gardener's Hearthstone
    [166746] = 286331, -- Fire Eater's Hearthstone
    [166747] = 286353, -- Brewfest Reveler's Hearthstone
    [168907] = 298068, -- Holographic Digitalization Hearthstone
    [172179] = 308742, -- Eternal Traveler's Hearthstone
    [180290] = 326064, -- Night Fae Hearthstone
    [182773] = 340200, -- Necrolord Hearthstone
    [183716] = 342122, -- Venthyr Sinstone
    [184353] = 345393, -- Kyrian Hearthstone
    [188952] = 363799, -- Dominated Hearthstone
    [190196] = 366945, -- Enlightened Hearthstone
    [190237] = 367013, -- Broker Translocation Matrix
    [193588] = 375357, -- Timewalker's Hearthstone
    [200630] = 391042, -- Ohn'ir Windsage's Hearthstone
    [206195] = 412555, -- Path of the Naaru
    [208704] = 420418, -- Deepdweller's Earthen Hearthstone
    [209035] = 422284, -- Hearthstone of the Flame
    [212337] = 401802, -- Stone of the Hearth
    [228940] = 463481, -- Notorious Thread's Hearthstone
    [235016] = 1217281, -- Redeployment Module
    [236687] = 1220729, -- Explosive Hearthstone
    [245970] = 1240219, -- P.O.S.T. Master's Express Hearthstone
    [246565] = 1242509, -- Cosmic Hearthstone
    [257736] = 1261979, -- Lightcalled Hearthstone
    [263489] = 1270583, -- Naaru's Enfold
    [263933] = 1270814, -- Preyseeker's Hearthstone
    [265100] = 1273401, -- Corewarden's Hearthstone
}

-- Astral Recall shares the learned home bind with hearthstone items.
Navigation.hearthstoneSpells = { 556 }
