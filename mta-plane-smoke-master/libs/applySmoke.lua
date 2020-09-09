--> Dokunma!
--> Dont touch!
--> Owner: https://www.youtube.com/channel/UCfyBwH8WbGj8FjSxSPg9ZWA
local smokes = {}
local maximumVehicleSmoke = 52
local smoke = dxCreateTexture("dist/media/smoke.png")
local update = getTickCount()

function applySmoke(vehicle, r, g, b)
    setElementData(vehicle, "vehicle:smoke", {r, g, b})
end

--> v1.1 
function detachSmoke(vehicle)
    if getElementData(vehicle, "vehicle:smoke") then 
        vehicle:setData('vehicle:smoke', nil, false)
        if smokes[vehicle] then 
            smokes[vehicle] = nil;
        end
    end
end

addEventHandler("onClientRender", root, function()
    if update < getTickCount() then
        for k,v in pairs(getElementsByType("vehicle", true)) do
            local rgb = getElementData(v, "vehicle:smoke")
            if rgb then
                if getElementHealth(v) == 0 then 
                    smokes[v] = nil;
                    removeElementData(v, "vehicle:smoke")
                end

                rgb[4] = 255
                local x, y, z = getPositionFromElementOffset(v, 0, -5, 0)
                if not smokes[v] then
                    smokes[v] = {}
                end
                for i = maximumVehicleSmoke, 2, -1 do
                    smokes[v][i] = smokes[v][i - 1]
                end
                smokes[v][maximumVehicleSmoke+1] = nil
                smokes[v][1] = {x, y, z, rgb, 255}
            end
        end
        update = getTickCount() + 50
    end
    for k,v in pairs(smokes) do
        for i,s in pairs(v) do
            local x, y, z, rgb, alpha = unpack(s)
            alpha = math.max(alpha - 0.5, 0)
            rgb[4] = alpha
            dxDrawMaterialLine3D(x - 1, y - 1, z - 1, x + 1, y + 1, z + 1, smoke, 5, tocolor(unpack(rgb)), false, 0, 10000, 0)
            dxDrawMaterialLine3D(x - 1, y - 1, z - 1, x + 1, y + 1, z + 1, smoke, 5, tocolor(unpack(rgb)), false, 10000, 0, 0)
            dxDrawMaterialLine3D(x - 1, y - 1, z - 1, x + 1, y + 1, z + 1, smoke, 5, tocolor(unpack(rgb)), false, 10000, 10000, 0)
            dxDrawMaterialLine3D(x - 1, y - 1, z - 1, x + 1, y + 1, z + 1, smoke, 5, tocolor(unpack(rgb)), false, 0, 0, 10000)
            smokes[k][i] = {x + math.random(-10, 10)/100, y + math.random(-10, 10)/100, z + math.random(-10, 10)/100, rgb, alpha}
        end
    end
end)


--> Taken from https://wiki.multitheftauto.com/wiki/AttachEffect
--> Referans https://wiki.multitheftauto.com/wiki/AttachEffect
function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix (element) 
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] 
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z 
end