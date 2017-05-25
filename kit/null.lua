local _M = {}

local null = {}

_M.null = null

local function tonil(o)
    if o == null then
        return nil
    else
        return o
    end
end

_M.tonil = tonil

local function tonull(o)
    if o == nil then
        return null
    else
        return o
    end
end

_M.tonull = tonull

return _M
