---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


-- Based on:
-- https://github.com/swarn/fzy-lua
-- The MIT License (MIT)

-- Copyright (c) 2020 Seth Warn

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-- The lua implementation of the fzy string matching algorithm

local SCORE_GAP_LEADING = -0.005
local SCORE_GAP_TRAILING = -0.005
local SCORE_GAP_INNER = -0.01
local SCORE_MATCH_CONSECUTIVE = 1.0
local SCORE_MATCH_SLASH = 0.9
local SCORE_MATCH_WORD = 0.8
local SCORE_MATCH_CAPITAL = 0.7
local SCORE_MATCH_DOT = 0.6
local SCORE_MAX = math.huge
local SCORE_MIN = -math.huge
local MATCH_MAX_LENGTH = 1024


-- Check if `needle` is a subsequence of the `haystack`.
--
-- Called before scoring so non-matches need no score buffers.
--
-- Args:
--   needle (string)
--   haystack (string)
--   case_sensitive (bool, optional): defaults to false
--
-- Returns:
--   bool
---@param needle string
---@param haystack string
---@param case_sensitive boolean|nil
---@return boolean
local function has_match(needle, haystack, case_sensitive)
    if not case_sensitive then
        needle = string.lower(needle)
        haystack = string.lower(haystack)
    end

    local j = 1
    for i = 1, string.len(needle) do
        j = string.find(haystack, needle:sub(i, i), j, true) --[[@as number]]
        if not j then
            return false
        else
            j = j + 1
        end
    end

    return true
end

local function is_lower(c)
    return c:match("%l")
end

local function is_upper(c)
    return c:match("%u")
end


---@param haystack string
---@return table
local function precompute_bonus(haystack)
    ---@type table<number, number>
    local match_bonus = {}

    local last_char = "/"
    for i = 1, string.len(haystack) do
        local this_char = haystack:sub(i, i)
        if last_char == "/" or last_char == "\\" then
            match_bonus[i] = SCORE_MATCH_SLASH
        elseif last_char == "-" or last_char == "_" or last_char == " " then
            match_bonus[i] = SCORE_MATCH_WORD
        elseif last_char == "." then
            match_bonus[i] = SCORE_MATCH_DOT
        elseif is_lower(last_char) and is_upper(this_char) then
            match_bonus[i] = SCORE_MATCH_CAPITAL
        else
            match_bonus[i] = 0
        end

        last_char = this_char
    end

    return match_bonus
end


---@param needle string
---@param haystack string
---@param case_sensitive boolean|nil
---@param checkpoint fun()?
---@return number
local function score(needle, haystack, case_sensitive, checkpoint)
    local n = string.len(needle)
    local m = string.len(haystack)
    if n == 0 or m == 0 or m > MATCH_MAX_LENGTH or n > m then
        return SCORE_MIN
    elseif n == m then
        return SCORE_MAX
    end

    -- Note that the match bonuses must be computed before the arguments are
    -- converted to lowercase, since there are bonuses for camelCase.
    local match_bonus = precompute_bonus(haystack)

    if not case_sensitive then
        needle = string.lower(needle)
        haystack = string.lower(haystack)
    end

    -- Because lua only grants access to chars through substring extraction,
    -- get all the characters from the haystack once now, to reuse below.
    ---@type string[]
    local haystack_chars = {}
    for i = 1, m do
        haystack_chars[i] = haystack:sub(i, i)
    end

    -- Only the previous row's diagonal is needed; retain it before overwriting.
    -- Consumers use scores, so no position matrix or traceback is necessary.
    ---@type number[], number[]
    local D, M = {}, {}
    for i = 1, n do
        local diagonalD, diagonalM = SCORE_MIN, SCORE_MIN

        local prev_score = SCORE_MIN
        local gap_score = i == n and SCORE_GAP_TRAILING or SCORE_GAP_INNER
        local needle_char = needle:sub(i, i)

        for j = 1, m do
            local previousD, previousM = D[j], M[j]
            if needle_char == haystack_chars[j] then
                ---@type number
                local score = SCORE_MIN
                if i == 1 then
                    score = ((j - 1) * SCORE_GAP_LEADING) + match_bonus[j] --[[@as number]]
                elseif j > 1 then
                    local a = diagonalM + match_bonus[j] --[[@as number]]
                    local b = diagonalD + SCORE_MATCH_CONSECUTIVE
                    score = math.max(a, b)
                end
                D[j] = score
                prev_score = math.max(score, prev_score + gap_score)
            else
                D[j] = SCORE_MIN
                prev_score = prev_score + gap_score
            end
            M[j] = prev_score
            diagonalD, diagonalM = previousD, previousM
        end
        if checkpoint then checkpoint() end
    end
    return M[m]
end

---@class SearchResult
---@field i number Index of the line in the haystacks
---@field line string The line in the haystacks
---@field s number Score of the match


---@param needle string
---@param haystacks string[]
---@param case_sensitive boolean|nil
---@param checkpoint fun()? elapsed-budget checkpoint when called inside a batch
---@return SearchResult[]
function MapPinEnhanced:Filter(needle, haystacks, case_sensitive, checkpoint)
    local result = {}
    for i, line in ipairs(haystacks) do
        if has_match(needle, line, case_sensitive) then
            local s = score(needle, line, case_sensitive, checkpoint)
            table.insert(result, { i = i, s = s, line = line })
        end
        if checkpoint then checkpoint() end
    end
    ---@param a SearchResult
    ---@param b SearchResult
    ---@return boolean
    table.sort(result, function(a, b)
        return a.s > b.s
    end)

    return result
end

---@param searchString string
---@param targetString string
---@param case_sensitive boolean|nil
---@return boolean
function MapPinEnhanced:FuzzyMatch(searchString, targetString, case_sensitive)
    return has_match(searchString, targetString, case_sensitive)
end
