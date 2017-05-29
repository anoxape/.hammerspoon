-- luacheck: read_globals hs, globals kit vhs

hs.autoLaunch(true)
hs.consoleOnTop(true)
hs.dockIcon(false)
hs.menuIcon(false)

kit, vhs = require 'kit', require 'vhs'

local alpha = 0.95

hs.console.alpha(alpha)
hs.console.behaviorAsLabels { 'moveToActiveSpace' }

vhs {
    cheatsheet = {
        content = {
            mods = {
                order = { 'shift', 'ctrl', 'alt', 'cmd' },
            },
        },
        view = {
            alpha = alpha,
            cache = hs.timer.days(1),
        },
    },
    dock_press = {},
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
    [{ { 'ctrl' }, '§' }] = hs.toggleConsole,
    [{ { 'ctrl' }, 'f1' }] = vhs.cheatsheet.show,
    [{ { 'cmd', 'ctrl' }, 'v' }] = vhs.things.force_paste,
})
