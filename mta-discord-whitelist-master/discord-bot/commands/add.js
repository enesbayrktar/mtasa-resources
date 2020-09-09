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
    if (result)
      return message.channel.send(
        "Bu serial adresi zaten kayıtlı <@" + message.author.id + ">"
      );

    mta.resources.whitelist.add(args[0]).then(state => {
      if (state)
        return message.channel.send(
          args[0] +
            " adlı serial başarıyla kaydedildi. İşlemi geri almak için " + process.env.PREFIX + " rollback <@" +
            message.author.id +
            ">"
        );
    });
  });
};
