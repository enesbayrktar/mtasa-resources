addEventHandler('onClientResourceStart', resourceRoot, 
function()

    Smoke = Service:new('smoke')

    function Smoke:init()
        
        self._allowedVehicles = self._allowedVehicles or error('Argument [AllowedVehicles] dont passed! [got nil]')
        self._keys = self._keys or error('Argument [keys] dont passed! [got nil]')

        local funcs = {
            ['3'] = function()
                applySmoke(localPlayer.vehicle, 245, 0, 0)
            end,
            ['4'] = function()
                applySmoke(localPlayer.vehicle, 255, 255, 255)
            end,
            --[[ Yeni renk ekleme;
                [tuşadı] = function()
                    applySmoke(localPlayer.vehicle, kırmızı, yeşil, mavi)
                end,
            ]]--
            ['5'] = function()
                detachSmoke(localPlayer.vehicle)
            end,
        }

        --> Oyuncu _key değerine bastığında
        local function _handle(key, keyState)
            return funcs[key]();
        end

        --> Oyuncu araca binerse!
        addEventHandler('onClientVehicleEnter', root,
        function(pl, seat)
            if pl == localPlayer and seat == 0 and self:find(self._allowedVehicles, pl.vehicle.model) then 
                table.foreach(self._keys,
                function(_, key)
                    bindKey(key, 'down', _handle)
                end)
            end
        end)

        --> Oyuncu araçtan inerse!
        addEventHandler('onClientVehicleExit', root,
        function(pl, seat)
            if pl == localPlayer and self:find(self._allowedVehicles, source.model) then 
                table.foreach(self._keys,
                function(_, key)
                    unbindKey(key, 'down', _handle)
                end)
            end
        end)

        --> Oyuncunun aracı patladığında
        addEventHandler('onClientVehicleExplode', root,
        function()
            if self:find(self._allowedVehicles, source.model) then 
                detachSmoke(source)
            end
        end)

    end

    Smoke:register{
        allowedVehicles = {519, 520}, --// 519 Shamal , 520 Hydra
        keys = {'3', '4', '5'},
    }
    :init()   

end)