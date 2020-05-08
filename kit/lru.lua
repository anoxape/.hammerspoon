local assert = assert
local setmetatable = setmetatable

local _M = {}

local KEY, VALUE, OLDER, NEWER = 1, 2, 3, 4

local function new_item()
    return { nil, nil, nil, nil }
end

function lru(capacity)
    assert(capacity > 0, 'capacity is not > 0')

    local first, last

    local function list_del(item)
        local older, newer = item[OLDER], item[NEWER]

        if older ~= nil and newer ~= nil then
            newer[OLDER], older[NEWER] = older, newer
        elseif newer ~= nil then
            newer[OLDER], first = nil, newer
        elseif older ~= nil then
            last, older[NEWER] = older, nil
        else
            first, last = nil, nil
        end

        item[OLDER], item[NEWER] = nil, nil
    end

    local function list_add(item)
        if last ~= nil then
            item[OLDER], last[NEWER] = last, item
        else
            first = item
        end

        last = item
    end

    local map, size = {}, 0

    local function map_del(key)
        map[key], size = nil, size - 1
    end

    local function map_add(key, value)
        map[key], size = value, size + 1
    end

    local function get(_, key)
        local item = map[key]

        if item == nil then
            return nil
        end

        list_del(item)
        list_add(item)

        return item[VALUE]
    end

    local function set(_, key, value)
        assert(key ~= nil, 'table index is nil')

        local item = map[key]

        if item ~= nil and value ~= nil then
            list_del(item)
            item[VALUE] = value
            list_add(item)
        elseif value ~= nil then
            while size + 1 > capacity do
                item = first -- cache
                map_del(item[KEY])
                list_del(item)
            end

            if item == nil then
                item = new_item() -- cache miss
            end

            item[KEY], item[VALUE] = key, value
            list_add(item)
            map_add(key, item)
        elseif item ~= nil then
            map_del(key)
            list_del(item)
        end
    end

    local function iterate(_, key)
        local item

        if key ~= nil then
            item = map[key][OLDER]
        else
            item = last
        end

        if item ~= nil then
            return item[KEY], item[VALUE]
        else
            return nil
        end
    end

    return setmetatable({}, {
        __index = get,
        __newindex = set,
        __pairs = function()
            return iterate, nil, nil
        end,
    })
end

_M.lru = lru

return _M
