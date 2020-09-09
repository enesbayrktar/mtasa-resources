addEventHandler("onResourceStart", resourceRoot,
function()

    -- Veri işlemleri
    Database  = FileService:data('get');
    AssignIDS = {}
    if not Database then 
        NewFile = FileService:data{
            set = true,
            preparedData = {
                {},
            },
        } 

        if (NewFile) then 
            return restartResource(getThisResource());
        end
    end

    if #Database > 0 then 
        table.foreach(Database, function(item, value)
            if (tonumber(value[2]) > 0) then 
                AssignIDS[value[1]] = tonumber(value[2]);
            end
        end)
    end
   -- Veri işlemleri bitiş
    
    -- Alan oluşumu
    CoordsService:create(1436.1767578125, -1725.603515625, 88, 128, 
    function(ShapeSource)
        
        addCommandHandler('kamu',
        function(player, command, react, id, count)

            -- Eğer kullanıcı PD'değil ise
            if player:getData('faction') ~= Service:get('PDFACTID') then 
                return false
            end
            
            -- Eğer aksiyon yoksa
            if not react then 
                return player:outputChat("PDKOMUT: /" .. command .. " [ver/al] [id] [miktar]", 255, 194, 14)
            end

            -- Eğer kullanıcı varsa
            local targetPlayer, targetPlayerNick = exports.global:findPlayerByPartialNick(player, id)
            if not targetPlayer then 
                return false 
            end
            
            -- Birliği PD ise
            if (targetPlayer:getData('faction') == Service:get('PDFACTID') and Service:get('PDTOPD') ~= true)  then 
                return player:outputChat('PDKOMUT: Birlik içerisindeki birisine kamu görevi veremezsin.', 255, 194, 14)
            end
            local dbID = tonumber(targetPlayer:getData('dbid'))
            local Distance = getDistanceBetweenPoints3D(player.position, targetPlayer.position)
            
            -- Eğer 30 birim yakınsa
            if Distance < Service:get('DISTANCE') then 
                if react == 'al' then 

                    if AssignIDS[dbID] then 
                        AssignIDS[dbID] = nil;            
                        table.foreach(Database, 
                        function(item, value)
                            if value[1] == targetPlayer:getData('dbid') then 
                                triggerClientEvent(player, 'crusher:finish', targetPlayer)
                                AssignIDS[dbID] = nil;
                                return targetPlayer:outputChat('GÖREVLİ: Kamu görevinden alındın, bir daha görmeyelim seni buralarda!', 255, 194, 14)
                            end
                        end)

                    return true;

                    else 
                        return player:outputChat("Kullanıcı bir kamu görevinde değil.", 255, 194, 14)
                    end
                
                elseif react == 'ver' then 
                    -- Miktar değeri varsa
                    if not count then 
                        return player:outputChat("PDKOMUT: /" .. command .. " [ver/al] [id] [miktar]", 255, 194, 14)
                    end

                    -- Miktar değeri 0'dan büyükse
                    if not tonumber(count) or tonumber(count) < 0 then 
                        return player:outputChat("PDKOMUT: /" .. command .. " [ver/al] [id] [miktar]", 255, 194, 14)
                    end 

                    -- Değer atamaları
                    if not AssignIDS[dbID] then 
                        
                        AssignIDS[dbID] = tonumber(count);

                        table.insert(Database, {dbID, tonumber(count)});
                        triggerEvent('crusher:check', resourceRoot, dbID, targetPlayer, player)
                        return true
                    else 
                        return player:outputChat("Kullanıcı zaten bir kamu görevinde.", 255, 194, 14)
                    end
                end
            else 
                return player:outputChat("Kullanıcıya yakın olmalısın.", 255, 194, 14)
            end

            return player:outputChat("PDKOMUT: /" .. command .. " [ver/al] [id] [miktar]", 255, 194, 14)    
        end) -- Komut "kamu" bitişi
        
        -- Kontrol noktası
        local CenterCords = Vector3(1479.6611328125, -1672.419921875, 14.046875)



        Service:listener('crusher:check', function(dbID, player, pdmember, isRefresh)
            if AssignIDS[dbID] then 
                
                -- eğer pd üyesi çaptırdıyas
                if pdmember then 
                    player:outputChat(pdmember.name.." tarafından "..tostring(AssignIDS[dbID]).." kadar kamu cezasına çaptırıldın!", 255, 194, 14)
                end 

                -- Cinsiyetine göre kıyafet tanımlama
                local Gender = tonumber(player:getData('gender'));
                local Model = Gender == 0 and Service:get('REPLACESKINS')[1] or Service:get('REPLACESKINS')[2]
                if not isRefresh then 
                    triggerClientEvent(player, 'crusher:client', player, Model)
                else 
                    triggerClientEvent(player, 'crusher:client', player, false, true)
                end
                
                -- Alan dışındaysa zorla içeri alınsın
                if (not isInsideColShape(ShapeSource, player.position)) then
                  player.position = CenterCords  
                end
            end
        end)

        -- Oyuncu marker'a girdiğinde
        Service:listener('crusher:hitMarker', 
        function(player, positionControllerID, modelControllerID)
            player:setData('isMission', true, false)
            giveWeapon(player, Service:get('WEAPONID'), 1, true)
            triggerClientEvent(player, 'crusher:weapon:gived', player, positionControllerID, modelControllerID)
        end)

        -- Oyuncu 2sn boyunca marker içindeyken
        Service:listener('crusher:complete', 
        function(player)

            local dbID = player:getData('dbid')
            if (AssignIDS[dbID] - 1) > 0 then 
                AssignIDS[dbID] = AssignIDS[dbID] - 1;

                triggerClientEvent(player, 'crusher:finish', player)
                triggerEvent('crusher:check', resourceRoot, dbID, player, false)
                takeWeapon(player, Service:get('WEAPONID'))
                player:setData('isMission', false, false)
            
            else 
                triggerClientEvent(player, 'crusher:finish', player, true)
                takeWeapon(player, Service:get('WEAPONID'))
                player:setData('isMission', false, false)
                AssignIDS[dbID] = nil;
            end
        end)

        -- Oyuncu alandan çıkmaya çalışırsa
        addEventHandler("onColShapeLeave", resourceRoot, 
        function(element)
            if (getElementType(element) == "player" and source == ShapeSource) then 
                if AssignIDS[element:getData('dbid')] then
                    element.position = CenterCords

                    if element:getData('isMission') then
                        AssignIDS[element:getData('dbid')] = AssignIDS[element:getData('dbid')] + 1; 
                        return element:outputChat('[!] Alanın dışına çıkmaya çalıştığın için ceza sayın yeniden '..AssignIDS[element:getData('dbid')]..' olarak ayarlandı.', 255, 194, 14)
                    else 
                        return element:outputChat('[!] Alanın dışına çıkamazsın!', 255, 194, 14)
                    end
                end
            end
            cancelEvent()
        end)
    end)

end)

addEventHandler("onResourceStop", resourceRoot,
function()
    if Database then 
        Database = {};
        table.foreach(AssignIDS, function(item, value)
            table.insert(Database, {item, value})
        end)

        FileService:data{
            set = true,
            preparedData = Database,
        }
    end
    
end)