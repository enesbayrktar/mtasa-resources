addEventHandler('onClientResourceStart', resourceRoot,
function()
    
    Timer(function()

        if not localPlayer.vehicle then
            return
        end 

        if localPlayer.vehicleSeat ~= 0 then 
            return
        end

        -- localPlayer.vehicle.inWater readonly property.
        -- localPlayer.vehicle.inWater sadece okunabilir bir değer.
        if not localPlayer.vehicle:isInWater() then 
            return 
        end

        Area:pull(Area:getID(),
        function(this, zone)

            local node = this:node(zone)
            localPlayer.vehicle.position = Vector3(node.x, node.y, node.z + 1)
            
        end)
    end
    ,1000, 0)
	
	-- v1.0.0
	--callFunctionWithSleeps(Area:register({0, 63}).load, Area, 'data/node_') 

end)