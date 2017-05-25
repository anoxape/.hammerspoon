local hs_eventtap = require 'hs.eventtap'
local hs_pasteboard = require 'hs.pasteboard'

local keyStrokes = hs_eventtap.keyStrokes
local getContents = hs_pasteboard.getContents

local _M = {}

local function force_paste()
    return keyStrokes(getContents())
end

_M.force_paste = force_paste

local function mute(device)
    return device:setMuted(true)
end

_M.mute = mute

local function unmute(device)
    return device:setMuted(false)
end

_M.unmute = unmute

return _M
