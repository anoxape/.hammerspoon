local setmetatable = setmetatable

local hs_timer = require 'hs.timer'

local delayed_new = hs_timer.delayed.new
local minutes = hs_timer.minutes

local floating = require 'hs.drawing'.windowLevels.floating
local mainScreen = require 'hs.screen'.mainScreen
local webview_new = require 'hs.webview'.new

local _M = {}

_M.config = {
    cache = minutes(1),
    screen = mainScreen;
    width = 1,
    height = 1,
    alpha = 1,
    window_level = floating,
    window_style = 'utility',
    preferences = {
        developerExtrasEnabled = false,
        javaScriptEnabled = false,
    },
}

local screen, width, height, alpha, window_level, window_style, preferences
local view

local function dispose()
    if view ~= nil then
        view:delete()
        view = nil
    end
end

local function size()
    return screen():frame():scale(width, height)
end

local function create()
    view = webview_new(size(), preferences):alpha(alpha):level(window_level):windowStyle(window_style)
end

local janitor

function _M.init(config)
    screen = config.screen
    width = config.width
    height = config.height
    alpha = config.alpha
    window_level = config.window_level
    window_style = config.window_style
    preferences = config.preferences

    janitor = delayed_new(config.cache, dispose)
end

local function show(content)
    janitor:stop()

    if view == nil then
        create()
    end

    view:html(content)
    view:show()

    return view
end

_M.show = show

local function hide()
    if view ~= nil then
        view:hide()
        janitor:start()
    end
end

_M.hide = hide

return setmetatable(_M, { __gc = dispose })
