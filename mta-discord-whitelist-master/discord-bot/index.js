require("dotenv").config();

const path = require("path");

const Discord = require("discord.js");
const MultiTheftAuto = require("mtasa").Client;
const Commands = require(path.resolve(__dirname, "libs/command"));

const server = new MultiTheftAuto(
  process.env.MTA_SERVER,
  process.env.MTA_PORT,
  process.env.MTA_USERNAME,
  process.env.MTA_PASSWORD
);
const client = new Discord.Client();
const commands = new Commands(client);

//console.log(server.resources.whitelist.abc("123123"));

client.on("ready", async () => {
  client.guilds.cache.map(async function(key) {
    const whiteadmin = key.roles.cache.find(
      roles => roles.name === "Sunucu Görevlisi"
    );
    const everyone = await key.roles.cache.find(
      roles => roles.name === "@everyone"
    );
    let whitelist = await key.channels.cache.find(c => c.name === "whitelist");

    if (whitelist) await whitelist.delete(), (whitelist = undefined);

    if (whiteadmin === undefined) {
      await key.roles.create({
        data: {
          name: "Sunucu Görevlisi",
          color: "#6441a4",
        },
      });
    }

    if (whitelist === undefined) {
      key.channels
        .create("whitelist", {
          type: "text",
          permissionOverwrites: [
            {
              id: everyone.id,
              deny: ["VIEW_CHANNEL"],
            },
            {
              id: key.roles.cache.find(
                roles => roles.name === "Sunucu Görevlisi"
              ).id,
              allow: ["VIEW_CHANNEL"],
            },
          ],
        })
        .then(channel => {
          channel
            .send({
              embed: {
                color: 3447003,
                author: {
                  icon_url: client.user.avatarURL,
                },
                title: "Komutlar:",
                description: "Bot üzerinde kullanabileceğiniz komutlar.",
                fields: [
                  {
                    name: "*" + process.env.PREFIX + " ekle [serial]*",
                    value:
                      "[serial] değerini girdiğiniz oyuncunun oyuna bağlanmasına izin verir.",
                  },
                  {
                    name: "*" + process.env.PREFIX + " kaldir [serial]*",
                    value:
                      "[serial] değerini girdiğiniz oyuncu sunucuya bir daha erişemez.",
                  },
                  {
                    name: "*" + process.env.PREFIX + " rollback*",
                    value: "son eklenen [serial] değerini sistemden kaldırır",
                  },
                ],
                timestamp: new Date(),
                footer: {
                  icon_url: client.user.avatarURL,
                  text: "© nybjp",
                },
              },
            })
            .then(message => message.pin());
        });
    }
  });

  commands.register(
    "ekle", 
    require(path.resolve(__dirname, "commands/add"))
  );
  commands.register(
    "kaldir",
    require(path.resolve(__dirname, "commands/remove"))
  );
  commands.register(
    "rollback",
    require(path.resolve(__dirname, "commands/rollback"))
  );

  client.user.setActivity(process.env.BOT_CONTENT);

  client.on("message", async message => {
    // Eğer mesajı gönderen bir botsa hiçbirşey yapma
    if (message.author.bot) return;

    // Eğer whitelist kanalına mesaj atılmamışsa
    if (message.channel.name !== "whitelist") return;

    // Mesajın başında gösterdiğimiz ön işaret yoksa (varsayılan olaran //whitelist dir)
    if (message.content.indexOf(process.env.PREFIX) !== 0) return;

    // Girilen komutmuz //whitelist ekle 123123 123 12 olsun
    // Argümanlar = ["123123", "123", "12"]
    const args = message.content
      .slice(process.env.PREFIX.length)
      .trim()
      .split(/ +/g);

    // Komut = ekle
    const command = args.shift().toLowerCase();

    // Yukarıda tanımlamış olduğumuz komut'u çalıştır
    commands.use(command, args, message, server).catch(() => {
      return message.channel.send(
        "Söz dizimi hatalı lütfen böyle bir komut olup olmadığını kontrol edin. <@" +
          message.author.id +
          ">"
      );
    });
  });

  console.log(
    "\n dc-whitelist \n * Tanımlı komutlar: " +
      commands.list() +
      "\n [Yapımcı: nybjp / Enes Bayraktar, Versyon: 1.0]"
  );
});

client.login(process.env.TOKEN);
