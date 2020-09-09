Service = {}
local Service_mt = Class(Service)

function Service:new(namespace)
    return setmetatable({ namespace = namespace }, Service_mt)
end

function Service:register(object)

    if (not object or (type(object) ~= 'table') or self:empty(object)) then
        return false, error('required argument OBJECT not found, please check code syntax')
    end
    self.url    = object[1];

return true
end

function Service:getService()
    return self;
end