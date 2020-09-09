FileService = Service:new('file')

function FileService:data(object)

    if not object then 
        error('required argumant OBJECT null, [got the table]')
    end
    local DATAPATH = 'data/';
    local LOAD  = self:load(DATAPATH..Service:get('FILENAME'))

    if object.set then 

        if not LOAD then 
            return self:save(DATAPATH..Service:get('FILENAME'), toJSON(object.preparedData))
        end

        return self:save(DATAPATH..Service:get('FILENAME'), toJSON(object.preparedData))
    else 

        if LOAD then 
            return fromJSON(LOAD)
        end

        return false;
    end 

return true
end

function FileService:load(path, count)

    if (not File.exists(path)) then 
        return false 
    end

    local file = File.open(path)

    if not file then
        return  false 
    end

    if not count then 
        count = file:getSize()
    end

    local data = file:read(count)

    file:close()

    self.files = self.files or {}
    table.insert(self.files, path)
    
    collectgarbage()

return data;
end

function FileService:save(path, data)
    if not path then
        return error('required argumant PATH null, [got the string]')
    end 

    if File.exists(path) then
        File.delete(path)
    end
    
    local file = File(path)
    file:write(data);
    file:close()

return true 
end