function Class(namespace)
    namespace = namespace or {}
    local mt = {
        __metatable = namespace;
        __index     = namespace;
    }
    
    local function new(_, init)
        return setmetatable(init or {}, mt)
    end
    namespace.new  = namespace.new  or new
    
return mt
end