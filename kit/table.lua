local ipairs = ipairs
local move = table.move
local rawset = rawset
local type = type

local _M = {}

local function keys(gen, param, state)
    local acc, pos = {}, 1

    for k, _ in gen, param, state do
        rawset(acc, pos, k)
        pos = pos + 1
    end

    return acc
end

_M.keys = keys

local function values(gen, param, state)
    local acc, pos = {}, 1

    for _, v in gen, param, state do
        rawset(acc, pos, v)
        pos = pos + 1
    end

    return acc
end

_M.values = values

-- each

local function eachk(fun, gen, param, state)
    for k, _ in gen, param, state do
        fun(k)
    end
end

_M.eachk = eachk

local function eachv(fun, gen, param, state)
    for _, v in gen, param, state do
        fun(v)
    end
end

_M.eachv = eachv
_M.each = eachv

local function eachkv(fun, gen, param, state)
    for k, v in gen, param, state do
        fun(k, v)
    end
end

_M.eachkv = eachkv

-- map

local function mapk(acc, fun, gen, param, state)
    for k, _ in gen, param, state do
        acc[k] = fun(k)
    end

    return acc
end

_M.mapk = mapk

local function mapv(acc, fun, gen, param, state)
    for k, v in gen, param, state do
        acc[k] = fun(v)
    end

    return acc
end

_M.mapv = mapv
_M.map = mapv

local function mapkv(acc, fun, gen, param, state)
    for k, v in gen, param, state do
        acc[k] = fun(k, v)
    end

    return acc
end

_M.mapkv = mapkv

-- imap

local function imapk(acc, fun, gen, param, state)
    for k, _ in gen, param, state do
        local r = fun(k)

        if r ~= nil then
            acc[#acc + 1] = r
        end
    end

    return acc
end

_M.imapk = imapk

local function imapv(acc, fun, gen, param, state)
    for _, v in gen, param, state do
        local r = fun(v)

        if r ~= nil then
            acc[#acc + 1] = r
        end
    end

    return acc
end

_M.imapv = imapv
_M.imap = imapv

local function imapkv(acc, fun, gen, param, state)
    for k, v in gen, param, state do
        local r = fun(k, v)

        if r ~= nil then
            acc[#acc + 1] = r
        end
    end

    return acc
end

_M.imapkv = imapkv

-- amap

local function infer(acc, fun, gen, param, state)
    for _, v in gen, param, state do
        rawset(acc, v, fun(v))
    end

    return acc
end

_M.infer = infer

local function set(acc, stub, gen, param, state)
    for _, v in gen, param, state do
        rawset(acc, v, stub)
    end

    return acc
end

_M.set = set

-- misc

local function append(acc, tab)
    return move(tab, 1, #tab, #acc + 1, acc)
end

_M.append = append

local function _flatten(acc, tab)
    for _, v in ipairs(tab) do
        if type(v) == 'table' then
            _flatten(acc, v)
        else
            rawset(acc, #acc + 1, v)
        end
    end
end

local function flatten(tab)
    local acc = {}

    _flatten(acc, tab)

    return acc
end

_M.flatten = flatten

return _M
