local pairs = pairs

local hs_filter = require 'hs.window'.filter
local hs_keycodes = require 'hs.keycodes'

local currentLayout = hs_keycodes.currentLayout
local setLayout = hs_keycodes.setLayout

-- TODO: https://github.com/Hammerspoon/hammerspoon/issues/615

local _M = {}

_M.config = {
    default = hs_keycodes.layouts()[1],
}

local function update(layout)
    if layout and currentLayout() ~= layout then
        return setLayout(layout)
    end
end

local default, cache

local events = {
    [hs_filter.windowDestroyed] = function(o) cache[o:id()] = nil end,
    [hs_filter.windowUnfocused] = function(o) cache[o:id()] = currentLayout() end,
    [hs_filter.windowFocused] = function(o) update(cache[o:id()] or default) end,
}

local filter

function _M.init(config)
    default = config.default

    cache = {}
    filter = hs_filter.new(true)

    for event, fun in pairs(events) do
        filter:subscribe(event, fun)
    end
end

return _M
