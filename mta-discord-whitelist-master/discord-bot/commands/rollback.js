module.exports = (args, message, mta) => {
  if (args.length > 0)
    return message.channel.send(
      "Söz dizimi hatalı lütfen komut argümanlarını kontrol edin. Bu komut varsayılan bir argüman içermiyor <@" +
        message.author.id +
        ">"
    );

  mta.resources.whitelist.rollback().then(result => {
    if (!result)
      return message.channel.send(
        "rollback komutu şuanda geçerli değildir, son eklenen herhangi bir serial mevcut değil! <@" +
          message.author.id +
          ">"
      );
    return message.channel.send(
      result +
        " adlı serial değeri başarıyla oyundan kaldırıldı. <@" +
        message.author.id +
        ">"
    );
  });
};
