addEventHandler("onResourceStart", resourceRoot,
function()

    -- Veri işlemleri
    Database  = FileService:data('get');
    if not Database then 
        NewFile = FileService:data{
            set = true,
            preparedData = {},
        } 

        if (NewFile) then 
            return restartResource(getThisResource());
        end
    end

    Cache = Database;
    LastSerial = nil;
   -- Veri işlemleri bitiş

    function add(serial)
        serial = serial:gsub(' ', '');
        LastSerial = serial;

        if Cache[serial] then 
            return false;
        end

        Cache[serial] = true;
        return true 
    end
    
    function exists(serial)
        serial = serial:gsub(' ', '');
        return (Cache[serial] or false)
    end

    function rollback()

        if LastSerial then 
            Cache[LastSerial] = nil
            return LastSerial;
        end
    return false 
    end

    function remove(serial)
        serial = serial:gsub(' ', '');
        Cache[serial] = nil;
        return true
    end

    addEventHandler('onPlayerConnect', resourceRoot,
    function(_, _, _, playerSerial, _)
        if not Cache[tostring(playerSerial)] then 
            outputDebugString('['..playerSerial..'] Serialine sahip oyuncu oyuna girmeye çalıştı.', 0, 255, 255, 255)
            cancelEvent(true,"Whitelist'e ekli değilsin üzgünüm dostum! lütfen bize discord üzerinden başvur.")
        end
    end)
end)

addEventHandler("onResourceStop", resourceRoot,
function()
    if Database then 
        Database = {};
        table.foreach(Cache, function(item, value)
            Database[item] = value
        end)
    
        FileService:data{
            set = true,
            preparedData = Database,
        }
    end
    
end)