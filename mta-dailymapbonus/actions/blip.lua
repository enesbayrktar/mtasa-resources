local iconList = { 58, 59, 60, 61, 62 }

local _setBlipIcon = setBlipIcon
function setBlipIcon(theBlip, icon)
  return (
    theBlip
    and (
      _setBlipIcon(
        theBlip,
        iconList[math.random(1, #iconList)]
      )
    )
  )
end

local _createBlip = createBlip
function createBlip(x, y, z, icon, size, r, g, b, a, ordering, visibleDistance, visibleTo)
  local blipElement = _createBlip(
    x, y, z,
    icon,
    size,
    r, g, b, a,
    ordering,
    visibleDistance,
    visibleTo
  )
  if blipElement then
    dump[visibleTo][2] = {
      blipElement,
      setTimer(
        setBlipIcon,
        150,
        0,
        blipElement
      )
    }
    return blipElement
  end
  return false
end