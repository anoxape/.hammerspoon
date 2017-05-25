local frontmostApplication = require 'hs.application'.frontmostApplication
local modal_new = require 'hs.hotkey'.modal.new

local setup = require 'kit'.setup

local content = require 'cheatsheet/content'
local view = require 'cheatsheet/view'

local _M = {}

_M.config = {
    escape = { {}, 'escape' },
}

local modal

local function hide()
    return modal:exit()
end

_M.hide = hide

local function show()
    return modal:enter()
end

_M.show = show

function _M.init(config)
    setup(content, config.content)
    setup(view, config.view)

    local escape = config.escape

    modal = modal_new()

    function modal:entered()
        view.show(content.parse(frontmostApplication()))
    end

    function modal:exited()
        view.hide()
    end

    modal:bind(escape[1], escape[2], hide)
end

return _M
