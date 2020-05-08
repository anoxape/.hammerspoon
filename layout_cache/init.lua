local pairs = pairs

local hs_filter = require 'hs.window'.filter
local hs_keycodes = require 'hs.keycodes'

local currentLayout = hs_keycodes.currentLayout
local setLayout = hs_keycodes.setLayout

local lru = require 'kit'.lru

-- TODO: https://github.com/Hammerspoon/hammerspoon/issues/615

local _M = {}

_M.config = {
    default = hs_keycodes.layouts()[1],
    cache_size = 256,
}

local function update(layout)
    if layout and currentLayout() ~= layout then
        return setLayout(layout)
    end
end

local default, cache

local events = {
    [hs_filter.windowDestroyed] = function(window)
        cache[window:id()] = nil
    end,
    [hs_filter.windowUnfocused] = function(window)
        cache[window:id()] = currentLayout()
    end,
    [hs_filter.windowFocused] = function(window)
        update(cache[window:id()] or default)
    end,
}

local filter

function _M.init(config)
    default = config.default

    cache = lru(config.cache_size)
    filter = hs_filter.new()

    for event, fun in pairs(events) do
        filter:subscribe(event, fun)
    end
end

return _M
