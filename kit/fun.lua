local select = select

local _M = {}

local function nop(...)
    return ...
end

_M.nop = nop

local function _freduce(fun, acc, v, ...)
    if select('#', ...) == 0 then
        return fun(acc, v)
    else
        return _freduce(fun, fun(acc, v), ...)
    end
end

local function freduce(fun, acc, ...)
    if select('#', ...) == 0 then
        return acc
    else
        return _freduce(fun, acc, ...)
    end
end

_M.freduce = freduce

local function fbind(...)
    return freduce(function(fun, arg)
        return function(...)
            return fun(arg, ...)
        end
    end, ...)
end

_M.fbind = fbind

local function fcall(...)
    return freduce(function(fun1, fun2)
        return function(...)
            return fun1(fun2(...))
        end
    end, ...)
end

_M.fcall = fcall

return _M
