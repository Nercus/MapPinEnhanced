---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local version = C_AddOns.GetAddOnMetadata(MapPinEnhanced.name, "Version")

local function convertVersionToNumeric(ver)
    ---@type string, string, string, string, string
    local major, minor, patch, _, betaNum = ver:match("^(%d+)%.(%d+)%.(%d+)%-(beta)%.(%d+)$")
    if major then
        -- Betas: major*1000000 + minor*10000 + patch*100 + betaNum
        -- But to keep betas below release, use patch-1 for betas
        return tonumber(major) * 1000000 + tonumber(minor) * 10000 + (tonumber(patch) - 1) * 100 + tonumber(betaNum)
    else
        ---@type string, string, string
        major, minor, patch = ver:match("^(%d+)%.(%d+)%.(%d+)$")
        if major then
            return tonumber(major) * 1000000 + tonumber(minor) * 10000 + tonumber(patch) * 100
        end
    end
    return 0
end

local numericVersion = convertVersionToNumeric(version)
MapPinEnhanced.numericVersion = numericVersion
MapPinEnhanced.version = version


--@do-not-package@

local testVersionString = {
    "1.0.0-beta.1",
    '3.0.2-beta.2',
    '3.0.2-beta.23',
    '3.0.2',
    '3.1.0',
    '10.0.2',
    '99.9.9'
}

for i, ver in ipairs(testVersionString) do
    local numVer = convertVersionToNumeric(ver)
    local prevNumVer = testVersionString[i - 1] and convertVersionToNumeric(testVersionString[i - 1]) or 0
    MapPinEnhanced:Test("Version number conversion: " .. i, function(test)
        test:Expect(numVer > prevNumVer):ToBeTruthy()
        test:Expect(numVer):ToBeType("number")
        test:Expect(ver):ToBeType("string")
    end)
end

--@end-do-not-package@
