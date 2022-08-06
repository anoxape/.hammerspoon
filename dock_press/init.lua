local ipairs = ipairs

local hs_application = require 'hs.application'

local applicationElement = require 'hs.axuielement'.applicationElement
local bind = require 'hs.hotkey'.bind

local fbind = require 'kit'.fbind

local _M = {}

_M.config = {
    modifier = { 'ctrl' },
    keys = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' },
}

local function press(index)
    local icon = applicationElement(hs_application 'Dock')[1][index]

    if icon.AXRole == 'AXDockItem' then
        icon:performAction('AXPress')
    end
end

function _M.init(config)
    local modifier = config.modifier
    local keys = config.keys

    for index, key in ipairs(keys) do
        bind(modifier, key, fbind(press, index))
    end
end

return _M
