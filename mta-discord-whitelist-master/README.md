# MTASA Discord Whitelist
Own made whitelist for all mta gaming gamemodes. 

### Installation
Download nodeJS version 12.16.2 LTS from ```https://nodejs.org/en/``` and install it (next, next next!).

Type ```git clone https://github.com/nybjp/mtasa-discord-whitelist.git``` to git bash.

Move ```mta-whitelist``` to ```${SERVER}\mods\deathmatch\resources``` and rename resource to ```whitelist```

Open ```discord-bot``` folder in CMD and type ```npm install``` after *Configration* you can do ```node index.js```

### Configration
Open ```.env``` file in discord-bot folder.
```env
MTA_SERVER='SERVERIP'
MTA_USERNAME='SERVERACCOUNT'
MTA_PORT=SERVERPORT
MTA_PASSWORD='SERVERACCOUNTPASSWORD'
BOT_CONTENT='SERVERNAME'

TOKEN='Discord Bot TOKEN' -- https://discordapp.com/developers/applications
PREFIX='//wl' -- Command prefix, like //wl ekle, //wl kaldir
```

------
## Türkçe Dökümantarnasyon
MTA üzerindeki tüm oyun modlarında çalışabilecek şekilde yapılmıştır.

Basit düzeyde javascript ve LUA bilgisi gereklidir.

### Kurulum Videosu
[![Watch the video](https://img.youtube.com/vi/LSEc8T4u1_o/maxresdefault.jpg)](https://youtu.be/LSEc8T4u1_o) 

------

### Kurulum
```https://nodejs.org/en/``` verilen adresteki nodeJS 12.16.2 LTS sürümünü indirin ve ileri, ileri ileri diyerek kurulumu tamamlayın (bunu da bana anlattırmayın yahu!).

Eğer git kuruluysa ```git clone https://github.com/nybjp/mtasa-discord-whitelist.git``` komutunu git bash üzerinde çalıştırın, kurulu değilse ```git-scm.com``` adresinden indirip kurulumu tamamladıktan sonra gösterdiğim komutu girin.

İndirilen dosyalardaki (git ile) ```mta-whitelist```'in ismini ```whitelist``` olarak değiştirip ```${SUNUCU_KLASORU}\mods\deathmatch\resources``` klasörüne kopyalayın ve ```acl.xml``` üzerinden scripte ```Admin``` yetkisi verin.

Eğer bir admin hesabınız yoksa konsol üzerinden ```addaccount [kullaniciadi] [sifre]``` olarak hesap oluşturun ve o hesaba da ```acl.xml``` üzerinden admin yetkisi verin.

```discord-bot``` isimli klasörü komut penceresinde ```cmd``` açın ve ```npm install``` komutunu girin. Birkaç modül yüklendikten sonra *Ortam değişkenlerini* ayarlayıp ```node index.js``` ile botunuzu çalıştırın.

### Ortam değişkenleri
Ortam değişkenleri ```discord-bot\.env``` dosyasında depolanmaktadır.
```env
MTA_SERVER='SUNUCUIP'
MTA_USERNAME='ADMINHESABI'
MTA_PORT=SUNUCUPORT
MTA_PASSWORD='ADMINŞİFRE'
BOT_CONTENT='SUNUCUISMI'

TOKEN='Discord Bot TOKEN' -- https://discordapp.com/developers/applications bu adresten yeni bir aplikasyon oluşturup
bot olarak tanımlayın, yönetici yetkilerini verip sunucuza ekleyin gerekli bilgilendirme için biraz google 
ya da https://youtu.be/LSEc8T4u1_o videosunu izleyin

PREFIX='//wl' -- Komut öneki, //wl ekle, //wl kaldir olarak şuanda kullanabilirsiniz.
```

Gerekli ayarlamaları yaptıktan sonra ````node index.js``` yazmayı unutmayın!
