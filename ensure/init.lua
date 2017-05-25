local frontmostApplication = require 'hs.application'.frontmostApplication
local modal_new = require 'hs.hotkey'.modal.new
local doAfter = require 'hs.timer'.doAfter

local setup = require 'kit'.setup

local keystroke = require 'ensure/keystroke'

local send = keystroke.send

local _M = {}

_M.config = {
    escape = { {}, 'escape' },
    message = 'Press again to confirm',
    delay = 1,
}

local escape, message, delay

function _M.init(config)
    setup(keystroke, config.keystroke)

    escape = config.escape
    message = config.message
    delay = config.delay
end

local function bind(mods, key)
    local modal = modal_new(mods, key, message)

    local function nay()
        modal:exit()
    end

    local function yay()
        send(frontmostApplication(), mods, key)
        modal:exit()
    end

    function modal:entered()
        doAfter(delay, nay)
    end

    modal:bind(escape[1], escape[2], nay)
    modal:bind(mods, key, nil, yay)

    return modal
end

_M.bind = bind

local function bindSpec(keyspec)
    return bind(keyspec[1], keyspec[2])
end

_M.bindSpec = bindSpec

return _M
