local pairs = pairs
local require = require
local setmetatable = setmetatable

local setup = require 'kit'.setup

local _M = {}

function _M.init(config)
    for modname, modconfig in pairs(config) do
        local module = require(modname)

        setup(module, modconfig)

        _M[modname] = module
    end
end

return setmetatable(_M, { __call = setup })
