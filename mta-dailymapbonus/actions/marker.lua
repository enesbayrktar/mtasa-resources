local avaliablePositions = {
  {201.97350, -1643.69006, 12.80954}
  -- Posizyonlar;
}

local _setMarkerColor = setMarkerColor
function setMarkerColor(theMarker) -- declare r, g, b, a values because we dont need it yet
  return (
    theMarker
    and (
      _setMarkerColor(
        theMarker,
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255),
        100
      )
    )
  )
end

local _createMarker = createMarker
function createMarker(x, y, z, theType, size, r, g, b, a, visibleTo, hitFunction)
  local markerElement = _createMarker(
    x, y, z,
    theType,
    size,
    r, g, b, a,
    visibleTo
  )
  if type(dump[visibleTo]) == 'table' then
    for i=1, #dump[visibleTo] do
      for k=1, #dump[visibleTo][i] do
        local elem = dump[visibleTo][i][k]
        if isTimer(elem) then
          killTimer(elem)
        else
          destroyElement(elem)
        end
      end
    end
    dump[visibleTo] = nil
  end
  dump[visibleTo] = {}
  dump[visibleTo][1] = {
    setTimer(
      setMarkerColor,
      150,
      0,
      markerElement
    ),
    markerElement
  }
  createBlip(
    x, y, z,
    58,
    2,
    255, 255, 255, 255, 0,
    99999.0,
    visibleTo
  )
  return (
    hitFunction
    and (
      addEventHandler(
        'onMarkerHit',
        markerElement,
        hitFunction
      )
      and (
        markerElement
      )
      or markerElement
    )
    or (
      markerElement
    )
  )
end

function getRandomMarkerPosition(player, hitFunction)
  local randomPosition = avaliablePositions[math.random(1, #avaliablePositions)]
  local x, y, z = unpack(randomPosition)
  local markerElement = createMarker(
    x, y, z,
    'cylinder',
    2.0,
    255, 255, 255, 100,
    player,
    hitFunction
  )
  return randomPosition, markerElement
end