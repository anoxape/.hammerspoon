local newKeyEvent = require 'hs.eventtap'.event.newKeyEvent
local usleep = require 'hs.timer'.usleep

local _M = {}

_M.config = {
    delay = 200000,
}

local delay

function _M.init(config)
    delay = config.delay
end

local function send(app, modifiers, character)
    newKeyEvent(modifiers, character, true):post(app)
    usleep(delay)
    newKeyEvent(modifiers, character, false):post(app)
end

_M.send = send

return _M
