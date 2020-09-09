
function store(path, data, callback)
    
    local _data = data or error('required argumen [data] got nil')
    local _path = path or error('required argument [path] got nil')
    
    if not loadJSON(path) then
        saveJSON(path, _data) 
        if callback then 
            return callback(path, true)
        end
        return true
    end
end

function loadJSON(path)
    --> Dosya var mı yok mu?
    outputConsole(path)
    if (not File.exists(path)) then 
        return false
    end

    --> Dosya varsa açmaya çalış
    local _file = File.open(path)

    if not _file then
        return false, error('File cannot be opened ['..path..']')
    end

    --> Dosya açıldıysa byte cinsinden okuma yap
    local _count = nil;
    if not _count then 
        _count = _file:getSize()
    end

    local _data = _file:read(_count)

    _file:close()

--> return TABLE
return fromJSON(_data);
end

function saveJSON(path, data)
    --> Dosya var mı yok mu? varsa sil.
    if File.exists(path) then 
        File.delete(path) 
    end
    
    --> Yeni dosya oluştur
    local _file = File(path)
    --> Gönderilen veriyi JSON'a çevirerek dosyaya bas
    _file:write(toJSON(data));
    _file:close()

return true
end