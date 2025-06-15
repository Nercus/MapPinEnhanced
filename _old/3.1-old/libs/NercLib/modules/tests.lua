---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib


---@param addon NercLibAddon
function NercLib:AddTestsModule(addon)
    ---@class Tests
    ---@field tests Test[]
    local Tests = addon:GetModule("Tests")
    Tests.tests = {}

    function Tests:FormatTestError(message, stack)
        assert(type(message) == "string", "Message not provided")
        assert(type(stack) == "string", "Stack not provided")
        -- split stack on new lines and remove the first line
        local stackLines = { strsplit("\n", stack) }
        return string.format("%s\n%s", message, stackLines[2])
    end

    local function serializeTable(t)
        local serializedValues = {}
        ---@type any, string
        local value, serializedValue
        for i = 1, #t do
            ---@type any
            value = t[i]
            serializedValue = type(value) == 'table' and serializeTable(value) or value
            table.insert(serializedValues, serializedValue)
        end
        return string.format("{ %s }", table.concat(serializedValues, ', '))
    end

    function Tests:ToString(value)
        assert(value ~= nil, "Value not provided")
        if not value then
            return "nil"
        end
        if (type(value) == "table") then
            return serializeTable(value)
        end
        return tostring(value)
    end

    ---@param name string
    ---@param func fun(test: Test)
    function Tests:Test(name, func)
        assert(type(name) == "string", "Test Name not provided")
        assert(type(func) == "function", "Test Function not provided")

        if (not self.tests) then
            self.tests = {}
        end

        ---@class Test
        local test = {
            name = name,
        }

        ---@param value any
        ---@return {ToBe: fun(_, expected: any), ToBeTruthy: fun(), ToBeFalsy: fun(), ToBeType: fun(_, expected: type)}
        function test:Expect(value)
            ---@param expected any
            local function ToBe(expected)
                -- check if the value is a table
                if (type(value) == "table") then
                    ---@cast value table<any, any>
                    for k, v in pairs(value) do
                        if (v ~= expected[k]) then
                            error(Tests:FormatTestError(
                                string.format("Expected %s to be %s.", Tests:ToString(v), Tests:ToString(expected[k])),
                                debugstack(1)))
                        end
                    end
                    return
                end
                if (value ~= expected) then
                    error(Tests:FormatTestError(
                        string.format("Expected %s to be %s.", Tests:ToString(value), Tests:ToString(expected)),
                        debugstack(1)))
                end
            end

            local function ToBeTruthy()
                if not value then
                    error(Tests:FormatTestError(string.format("Expected %s to be truthy.", Tests:ToString(value)),
                        debugstack(1)))
                end
            end

            local function ToBeFalsy()
                if value then
                    error(Tests:FormatTestError(string.format("Expected %s to be falsy.", Tests:ToString(value)),
                        debugstack(1)))
                end
            end

            ---@param expected type
            local function ToBeType(_, expected)
                if (type(value) ~= expected) then
                    error(Tests:FormatTestError(
                        string.format("Expected %s to be of type %s.", Tests:ToString(value), Tests:ToString(expected)),
                        debugstack(1)))
                end
            end

            return {
                ToBe = ToBe,
                ToBeTruthy = ToBeTruthy,
                ToBeFalsy = ToBeFalsy,
                ToBeType = ToBeType,
            }
        end

        ---@return boolean success
        ---@return string result
        function test:Run()
            return pcall(func, self)
        end

        table.insert(self.tests, test)
    end

    ---@return number count
    function Tests:GetNumberOfTests()
        return #(self.tests or {})
    end

    function Tests:GetTests()
        return self.tests
    end

    ---Run all registered tests
    ---@param onUpdate fun(success: boolean, result: string)
    ---@param onFinish fun(testErrors: table<string, boolean>)
    function Tests:RunTests(onUpdate, onFinish)
        local tests = self.tests
        if not tests then return end
        local testCount = self:GetNumberOfTests()
        ---@type table<string, boolean>
        local testState = {}

        ---@type FunctionContainer
        local ticker
        local testIndex = 1
        ticker = C_Timer.NewTicker(0.05, function()
            local test = tests[testIndex]
            if not test then return end
            local success, result = test:Run()
            onUpdate(success, result)
            testState[test.name] = success
            if (not success) then
                error(string.format("Test %s failed with error:\n%s", test.name, result))
            end
            if (testIndex >= testCount) then
                ticker:Cancel()
                onFinish(testState)
            end
            testIndex = testIndex + 1
        end, testCount)
    end

    --- SOME EXAMPLE TESTS
    -- Tests:Test("Test /way 50 50", function(self)
    --     local PinProvider = MapPinEnhanced:GetModule("PinProvider")
    --     local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50 50")
    --     self:Expect(title):ToBe(nil)
    --     self:Expect(mapID):ToBe(C_Map.GetBestMapForUnit("player"))
    --     self:Expect(coords):ToBe({ 50, 50 })
    -- end)

    -- Tests:Test("ToggleTracker Show", function(self)
    --     MapPinEnhanced:TogglePinTracker(true)
    --     self:Expect(MapPinEnhanced.pinTracker:IsShown()):ToBeTruthy()
    -- end)


    -- Tests:Test("ToggleTracker Hide", function(self)
    --     MapPinEnhanced:TogglePinTracker(false)
    --     self:Expect(MapPinEnhanced.pinTracker:IsShown()):ToBeFalsy()
    -- end)
end
