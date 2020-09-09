module.exports = (args, message, mta) => {
  if (args.length > 1 || args.length === 0)
    return message.channel.send(
      "Söz dizimi hatalı lütfen komut argümanlarını kontrol edin. <@" +
        message.author.id +
        ">"
    );

  if (args[0] !== args[0].toUpperCase())
    return message.channel.send(
      "Girilen verinin bir serial olup olmadığından emin olun. <@" +
        message.author.id +
        ">"
    );

  mta.resources.whitelist.exists(args[0]).then(result => {
    if (!result)
      return message.channel.send(
        "Girilen serial değerine ait oyuncu sunucuda mevcut değil. <@" +
          message.author.id +
          ">"
      );

    mta.resources.whitelist.remove(args[0]).then(result => {
      console.log(result);
      return message.channel.send(
        args[0] +
          " adlı serial değeri başarıyla oyundan kaldırıldı. <@" +
          message.author.id +
          ">"
      );
    });
  });
};
