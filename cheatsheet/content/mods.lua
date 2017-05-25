local concat = table.concat
local ipairs = ipairs
local pairs = pairs

local set = require 'kit'.set

local _M = {}

_M.config = {
    char = {
        shift = '⇧',
        ctrl = '⌃',
        alt = '⌥',
        cmd = '⌘',
    },
    order = {
        'shift',
        'ctrl',
        'alt',
        'cmd',
    },
}

local char, order

function _M.init(config)
    char = config.char
    order = config.order
end

local function parse(mods)
    local mods_set = set({}, true, pairs(mods))
    local text = {}

    for _, mod in ipairs(order) do
        if mods_set[mod] ~= nil then
            text[#text + 1] = char[mod]
            mods_set[mod] = nil
        end
    end

    for mod, _ in pairs(mods_set) do
        text[#text + 1] = '[' .. mod .. ']'
    end

    return concat(text)
end

_M.parse = parse

return _M
