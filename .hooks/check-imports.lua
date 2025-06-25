---@diagnostic disable: no-unknown, undefined-global

local function check_imports(xmlfile, errors)
    local xmldir = xmlfile:match("^(.*)[/\\][^/\\]+$") or "."
    for line in io.lines(xmlfile) do
        for importfile in line:gmatch('file="([^"]+)"') do
            if not importfile:lower():match("^interface/") then
                local fullpath = xmldir .. "/" .. importfile
                local f = io.open(fullpath, "r")
                if not f then
                    table.insert(errors, string.format("Incorrect import: %s (imported in %s)", fullpath, xmlfile))
                else
                    f:close()
                end
            end
        end
    end
end

local errors = {}
for i = 1, #arg do
    local xmlfile = arg[i]
    check_imports(xmlfile, errors)
end

if #errors > 0 then
    for _, err in ipairs(errors) do print(err) end
    print("Commit aborted: One or more imported files are missing.")
    os.exit(1)
else
    print("All XML imports in provided files exist. Proceeding.")
end
