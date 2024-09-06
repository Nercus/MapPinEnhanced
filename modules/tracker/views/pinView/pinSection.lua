---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinTracker
---@field Sections PinSection[]
local PinTracker = MapPinEnhanced:GetModule("PinTracker")
local Events = MapPinEnhanced:GetModule("Events")
local Textures = MapPinEnhanced:GetModule("Textures")
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local Utils = MapPinEnhanced:GetModule("Utils")

local L = MapPinEnhanced.L


---@class SectionInfo
---@field name string
---@field icon string path to the icon of the section
---@field source string default is "MapPinEnhanced"


---@param sectionInfo SectionInfo
function PinTracker:RegisterSection(sectionInfo)
    assert(sectionInfo.name, "Section name is required")
    assert(sectionInfo.icon, "Section icon is required")
    assert(sectionInfo.source, "Section source is required")

    if not self.Sections then
        self.Sections = {}
    end

    ---@class PinSection
    ---@field info SectionInfo
    ---@field pins PinObject[]
    local section = {}
    section.info = sectionInfo
    section.pins = {}

    ---@param pinData pinData
    function section:AddPin(pinData)
        local sectionID = Utils:GenerateUUID(string.format("section-%s", sectionInfo.name))
        local pin = PinFactory:CreatePin(pinData, sectionID)
        table.insert(self.pins, pin)
    end

    function section:ClearPins()
        self.pins = {}
    end

    function section:GetPins()
        return self.pins
    end

    function section:GetPinCount()
        return #self.pins
    end

    function section:GetPinByIndex(index)
        return self.pins[index]
    end

    function section:GetTrackedPin()
        for _, pin in ipairs(self.pins) do
            if pin:IsTracked() then
                return pin
            end
        end
        return nil
    end

    function section:GetPinByID(pinID)
        for _, pin in ipairs(self.pins) do
            if pin.pinID == pinID then
                return pin
            end
        end
        return nil
    end

    table.insert(self.Sections, section)
end

function PinTracker:GetSectionsBySource(source)
    local sections = {}
    for _, section in ipairs(self.Sections) do
        if section.info.source == source then
            table.insert(sections, section)
        end
    end
    return sections
end

function PinTracker:GetSectionByName(name)
    for _, section in ipairs(self.Sections) do
        if section.info.name == name then
            return section
        end
    end
end

function PinTracker:UnregisterSectionByName(name)
    for i, section in ipairs(self.Sections) do
        if section.info.name == name then
            table.remove(self.Sections, i)
            return
        end
    end
end

function PinTracker:UnregisterSectionBySource(source)
    assert(source, "Source is required")
    assert(source ~= "MapPinEnhanced", "Cannot unregister default sections")
    for i, section in ipairs(self.Sections) do
        if section.info.source == source then
            table.remove(self.Sections, i)
        end
    end
end

function PinTracker:LoadDefaultSections()
    self:RegisterSection({
        name = L["Uncategorized Pins"],
        icon = Textures:GetTexture("PinTrackedYellow"),
        source = MapPinEnhanced.addonName
    })

    self:RegisterSection({
        name = L["Temporary Import"],
        icon = Textures:GetTexture("IconImport_Yellow"),
        source = MapPinEnhanced.addonName
    })
end

Events:RegisterEvent("PLAYER_LOGIN", function()
    PinTracker:LoadDefaultSections()
end)
