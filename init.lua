-- luacheck: read_globals hs, globals kit vhs

kit, vhs = require 'kit', require 'vhs'

local alpha = 0.95

hs.console.alpha(alpha)
hs.console.behaviorAsLabels { 'moveToActiveSpace' }

hs.window.animationDuration = 0

local hyper = { 'ctrl', 'alt', 'cmd' }

-- vhs

vhs {
    cheatsheet = {
        content = {
            mods = {
                order = { 'shift', 'ctrl', 'alt', 'cmd' },
            },
        },
        view = {
            alpha = alpha,
            cache = hs.timer.hours(1),
        },
    },
    dock_press = {
        modifier = { 'ctrl' },
    },
    ensure = {
        message = 'Really?',
    },
    layout_cache = {},
    things = {},
}

kit.each(vhs.ensure.bindSpec, ipairs {
    { { 'cmd' }, 'q' },
    { { 'cmd', 'alt' }, 'q' },
    { { 'cmd', 'shift' }, 'w' },
})

kit.eachkv(hs.hotkey.bindSpec, pairs {
    [{ hyper, 'space' }] = hs.toggleConsole,
    [{ hyper, '/' }] = vhs.cheatsheet.show,
    [{ hyper, 'v' }] = vhs.things.force_paste,
})

-- spoon

hs.loadSpoon 'MiroWindowsManager'

spoon.MiroWindowsManager:bindHotkeys {
    up = { hyper, 'up' },
    right = { hyper, 'right' },
    down = { hyper, 'down' },
    left = { hyper, 'left' },
    fullscreen = { hyper, 'return' },
}
