Service = {}
local Service_mt = Class(Service)

function Service:new(namespace)
    return setmetatable({ namespace = namespace }, Service_mt)
end

function Service:getID(x, y)
    x = x or localPlayer.position.x or error('Identify error for x position')
    y = y or localPlayer.position.y or error('Identify error for y position')

    return math.floor((y + 3000)/750)*8 + math.floor((x + 3000)/750)
end

function Service:cache(key, value)
    
    cacheTable = cacheTable or {}
    if not cacheTable[key] then 
        cacheTable[key] = value;
    end 

return cacheTable[key]
end

function Service:node(zone, x, y, z)
    x = x or localPlayer.vehicle.position.x or error('Identify error for x position')
    y = y or localPlayer.vehicle.position.y or error('Identify error for y position')
    z = z or localPlayer.vehicle.position.z or error('Identify error for z position')
    zone = zone or error('Idetify error for element ZONE')

    return findNearestRoad(zone, x , y);
end


-- Kaynakça: https://github.com/dcr30/drift-paradise-mta/tree/master/%5Bcore%5D/dpPathGenerator
function findNearestRoad(zone, x,y)
    local nodeStart =-1
    local distance= 10000
    for i,queue in pairs(zone) do
        local nodeDistance=getDistanceBetweenPoints2D(x,y,queue.x,queue.y)
        if distance > nodeDistance then
            distance = nodeDistance
            nodeStart = queue
        end
    end
    return nodeStart
end