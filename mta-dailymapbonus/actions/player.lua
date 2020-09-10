local function checkPlayers()
  for i, v in pairs(timedPlayers) do
    if os.difftime(os.time(), v[2]) > 86400 then -- second
      timedPlayers[i] = nil
    end
  end
end

function givePlayerBonus(hitElement)
  if getElementType(hitElement) ~= 'player' then -- bazı zeki insanları devredışı bırakalım
    return
  end

  if timedPlayers[getPlayerSerial(hitElement)] then
    return
  end

  timedPlayers[getPlayerSerial(hitElement)] = {
    hitElement,
    os.time(),
    os.time() + 86400
  }
  if type(dump[hitElement]) == 'table' then
    for i=1, #dump[hitElement] do
      for k=1, #dump[hitElement][i] do
        local elem = dump[hitElement][i][k]
        if isTimer(elem) then
          killTimer(elem)
        else
          destroyElement(elem)
        end
      end
    end
  end
  dump[hitElement] = nil

  local responseString = string.format(
    '#046bd4[#] #ffffffTebrikler %s günlük hediyeniz başarıyla tanımlandı.\n#046bd4[#] #ffffffBir sonraki hediyeye kalan süre 24 saat.\n#046bd4[#] #ffffffBlabla gaming iyi oyunlar diler.',
    removeHex(
      getPlayerName(
        hitElement
      )
    )
  )

  outputChatBox(
    responseString,
    hitElement,
    255, 255, 255,
    true
  )

  log('gived',
    string.format('USER SUCCESSFULLY TAKEN %s %s',
      removeHex(
        getPlayerName(
          hitElement
        )
      ),
      getPlayerSerial(
        hitElement
      )
    )
  )

  -- Hediye kodları!
end

ctt = setTimer(
  checkPlayers,
  3600000, -- ? 1 saat & 1 hour ms
  0
)

function generateBonus(player)
  local item = timedPlayers[getPlayerSerial(player)] -- declare
  if item then
    return
  end

  local position, element = getRandomMarkerPosition(
    player,
    givePlayerBonus
  )
end
