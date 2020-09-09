# Plane Smoke
> A own maded afterburner script for MTA:SA.
> Special thanks to my poland friend Liberty#5062
    
### Installation
Move in to ```${SERVER_DIR}\mods\deathmatch\resources``` folder.
Type ```refresh``` command on console.
Finally you can do ```start mta-plane-smoke```

### Usage
Enter hydra or which vehicle id's contains `allowedVehicles` assigned you.

#### Controls
- `Number 3` for Red Smoke.
- `Number 4` for White Smoke.
- `Number 5` for close the smoke.

#### Configration
From `containers/SmokeContainer.lua:66`
```lua
Smoke:register{
   allowedVehicles = {519, 520}, --// 519 Shamal , 520 Hydra
   keys = {'3', '4', '5'}, --// which keys do you use, (indexing opposite of line 10
}:init()
```

------

## Türkçe Dökümantarnasyon
Multi Theft Auto için yapılmış belirlediğiniz araçların arka tarafından istediğiniz renkte duman çıkartabildiğiniz bir sistemdir.
    
### Kurulum
İndirilen dosyayı ```${SUNUCU_KLASORU}\mods\deathmatch\resources``` klasörüne kopyalayın.

Konsol'a ```refresh``` komutunu girin.

Son olarak sistem yüklendikten sonra ```start mta-plane-smoke``` komutu ile başlatabilirsiniz.

### Kullanım
`allowedVehicles` kısmına atadığınız id değerini içeren araca binin ve listelenen tuşları eylemler için kullanın.

#### Tuşlar
- Kırmızı duman için `Numpad 3`
- Beyaz duman için `Numpad 4`
- Dumanları kapatmak için `Numpad 5`

#### Ortam Değişkenleri
Hop! bunu yapmadan önce ne yaptığını bilmeni isterim.

Buradaki `keys` kısmındaki değerleri değiştirdiğinde 10.satırdaki verilerle eşitlemeyi unutma yoksa sistem çalışmaz! Nasıl yeni bir renk ekleyebileceğini orada sana anlattım, iyi eğlenceler.

`containers/SmokeContainer.lua:66` dosyasından alınmıştır.
```lua
Smoke:register{
   allowedVehicles = {519, 520}, --// 519 Shamal , 520 Hydra, Araçların ID değerleri.
   keys = {'3', '4', '5'}, --// Hangi tuşlarla çalışacağı, dosyanın 10.satırına bakmayı unutmayın.
}:init()
```

#### Dipnot
Özellikle Polonyalı arkadaşıma teşekkürlerimi borç bilirim, sizden ricam kanalını ve projesini desteklemeniz.
`Liberty#5020`
https://www.youtube.com/channel/UCfyBwH8WbGj8FjSxSPg9ZWA
