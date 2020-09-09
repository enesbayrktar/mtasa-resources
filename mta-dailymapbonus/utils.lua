timedPlayers = {}
dump = {}

function removeHex(s)
  if type (s) == "string" then
    while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
      s = s:gsub ("#%x%x%x%x%x%x", "")
    end
  end
  return s or false
end