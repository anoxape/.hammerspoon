local pairs = pairs
local type = type

local _M = {}

local function merge(acc, tab)
    if type(acc) == 'table' and type(tab) == 'table' then
        for k, v in pairs(tab) do
            acc[k] = v
        end

        return acc
    else
        return tab
    end
end

_M.merge = merge

return _M
