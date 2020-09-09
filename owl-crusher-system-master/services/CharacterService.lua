addEventHandler('onClientResourceStart', resourceRoot,
function()

    Models       = {"sweet", "gungrl3"} 
    SKINLIST     = Service:get('REPLACESKINS')
    OLDMODEL     = false;
    bHop, unJump = false, false

    table.foreach(Models,
    function(item, value)
        local txd = engineLoadTXD('models/'..value..'.txd', true)
        engineImportTXD (txd, SKINLIST[item])

        local dff = engineLoadDFF ('models/'..value..'.dff')
        engineReplaceModel (dff, SKINLIST[item])
    end)

    local function addBroom(broom)
        local txd = engineLoadTXD('models/broom.txd', true)
        engineImportTXD (txd, Service:get('BROOMID'))

        local dff = engineLoadDFF('models/broom.dff')
        engineReplaceModel(dff, Service:get('BROOMID'))
    return true 
    end
    addBroom()

    function key(button, press)  
        if unJump == false and bHop then 
            unJump = true;
            toggleControl("jump",true)
            Timer(function()
                toggleControl('jump', false)
                Timer(function() unJump = false end, 1000, 1)
            end,50, 1)
        end
    end

    Service:listener('accounts:characters:spawn', 
    function()
        CoordsService:flushMarkers() 
        triggerServerEvent('crusher:check', root, localPlayer:getData('dbid'), localPlayer) 
    end)

    if localPlayer:getData('dbid') then 
        triggerServerEvent('crusher:check', root, localPlayer:getData('dbid'), localPlayer) 
    end

    Service:listener('crusher:client',
    function(model2, marker)

        if not marker then 
            bHop = true
            OLDMODEL = localPlayer.model;
            localPlayer:setData('viewingInterior', 1, false)

            localPlayer.model = model2
        end 

        CoordsService:random(Vector2(1436.1767578125, -1725.603515625), Vector2(math.random(88), math.random(128)), 
        function(pos) 
            -- Dönen rastgele alan değerinde bir marker oluşturuyoruz.  
            CoordsService:marker(Vector2(pos), getGroundPosition(pos.x, pos.y, 20.046875), 
            function(marker, markerID)
                -- Marker'a değdiğinde
                addEventHandler ("onClientMarkerHit", marker,
                function(hitPlayer) 
                    CoordsService:deleteMarker(markerID)
                    triggerServerEvent('crusher:hitMarker', resourceRoot, hitPlayer)
                
                end)
            end)
        end)

    end, localPlayer)

    Service:listener('crusher:weapon:gived', 
    function(modelControllerID)

        local Player = source
        toggleAllControls(false)
        setPedAnimation(Player, "POLICE", "CopTraf_Left")

        Timer(triggerServerEvent, Service:get('MISSONMS'), 1, 'crusher:complete', resourceRoot, Player)
    
    end, localPlayer)

    Service:listener('crusher:finish',
    function(bool)

        -- Bunny engelleme
        bHop = false

        -- Controller silinmesi
        CoordsService:flushMarkers()

        -- Kontrollerin açılması
        toggleAllControls(true)

        -- Ped animasyonunun bitişi
        setPedAnimation(source, false)

        -- Karakter skin ayarlamaları
        -- print(OLDMODEL)
        source.model = OLDMODEL or 255

        -- Envanter
        source:setData('viewingInterior', 0, false)

        if (bool) then 
            outputChatBox('bitiş yazısı')
        end
    end)

    bindKey("jump","down",key)
end)