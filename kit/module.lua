local merge = require 'kit/core'.merge

local _M = {}

local function setup(module, config)
    if module.init then
        return module.init((module.configure or merge)(module.config or {}, config or {}))
    end
end

_M.setup = setup

return _M
