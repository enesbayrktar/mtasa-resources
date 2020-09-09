Service = {}
local Service_mt = Class(Service)

function Service:new(namespace)
    return setmetatable({ namespace = namespace }, Service_mt)
end

function Service:listener(namespace, func, element)
    addEvent(namespace, true)
    addEventHandler(namespace, (element or root), func)
end

function Service:credentials(object)

    prefix = {
        'PDFACTID',
        'FILENAME',
        'REPLACESKINS',
        'PDTOPD',
        'BROOMID',
        'WEAPONID',
        'MISSONMS',
        'DISTANCE',
    }
    table.foreach(object, function(i, v)
        self:push(prefix[i], v); 
    end)
end

function Service:push(index, value)
    self[index] = value;
return true
end

function Service:get(index)
    return self[index]
end

function Service:register(object)

    if (not object or (type(object) ~= 'table') or self:empty(object)) then
        return false, error('required argument OBJECT not found, please check code syntax')
    end
    self.url    = object[1];

return true
end

function Service:empty(value)
    return value == nil or value == ''
end

function Service:getService()
    return self;
end

--@sözdizimi Service:credentials{PDFACTID, FILENAME, REPLACESKINS, PDTOPD, BROOMID, WEAPONID}
Service:credentials{1, 'data.json', {264, 205}, true, 323, 12, 5000, 30}
