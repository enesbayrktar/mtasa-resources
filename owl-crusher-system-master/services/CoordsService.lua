CoordsService = Service:new('coords')

function CoordsService:create(south, west, radius, height, func)
    return func(ColShape.Rectangle(south, west, radius, height))
end

function CoordsService:random(corner, offset, func)
    return func(corner + offset)
end

function CoordsService:marker(vector, z, func)
    self.markers = self.markers or {}
    local id     = (#self.markers or 0) + 1
    self.markers[id] = Marker(vector.x, vector.y, z, "cylinder", 1.5, 255, 0 , 0, 200)
    return func(self.markers[id], id)
end

function CoordsService:deleteMarker(id)
    if self.markers[id] then
        destroyElement(self.markers[id])
        self.markers[id] = nil;
    end 
end

function CoordsService:flushMarkers()
    if self.markers then 
        table.foreach(self.markers, 
        function(item, value)
            destroyElement(value);
            self.markers[item] = nil;
        end)
    end
end