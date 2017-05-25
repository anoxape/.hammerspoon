local setup = require 'kit'.setup

local content_menu = require 'cheatsheet/content/menu'
local content_style = require 'cheatsheet/content/style'

local menu_parse = content_menu.parse
local style_css = content_style.css

local _M = {}

_M.config = {
    title = 'Cheatsheet',
}

local header, footer

function _M.init(config)
    setup(content_menu, config.menu)
    setup(content_style, config.style)

    local head = '<head>'
            .. '<title>' .. config.title .. '</title>'
            .. '<style type="text/css">' .. style_css() .. '</style>'
            .. '</head>'

    header = '<!DOCTYPE html>' .. '<html>' .. head .. '<body>'
    footer = '</body></html>'
end

local function parse(application)
    return header .. menu_parse(application:getMenuItems()) .. footer
end

_M.parse = parse

return _M
