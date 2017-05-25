local ipairs = ipairs
local require = require

local path = 'kit/'

local function module(modname)
    return require(path .. modname)
end

local _M = module 'core'

local modules = {
    'fun',
    'module',
    'null',
    'table',
}

local merge = _M.merge

for _, modname in ipairs(modules) do
    merge(_M, module(modname))
end

return _M
