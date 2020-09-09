Service = {}
local Service_mt = Class(Service)

function Service:new(namespace)
    return setmetatable({ namespace = namespace }, Service_mt)
end

function Service:register(object)

    if (not object or (type(object) ~= 'table')) then
        return false, error('required argument OBJECT not found, please check code syntax')
    end

    self._allowedVehicles = object.allowedVehicles or nil;
	self._keys = object.keys or nil;

return self
end

function Service:find(t, ...)
	local args = { ... }
	if #args == 0 then
		for k,v in pairs(t) do
			if v then
				return k
			end
		end
		return false
	end

	local value = table.remove(args)
	if value == '[nil]' then
		value = nil
	end
	for k,v in pairs(t) do
		for i,index in ipairs(args) do
			if type(index) == 'function' then
				v = index(v)
			else
				if index == '[last]' then
					index = #v
				end
				v = v[index]
			end
		end
		if v == value then
			return k
		end
	end
	return false
end