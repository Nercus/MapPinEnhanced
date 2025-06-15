---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinSections
---@field Sections {[string]: PinSection} all registered sections -> using the section name as key
local PinSections = MapPinEnhanced:GetModule("PinSections")
local Textures = MapPinEnhanced:GetModule("Textures")
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
local Events = MapPinEnhanced:GetModule("Events")

local L = MapPinEnhanced.L

---@param source string
---@return PinSection[]
function PinSections:GetSectionsBySource(source)
    local sections = {}
    for _, section in pairs(self.Sections) do
        if section.source == source then
            table.insert(sections, section)
        end
    end
    return sections
end

---@param sectionName string
---@return PinSection?
function PinSections:GetSectionByName(sectionName)
    return self.Sections[sectionName]
end

---@return number
function PinSections:GetTotalPinCount()
    local sections = self:GetAllSections()
    local length = 0
    for _, section in pairs(sections) do
        length = length + section:GetPinCount()
    end
    return length
end

function PinSections:UnregisterSectionBySource(source)
    assert(source, "Source is required")
    assert(source ~= "MapPinEnhanced", "Cannot unregister default sections")
    for sectionName, section in pairs(self.Sections) do
        if section.source == source then
            self.Sections[sectionName] = nil
        end
    end
end

function PinSections:UnregisterSectionByName(sectionName)
    self.Sections[sectionName] = nil
    self:PersistSections()
end

function PinSections:GetAllSections()
    return self.Sections
end

function PinSections:ClearPins()
    local sections = self:GetAllSections()
    for _, section in pairs(sections) do
        section:ClearPins()
    end
end

---persist the section data. If sectionName and pinID are provided, only the pin data will be saved. If only sectionName is provided, only the section data will be saved. If neither are provided, all sections will be saved.
---@param sectionName? string the name of the section
---@param pinID? UUID the unique identifier of the pin starting with "pin-"
function PinSections:PersistSections(sectionName, pinID)
    if sectionName and pinID then
        local section = self.Sections[sectionName]
        if not section then return end
        local pin = section.pins[pinID]
        if not pin then
            SavedVars:Delete("sections", sectionName, "pins", pinID)
            return
        end
        local pinData = pin:GetPinData()
        SavedVars:Save("sections", sectionName, "pins", pinID, pinData)
    elseif sectionName then
        local section = self.Sections[sectionName]
        local sectionData = section:GetSavableData()
        SavedVars:Save("sections", sectionName, sectionData)
    else
        ---@type table<string, {info: SectionInfo, pins: pinData[]}>
        local sectionsData = {}
        ---@diagnostic disable-next-line: redefined-local the sectionName is nil here
        for sectionName, section in pairs(self.Sections) do
            sectionsData[sectionName] = section:GetSavableData()
        end
        SavedVars:Save("sections", sectionsData)
    end
end

function PinSections:RestoreSections()
    ---@type table<UUID, {info: SectionInfo, pins: pinData[]}>?
    local sections = SavedVars:Get("sections") --[[@as table<UUID, {info: SectionInfo, pins: pinData[]}>?]]
    if not sections then return end
    for _, section in pairs(sections) do
        local restoredSection = self:RegisterSection(section.info)
        for _, pinData in pairs(section.pins) do
            restoredSection:AddPin(pinData, true)
        end
    end
end

function PinSections:RegisterDefaultSections()
    for _, section in pairs(self.Sections) do
        if section.source == MapPinEnhanced.addonName then
            return
        end
    end
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

function PinSections:RegisterOptions()
    local Options = MapPinEnhanced:GetModule("Options")
    Options:RegisterCheckbox({
        category = L["General"],
        label = L["Auto Track Nearest Pin"],
        description = "Automatically track the nearest pin when a tracked pin is removed.",
        default = SavedVars:GetDefault("general", "autoTrackNearestPin") --[[@as boolean]],
        init = function() return SavedVars:Get("general", "autoTrackNearestPin") --[[@as boolean]] end,
        onChange = function(value)
            SavedVars:Save("general", "autoTrackNearestPin", value)
        end
    })
end

function PinSections:RegisterSlashCommands()
    local SlashCommand = MapPinEnhanced:GetModule("SlashCommand")
    SlashCommand:AddSlashCommand(L["Clear"]:lower(), function()
        self:ClearPins()
    end, L["Clear All Pins"])
end

local initialized = false
function PinSections:OnInitialize()
    if initialized then return end
    PinSections:RegisterOptions()
    PinSections:RegisterSlashCommands()
    PinSections:RestoreSections()
    PinSections:RegisterDefaultSections()
    initialized = true
end

Events:RegisterEvent("PLAYER_LOGIN", function()
    PinSections:OnInitialize()
end)
