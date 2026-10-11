---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

--- Note: There are no flying mounts in Forever
---@type table<number, NavigationMountInfo>
local mountData = {}

Navigation.mountData = mountData

Navigation.defaultMountInfo = { fly = false, ground = true }
