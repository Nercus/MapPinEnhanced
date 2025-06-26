---@class MapPinEnhanced
---@field tests Test[] a list of tests that have been registered
local MapPinEnhanced = select(2, ...)

---@alias TestExpectations {ToBe: fun(_, expected: any), ToBeTruthy: fun(), ToBeFalsy: fun(), ToBeType: fun(_, expected: type)}

---@class Test
---@field name string The name of the test
---@field Expect fun(_, value: any): TestExpectations The function to call to expect a value
---@field Run fun(): boolean, string The function to run the test, returns success and result


local function FormatTestError(message, stack)
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

local function ToString(value)
    assert(value ~= nil, "Value not provided")
    if not value then
        return "nil"
    end
    if (type(value) == "table") then
        return serializeTable(value)
    end
    return tostring(value)
end

---Create a new test. Example usage:
-- Addon:Test("Test addition", function(test)
--     local sum = 1 + 1
--     test:Expect(sum):ToEqual(2)
-- end)

-- Addon:Test("Test frame showable", function(test)
--    MyFrame:Show()
--    test:Expect(MyFrame:IsShown()):ToBeTruthy()
-- end)
--
-- Addon:Test("Test is value saved persistently", function(test)
--    local sum = 1 + 1
--    test:SetVar("sum", sum)
--    test:Expect(Addon:GetVar("sum")):ToEqual(2)
-- end)
---@param name string
---@param func fun(test: Test)
function MapPinEnhanced:Test(name, func)
    assert(type(name) == "string", "Test Name not provided")
    assert(type(func) == "function", "Test Function not provided")

    if (not self.tests) then
        self.tests = {}
    end

    local test = {
        name = name,
    }

    function test:Expect(value)
        ---@param expected any
        local function ToBe(expected)
            -- check if the value is a table
            if (type(value) == "table") then
                ---@cast value table<any, any>
                for k, v in pairs(value) do
                    if (v ~= expected[k]) then
                        error(FormatTestError(
                            string.format("Expected %s to be %s.", ToString(v), ToString(expected[k])),
                            debugstack(1)))
                    end
                end
                return
            end
            if (value ~= expected) then
                error(FormatTestError(
                    string.format("Expected %s to be %s.", ToString(value), ToString(expected)),
                    debugstack(1)))
            end
        end

        local function ToBeTruthy()
            if not value then
                error(FormatTestError(string.format("Expected %s to be truthy.", ToString(value)),
                    debugstack(1)))
            end
        end

        local function ToBeFalsy()
            if value then
                error(FormatTestError(string.format("Expected %s to be falsy.", ToString(value)),
                    debugstack(1)))
            end
        end

        ---@param expected type
        local function ToBeType(_, expected)
            if (type(value) ~= expected) then
                error(FormatTestError(
                    string.format("Expected %s to be of type %s.", ToString(value), ToString(expected)),
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

---Get the number of tests that have been registered
---@return number
function MapPinEnhanced:GetNumberOfTests()
    return #(self.tests or {})
end

---Get all tests that have been registered
---@return Test[]
function MapPinEnhanced:GetTests()
    return self.tests
end

---Run all registered tests
---@param onUpdate fun(success: boolean, result: string)
---@param onFinish fun(testErrors: table<string, boolean>)
function MapPinEnhanced:RunTests(onUpdate, onFinish)
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
