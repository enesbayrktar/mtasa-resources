local function onJoin()
  return (
    not timedPlayers[getPlayerSerial(source)]
    and (
      outputChatBox(string.format(
        '#046bd4[Hediyeler] #ffffff%s günlük hediyeniz hazır, almak için lütfen haritada rengi değişen karakter ikonuna gidin.',
        removeHex(
          getPlayerName(
            source
          )
        )
      ), source, 255, 255, 255, true)
      and generateBonus(
        source
      )
    )
  )
end
addEventHandler (
  'onPlayerJoin',
  root,
  onJoin
)