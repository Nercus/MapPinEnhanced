---@diagnostic disable: no-unknown, undefined-global

local function get_staged_xml_files()
    local files = {}
    local p = io.popen('git diff --cached --name-only')
    if not p then return files end
    for file in p:lines() do
        if file:lower():match("%.xml$") then
            table.insert(files, file)
        end
    end
    p:close()
    return files
end

local function check_imports(xmlfile, errors)
    -- Exclude files in 'libs' or 'hooks' folders
    if xmlfile:match("[/\\]libs[/\\]") or xmlfile:match("[/\\]hooks[/\\]") then
        return
    end

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
local staged_files = get_staged_xml_files()
for _, xmlfile in ipairs(staged_files) do
    check_imports(xmlfile, errors)
end

if #errors > 0 then
    for _, err in ipairs(errors) do print(err) end
    print("Commit aborted: One or more imported files are missing.")
    os.exit(1)
else
    print("All XML imports in staged files exist. Proceeding.")
end
