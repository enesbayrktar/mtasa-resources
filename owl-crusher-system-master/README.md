# Crusher System
Own made crusher system for OWL gaming gamemodes. 
Not supported officaly, if youre known LUA you can improve that later!
    
### Installation
Move in to ```${SERVER_DIR}\mods\deathmatch\resources``` folder.
Type ```refresh``` command on console.
Finally you can do ```start owl-crusher-system```

### Configration
```lua
--@syntax Service:credentials{PDFACTID, FILENAME, REPLACESKINS, PDTOPD, BROOMID, WEAPONID, MISSONMS, DISTANCE}
Service:credentials{1, 'data.json', {264, 205}, true, 323, 12, 5000, 30}
```

------
## Türkçe Dökümantarnasyon
OWL Gaming için kamu görevi scripti tarafımca yapılmıştır.
Resmi olarak desteklenmemektedir, herhangi bir geliştirme için kodları kendiniz düzenlemeniz gerek.
    
### Kurulum
İndirilen dosyayı ```${SUNUCU_KLASORU}\mods\deathmatch\resources``` klasörüne kopyalayın.

Konsol'a ```refresh``` komutunu girin.

Son olarak sistem yüklendikten sonra ```start owl-crusher-system``` komutu ile başlatabilirsiniz.

### Ortam değişkenleri
```FACTID``` OWL oyun modu üzerindeki polis birliğinin tanımlayıcı(id) değeri (```standart: 1 ```).

```FILE```  Veritabanı olarak depolanıcak dosyanın adı (```standart: data.json ```).

```REPLACESKINS``` Oyun içi değiştirelecek kıyafet model tanımlayıcı değerleri. (```standart: ARR {264, 205} ```).

```PDTOPD``` Polis üyelerin birbirlerine kamu cezasını vermelerini istemiyorsanız. (```standart: true ```).

```BROOMID, WEAPONID ``` Oyun içi görevde kullanılacak süpürge'nin model ve silah değerleri. (```standart: 323, 12 ```).

```MISSONMS ``` Cezada olan oyuncuların oyun içi marker'da bekleyeceği süre milisaniye değeri. (```standart: 5000 ```).

```DISTANCE``` Polisin komutu kullanabileceği oyuncuya olan maksimum birim uzaklığı. (```standart 30 ```).

```lua
--@sözdizimi Service:credentials{FACTID, FILE, REPLACESKINS, PDTOPD, BROOMID, WEAPONID, MISSONMS, DISTANCE}
Service:credentials{1, 'data.json', {264, 205}, true, 323, 12, 5000, 30}
```
