---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

Navigation.DEFAULT_PATH_COLOR = CreateColor(0.7, 0.7, 0.7)

---@type table<string, ColorMixin>
Navigation.PATH_COLORS = {
    walk = CreateColor(0.35, 0.8, 0.35),
    fly = CreateColor(0.35, 0.75, 1),
    portal = CreateColor(0.7, 0.4, 1),
    localportal = CreateColor(0.7, 0.4, 1),
    border = CreateColor(0.35, 0.8, 0.35),
    floor = CreateColor(0.65, 0.75, 0.45),
    flighttaxi = CreateColor(1, 0.75, 0.25),
    boat = CreateColor(0.25, 0.65, 1),
    ship = CreateColor(0.25, 0.65, 1),
    zeppelin = CreateColor(1, 0.55, 0.25),
    tram = CreateColor(0.75, 0.65, 0.4),
    transport = CreateColor(0.75, 0.65, 0.4),
    gossip = CreateColor(1, 0.8, 0.35),
    phaseswitch = CreateColor(0.85, 0.45, 0.75),
    spell = CreateColor(0.5, 0.55, 1),
    dungeonteleport = CreateColor(1, 0.35, 0.35),
    item = CreateColor(0.25, 0.85, 0.75),
    toy = CreateColor(0.95, 0.5, 0.75),
    dhearth = CreateColor(0.5, 0.55, 1),
    unboundteleport = CreateColor(1, 0.35, 0.35),
}
