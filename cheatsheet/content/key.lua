local type = type
local menuGlyphs = require 'hs.application'.menuGlyphs

local _M = {}

local function parse(char, glyph)
    if type(glyph) == 'number' then
        return menuGlyphs[glyph] or '?' .. glyph .. '?'
    elseif type(char) == 'string' and char ~= '' then
        return char
    end
end

_M.parse = parse

return _M
