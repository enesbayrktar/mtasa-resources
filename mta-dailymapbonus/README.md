# Dailymapbonus
Give in-game bonuses each serial on every 24 hours

### Installation
Move in to ```${SERVER_DIR}\mods\deathmatch\resources``` folder.
Type ```refresh``` command on console.
Finally you can do ```start mta-dailymapbonus```

You can edit random marker positions on ```actions/marker.lua``` and you can edit the bonuses too givePlayerBonus() function inside the ```actions/player.lua```

------

## Türkçe Dökümantarnasyon
Oyundaki oyunculara her 24 saatte bir rastgele bir konumda marker oluşturur, buraya giden oyuncu rastgele bir ödül kazanır. (not: halk arasında günlük bonus sistemi olarak da geçmektedir)
    
### Kurulum
İndirilen dosyayı ```${SUNUCU_KLASORU}\mods\deathmatch\resources``` klasörüne kopyalayın.

Konsol'a ```refresh``` komutunu girin.

Son olarak sistem yüklendikten sonra ```start mta-dailymapbonus``` komutu ile başlatabilirsiniz.

Rastgele konumları ```actions/marker.lua``` dosyasının başında bulunan tablodan düzenleyebilirsiniz.

Verilecek olan hediyeyi (içi boştur, şuanda herhangi bir hediye vermez kendinize göre düzenlemeniz gerekir!) ```actions/player.lua``` içerisindeki ```givePlayerBonus()``` fonksiyonundan ayarlayabilirsiniz.
