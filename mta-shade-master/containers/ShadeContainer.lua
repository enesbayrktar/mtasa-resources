addEventHandler('onClientResourceStart', resourceRoot,
function()

    Shade = Service:new('shade');

    function Shade:add(object, callback)
        object = object or false;
        if not object then
            return error('Gelen [OBJE] argümanı hatalı.');
        end
        
        self.cache = self.cache or {};
        if self.cache[object.id] then
            return error('Verilmiş olan ID ile kayıtlı bir Shade elementi mevcut')
        end

        self.cache[object.id] = object.func;
        if not callback then
            return true
        end

        return callback(self, object.id);
    end;

    function Shade:use(id)
        id = id or false
        if not id or type(id) ~= 'string' then
            return error('ID argümanı hatalı')
        end

        return self.cache[id]();
    end

    setFarClipDistance(300)

    --? Su efekti
    Shade:add({
    id = 'Water',
    func = 
    function()
        if getVersion().sortable < "1.1.0" then
            return false
        end

        local WShader = DxShader("dist/fx/water.fx");
        if not WShader then
            return error('Shader yüklenemedi!');
        end

        local function __init__()
            local noise3d = DxTexture('dist/media/smallnoise3d.dds', 'argb', false);
            local env256  = DxTexture('dist/media/cube_env256.dds', 'argb', false);

            WShader:setValue('sRandomTexture', noise3d)
            WShader:setValue('sReflectionTexture', env256)
            WShader:applyToWorldTexture('waterClear256');
        end

        if pcall(__init__) then 
            WShader:setValue("sWaterColor", 0/255, 128/255, 255/255, 150/255);

            --? Işıklandırma hatalarını giderme
            Shade:add({
            id = 'Clearlights',
            func = 
            function()
        
                local LShader = DxShader('dist/fx/light_disable.fx', 0, 0, false, "object");
                if not LShader then
                    return error('Shader yüklenemedi!');
                end

                local function __init__()
                    LShader:applyToWorldTexture('*');
                end

                if pcall(__init__) then 
                    

                    --? Gölgelendirme ayarı
                    Shade:add({
                    id = 'SSAO',
                    func = 
                    function()
                
                    

                        local function __init__()
                    
                            local isAOMaterialPrimitive = true
                            local isDebugMode = false

                            local scx, scy = guiGetScreenSize()
                            local renderTarget = {RTNormal = nil, isOn = false}
                            local aoShader = {shader = nil, colorRT = nil, enabled = false}

                            local function enableAO()
                                if aoShader.enabled then return end
                                if renderTarget.isOn then
                                    if isAOMaterialPrimitive then
                                        aoShader.shader, tec = DxShader("dist/fx/primitive3D_ssao_dr.fx")
                                    else
                                        aoShader.shader, tec = DxShader("dist/fx/material3D_ssao_dr.fx")
                                    end
                                    if aoShader.shader and renderTarget.RTNormal then
                                        aoShader.shader:setValue("sRTNormal", renderTarget.RTNormal)
                                    end
                                else
                                    if isAOMaterialPrimitive then 
                                        aoShader.shader, tec = DxShader("dist/fx/primitive3D_ssao.fx")
                                    else
                                        aoShader.shader, tec = DxShader("dist/fx/material3D_ssao.fx")	
                                    end
                                end

                                aoShader.colorRT = DxRenderTarget(scx, scy, false)
                                isAllValid = true

                                    isAllValid = aoShader.shader and aoShader.colorRT
                                    if isAllValid then
                                        aoShader.shader:setValue("fViewportSize", scx, scy)
                                        aoShader.shader:setValue("sPixelSize", 1 / scx, 1 / scy)
                                        aoShader.shader:setValue("sAspectRatio", scx / scy)
                                        aoShader.shader:setValue("sRTColor", aoShader.colorRT)
                                        aoShader.shader:setValue("fViewportSize", scx, scy)
                            
                                        if isDebugMode then
                                            aoShader.shader:setValue("fBlend", 5, 6)
                                        else
                                            aoShader.shader:setValue("fBlend", 1, 3)
                                        end
                                    end
                                aoShader.enabled = isAllValid
                            end

                            local function disableAO()
                                if not aoShader.enabled then return end
                                aoShader.enabled = false
                                destroyElement(aoShader.shader)
                                aoShader.shader = nil
                                destroyElement(aoShader.colorRT)
                                aoShader.colorRT = nil
                            end

                            local trianglestrip_quad = {{-1, -1, 0, 0, 0}, {-1, 1, 0, 0, 1}, {1, -1, 0, 1, 0}, {1, 1, 0, 1, 1}}

                            local cPosX, cPosY, cPosZ = getCameraMatrix()
                            addEventHandler("onClientPreRender", root, function()
                                if aoShader.enabled then
                                    dxSetRenderTarget(aoShader.colorRT)
                                    dxSetRenderTarget()
                                    if isAOMaterialPrimitive then
                                        dxDrawMaterialPrimitive3D( "trianglestrip", aoShader.shader, false, unpack( trianglestrip_quad ) )
                                    else
                                        cPosX, cPosY, cPosZ = getCameraMatrix()
                                        dxDrawMaterialLine3D( cPosX + 0.5, cPosY + 1, cPosZ, cPosX + 0.5, cPosY , cPosZ, aoShader.shader, 1, tocolor(255,255,255,255), cPosX + 0.5,cPosY + 0.5, cPosZ + 1 )
                                    end
                                end
                            end, true, "high+9" )

                            if dxGetStatus().VideoMemoryFreeForMTA > 300 then 
                                enableAO()
                            end
                        end

                        if pcall(__init__) then
                            return true
                        else
                            return error('Bilinmedik bir hata oluştu!')
                        end

                    end
                    }, function(this, id)
                        return this:use(id);
                    end)

                    return true
                else
                    return error('Bilinmedik bir hata oluştu!')
                end

            end
            }, function(this, id)
                return this:use(id);
            end)

            return true
        else
            return error('Bilinmedik bir hata oluştu!')
        end

    end
    }, function(this, id)
        return this:use(id);
    end)

    return true
end)
