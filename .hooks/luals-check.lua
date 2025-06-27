---@diagnostic disable: no-unknown, undefined-global

-- Get staged Lua files
local handle = io.popen('git diff --cached --name-only --diff-filter=ACM')
local files = {}
for file in handle:lines() do
    if file:match('%.lua$') then
        table.insert(files, file)
    end
end
handle:close()

if #files == 0 then
    os.exit(0)
end

local has_errors = false

for _, file in ipairs(files) do
    -- Run lua-language-server --check
    os.execute('lua-language-server --check "' .. file .. '"')

    -- Check the log file for errors
    local log_path = os.getenv('USERPROFILE') .. '\\.cache\\lua-language-server\\log\\check.json'
    local log = io.open(log_path, 'r')
    if log then
        local content = log:read('*a')
        log:close()
        if content:find('"severity":%s*1') then -- severity 1 = error
            print('LuaLS error in ' .. file)
            has_errors = true
        end
    end
end

if has_errors then
    print('Commit blocked: LuaLS found errors in staged Lua files.')
    os.exit(1)
end

os.exit(0)
